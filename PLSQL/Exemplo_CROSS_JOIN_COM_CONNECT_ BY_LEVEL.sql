    SELECT A.ID AS ID_INTEGRACAO
         , B.CODCLI
         , B.TPINSCRICAOCLI
         , B.CONDICAOCLI
         , B.INSCESTADUALCLI
         , B.NRINSCRICAOCLI
         , B.RSOCIALCLI
         , B.NFANTASIACLI
         , B.INSCMUNICIPALCLI
         , B.COD_SUFRAMA
         , DECODE(B.CLI_OPT_SIMPLES_NACIONAL,'S',1,3) AS REGIME_TRIBUTARIO
         , DECODE(B.CLI_OPT_SIMPLES_NACIONAL,'S',3,1) AS TIPO_LUCRO
         , B.CIDADECLI
         , B.CODIGOUF
         , B.CODMUNIC
         , B.CEPCLI
         , B.ENDERECOCLI
         , B.NR_ENDERECO
         , B.COMPLCLI
         , B.BAIRROCLI
         , B.TELEFONECLI
         , B.CONTATOCLI
         , B.SIGLA_PAIS
         , C.CODIGOMUNICFEDERAL
         , D.CODIGOEMPRESA 
      FROM SFKMM_INTEGRACAO A
INNER JOIN BGM_CLIENTE      B ON A.VALORESPK  = B.CODCLI
 LEFT JOIN DVS_MUNICIPIO    C ON B.CODMUNIC   = C.CODMUNIC
CROSS JOIN (    SELECT DECODE(LEVEL, 1, 9, 2, 2) AS CODIGOEMPRESA 
                  FROM DUAL 
            CONNECT BY LEVEL <= 2) D
    WHERE A.NOMETABELA  = 'BGM_CLIENTE' 
      AND A.ETAPA       = 1
      AND B.CONDICAOCLI = 'A'
 ORDER BY A.DATA

 /*


update SFKMM_INTEGRACAO
set etapa = 0;
commit;

*/