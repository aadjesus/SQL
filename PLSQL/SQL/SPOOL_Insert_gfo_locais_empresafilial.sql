set head off
SET ECHO OFF
SET FEEDBACK OFF
SET PAGESIZE 50000
SPOOL v:\Temp\Insert_gfo_locais_empresafilial.SQL;

Select Distinct 'Insert Into gfo_locais_empresafilial(codigoempresa,codigofl,cod_localidade) Values (' 
       || b.codigoempresa
       ||','
       || b.codigofl
       ||','
       || a.cod_localidade
       || ');'
  From gfo_itinerario_itens a
     , bgm_cadlinhas b
 Where a.codintlinha = b.codintlinha
   And b.codigoempresa <> 8;
   
SPOOL Off
/
@v:\Temp\Insert_gfo_locais_empresafilial.SQL;
Commit;   