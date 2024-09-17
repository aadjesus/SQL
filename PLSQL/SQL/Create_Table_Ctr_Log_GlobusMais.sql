Create Table GLB_Log_2013_01(
       ID                  Number        Not Null
      ,Sistema             Varchar2(3)   Not Null
      ,Usuario             Varchar2(15)  Not Null
      ,Tipo                Varchar2(255) Not Null -- Salvar o tipo do botão
      ,Data                Date          Not Null
      ,Usuario_Sac         Varchar2(15)
      ,Usuario_SO          Varchar2(255)
      ,Terminal            varchar2(255)
      ,Ip_Adress           varchar2(50)
      
      ,Tela                Varchar2(255) Not Null
      ,Titulo_Campos_Chave varchar2(4000) 
      ,Valor_Campos_Chave  varchar2(4000) 
      ,Texto               Long
      );     

Create Table Ctr_Log_GlobusMais(
       ID          Number        Not Null
      ,Sistema     Varchar2(3)   Not Null
      ,Usuario     Varchar2(15)  Not Null
    --  ,Tela        Varchar2(255) Not Null
      ,Tipo        Varchar2(1)   Not Null -- Inclusão \ Alteração \ Exclusão
      ,Data        Date          Not Null
      );
      
Create Table Ctr_Log_GlobusMaisDados(
       ID                  Number         Not Null
      ,ID_LOG              Number         Not Null
      ,Data                Date           Not Null

      ,Usuario_Sac         Varchar2(15)
      ,Usuario_SO          Varchar2(255)
      ,Terminal            varchar2(255) 
      ,Ip_Adress           varchar2(50)

      ,Titulo_Campos_Chave varchar2(255) 
 --     ,Valor_Campos_Chave  varchar2(255) 
      ,Texto               Long
      );     

Alter Table Ctr_Log_GlobusMais Add(Constraint Pk_Ctr_Log_GlobusMais
                                   Primary Key(ID) Using Index
                                   Tablespace Globus_Index);

Alter Table Ctr_Log_GlobusMaisDados Add(Constraint Pk_Ctr_Log_GlobusMaisDados
                                        Primary Key(ID) Using Index
                                        Tablespace Globus_Index);
      
Alter Table Ctr_Log_GlobusMaisDados Add(Constraint Fk_Ctr_Log_GlobusMais
                                        Foreign Key(ID) 
                                        References Ctr_Log_GlobusMais);
      
      
-- Controlar por quantidade ex:
-- Consultar as informações por: "Sistema + Usuario + Tela + Tipo"
-- e ir fazendo os insertes ate chegar a uma determinada quantidade definida, quando atingir essa quantidade fazer update e não mais insert

--select count(*) from ctr_log a where a.textolog like '%Incluiu O.S. Corretiva de No :%'

