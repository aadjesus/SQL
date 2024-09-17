-----------------------------------------------------------------------------------------------------------------------------------------------------------------

insert into versioninfo (version, appliedon, description) values (22, sysdate, 'SIM58931_1');
insert into versioninfo (version, appliedon, description) values (35, sysdate, 'SIM59759_1');
insert into versioninfo (version, appliedon, description) values (44, sysdate, 'SIM59881_1');
insert into versioninfo (version, appliedon, description) values (47, sysdate, 'SIM59881_4');

-- insert into versioninfo (version, appliedon, description) values (53, sysdate, 'SIM59881_4');
-- insert into versioninfo (version, appliedon, description) values (55, sysdate, 'SIM59881_4');
-- insert into versioninfo (version, appliedon, description) values (61, sysdate, 'SIM59881_4');
-- insert into versioninfo (version, appliedon, description) values (64, sysdate, 'SIM59881_4');
-- insert into versioninfo (version, appliedon, description) values (67, sysdate, 'SIM59881_4');
-- insert into versioninfo (version, appliedon, description) values (69, sysdate, 'SIM59881_4');
-- insert into versioninfo (version, appliedon, description) values (73, sysdate, 'SIM59881_4');
-- insert into versioninfo (version, appliedon, description) values (74, sysdate, 'SIM59881_4');
-- insert into versioninfo (version, appliedon, description) values (75, sysdate, 'SIM59881_4');
-- insert into versioninfo (version, appliedon, description) values (77, sysdate, 'SIM59881_4');
-- insert into versioninfo (version, appliedon, description) values (81, sysdate, 'SIM59881_4');
-- insert into versioninfo (version, appliedon, description) values (84, sysdate, 'SIM59881_4');
-- insert into versioninfo (version, appliedon, description) values (85, sysdate, 'SIM59881_4');
-- insert into versioninfo (version, appliedon, description) values (89, sysdate, 'SIM59881_4');
-- insert into versioninfo (version, appliedon, description) values (92, sysdate, 'SIM59881_4');
-- insert into versioninfo (version, appliedon, description) values (95, sysdate, 'SIM59881_4');
-- insert into versioninfo (version, appliedon, description) values (97, sysdate, 'SIM59881_4');
-- insert into versioninfo (version, appliedon, description) values (98, sysdate, 'SIM59881_4');

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Create table
create table SII_SISTEMA
(
  CODSISTEMA           VARCHAR2(3) not null,
  NOMESISTEMA          VARCHAR2(40) not null,
  NOMEABREVIADOSISTEMA VARCHAR2(8)
);
-- Create/Recreate primary, unique and foreign key constraints 
alter table SII_SISTEMA
  add constraint XPKSII_SISTEMA primary key (CODSISTEMA)
  using index 
  tablespace GLOBUS_INDEX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Create table
create table SII_MODULO
(
  CODSISTEMA                VARCHAR2(3) not null,
  CODMODULO                 VARCHAR2(3) not null,
  DESCRICAOMODULO           VARCHAR2(40),
  ABREVIADOMODULO           VARCHAR2(3),
  DESCRITIVOMODULO          VARCHAR2(2000),
  DISPONIVEL_ATU            VARCHAR2(1) default 'S',
  ABREVIADOMODULO_DES       VARCHAR2(3),
  DATA_LANCTO               DATE default '01-jan-1900',
  ABREVIADOMODULO_QUALIDADE VARCHAR2(3),
  MODULO_INTEGRACAO         VARCHAR2(1) default 'N',
  VISUALIZA_MYTICKET        VARCHAR2(1) default 'N',
  DESCRICAO_MYTICKET        VARCHAR2(100),
  MODULOATIVO               VARCHAR2(1) default 'S',
  ID_MODULO                 NUMBER not null,
  SETOR_RESP                VARCHAR2(3),
  API_KEY_INTEGRADOR        VARCHAR2(200),
  TEAMPROJEC                VARCHAR2(50),
  AREAPATH                  VARCHAR2(50),
  ITERATIONPATH             VARCHAR2(200),
  --COD_SETOR_GLOBUS          NUMBER(2),
  TAMANHO_PORTAL            VARCHAR2(1) default 'S',
  NOME_EXECUTAVEL           VARCHAR2(200),
  NOME_EXE_GLBMAIS          VARCHAR2(200),
  DISPONIVEL_WEBCONCEDENTE  VARCHAR2(1)
);
-- Create/Recreate primary, unique and foreign key constraints 
alter table SII_MODULO
  add constraint XPK1SII_MODULO primary key (ID_MODULO)
  using index 
  tablespace GLOBUS_INDEX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Create table
