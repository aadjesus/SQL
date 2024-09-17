------------------------------------------------------------------
-- Complemento
------------------------------------------------------------------
Create Table CRD_Cad_Compl_Ciranda2013(
       Cod_Cad_Compl        Number        Not Null
      ,ObsCadCompl          Varchar2(255)   
      ,Compl_Cad_Compl      Varchar2(255)
      );     

Alter Table CRD_Cad_Compl_Ciranda2013 
Add(Constraint Pk_CRDCadComplCiranda2013
Primary Key(Cod_Cad_Compl) Using Index
Tablespace Globus_Index);
------------------------------------------------------------------
-- Cadastro
------------------------------------------------------------------
Create Table CRD_Cad_Ciranda2013(
       Cod_Int_Cad     Number        Not Null
      ,Cod_Cad         Varchar2(3)   
      ,Desc_Cad        Varchar2(255) 
      ,Tipo_Cad        Varchar2(1)   -- a \ b \ c
      ,Status_Cad      Number(1)     -- 0 \ 1 \ 2
      ,Cod_Cad_Compl   Number
      ,Ativo_Cad       Varchar2(1)  default 'S'
      );

Alter Table CRD_Cad_Ciranda2013
Add(Constraint Pk_CRD_CadCiranda2013
Primary Key(Cod_Int_Cad) Using Index
Tablespace Globus_Index);

Alter Table CRD_Cad_Ciranda2013 
Add(Constraint Fk_CRDCadComplCiranda2013
Foreign Key(Cod_Cad_Compl) 
References CRD_Cad_Compl_Ciranda2013);
------------------------------------------------------------------
-- Movimentacao
------------------------------------------------------------------
Create Table CRD_Mov_Ciranda2013(
       Cod_Int_Mov     Number        Not Null
      ,Cod_Int_Cad     Number        Not Null
      ,Cod_Emp         Number        Not Null
      ,Cod_Fil         Number        Not Null
      ,Data_Mov        Date          
      ,Hora_Mov        Date          
      );     

Alter Table CRD_Mov_Ciranda2013
Add(Constraint Pk_CRD_MovCiranda2013
Primary Key(Cod_Int_Mov) Using Index
Tablespace Globus_Index);
      
Alter Table CRD_Mov_Ciranda2013 
Add(Constraint Fk_CRD_CadCiranda2013
Foreign Key(Cod_Int_Cad) 
References CRD_Cad_Ciranda2013);
------------------------------------------------------------------
-- Itens Movimentacao
------------------------------------------------------------------
Create Table CRD_Item_Ciranda2013(
       Cod_Int_Item    Number        Not Null
      ,Cod_Int_Mov     Number        Not Null
      ,Tipo_MOv        Varchar2(1)   
      ,Seq_Mov         Number
      ,Qtde_Mov        Number(10,2)
      ,Valor1_Mov      Number(10,2)
      ,Valor2_Mov      Number(10,2)
      ,Desconto_Mov    Number(10,2)
      ,Total_Mov       Number(10,2)
      );     

Alter Table CRD_Item_Ciranda2013
Add(Constraint Pk_CRDItemCiranda2013
Primary Key(Cod_Int_Item) Using Index
Tablespace Globus_Index);
      
Alter Table CRD_Item_Ciranda2013 
Add(Constraint Fk_CRDMovCiranda2013
Foreign Key(Cod_Int_Mov) 
References CRD_Mov_Ciranda2013);
------------------------------------------------------------------
-- Cadastro de funcionarios
------------------------------------------------------------------
create table FLP_FUNCIONARIOS_Teste
(
  CODINTFUNC          NUMBER not null,
  CODIGOUF            VARCHAR2(3),
  CODRACA             NUMBER(2),
  CODVINC             NUMBER(2),
  CODREGIAO           NUMBER(3),
  CODBANCO            NUMBER(3),
  CODIGOEMPRESA       NUMBER(3),
  CODAGENCIA          NUMBER(5),
  CODIGOFL            NUMBER(3),
  CODFUNC             VARCHAR2(6),
  CODTPADM            NUMBER(2),
  CODESTCIV           NUMBER(2),
  CODINSTR            NUMBER(2),
  CODNAC              NUMBER(2),
  CODASMED_BKP        NUMBER(3),
  CONTSINDIFUNC       VARCHAR2(1),
  TIPOFUNC            VARCHAR2(1),
  CONTACORFUNC        VARCHAR2(15),
  FONEFUNC            VARCHAR2(15),
  LOCALNASTOFUNC      VARCHAR2(20),
  APELIDOFUNC         VARCHAR2(30),
  ENDBAIRROFUNC       VARCHAR2(20),
  ENDCIDADEFUNC       VARCHAR2(20),
  NOMEFUNC            VARCHAR2(30),
  ENDRUAFUNC          VARCHAR2(30),
  ENDCOMPLFUNC        VARCHAR2(20),
  DIASEXPERFUNC       NUMBER(2),
  DTADMFUNC           DATE,
  DTNASCTOFUNC        DATE,
  DTTRANSFFUNC        DATE,
  SOCIOSINDIFUNC      VARCHAR2(1),
  SITUACAOFUNC        VARCHAR2(1),
  RECEBEADTFUNC       VARCHAR2(1),
  INCINSSFUNC         VARCHAR2(1),
  INCIRFFUNC          VARCHAR2(1),
  INCFGTSFUNC         VARCHAR2(1),
  CESTABASICAFUNC     VARCHAR2(1),
  VALEREFEICFUNC      VARCHAR2(1),
  SEXOFUNC            VARCHAR2(1),
  JORNADAFUNC         NUMBER(5,2),
  ENDNRFUNC           VARCHAR2(5),
  DTAPOSENTFUNC       DATE,
  ENDCEPFUNC          NUMBER(8),
  ENDPTREFERFUNC      VARCHAR2(70),
  EMITEXTRFUNC        VARCHAR2(1),
  TIPOSANGUEFUNC      VARCHAR2(3),
  EMAILFUNC           VARCHAR2(80),
  IMPRCARTPTOFUNC     VARCHAR2(1),
  BATEPTOELETRFUNC    VARCHAR2(1),
  LIVRODEPTOFUNC      VARCHAR2(1),
  ESCALAREVEZFUNC     VARCHAR2(1),
  TEMFREQUENFUNC      VARCHAR2(1),
  CHAPAFUNC           VARCHAR2(6),
  SENHACARTAOFUNC     VARCHAR2(15),
  NOMECOMPLETOFUNC    VARCHAR2(60),
  CODIGOUFNASCTO      VARCHAR2(3),
  DATAAVISOPREVIOFUNC DATE,
  TEMCOMPLEMFUNC      VARCHAR2(1),
  TIPOAVISOFUNC       VARCHAR2(1),
  CODINTANTERIOR      NUMBER,
  TIPOCONTA           NUMBER(1) ,
  DIASPRORROGACAOFUNC NUMBER(2),
  FONE2FUNC           VARCHAR2(15),
  CODMOTAPOSENT       NUMBER(2),
  CODGARSAL           NUMBER(3),
  USUARIOALTER        VARCHAR2(15),
  CODHORA_BKP         NUMBER(3),
  CODESCALA_BKP       NUMBER(3),
  CODINTCUR           NUMBER
);

Alter Table FLP_FUNCIONARIOS_Teste
Add(Constraint Pk_FLPFUNCIONARIOSteste
Primary Key(CODINTFUNC) Using Index
Tablespace Globus_Index);
