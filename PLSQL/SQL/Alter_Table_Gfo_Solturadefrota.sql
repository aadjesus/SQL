alter table gfo_solturadefrota drop column dat_escala; 
alter table gfo_solturadefrota drop column cod_intturno  ;
alter table gfo_solturadefrota drop column cod_intescala  ;
alter table gfo_solturadefrota drop column cod_servdiaria  ;
alter table gfo_solturadefrota add id_soltura number not null;
alter table gfo_solturadefrota drop constraint PK_GFO_SOLTURADEFROTA;

ALTER TABLE gfo_solturadefrota
ADD CONSTRAINT PK_gfo_solturadefrota
PRIMARY KEY (id_soltura)
USING INDEX TABLESPACE GLOBUS_INDEX;          