create table SII_ASSOCIACLIENTEMODULO
(
  CODSISTEMA        VARCHAR2(3) not null,
  CODMODULO         VARCHAR2(3) not null,
  CODCONTRATO       VARCHAR2(15) not null,
  CODANEXOCONTRATO  VARCHAR2(15) not null,
  CODCLIENTE        VARCHAR2(6) not null,
  STATUSMODULO      VARCHAR2(2),
  HORAS_IMPLANTACAO NUMBER(10,2),
  HORAS_COMERCIAL   NUMBER(10,2)
);
-- Create/Recreate primary, unique and foreign key constraints 
alter table SII_ASSOCIACLIENTEMODULO
  add constraint XPKSII_ASSOCIACLIENTEMODULO primary key (CODSISTEMA, CODMODULO, CODCONTRATO, CODANEXOCONTRATO, CODCLIENTE)
  using index 
  tablespace GLOBUS_INDEX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 4M
    next 1M
    minextents 1
    maxextents unlimited
  );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Create table
create table SII_GRUPOSATENDIMENTO_FUNC
(
  CODIGO_GRUPO      NUMBER(6) not null,
  GRUPO_TIPO        NUMBER(1) not null,
  CODIGOFUNCIONARIO VARCHAR2(8) not null,
  FLAG_AUTOMATICA   VARCHAR2(1)
);
-- Create/Recreate primary, unique and foreign key constraints 
alter table SII_GRUPOSATENDIMENTO_FUNC
  add constraint PK_GRP_ATENDIMENTO_FUNC primary key (CODIGO_GRUPO, GRUPO_TIPO, CODIGOFUNCIONARIO)
  using index 
  tablespace GLOBUS_INDEX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Create table
create table SII_FUNCAO
(
  CODFUNCAO                 VARCHAR2(3) not null,
  DESCRICAOFUNCAO           VARCHAR2(40),
  EFETUAALTERACAO           VARCHAR2(1),
  TREINAUSER                VARCHAR2(1),
  RESPONSAVELSETOR          VARCHAR2(1),
  RVOBRIGATORIO             VARCHAR2(1),
  VISUALIZASETORES          VARCHAR2(1),
  ELIMINAPENDENCIARV        VARCHAR2(1),
  DEFINECRITICIDADE         VARCHAR2(1),
  DEFINEVALORRV             VARCHAR2(1),
  EFETUATESTE               VARCHAR2(1),
  INDICADOR_DESENVOLVIMENTO VARCHAR2(1) default '2'
);
-- Create/Recreate primary, unique and foreign key constraints 
alter table SII_FUNCAO
  add constraint XPKSII_FUNCAO primary key (CODFUNCAO)
  using index 
  tablespace GLOBUS_INDEX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Create table
