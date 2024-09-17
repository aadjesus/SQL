DECLARE
	CURSOR c_Objetos IS
		SELECT Object_Type
				,Object_Name
		  FROM User_Objects
		 WHERE Instr(Object_Name, 'MANU_') > 0
			AND Object_Type <> 'INDEX'
			AND Object_Name <> 'MANU_VERSIONINFO'
		 ORDER BY Object_Id;
BEGIN
	FOR Objeto IN c_Objetos
	LOOP
		EXECUTE IMMEDIATE 'DROP ' || Objeto.Object_Type || ' ' || Objeto.Object_Name;
	END LOOP;
END;