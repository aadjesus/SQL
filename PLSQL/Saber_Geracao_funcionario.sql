  SELECT GERACAO
       , COUNT(*)
    FROM (    SELECT CASE WHEN EXTRACT(YEAR FROM B.DTNASCTOFUNC) BETWEEN 2010 AND EXTRACT(YEAR FROM SYSDATE) THEN 'GERA��O ALFA'
                          WHEN EXTRACT(YEAR FROM B.DTNASCTOFUNC) BETWEEN 1996 AND 2010                       THEN 'GERA��O Z'
                          WHEN EXTRACT(YEAR FROM B.DTNASCTOFUNC) BETWEEN 1981 AND 1995                       THEN 'GERA��O Y'
                          WHEN EXTRACT(YEAR FROM B.DTNASCTOFUNC) BETWEEN 1965 AND 1980                       THEN 'GERA��O X'
                          WHEN EXTRACT(YEAR FROM B.DTNASCTOFUNC) BETWEEN 1946 AND 1964                       THEN 'BABY BOOMER'
                     END AS GERACAO
                FROM CTR_CADASTRODEUSUARIOS A
          INNER JOIN FLP_FUNCIONARIOS B ON A.CODINTFUNC = B.CODINTFUNC
               WHERE EXISTS (SELECT 1
                               FROM ACD_INFORMACOESGERAIS C
                              WHERE A.USUARIO = C.USUARIORESPABERTURA))
GROUP BY GERACAO                      
