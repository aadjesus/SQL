CREATE OR REPLACE TRIGGER Tr_Manu_Qtdematmarca
	AFTER INSERT OR UPDATE OR DELETE ON Est_Qtdematmarca
	FOR EACH ROW
DECLARE
	v_Json           VARCHAR2(4000);
	v_Codigomatint   NUMBER;
	v_Codigolocal    NUMBER(3);
	v_Codigomarcamat NUMBER(4);
	v_Codigotpoleo   VARCHAR2(4);
BEGIN
	BEGIN
		v_Codigomatint   := (CASE WHEN Deleting THEN :OLD.Codigomatint ELSE :NEW.Codigomatint END);
		v_Codigolocal    := (CASE WHEN Deleting THEN :OLD.Codigolocal ELSE :NEW.Codigolocal END);
		v_Codigomarcamat := (CASE WHEN Deleting THEN :OLD.Codigomarcamat ELSE :NEW.Codigomarcamat END);
	
		SELECT Codigotpoleo
		  INTO v_Codigotpoleo
		  FROM Aba_Cadtipooleocombo
		 WHERE Codigomatint = v_Codigomatint
			AND Codigolocal = v_Codigolocal
			AND Codigomarcamat = v_Codigomarcamat
         AND tipotpoleo IN ('CB','DI','MO');        
	
		v_Json := '''codigotpoleo'': "' || v_Codigotpoleo || '", ' || '''qtdematmarca'': "' || (CASE WHEN Deleting THEN 0 ELSE :NEW.Qtdematmarca END) || '"  ';
	
		Pr_Manu_Insert_Json('EST_QTDEMATMARCA', 1, v_Json);
	EXCEPTION
		WHEN OTHERS THEN
			v_Json := '';
	END;
END Tr_Manu_Qtdematmarca;