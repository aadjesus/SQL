select a.tablespace_name 
       --sum(a.bytes) / 1024 / 1024 / 1024 tamanho_GB
       , a.*
  from dba_segments a
Where   a.tablespace_name In ( 'GLOBUS_TABLE','GLOBUS_INDEX')
--group by tablespace_name  

SELECT *--name, value
FROM gv$parameter
--WHERE name LIKE 'db%name';


--SELECT * FROM USER_RECYCLEBIN
--select * from ALL_ERRORS
--sELECT *       FROM   all_objects
--sELECT *       FROM   V$DIAG_CRITICAL_ERROR
--select * from all_catalog a Where a.owner = 'SYS' And a.table_name Like '%ERRO%'
--select * from dict Where table_name Like '%ERRO%'
select utl_http.request('http://www.google.com.br') from dual