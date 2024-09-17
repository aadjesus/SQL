create user Ciranda2013
  identified by "Ciranda2013"
  default tablespace GLOBUS_TABLE
  temporary tablespace GLB_TEMP
  profile DEFAULT;

grant dba to Ciranda2013;
grant select_catalog_role to Ciranda2013;

grant debug any procedure to Ciranda2013;
grant debug connect session to Ciranda2013;
grant select any table to Ciranda2013;
grant unlimited tablespace to Ciranda2013;

