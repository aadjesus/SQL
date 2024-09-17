DECLARE
	v_Executa_Carga_Inicial BOOLEAN;
	CURSOR c_Objetos IS
		SELECT Object_Type
			 , Object_Name
		  FROM User_Objects
		 WHERE Instr(Object_Name, 'MANU_') > 0
			AND Data_Object_Id IS NULL
			AND Object_Type <> 'SEQUENCE'
		 ORDER BY Object_Id;

	FUNCTION Objeto_Valido(p_Nome_Objeto VARCHAR2) RETURN BOOLEAN IS
		v_Valido NUMBER;
	BEGIN
		SELECT COUNT(*)
		  INTO v_Valido
		  FROM User_Objects
		 WHERE Object_Name = p_Nome_Objeto;
	
		RETURN v_Valido > 0;
	END;
BEGIN
	v_Executa_Carga_Inicial := TRUE;
	FOR Objeto IN c_Objetos
	LOOP
		EXECUTE IMMEDIATE 'ALTER ' || Objeto.Object_Type || ' ' || Objeto.Object_Name || ' COMPILE';
		IF NOT Objeto_Valido(Objeto.Object_Name) THEN
			Dbms_Output.Put_Line(Objeto.Object_Name);
			v_Executa_Carga_Inicial := FALSE;
		END IF;
	END LOOP;

	IF v_Executa_Carga_Inicial THEN
		Pr_Manu_Carga_Inicial();
	END IF;
END;