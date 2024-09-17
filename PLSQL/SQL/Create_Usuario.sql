--DROP USER AAUGUSTO CASCADE;
--CREATE USER AAUGUSTO IDENTIFIED BY AAUGUSTO DEFAULT TABLESPACE GLOBUS_TABLE;
--GRANT DBA TO AAUGUSTO;
--GRANT connect to AAUGUSTO;

conn COMPORTE110303/COMPORTE110303@ORA10G

DROP USER AAUGUSTO Cascade
CREATE USER AAUGUSTO IDENTIFIED BY AAUGUSTO DEFAULT TABLESPACE GLOBUS_TABLE-- TEMPORARY TABLESPACE TEMPORARY_DATA;
GRANT DBA TO AAUGUSTO;
GRANT CONNECT TO AAUGUSTO;

--ALTER USER SYS IDENTIFIED BY MANAGER;
--connect SYS/MANAGER@AAUGUSTO AS SYSDBA;
--grant select any table to Globus;
--grant select on v_$session to Globus;
--grant select_catalog_role to Globus;

--IMP CEAM1309/CEAM1309 FROMUSER=GLOBUS TOUSER=CEAM1309 FILE=TESTE.DMP LOG=CEAM1309.TXT
--grant sysdba, sysoper to AAUGUSTO;

--connect AAUGUSTO/AAUGUSTO;

--connect AAUGUSTO@AAUGUSTO;
--connect AAUGUSTO/AAUGUSTO as Sysoper;

conn AAUGUSTO/AAUGUSTO@ORA10G;

/*Create Table Hands_On_Globus(Codigo Number
                            ,Descricao Varchar2(50) Not Null);

Alter Table Hands_On_Globus Add(Constraint Pk_Hands_On_Globus
                                Primary Key(Codigo) Using Index
                                Tablespace Globus_Index);

create table CTR_MENUSAOUSUARIO
(
  USUARIO                 VARCHAR2(15) not null,
  SISTEMA                 VARCHAR2(3) not null,
  INDICEMENU              VARCHAR2(6) not null,
  NOME                    VARCHAR2(30) not null,
  CAPTION                 VARCHAR2(50),
  CHECKSUMMENU            VARCHAR2(10),
  TEMDIREITOEXCLUSAOMENU  VARCHAR2(1),
  TEMDIREITOINCLUSAOMENU  VARCHAR2(1),
  TEMDIREITOALTERACAOMENU VARCHAR2(1),
  FAVORITO                VARCHAR2(1) default 'N' not null
);

alter table CTR_MENUSAOUSUARIO  add(constraint XPKCTR_MENUSAOUSUARIO 
                                    primary key (USUARIO, SISTEMA, INDICEMENU, NOME) Using Index
                                    tablespace GLOBUS_INDEX);
*/