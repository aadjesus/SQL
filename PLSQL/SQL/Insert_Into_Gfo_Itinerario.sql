--@c:\Users\alessandro.augusto\Documents\SQL\Insert_Into_Gfo_Itinerario.sql;
set head off
SET ECHO OFF
SET FEEDBACK OFF
SET PAGESIZE 50000
SPOOL C:\Temp\Insert_Into_GFO_ITINERARIO.SQL;

Select 'Insert  Into  GFO_ITINERARIO( codintlinha,id_itinerario ,vigencia_inicial ,ativo ) Values ( ' 
       || a.codintlinha
       ||','
       || To_char(a.id_itinerario + (Select Max(c.id_itinerario) 
                                       From GFO_ITINERARIO c 
                                      Where c.codintlinha      = a.codintlinha 
                                        And c.vigencia_inicial = a.vigencia_inicial))
       ||','
       || 'TO_DATE(''12/07/2010 00:00:00'',''DD/MM/YYYY HH24:MI:SS'')'
       ||','''
       || a.ativo 
       || ''');'  
  From GFO_ITINERARIO a
 Where a.VIGENCIA_INICIAL In (Select Max(b.VIGENCIA_INICIAL) 
                                From GFO_ITINERARIO b
                               Where VIGENCIA_INICIAL < TO_DATE('12/07/2010 00:00:00','DD/MM/YYYY HH24:MI:SS')
                                 And a.codintlinha = b.codintlinha)
   And a.codintlinha In (4,13,19,23,25,29,30,52,118,152,153,154,158,181,191,193,194)
Order By a.codintlinha, a.id_itinerario;

SPOOL Off
/
@C:\Temp\Insert_Into_GFO_ITINERARIO.Sql;