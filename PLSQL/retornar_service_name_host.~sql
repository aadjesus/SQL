SELECT i.host_name                                AS servidor_host
     , SYS_CONTEXT('USERENV','SERVICE_NAME')      AS service_name
     ,(SELECT REGEXP_SUBSTR(value, 'PORT=([0-9]+)',1,1,NULL,1) 
         FROM v$listener_network 
        WHERE type = 'LOCAL LISTENER' 
          AND ROWNUM = 1) AS listener_port
FROM v$instance i;


select * FROM v$instance i;
select * FROM v$listener_network


SELECT *
  FROM v$listener_network 
  WHERE type = 'LOCAL LISTENER' 
   AND ROWNUM = 1
          
          
          
"Data Source=(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=XE)));User ID=desenv;Password=desenv3128;"          
                          (ADDRESS=(PROTOCOL=TCP)(HOST=ORA19C.DOMAIN.LOCAL)(PORT=1521))