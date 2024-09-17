DROP USER USER_MIGRATE CASCADE;
DROP USER USER_SISTEMA CASCADE;

CREATE USER USER_MIGRATE IDENTIFIED BY USER_MIGRATE;
GRANT UNLIMITED TABLESPACE
    , GRANT ANY PRIVILEGE
    , CONNECT
    , CREATE USER
    , CREATE SESSION
    , CREATE TRIGGER 
    , CREATE SEQUENCE 
    , CREATE PROCEDURE 
    , CREATE TABLE
    , CREATE synonym 
    , select any sequence
    , select any table
    , insert any table
    , update any table
    , delete any table
   TO USER_MIGRATE;

--CREATE OR REPLACE SYNONYM version_info FOR RIODOCE_ENC.enc7_version_info;

CREATE USER USER_SISTEMA IDENTIFIED BY USER_SISTEMA;
GRANT UNLIMITED TABLESPACE
    , CONNECT
    , CREATE synonym 
    , select any sequence
    , select any table
    , insert any table
    , update any table
    , delete any table
   TO USER_SISTEMA;

--CREATE OR REPLACE SYNONYM version_info FOR USER_MIGRATE.version_info;
   
--select * from user_objects
--select * from version_info
--SELECT * FROM DBA_TAB_PRIVS