create table SII_CLIENTE
(
  CODCLIENTE                VARCHAR2(6) not null,
  CODGRUPOEMP               VARCHAR2(4) not null,
  CODTIPOEMPRESA            VARCHAR2(2) not null,
  CODUFCOBRANCA             VARCHAR2(2),
  RAZAOSOCIALCLIENTE        VARCHAR2(40) not null,
  CODUFENDERECO             VARCHAR2(2) not null,
  NOMEFANTASIACLIENTE       VARCHAR2(20) not null,
  CNPJCLIENTE               VARCHAR2(14),
  IESTADUALCLIENTE          VARCHAR2(12),
  ATIVOCLIENTE              VARCHAR2(1) not null,
  CODIGOGLOBUSCLIENTE       NUMBER(8),
  QUANTFUNCIONARIOS         NUMBER(5),
  QUANTCARROS               NUMBER(5),
  RUACOBRANCA               VARCHAR2(40),
  RUACLIENTE                VARCHAR2(40),
  NUMEROCOBRANCA            VARCHAR2(6),
  NUMEROCLIENTE             VARCHAR2(6),
  COMPLEMENTOCOBRANCA       VARCHAR2(20),
  COMPLCLIENTE              VARCHAR2(20),
  BAIRROCOBRANCA            VARCHAR2(20),
  BAIRROCLIENTE             VARCHAR2(20),
  CIDADECOBRANCA            VARCHAR2(20),
  CIDADECLIENTE             VARCHAR2(20),
  CEPCLIENTE                VARCHAR2(8),
  CEPCOBRANCA               VARCHAR2(8),
  CAIXAPOSTALCOBRANCA       VARCHAR2(20),
  CAIXAPOSTALCLIENTE        VARCHAR2(20),
  DISTANCIACLIENTE          NUMBER(6),
  EMAILCLIENTE              VARCHAR2(60),
  WORKCLIENTE               NUMBER(2),
  HOMEPAGECLIENTE           VARCHAR2(60),
  QTDESERVERCLIENTE         NUMBER(2),
  SERVERCLIENTE             VARCHAR2(60),
  FONE1CLIENTE              VARCHAR2(30),
  ORACLECLIENTE             VARCHAR2(60),
  FONE2CLIENTE              VARCHAR2(30),
  ESTACIONACLIENTE          VARCHAR2(1),
  FAX1CLIENTE               VARCHAR2(30),
  TEMPOCLIENTE              NUMBER(3),
  FAX2CLIENTE               VARCHAR2(30),
  MSGCLIENTE                VARCHAR2(60),
  OBSCLIENTE                VARCHAR2(60),
  CRITICOCLIENTE            VARCHAR2(1),
  ULTIMOEMAILENVIADO        DATE,
  EMAILCHAMADOSCLIENTE      VARCHAR2(1) default 'S' not null,
  EMAILRELATVISITASCLIENTE  VARCHAR2(1) default 'S' not null,
  EMAILSASABERTOSCLIENTE    VARCHAR2(1) default 'S' not null,
  EMAILSASREPROVADOSCLIENTE VARCHAR2(1) default 'S' not null,
  EMAILSASAPROVADOSCLIENTE  VARCHAR2(1) default 'S' not null,
  EMAILSASCONCLUIDOSCLIENTE VARCHAR2(1) default 'S' not null,
  EMAILAGENDAMENTOSCLIENTE  VARCHAR2(1) default 'S' not null,
  CODLIENTEOLD              VARCHAR2(6),
  ATENDIDOPORTERCEIRO       VARCHAR2(1),
  CATEGORIACLIENTE          VARCHAR2(1),
  SENHAWEB                  VARCHAR2(10),
  VISUALIZASIM              VARCHAR2(1),
  VISUALIZASAS              VARCHAR2(1),
  CODREGIAO                 NUMBER(3),
  QTDELICENCAS              NUMBER(5),
  LIGACAOPREVENTIVA         VARCHAR2(1),
  EMIMPLANTACAO             VARCHAR2(1),
  CODLOCAL                  NUMBER(3),
  INDICADORCLIENTE          NUMBER(6,2),
  CLASSIFICACLIENTE         VARCHAR2(2),
  DATALIMITEUSO             DATE,
  TERMINOIMPLANTACAO        DATE,
  ARQCONCEDENTE             LONG,
  DATAENVIOKIT              DATE,
  OBSERVACAOKIT             VARCHAR2(60),
  EMPRESA_CONCEDENTE        VARCHAR2(1) default 'N',
  AMBIENTE_GLOBUS_MAIS      VARCHAR2(1) default ('N'),
  FATOR_SLA                 NUMBER(5,2) default 0.00,
  DTINSTALWEBSERVICE        DATE,
  GLOBUS_CLOUD              CHAR(1) default 'N',
  WEBCONCEDENTE             CHAR(1) default 'N',
  DT_COMUNICADO_VENDA       DATE,
  DT_RECEB_CONTRATO         DATE,
  NUMERO_MYTICKET           NUMBER,
  NUMERO_RA                 VARCHAR2(7),
  VISUALIZAR_RELATORIO      VARCHAR2(1) default 'S',
  GLB_CLOUD_DATA_INICIAL    DATE,
  GLB_CLOUD_DATA_FINAL      DATE,
  GLB_CLOUD_STATUS          VARCHAR2(1),
  GLB_CLOUD_QTDE_LICENCAS   NUMBER(5),
  GLB_CLOUD_OBSERVACAO      VARCHAR2(60),
  DATA_GOLIVE               DATE,
  CODREPRESENTANTE          NUMBER(3),
  CONTROLE_LICENCA          VARCHAR2(3) default 'GLB',
  FORMASDEACESSO            VARCHAR2(255 CHAR),
  FORMASDEACESSO_BAK        VARCHAR2(2000 CHAR),
  GLB_CLOUD_EMPRESA         NUMBER(1) default 0,
  BUSINESS_UNIT             VARCHAR2(1),
  GLOBUS                    VARCHAR2(1) default 'N',
  SIGA                      VARCHAR2(1) default 'N',
  LUNA                      VARCHAR2(1) default 'N',
  AVACORP                   VARCHAR2(1) default 'N',
  OUTROS_PRODUTOS           VARCHAR2(1) default 'N',
  SEG_FRETAMENTO            VARCHAR2(1) default 'N',
  SEG_TURISMO               VARCHAR2(1) default 'N',
  SEG_URBANO                VARCHAR2(1) default 'N',
  SEG_RODOVIARIO            VARCHAR2(1) default 'N',
  SEG_ENCOMENDAS_CGS        VARCHAR2(1) default 'N',
  SEG_TRR                   VARCHAR2(1) default 'N',
  SEG_PARCEIRO              VARCHAR2(1) default 'N',
  CONTRATO_CLOUD            VARCHAR2(1),
  AUTORIZA_CLI_INADIMPLENTE VARCHAR2(1) default 'N'  
);
-- Create/Recreate primary, unique and foreign key constraints 
alter table SII_CLIENTE
  add constraint XPKSII_CLIENTE primary key (CODCLIENTE)
  using index 
  tablespace GLOBUS_INDEX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Create table
