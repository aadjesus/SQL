/* Procedimento a ser realizado para criar o usuário */
/* Nessa primeira linha abaixo, colocar a senha do usuário sys. Ex: conn sys/senha@globusserver as sysdba por conn sys/manager@globusserver as sysdba */
/* Trocar a senha do usuário globus(se for diferente de globus. Ex: conn globus/globus@globusserver por conn globus/senha_real@globusserver */

conn sys/manager@globusserver as sysdba

create user smartway identified by smartway
	default tablespace globus_table
	temporary tablespace temp;

grant dba to smartway;
grant select any table to smartway;
grant select_catalog_role to smartway;
grant select on v_$session to smartway;
grant select on DBA_TABLESPACES to smartway;
grant select on DBA_TEMP_FILES  to smartway;
grant select on DBA_SEGMENTS  to smartway;
grant select on DBA_FREE_SPACE  to smartway;
grant select on V_$SORT_SEGMENT  to smartway;
grant select on DBA_DATA_FILES  to smartway;
grant create session to smartway;
grant unlimited tablespace to smartway;
GRANT SELECT ON DBA_TABLES TO smartway;

conn globus/globus@globusserver
spool c:\temp\grant.sql
select 'grant select,insert,delete,update on ' ||table_name|| ' to smartway;' from user_tables;
spool off

@c:\temp\grant.sql;
spool c:\temp\grant_execute.sql
select 'grant execute on ' ||object_name|| ' to smartway;' from user_objects where object_type in ('PROCEDURE','FUNCTION','PACKAGE','PACKAGE BODY');
spool off

@c:\temp\grant_execute.sql;
grant create synonym to smartway;
conn smartway/smartway@globusserver
spool c:\temp\CriaEstrutura.sql
SELECT 'CREATE SYNONYM ' || TABLE_NAME || ' FOR ' ||OWNER|| '.' || TABLE_NAME|| ';'
FROM DBA_TABLES WHERE OWNER = 'GLOBUS'
/
spool off

@c:\temp\CriaEstrutura.sql;


