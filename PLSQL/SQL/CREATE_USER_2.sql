DROP USER GLOBUS_ADM CASCADE;
DROP USER GLOBUS_SIS CASCADE;

CREATE USER GLOBUS_ADM IDENTIFIED BY GLOBUS_ADM;
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
   TO GLOBUS_ADM;

--CREATE OR REPLACE SYNONYM version_info FOR RIODOCE_ENC.enc7_version_info;

CREATE USER GLOBUS_SIS IDENTIFIED BY GLOBUS_SIS;
GRANT UNLIMITED TABLESPACE
    , CONNECT
    , CREATE synonym 
    , select any sequence
    , select any table
    , insert any table
    , update any table
    , delete any table
   TO GLOBUS_SIS;

--CREATE OR REPLACE SYNONYM version_info FOR GLOBUS_ADM.version_info;
   
--select * from user_objects
--select * from version_info
--SELECT * FROM DBA_TAB_PRIVS
