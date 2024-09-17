CREATE OR REPLACE TRIGGER Tr_Manu_Senhafuncionario
	AFTER INSERT OR UPDATE OR DELETE ON Man_Senhafunc
	FOR EACH ROW
DECLARE
	Json            VARCHAR2(4000);
	v_Codfunc       Flp_Funcionarios.Codfunc%TYPE;
	v_Chapafunc     Flp_Funcionarios.Chapafunc%TYPE;
	v_Nomefunc      Flp_Funcionarios.Nomefunc%TYPE;
	v_Apelidofunc   Flp_Funcionarios.Apelidofunc%TYPE;
	v_Codigoempresa Flp_Funcionarios.Codigoempresa%TYPE;
	v_Codigofl      Flp_Funcionarios.Codigofl%TYPE;
	Operacao        INTEGER;
	Codigo          Man_Senhafunc.Codintfunc%TYPE;
	Senha           Man_Senhafunc.Senhausu%TYPE;
BEGIN
	Codigo := :NEW.Codintfunc;
	Senha := :NEW.Senhausu;
	
	IF Deleting OR Senha IS NULL THEN
		Return;
	END IF;
	
	IF Inserting THEN
		Operacao := 0;		    
	ELSE
		Operacao := 1;
	END IF;

	SELECT Codfunc
			,Chapafunc
			,Nomefunc
			,Apelidofunc
			,Codigoempresa
			,Codigofl
	  INTO v_Codfunc
			,v_Chapafunc
			,v_Nomefunc
			,v_Apelidofunc
			,v_Codigoempresa
			,v_Codigofl
	  FROM Flp_Funcionarios
	 WHERE Codintfunc = Codigo;

	Json := '''codintfunc'':'      || Codigo          || ','   || 
           '''codfunc'':"'        || v_Codfunc       || '", ' || 
           '''chapafunc'':"'      || v_Chapafunc     || '", ' || 
           '''nomefunc'':"'       || v_Nomefunc      || '", ' || 
           '''apelidofunc'':"'    || v_Apelidofunc   || '", ' || 
           '''codigoempresa'':"'  || v_Codigoempresa || '", ' || 
           '''codigofl'':"'       || v_Codigofl      || '", ' || 
           '''senhausu'':"'       || Senha   || '"';

	Pr_Manu_Insert_Json('man_senhafunc', Operacao, Json);

END Tr_Manu_Senhafuncionario;