create table SII_CONTATOCLIENTE
(
  CODCONTATO               VARCHAR2(4) not null,
  CODCLIENTE               VARCHAR2(6) not null,
  NOMECONTATOCLI           VARCHAR2(40) not null,
  CARGOCONTATOCLI          VARCHAR2(40) not null,
  NOMEREDUZIDOCONTATOCLI   VARCHAR2(20),
  OBSCONTATOCLI            VARCHAR2(200),
  ATIVOCONTATOCLI          VARCHAR2(1) default 'N' not null,
  EMAILCONTATOCLI          VARCHAR2(60),
  APROVASASCONTATOCLI      VARCHAR2(1),
  NIVELDEDECISAOCONTATOCLI VARCHAR2(1) not null,
  TELEFONECONTATOCLI       VARCHAR2(30),
  NOTIFICAATUALIZACAO      VARCHAR2(1) default 'N',
  RECEBEEMAILRV            VARCHAR2(1) default 'N',
  NOTIFICACONCEDENTE       VARCHAR2(1) default 'N',
  SENHAWEB                 VARCHAR2(32),
  ABRE_PSE                 VARCHAR2(1) default 'S',
  ABRE_SIM                 VARCHAR2(1) default 'S',
  ID_OPERADOR_MTK_INSERCAO NUMBER(10),
  RAMALCONTATOCLI          VARCHAR2(4 CHAR),
  CLASSIFICACAOCONTATOCLI  VARCHAR2(1) default '3'
);
-- Create/Recreate primary, unique and foreign key constraints 
alter table SII_CONTATOCLIENTE
  add constraint XPKSII_CONTATOCLIENTE primary key (CODCLIENTE, CODCONTATO)
  using index 
  tablespace GLOBUS_INDEX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 896K
    next 1M
    minextents 1
    maxextents unlimited
  );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Create table
