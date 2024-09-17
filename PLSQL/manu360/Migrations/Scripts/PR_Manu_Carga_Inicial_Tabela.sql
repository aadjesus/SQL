CREATE OR REPLACE PROCEDURE Pr_Manu_Carga_Inicial_Tabela(p_Nome_Tabela   IN VARCHAR2
																		  ,p_Carga_Inicial IN BOOLEAN
																		  ,p_Tipo_Operacao IN INTEGER) IS
	v_Into_Select VARCHAR2(50);
	v_Sql_Update  VARCHAR2(1000);
	v_Nome_Tabela VARCHAR2(50);
	v_Qtde        INTEGER;   
	CURSOR c_Triggers IS
		SELECT a.Trigger_Name Nome
		  FROM User_Triggers a
		 WHERE a.Table_Name = Upper(p_Nome_Tabela)
			AND EXISTS (SELECT *
					 FROM User_Objects b
					WHERE a.Trigger_Name = b.Object_Name
					  AND b.Status <> 'VALID');

	PROCEDURE Triggers_Invalidas(p_Habilita IN VARCHAR2) IS
	BEGIN
		FOR Item IN c_Triggers
		LOOP
			BEGIN
				EXECUTE IMMEDIATE 'ALTER TRIGGER ' || Item.Nome || ' ' || p_Habilita;
			EXCEPTION
				WHEN OTHERS THEN
					Dbms_Output.Put_Line(p_Nome_Tabela || ': ' || Item.Nome || ': ' || SQLERRM);
			END;
		END LOOP;
	END;

	FUNCTION Retornar_Condicao RETURN VARCHAR2 IS
		v_Condicao VARCHAR2(1000);
	BEGIN
		v_Condicao := NULL;
		BEGIN
			SELECT Cond_Carga_Inicial
			  INTO v_Condicao
			  FROM Manu_Condicao
			 WHERE Table_Name = p_Nome_Tabela;
			IF NOT v_Condicao IS NULL THEN
				v_Condicao := ' WHERE ' || v_Condicao;
			END IF;
		EXCEPTION
			WHEN OTHERS THEN
				v_Condicao := NULL;
		END;
	
		RETURN(v_Condicao);
	END;

BEGIN
	BEGIN
		v_Nome_Tabela := Upper(p_Nome_Tabela);
	
		-- Valida se existe a trigger para tabela
		SELECT Trigger_Name
		  INTO v_Into_Select
		  FROM User_Triggers
		 WHERE Upper(Trigger_Name) LIKE 'TR_MANU_%'
			AND Table_Name = v_Nome_Tabela;	
	
      -- Testa se já não foi feito a carga inicial
		SELECT COUNT(*)
		  INTO v_Qtde
		  FROM Manu_Carga_Inicial
		 WHERE Table_Name = v_Nome_Tabela;
		IF v_Qtde = 1 THEN
			RETURN;
		END IF;
	
		-- Insere os dados da carga inicial 
		INSERT INTO Manu_Carga_Inicial
			(Table_Name
			,Carga_Inicial
			,Tipo_Operacao)
		VALUES
			(v_Nome_Tabela
			,1
			,p_Tipo_Operacao);
		COMMIT;	
      
		UPDATE Manu_Carga_Inicial
			SET Carga_Inicial = 2
		 WHERE Table_Name = v_Nome_Tabela;
	   
      v_Qtde := 0;
		IF p_Carga_Inicial THEN
			-- Procura a menor coluna ou nullable ou uma number, para o update
			SELECT Column_Name
			  INTO v_Into_Select
			  FROM (SELECT a.Column_Name
							  ,CASE
									WHEN a.Data_Length = 1 THEN
									 0
									WHEN a.Nullable = 'Y' THEN
									 1
									ELSE
									 3
								END Ordem
						 FROM User_Tab_Columns a
						WHERE a.Table_Name = v_Nome_Tabela
						  AND (a.Data_Length = 1 OR (a.Data_Type = 'NUMBER' AND a.Nullable = 'Y') OR a.Data_Type = 'NUMBER')
						ORDER BY Ordem ASC)
			 WHERE Rownum = 1;
		
			Triggers_Invalidas('DISABLE');
		
			-- Exclui os dados caso exista
			EXECUTE IMMEDIATE 'Delete from manu_integracao where table_name = ''' || v_Nome_Tabela || '''';
		
			-- Executa o update
			EXECUTE IMMEDIATE 'update ' || v_Nome_Tabela || ' set ' || v_Into_Select || ' = ' || v_Into_Select || Retornar_Condicao();
         v_Qtde := sql%ROWCOUNT;
		
			Triggers_Invalidas('ENABLE');
		
		END IF;
	
		UPDATE Manu_Carga_Inicial
			SET Data_Final    = SYSDATE
				,Carga_Inicial = 3
            ,Qtde          = v_Qtde
		 WHERE Table_Name = v_Nome_Tabela;
	
		COMMIT;
	EXCEPTION
		WHEN OTHERS THEN
			ROLLBACK;
			Dbms_Output.Put_Line(v_Nome_Tabela || ': ' || SQLERRM);
	END;
END Pr_Manu_Carga_Inicial_Tabela;