--create tablespace escala_table datafile 'x:\oracle\oradata\orcl\esc_tbl.dat' size 30g online;
--create tablespace escala_index datafile 'x:\oracle\oradata\orcl\esc_idx.dat' size 30g online;
--conn sys/manager@globusserver as sysdba

create user Globus7 identified by Globus7 default tablespace GLOBUS_TABLE temporary tablespace temp;
grant dba to Globus7;
grant select any table to Globus7;
grant select_catalog_role to Globus7;
grant select on v_$session to Globus7;
grant select on DBA_TABLESPACES to Globus7;
grant select on DBA_TEMP_FILES  to Globus7;
grant select on DBA_SEGMENTS  to Globus7;
grant select on DBA_FREE_SPACE  to Globus7;
grant select on V_$SORT_SEGMENT  to Globus7;
grant select on DBA_DATA_FILES  to Globus7;
grant create session to Globus7;
grant unlimited tablespace to Globus7;
GRANT SELECT ON DBA_TABLES TO Globus7;

conn escalatesteale/escalatesteale@ora11g64

spool c:\temp\grant.SQL
select 'grant select,insert,delete,update on ' ||table_name|| ' to Globus7;' from user_tables;
spool off

@c:\temp\grant.sql;
grant create synonym to Globus7;
conn escalatesteale/escalatesteale@ora11g64

spool c:\temp\CriaEstrutura.sql
SELECT 'CREATE SYNONYM ' || TABLE_NAME || ' FOR ' ||OWNER|| '.' || TABLE_NAME|| ';'
FROM DBA_TABLES WHERE OWNER = 'ESCALATESTEALE'
/
spool off

@c:\temp\CriaEstrutura.sql;