create table SII_GRUPOSATENDIMENTO
(
  CODIGO_GRUPO NUMBER(6) not null,
  DESCRICAO    VARCHAR2(40),
  CODSETOR     VARCHAR2(6),
  RESPONSAVEL  VARCHAR2(40)
);
-- Create/Recreate primary, unique and foreign key constraints 
alter table SII_GRUPOSATENDIMENTO
  add constraint PK_GRP_ATENDIMENTO primary key (CODIGO_GRUPO)
  using index 
  tablespace GLOBUS_INDEX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );  
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Create table
create table SII_FUNCIONARIO
(
  CODIGOFUNCIONARIO            VARCHAR2(8) not null,
  CODSETOR                     VARCHAR2(6) not null,
  NOMEFUNCIONARIO              VARCHAR2(40) not null,
  CODUF                        VARCHAR2(2) not null,
  NOMEABREVIADOFUNCIONARIO     VARCHAR2(34),
  CODFUNCAO                    VARCHAR2(3) not null,
  NUMEROCELULARFUNCIONARIO     VARCHAR2(12),
  SALARIOMESFUNCIONARIO        NUMBER(10,2),
  HORACOMERCIALFUNCIONARIO     NUMBER(10,2),
  DATAADMISSAOFUNCIONARIO      DATE not null,
  DATANAFUNCAOFUNCIONARIO      DATE not null,
  DATAGOZOINIFUNCIONARIO       DATE,
  DATAGOZOFINFUNCIONARIO       DATE,
  OBSFUNCIONARIO               VARCHAR2(2000),
  HORASSEMANAFUNCIONARIO       NUMBER(5,2) not null,
  ATIVOFUNCIONARIO             VARCHAR2(1) not null,
  RUAFUNCIONARIO               VARCHAR2(50),
  NUMERORUAFUNCIONARIO         VARCHAR2(6),
  COMPLFUNCIONARIO             VARCHAR2(50),
  BAIRROFUNCIONARIO            VARCHAR2(20),
  CIDADEFUNCIONARIO            VARCHAR2(20),
  CEPFUNCIONARIO               VARCHAR2(8),
  FONE1FUNCIONARIO             VARCHAR2(12),
  EMAIL1FUNCIONARIO            VARCHAR2(60),
  HOMEPAGEFUNCIONARIO          VARCHAR2(60),
  EMAIL2FUNCIONARIO            VARCHAR2(60),
  CADASTRACLIENTE              VARCHAR2(1),
  FONE2FUNCIONARIO             VARCHAR2(12),
  CADASTRATAREFACRONOGRAMA     VARCHAR2(1),
  CANCELACHAMADOTECNICO        VARCHAR2(1),
  FAXFUNCIONARIO               VARCHAR2(12),
  DADOSEQUIPTO                 VARCHAR2(60),
  IMPRESSORA                   VARCHAR2(30),
  IPFUNCIONARIO                VARCHAR2(15),
  VERSAOWINDOWS                VARCHAR2(30),
  SERIALWINDOWS                VARCHAR2(40),
  SENHADEACESSOFUNCIONARIO     VARCHAR2(200),
  AGENDACOMPROMISSO3           VARCHAR2(1),
  CADASTRACONTRATO             VARCHAR2(1),
  CADASTRAFUNCIONARIO          VARCHAR2(1),
  CADASTROSGENERICOS           VARCHAR2(1),
  INICIOEXPEDIENTE             DATE,
  TERMINOEXPEDIENTE            DATE,
  INICIOREFEICAO               DATE,
  TERMINOREFEICAO              DATE,
  RESPENTREGASAS               VARCHAR2(1),
  ALTERASTATUSEMAIL            VARCHAR2(1) default 'N' not null,
  VISUALIZACTEXCLUSIVO         VARCHAR2(1) default 'N' not null,
  CADASTRASAS                  VARCHAR2(1),
  LIBERASAS                    VARCHAR2(1),
  ENVIAORCAMENTOSAS            VARCHAR2(1),
  APROVASAS                    VARCHAR2(1),
  CODIDOFUNCIONARIOOLD         VARCHAR2(6),
  CODLOCAL                     NUMBER(3),
  CODINTFUNC                   NUMBER default 0 not null,
  DATANASCFUNCIONARIO          DATE,
  CODE                         VARCHAR2(3),
  CODCONTATOCLI                VARCHAR2(4),
  CODCLICONTATO                VARCHAR2(6),
  ASSINATURA_EMAIL             VARCHAR2(4000),
  SENHAACESSOGLOBUS            VARCHAR2(10),
  SENHAACESSOGLOBUSPOSICIONAL  VARCHAR2(10),
  ENVIA_EMAIL_CONF_COMPROMISSO VARCHAR2(1) default 'N',
  SEXOFUNC                     VARCHAR2(1),
  DIVULGA_ANIVERSARIO          VARCHAR2(1) default 'S',
  RECEBE_EMAIL_CONCEDENTE      VARCHAR2(1) default 'N' not null,
  ENVIADO_EMAIL_BEMVINDO       VARCHAR2(1) default 'S',
  NOMEMAQUINA                  VARCHAR2(25),
  VALORDIA_TRANSP              NUMBER(6,2),
  UTILIZA_FRETADO              VARCHAR2(1) default 'N',
  PAGA_SEGURANCA_CARRO         VARCHAR2(1) default 'N',
  VALORMES_TRANSP              NUMBER(6,2),
  VLRTRANSP_FIXO               VARCHAR2(1) default 'N',
  COR                          VARCHAR2(20),
  ESCOLARIDADE                 VARCHAR2(25),
  CARGO                        VARCHAR2(25),
  DATA_EMAIL_PARABENS          DATE,
  VALE_BENEFICIO               VARCHAR2(1) default 'N',
  PERMISSAOFUNCIONARIO         VARCHAR2(20),
  CODFUNC_GD2                  VARCHAR2(8),
  UNIDADE_NEG                  VARCHAR2(1) default 'N',
  PERMISSAOFUNCIONARIO_BKP     VARCHAR2(20),
  CODINTFUNC_2                 NUMBER,
  CODFUNFLP_2                  VARCHAR2(6),
  CHAPAFUNC_2                  VARCHAR2(6),
  DT_DEMISSAO                  DATE,
  CLASS                        VARCHAR2(2),
  CODBANCO                     NUMBER(3),
  CODAGENCIA                   NUMBER(5),
  CONTACORFUNC                 VARCHAR2(15),
  DIGITOCONTA                  NUMBER(1),
  DATAATUALIZOUSENHA           DATE
);
-- Create/Recreate primary, unique and foreign key constraints 
alter table SII_FUNCIONARIO
  add constraint XPKSII_FUNCIONARIO primary key (CODIGOFUNCIONARIO)
  using index 
  tablespace GLOBUS_INDEX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Create table
