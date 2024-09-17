conn COMPORTE110303/COMPORTE110303@ORA10G

create user aaugusto identified by aaugusto
default tablespace globus_table
--temporary tablespace temp
;
grant create session to aaugusto;
grant connect to aaugusto;
grant resource to aaugusto;

grant unlimited tablespace to aaugusto;
grant create synonym to aaugusto;
grant create any table to aaugusto;
 
conn aaugusto/aaugusto@ORA10G 

Create Table Hands_On_Globus(Codigo Number
                            ,Data_Alteracao Date
                            ,Exibe_Em_Relatorios Varchar2(1)
                            ,Descricao Varchar2(50) Not Null
                            
                            );

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
