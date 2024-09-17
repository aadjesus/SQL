/*
DELETE FROM MANU_CARGA_INICIAL WHERE TABLE_NAME in ('MAN_CADASTRODESERVICOS','EST_PARAMETRO','ABA_CADTIPOOLEOCOMBO');
COMMIT;
BEGIN 
      PR_MANU_CARGA_INICIAL(1);
END;
*/
SELECT a.*,ROWID FROM  manu_integracao a WHERE table_name = 'MAN_OS'
--DELETE manu_integracao
UPDATE manu_integracao SET etapa = 1 WHERE table_name = 'MAN_OS';
COMMIT;
--SELECT COUNT(*) FROM  manu_integracao a
--DELETE manu_integracao WHERE table_name <> 'MAN_OS'