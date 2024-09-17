--c:\Users\alessandro.augusto\Documents\SQL\Insert_Into_Gfo_Itinerario_Dia.sql 
set head off
SET ECHO OFF
SET FEEDBACK OFF
SET PAGESIZE 50000
SPOOL C:\Temp\Insert_Into_GFO_ITINERARIO_DIA.SQL;

SELECT 'Insert Into GFO_ITINERARIO_DIA(CODINTLINHA,ID_ITINERARIO,DIA) Values ( ' 
       || a.codintlinha
       ||','
       || To_char(a.id_itinerario + (Select Max(c.id_itinerario) 
                                       From GFO_ITINERARIO c 
                                      Where c.codintlinha      = a.codintlinha 
                                        And c.vigencia_inicial = b.vigencia_inicial))
       ||','
       || a.dia
       || ') ;'
  FROM GFO_ITINERARIO_DIA     a
     , GFO_ITINERARIO          b
 WHERE a.codintlinha   = b.codintlinha
   And a.id_itinerario = b.id_itinerario
   And b.VIGENCIA_INICIAL In (Select Max(b.VIGENCIA_INICIAL) 
                                From GFO_ITINERARIO b
                               Where VIGENCIA_INICIAL < TO_DATE('12/07/2010 00:00:00','DD/MM/YYYY HH24:MI:SS')
                                 And a.codintlinha = b.codintlinha)
And a.codintlinha In (4,13,19,23,25,29,30,52,118,152,153,154,158,181,191,193,194)
ORDER BY a.codintlinha, a.id_itinerario, a.dia;

SPOOL Off
/
@C:\Temp\Insert_Into_GFO_ITINERARIO_DIA.SQL;


/*
SELECT 'Update t_esc_localidade set ' 
   || DECODE(A.DESC_LOCALIDADE,       '',  '',' DESC_LOCALIDADE      =''###' || a.desc_localidade      || '###''')
   || DECODE(A.LATITUDE,              '',  '',',LATITUDE             =''###' || A.LATITUDE             || '###''')
   || DECODE(A.LONGITUDE,             '',  '',',LONGITUDE            =''###' || A.LONGITUDE            || '###''')
   || DECODE(A.TIPO_LOCAL,          Null,Null,',TIPO_LOCAL           ='   || A.TIPO_LOCAL                  )
   || DECODE(A.DESCRICAO_DIVULGACAO,  '',  '',',DESCRICAO_DIVULGACAO =''###' || A.DESCRICAO_DIVULGACAO || '###''')
   
   || ' Where cod_localidade = ' || A.COD_LOCALIDADE
  FROM  t_esc_localidade    a
*/