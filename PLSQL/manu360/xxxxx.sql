BEGIN
CREATE TABLE Manu_Analise
(
  maquina    VARCHAR2(30),
  DATA  Date default SYSDATE
); 

	CREATE OR REPLACE TRIGGER Tr_Manu_Integracao AFTER INSERT OR UPDATE OR DELETE ON Manu_Integracao FOR EACH ROW DECLARE v_maquina VARCHAR2(50);
	BEGIN
   
		SELECT SYS_CONTEXT('USERENV','TERMINAL')
		  INTO v_maquina
		  FROM Dual;	   

		INSERT INTO Manu_Analise
			(maquina)
		VALUES
			(v_maquina);
	END Tr_Manu_Integracao;
END;

DELETE Manu_Analise
SELECT * FROM Manu_Analise