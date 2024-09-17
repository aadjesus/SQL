Create Table GL5_Log(
       ID                   Number        Not Null
      ,Sistema              Varchar2(3)   Not Null
      ,Usuario              Varchar2(15)  Not Null
      ,Data                 Date          Not Null
      ,TipoBotao            Varchar2(1)            -- Quando não tiver "Tipo_Botao\Item_de_menu\Nome_Assembly" execução manual
      ,ItemDeMenu           Varchar2(500) 
      ,NomeAssembly         Varchar2(500) 
      ,TituloCamposChave    Varchar2(4000) 
      ,ValorCamposChave     Varchar2(4000) 
      ,Complemento          Varchar2(4000) 
      ,CheckSum             Varchar2(4000) 
      );
     
Alter Table GL5_Log
Add Constraint Pk_GL5Log
Primary Key(ID) Using Index
Tablespace Globus_Index;

Alter Table GL5_Log
Add Constraint Fk_GL5LogCTRSistemas
Foreign Key(Sistema) 
References  ctr_cadastrosistemas;

Alter Table GL5_Log
Add Constraint Fk_GL5LogCTRUsuarios
Foreign Key(Usuario) 
References  ctr_cadastrodeusuarios;

Create Table GL5_Log_Campo(
       ID                   Number        Not Null
      ,IDlog                Number        Not Null
      ,TipoCampo            Varchar2(1)   Not Null -- Chave/Obrigatório/Default
      ,TituloCampo          Varchar2(500) Not Null
      ,ValorCampo           Varchar2(500)
      );

Alter Table GL5_Log_Campo
Add Constraint Pk_GL5LogCampo
Primary Key(ID) Using Index
Tablespace Globus_Index;     


alter table GL5_Log_Campo
  add constraint Fk_GL5LogGL5Campo foreign key (ID_log)
  references GL5_Log (ID)
  ON DELETE CASCADE;         
      
Create Table GL5_Log_sac(
       ID                   Number        Not Null
      ,IDlog                Number        Not Null
      ,CodigoFuncionario    Varchar2(3)   Not Null
      ,UsuarioSO            Varchar2(500)
      ,Terminal             Varchar2(500)
      ,IpAdress             Varchar2(500)
      ,Motivo               Varchar2(500)         
      );   

Alter Table GL5_Log_sac
Add Constraint Pk_GL5LogSac
Primary Key(ID) Using Index
Tablespace Globus_Index;      

alter table GL5_Log_sac
  add constraint Fk_GL5LogGL5Sac foreign key (ID_log)
  references GL5_Log (ID) 
  ON DELETE CASCADE;

Alter Table GL5_Log
Add Constraint Fk_GL5LogCTRUsuarios
Foreign Key(CodigoFuncionario) 
References CTR_FUNCIONARIOSAC;     

create sequence SEQ_GL5_Log
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20
order;

create sequence SEQ_GL5_Log_Campo
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20
order;

create sequence SEQ_GL5_Log_sac
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20
order;