create table SII_GRUPOSATENDIMENTO_MODULOS
(
  ID_GRUPO_MODULO NUMBER not null,
  CODIGO_GRUPO    NUMBER(6),
  ID_MODULO       NUMBER
);
-- Create/Recreate primary, unique and foreign key constraints 
alter table SII_GRUPOSATENDIMENTO_MODULOS
  add constraint PK_GRP_MODULO primary key (ID_GRUPO_MODULO)
  using index 
  tablespace GLOBUS_INDEX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );  
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Create table
create table SII_CONTRATO
(
  CODCONTRATO   VARCHAR2(15) not null,
  CODCLIENTE    VARCHAR2(6) not null,
  TIPOCONTRATO  VARCHAR2(1),
  DATACONTRATO  DATE not null,
  ATIVOCONTRATO VARCHAR2(1)
);
-- Create/Recreate primary, unique and foreign key constraints 
alter table SII_CONTRATO
  add constraint XPKSII_CONTRATO primary key (CODCONTRATO, CODCLIENTE)
  using index 
  tablespace GLOBUS_INDEX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );  
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Create table
create table SII_SAS
(
  CODIGOSAS                  NUMBER(8) not null,
  CODMODULO                  VARCHAR2(3) not null,
  CODCONTATOAPROVASAS        VARCHAR2(4),
  CODFUNCLIBERASAS           VARCHAR2(8),
  TIPOSASSIM                 VARCHAR2(1) not null,
  CODCLIENTE                 VARCHAR2(6),
  DATARECEBIMENTOSAS         DATE,
  CODCONTATOSOLICITACAO      VARCHAR2(4),
  CODSISTEMA                 VARCHAR2(3) not null,
  VALORORCAMENTOSAS          NUMBER(10,2) not null,
  CODLOCALSISTEMA            VARCHAR2(6),
  PRIORIDADESAS              VARCHAR2(2),
  TIPOSOLICITACAOSAS         VARCHAR2(2),
  DOCTOANEXOSAS              VARCHAR2(100),
  SOLICITACAOSAS             VARCHAR2(4000),
  STATUSSAS                  VARCHAR2(2),
  CODFUNCPROGRAMASAS         VARCHAR2(8),
  CODFUNCTESTASAS            VARCHAR2(8),
  TEMPOEXECUCAOSAS           NUMBER(10),
  TERMINOPREVISTOSAS         DATE,
  ENTREGAPOSAPROVACAO        NUMBER(3),
  OBSORCAMENTOSAS            VARCHAR2(500),
  CODFUNCAPROVASAS           VARCHAR2(8),
  DATAAPROVACAOSAS           DATE,
  VALORFINALSAS              NUMBER(10,2),
  OBSAPROVASAS               VARCHAR2(4000),
  CODFUNCENTREGASAS          VARCHAR2(8),
  CODCONTATONOTIFICADO       VARCHAR2(4),
  DATAENTREGASAS             DATE,
  MODOENTREGASAS             VARCHAR2(2),
  CATEGORIALOCAL             VARCHAR2(1) not null,
  WISHLISTSAS                VARCHAR2(1) default 'N' not null,
  DATALIBERACAOSAS           DATE,
  DATAORCAMENTOSAS           DATE,
  DATAREPROVACAOSAS          DATE,
  DATACRONOGRAMASAS          DATE,
  CODFUNCABRESAS             VARCHAR2(8),
  ORDEMDESENVOLVIMENTOSAS    NUMBER(10,1),
  STATUSANTSAS               VARCHAR2(2),
  EMAILENVIADOSAS            VARCHAR2(1),
  TESTE                      VARCHAR2(100),
  PUBLICACAOSAS              VARCHAR2(4000),
  FATURADOSAS                VARCHAR2(1),
  DATAFATURADOSAS            DATE,
  DATACONCLUIDOSAS           DATE,
  UPGRADE1                   VARCHAR2(1),
  UPGRADE2                   VARCHAR2(1),
  DATALIMITESUPERVISOR       DATE,
  INICIOPREVISTOSAS1         DATE,
  INICIOPREVISTOSAS          DATE,
  TERMINOPREVISTO1           DATE,
  CRITICOSAS                 VARCHAR2(1),
  CODATIVIDADE               VARCHAR2(2),
  EXCLUSIVOSAS               VARCHAR2(1) default 'N',
  ASSUNTOBIG                 VARCHAR2(1) default 'N',
  DATADESENVOLVEDOR          DATE,
  RESPLIBERACAO              VARCHAR2(8),
  OBSLIBERACAO               VARCHAR2(2000),
  DATA_LOG                   DATE,
  DIVULGACLIENTE             VARCHAR2(1) default 'S',
  ENTREGAGARANTIDASAS        VARCHAR2(1) default 'N',
  CODFUNCGARANTESAS          VARCHAR2(8),
  DOCTOANEXOSAS2             VARCHAR2(100),
  DOCTOANEXOSAS3             VARCHAR2(100),
  DOCTOANEXOSAS4             VARCHAR2(100),
  DOCTOANEXOSAS5             VARCHAR2(100),
  EMAILCOLABORADOR           VARCHAR2(1000),
  CODFUNCENVIOORC            VARCHAR2(8),
  STATUS_ANALISE             VARCHAR2(1),
  RESPLIBERACAO2             VARCHAR2(8),
  OBSLIBERACAO2              VARCHAR2(4000),
  RESPLIBERACAO_2            VARCHAR2(8),
  OBSLIBERACAO_2             VARCHAR2(2000),
  MOTIVO_ALTER_DATA          VARCHAR2(4000),
  DATAANALISE_2              DATE,
  RESPLIBERACAO_3            VARCHAR2(8),
  OBSLIBERACAO_3             VARCHAR2(2000),
  DATAANALISE_3              DATE,
  WORKSHOP                   VARCHAR2(1) default 'N',
  OBSERVACAOUSUARIO          VARCHAR2(255),
  DATA_ABERTURA_PSEWEB       DATE,
  CODFUNC_ABERTURA_PSEWEB    VARCHAR2(8),
  DATA_LIBERACAO_PSEWEB      DATE,
  CODFUNC_LIBERADO_PSEWEB    VARCHAR2(8),
  CODANALISTARESP_PREANALISE VARCHAR2(3),
  DEF_ENVIAORCAMENTO         VARCHAR2(1) default 'N',
  NOVIDADE_INTERNA           VARCHAR2(1) default 'N',
  FATURADOAUTOMATICO         VARCHAR2(1) default 'N',
  ID_TFS                     NUMBER,
  INTEGROU_TFS               VARCHAR2(1) default 'N',
  CODPRODUTO                 NUMBER,
  COD_LOCAL_RESP_ABERTURA    NUMBER(3),
  HRS_PREVISTAS_DESENV       NUMBER(10),
  CODFUNCTESTECRON           VARCHAR2(8),
  DT_ENTREGA_GARANTIDA       DATE,
  DT_GARANTIU_ENTREGA        DATE,
  URL_VIDEO                  VARCHAR2(200),
  IMPEDE_UTILIZACAO          VARCHAR2(1) default 'N',
  GRAVAR_VIDEO               VARCHAR2(1) default 'N',
  TIPOSASSIMANTERIOR         VARCHAR2(1),
  CODIGOSASANTERIOR          NUMBER(8),
  DATA_PREVISTA_TESTE        DATE,
  SAS_REABERTO               VARCHAR2(1) default 'N',
  TIPOSAS_REPROVADO          VARCHAR2(1),
  CODIGOSAS_REPROVADO        NUMBER(8),
  OBJETIVO                   VARCHAR2(2000),
  SEVERIDADE                 NUMBER(2),
  BASE_EXEMPLO               VARCHAR2(89),
  PRIORIDADESAS_ANTIGA       VARCHAR2(2),
  FILIAL_FATURAMENTO         VARCHAR2(2),
  COD_CLIENTE_GLOBUS         VARCHAR2(6),
  TP_ATUALIZACAO             CHAR(2) default 'CP',
  DATA_ENVIO_GLB             DATE,
  CLASSIF_MOSCOW             VARCHAR2(3),
  CODVENDEDOR                VARCHAR2(6),
  CODGERENTE_VEND            VARCHAR2(6),
  PAGACOMISSAO               VARCHAR2(1) default 'N',
  DIASFATURAMENTO            NUMBER(3),
  CODFUNC_ULT_ALTERACAO      VARCHAR2(8),
  ANALISE_LGPD               VARCHAR2(2000),
  INFLUENCIA_LGPD            CHAR(1) default 'N'
);
-- Create/Recreate primary, unique and foreign key constraints 
alter table SII_SAS
  add constraint XPKSII_SAS primary key (TIPOSASSIM, CODIGOSAS)
  using index 
  tablespace GLOBUS_INDEX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 3M
    next 1M
    minextents 1
    maxextents unlimited
  );  
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
create or replace procedure pr_sii_associaclientemodulo is
	 cursor c_modulo is
			select codsistema, codmodulo, id_modulo from sii_modulo;
begin
	 for item_cursor in c_modulo() loop
			update sii_associaclientemodulo
				 set id_modulo = item_cursor.id_modulo
			 where codsistema = item_cursor.codsistema
				 and codmodulo = item_cursor.codmodulo
                 and id_modulo is null;
			commit;
	 end loop;
end pr_sii_associaclientemodulo;
