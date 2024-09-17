DELETE man_osfuncionarios WHERE Codintos = 947775;
DELETE man_osrealizado WHERE Codintos = 947775;
UPDATE Man_Os SET condicaoos = 'AB' WHERE Codintos = 947775;
DELETE ABA_MOVTANQUE WHERE datamovtanque >= '11-dec-2017';
DELETE ABA_TROCADEOLEO WHERE Dataabastcarro >= '11-dec-2017';
DELETE ABA_ITEMABASTCARRO WHERE dataabastcarro  >= '11-dec-2017';
DELETE Aba_Abastecimentocarro WHERE Dataabastcarro >= '11-dec-2017';
DELETE est_itensmovto WHERE datamovto >= '11-dec-2017';
DELETE est_movto WHERE datamovto >= '11-dec-2017';
DELETE EST_ITENSREQUISICAO WHERE numerorq IN (SELECT numerorq FROM EST_REQUISICAO  WHERE datarq >= '11-dec-2017');
DELETE EST_REQUISICAO WHERE datarq >= '11-dec-2017';
DELETE manu_integracao WHERE table_name = 'MAN_OS';
COMMIT;

SELECT * FROM EST_REQUISICAO WHERE numerorq = 1503367395
SELECT * FROM MAN_GRUPODESERVICO

SELECT * FROM
 EST_ITENSREQUISICAO WHERE numerorq IN (SELECT numerorq FROM EST_REQUISICAO  WHERE datarq >= '11-dec-2017');
 
SELECT * FROM manu_integracao 