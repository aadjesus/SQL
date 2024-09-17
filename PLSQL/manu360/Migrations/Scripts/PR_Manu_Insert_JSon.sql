CREATE OR REPLACE PROCEDURE Pr_Manu_Insert_Json(p_Nome_Tabela   IN VARCHAR2
															  ,p_Tipo_Operacao IN NUMBER
															  ,p_Json          IN VARCHAR2) IS
	v_Tipo_Operacao NUMBER(1);
   v_TpOperacao    NUMBER(1);
	v_Nome_Tabela   VARCHAR2(30);
	v_Carga_Inicial NUMBER(1);
BEGIN
	v_Nome_Tabela := Upper(p_Nome_Tabela);
	BEGIN
		SELECT Carga_Inicial
				,Tipo_Operacao
		  INTO v_Carga_Inicial
				,v_TpOperacao
		  FROM Manu_Carga_Inicial
		 WHERE Table_Name = v_Nome_Tabela;
	EXCEPTION
		WHEN OTHERS THEN
			v_Carga_Inicial := 0;
	END;

	BEGIN
		v_Tipo_Operacao := p_Tipo_Operacao;
	
		IF v_Carga_Inicial > 0 AND v_Carga_Inicial < 3 THEN
			BEGIN
				IF v_Carga_Inicial = 2 THEN
				   v_Tipo_Operacao := v_TpOperacao;
				ELSE
					RETURN;
				END IF;
			END;
		ELSIF NOT Fc_Manu_Validarsistema() THEN
			RETURN;
		END IF;
	
		INSERT INTO Manu_Integracao
			(Conteudo
			,Table_Name
			,Transaction_Id
			,Tipo_Operacao
			,Id)
		VALUES
			(Chr(123) || p_Json || Chr(125)
			,v_Nome_Tabela
			,Dbms_Transaction.Local_Transaction_Id
			,v_Tipo_Operacao
			,Seq_Manu_Integracao.NEXTVAL);
	
	EXCEPTION
		WHEN OTHERS THEN
			Dbms_Output.Put_Line(p_Nome_Tabela || ': ' || SQLERRM);
	END;
END Pr_Manu_Insert_Json;