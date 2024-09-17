create table GLB_GED_AUTORIZACOES_USU
(
  ID_TIPODOCTO       NUMBER not null,
  Usuario            VARCHAR2(15),
  Inclusao	         VARCHAR2(1),
  Alteracao	         VARCHAR2(1),
  Exclusao	         VARCHAR2(1),
  Consulta	         VARCHAR2(1)
);

alter table GLB_GED_AUTORIZACOES_USU 
      add constraint FK_TPDOCTO_AUTUSU 
      foreign key (ID_TIPODOCTO)
      references GLB_GED_TIPODOCTO (ID_TIPODOCTO) 
      on delete cascade;

Alter Table GLB_GED_AUTORIZACOES_USU 
      Add Constraint Fk_GLBGEDAUTUSU_CtrCadUsu
      Foreign Key(Usuario)
      References Ctr_Cadastrodeusuarios;

create table GLB_GED_AUTORIZACOES_GRP
(
  ID_TIPODOCTO       NUMBER not null,
  CodigoGrdUsu       NUMBER(3),
  Inclusao	         VARCHAR2(1),
  Alteracao	         VARCHAR2(1),
  Exclusao	         VARCHAR2(1),
  Consulta	         VARCHAR2(1),
  Envia_email	       VARCHAR2(1),
  Impressao	         VARCHAR2(1)
);

alter table GLB_GED_AUTORIZACOES_GRP
      add constraint FK_TPDOCTO_AUTGRUPO
      foreign key (ID_TIPODOCTO)
      references GLB_GED_TIPODOCTO (ID_TIPODOCTO) 
      on delete cascade;

Alter Table GLB_GED_AUTORIZACOES_GRP
      Add Constraint Fk_GLBGEDAUTGRUPO_CtrGrupoUsu
      Foreign Key(CodigoGrdUsu )
      References Ctr_Grupousuarios;
      