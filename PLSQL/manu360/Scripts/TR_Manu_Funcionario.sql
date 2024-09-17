CREATE OR REPLACE TRIGGER Tr_Manu_Funcionario
	AFTER INSERT OR UPDATE OR DELETE ON Flp_Funcionarios
	FOR EACH ROW
DECLARE
	Json     VARCHAR2(4000);
	v_Senha  VARCHAR2(10);
	Operacao INTEGER;
	Codigo   Flp_Funcionarios.Codintfunc%TYPE;
BEGIN
	Codigo := :NEW.Codintfunc;
	IF Inserting THEN
		Return;
	ELSIF Updating THEN
		Operacao := 1;
	ELSE
		Operacao := 2;
		Codigo   := :OLD.Codintfunc;
	END IF;

	BEGIN
		SELECT Senhausu
		  INTO v_Senha
		  FROM Man_Senhafunc
		 WHERE Codintfunc = Codigo;
	
		Json := '''codintfunc'':'     || Codigo             || ','   || 
              '''codfunc'':"'       || :NEW.Codfunc       || '", ' || 
              '''chapafunc'':"'     || :NEW.Chapafunc     || '", ' || 
              '''nomefunc'':"'      || :NEW.Nomefunc      || '", ' || 
              '''apelidofunc'':"'   || :NEW.Apelidofunc   || '", ' || 
              '''codigoempresa'':"' || :NEW.Codigoempresa || '", ' ||
				  '''codigofl'':"'      || :NEW.Codigofl      || '", ' || 
              '''senhausu'':"'      || v_Senha            || '"';
	
		Pr_Manu_Insert_Json('man_senhafunc', Operacao, Json);
	EXCEPTION
		WHEN OTHERS THEN
			Json := '';
	END;
END Tr_Manu_Funcionario;