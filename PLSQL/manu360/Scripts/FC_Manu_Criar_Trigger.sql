CREATE OR REPLACE FUNCTION Fc_Manu_Criar_Trigger(p_Nome_Tabela   IN VARCHAR2
																,p_Colunas       IN t_Manu_Colunas
																,p_Nome_Json     IN VARCHAR2
																,p_Tipo_Operacao IN INTEGER) RETURN BOOLEAN IS
	v_Sql_Trigger   VARCHAR2(4000);
	v_Enter         VARCHAR2(10);
	v_Nome_Trigger  VARCHAR2(40);
	v_Retorno       BOOLEAN;
	v_Colunas       NUMBER;
	v_Nome_Json     VARCHAR2(30);
	v_Tipo_Operacao VARCHAR2(50);

	-- Cria cursor com as colunas da tabela informada
	CURSOR c_Colunas IS
		SELECT Column_Name AS Nome
				,(CASE
					 WHEN Data_Type = 'VARCHAR2'
							AND Data_Length > 1 THEN
					  1
					 ELSE
					  0
				 END) AS Executarreplace
				,COUNT(*) Over() Tot_Rows
		  FROM User_Tab_Columns
		 WHERE (v_Colunas = 0 OR Column_Name IN (SELECT Upper(Column_Value) AS Column_Value
																 FROM TABLE(p_Colunas)))
			AND Table_Name = Upper(p_Nome_Tabela);

	FUNCTION Colunas RETURN VARCHAR2 IS
		v_Retorno VARCHAR2(4000);
		v_Coluna  VARCHAR2(1000);
	BEGIN
		FOR Item IN c_Colunas
		LOOP
			v_Coluna := Chr(40) || 'Case When Deleting Then :Old.' || Item.Nome || ' Else :New.' || Item.Nome || ' End' || Chr(41);
		
			IF Item.Executarreplace = 1 THEN
				v_Coluna := 'REPLACE(' || v_Coluna || ', ''"''    ,''\u0022'')';
				v_Coluna := 'REPLACE(' || v_Coluna || ', '''''''' ,''\u0027'')';
			END IF;
		
			v_Retorno := v_Retorno || '''''''' || Lower(Item.Nome) || ''''': "'' ||';
			v_Retorno := v_Retorno || v_Coluna;
			v_Retorno := v_Retorno || ' || ''"' || v_Enter;
		
			IF c_Colunas%ROWCOUNT != Item.Tot_Rows THEN
				v_Retorno := v_Retorno || ',  ''|| ' || v_Enter;
			END IF;
		END LOOP;
		RETURN(v_Retorno);
	END;

	FUNCTION Tipo_Operacao(p_Parte IN VARCHAR2) RETURN VARCHAR2 IS
		v_Retorno VARCHAR2(1000);
	BEGIN
		v_Retorno := '';
	
		IF p_Tipo_Operacao = -1 THEN
			BEGIN
				CASE p_Parte
					WHEN 1 THEN
						v_Retorno := v_Retorno || ' v_Tipo_Operacao  Integer;' || v_Enter;
					WHEN 2 THEN
						v_Retorno := v_Retorno || ' If Inserting Then        ' || v_Enter;
						v_Retorno := v_Retorno || '   v_Tipo_Operacao := 0;  ' || v_Enter;
						v_Retorno := v_Retorno || ' Elsif Updating Then      ' || v_Enter;
						v_Retorno := v_Retorno || '   v_Tipo_Operacao := 1;  ' || v_Enter;
						v_Retorno := v_Retorno || ' Else                     ' || v_Enter;
						v_Retorno := v_Retorno || '   v_Tipo_Operacao := 2;  ' || v_Enter;
						v_Retorno := v_Retorno || ' End If;                  ' || v_Enter;
					ELSE
						v_Retorno := v_Retorno || 'v_Tipo_Operacao';
				END CASE;
			END;
		ELSIF p_Parte = 3 THEN
			v_Retorno := v_Retorno || p_Tipo_Operacao;
		END IF;
	
		RETURN(v_Retorno);
	END;
BEGIN
	BEGIN
		IF NOT Fc_Manu_Validarsistema() THEN
			RETURN(FALSE);
		END IF;
	
		-- Verifica se informou colunas
		SELECT COUNT(*)
		  INTO v_Colunas
		  FROM TABLE(p_Colunas);
	
		-- Define os valores iniciais
		v_Retorno      := FALSE;
		v_Enter        := Chr(10);
		v_Nome_Trigger := 'TR_Manu_' || Upper(Substr(p_Nome_Tabela, Instr(p_Nome_Tabela, '_') + 1, 20));
		v_Nome_Json    := p_Nome_Tabela;
		IF NOT p_Nome_Json IS NULL THEN
			v_Nome_Json := p_Nome_Json;
		END IF;
	
		-- Texto trigger
		v_Sql_Trigger := v_Sql_Trigger || 'Create Or Replace Trigger ' || v_Nome_Trigger || v_Enter;
		v_Sql_Trigger := v_Sql_Trigger || '  After Insert Or Update Or Delete On ' || p_Nome_Tabela || v_Enter;
		v_Sql_Trigger := v_Sql_Trigger || '  For Each Row                        ' || v_Enter;
		v_Sql_Trigger := v_Sql_Trigger || 'Declare                               ' || v_Enter;
		v_Sql_Trigger := v_Sql_Trigger || '  v_Json        Varchar2(4000);       ' || v_Enter;
		v_Sql_Trigger := v_Sql_Trigger || Tipo_Operacao(1)                         || v_Enter;
		v_Sql_Trigger := v_Sql_Trigger || 'Begin                                 ' || v_Enter;
		v_Sql_Trigger := v_Sql_Trigger || Tipo_Operacao(2)                         || v_Enter;
		v_Sql_Trigger := v_Sql_Trigger || '                                      ' || v_Enter;
		v_Sql_Trigger := v_Sql_Trigger || '  v_Json := ' || Colunas() || ''';    ' || v_Enter;
		v_Sql_Trigger := v_Sql_Trigger || '  Pr_Manu_Insert_Json(''' || v_Nome_Json || ''', ' || Tipo_Operacao(3) || ', v_Json); ' || v_Enter;
		v_Sql_Trigger := v_Sql_Trigger || 'End ' || v_Nome_Trigger || ';' || v_Enter;
	
		-- Criar trigger
		EXECUTE IMMEDIATE v_Sql_Trigger;
	
		v_Retorno := TRUE;
	EXCEPTION
		WHEN OTHERS THEN
			Dbms_Output.Put_Line(p_Nome_Tabela || ': ' || SQLERRM);
			v_Retorno := FALSE;
	END;
	RETURN(v_Retorno);
END Fc_Manu_Criar_Trigger;