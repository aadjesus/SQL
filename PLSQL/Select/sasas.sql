CREATE OR REPLACE FUNCTION Fc_Xx(p_Tabela IN VARCHAR2
										  ,p_Coluna IN VARCHAR2) RETURN BOOLEAN IS


	v_Tamanho NUMBER;
	v_Sql     VARCHAR2(200);

	CURSOR c_Owner IS
		SELECT Username
		  FROM All_Users
		 WHERE Table_Name = Upper(p_Tabela);

BEGIN
	BEGIN
		FOR Item IN c_Owner
		LOOP
			v_Sql := 'SELECT MAX(Length(' || p_Coluna || ')) INTO :1 FROM ' || p_Tabela;
			EXECUTE IMMEDIATE v_Sql
				USING v_Tamanho;
		
		END LOOP;
	EXCEPTION
		WHEN OTHERS THEN
			Dbms_Output.Put_Line(SQLERRM);
	END;
	RETURN(FALSE);
END Fc_Xx;
/