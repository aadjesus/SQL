SELECT TO_DATE('01/01/0001 ' || TO_CHAR(A.HORARIO_INICIAL,'HH24:MI:SS'),'DD/MM/YYYY HH24:MI:SS'), A.*
  FROM GFO_ITINERARIO_HR_ITENS A, GFO_ITINERARIO_HR_DIA B      
 WHERE A.CODINTLINHA     = 4055  
   AND A.CODINTLINHA     = B.CODINTLINHA 
   AND A.ID_ITINERARIO   = B.ID_ITINERARIO 
   AND A.HORARIO_INICIAL = B.HORARIO_INICIAL
   AND B.DIA             = TO_CHAR(TO_DATE('04/02/2010 10:00:00','DD/MM/YYYY HH24:MI:SS'),'D')
   AND A.COD_LOCALIDADE IN (SELECT COD_LOCALIDADE
                              FROM T_ESC_LOCALIDADE
                             WHERE TIPO_LOCAL IN (SELECT TIPO_LOCAL
                                                    FROM GFO_TIPOLOCAL
                                                   WHERE PONTO_CONTROLE = 'S'))   
   AND A.ID_ITINERARIO IN (SELECT ID_ITINERARIO
                             FROM GFO_ITINERARIO_HR
                            WHERE CODINTLINHA = 4055
                              AND HORARIO_INICIAL <= TO_DATE('01/01/0001 10:00:00','DD/MM/YYYY HH24:MI:SS') 
                              AND HORARIO_FINAL >= TO_DATE('01/01/0001 10:00:00','DD/MM/YYYY HH24:MI:SS')                            
                              AND VIGENCIA_INICIAL = (SELECT MAX(VIGENCIA_INICIAL)
                                                        FROM GFO_ITINERARIO_HR 
                                                       WHERE CODINTLINHA = 4055
                                                         AND VIGENCIA_INICIAL <= TO_DATE('04/02/2010 10:00:00','DD/MM/YYYY HH24:MI:SS') 
                                                         AND HORARIO_INICIAL <= TO_DATE('01/01/0001 10:00:00','DD/MM/YYYY HH24:MI:SS') 
                                                         AND HORARIO_FINAL >= TO_DATE('01/01/0001 10:00:00','DD/MM/YYYY HH24:MI:SS'))) 
   AND A.HORARIO_INICIAL IN (SELECT HORARIO_INICIAL
                               FROM GFO_ITINERARIO_HR
                              WHERE CODINTLINHA = 4055
                                AND HORARIO_INICIAL <= TO_DATE('01/01/0001 10:00:00','DD/MM/YYYY HH24:MI:SS') 
                                AND HORARIO_FINAL >= TO_DATE('01/01/0001 10:00:00','DD/MM/YYYY HH24:MI:SS') 
                                AND VIGENCIA_INICIAL = (SELECT MAX(VIGENCIA_INICIAL)
                                                          FROM GFO_ITINERARIO_HR
                                                         WHERE CODINTLINHA = 4055
                                                           AND VIGENCIA_INICIAL <= TO_DATE('04/02/2010 10:00:00','DD/MM/YYYY HH24:MI:SS') 
                                                           AND HORARIO_INICIAL <= TO_DATE('01/01/0001 10:00:00','DD/MM/YYYY HH24:MI:SS') 
                                                           AND HORARIO_FINAL >= TO_DATE('01/01/0001 10:00:00','DD/MM/YYYY HH24:MI:SS')))