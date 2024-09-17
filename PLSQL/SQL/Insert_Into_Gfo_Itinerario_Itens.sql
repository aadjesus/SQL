--c:\Users\alessandro.augusto\Documents\SQL\Insert_Into_Gfo_Itinerario_Itens.sql 
set head off
SET ECHO OFF
SET FEEDBACK OFF
SET PAGESIZE 50000
SPOOL C:\Temp\Insert_Into_GFO_ITINERARIO_ITENS.SQL;

SELECT 'Insert Into GFO_ITINERARIO_ITENS(CODINTLINHA,ID_ITINERARIO,SENTIDO,SEQUENCIAL,TIPO_LOCAL,COD_LOCALIDADE,DISTANCIA,TEMPO) Values ( ' 
       || a.codintlinha
       ||','
       || To_char(a.id_itinerario + (Select Max(c.id_itinerario) 
                                       From GFO_ITINERARIO c 
                                      Where c.codintlinha      = a.codintlinha 
                                        And c.vigencia_inicial = b.vigencia_inicial))
       ||','''
       || a.sentido
       ||''','
       || a.sequencial
       ||','
       || a.tipo_local
       ||','
       || a.cod_localidade
       ||','
       || a.distancia
       ||','
       || 'TO_DATE('''
       || TO_CHAR(a.tempo,'DD/MM/YYYY HH24:MI:SS')
       || ''',''DD/MM/YYYY HH24:MI:SS'')'
       || ');'       
  FROM GFO_ITINERARIO_ITENS a
     , GFO_ITINERARIO       b
 WHERE a.codintlinha   = b.codintlinha
   And a.id_itinerario = b.id_itinerario
   And b.VIGENCIA_INICIAL In (Select Max(b.VIGENCIA_INICIAL) 
                                From GFO_ITINERARIO b
                               Where VIGENCIA_INICIAL < TO_DATE('12/07/2010 00:00:00','DD/MM/YYYY HH24:MI:SS')
                                 And a.codintlinha = b.codintlinha)
And a.codintlinha In (4,13,19,23,25,29,30,52,118,152,153,154,158,181,191,193,194)
ORDER BY a.codintlinha, a.id_itinerario, a.SEQUENCIAL;

SPOOL Off
/
@C:\Temp\Insert_Into_GFO_ITINERARIO_ITENS.SQL;