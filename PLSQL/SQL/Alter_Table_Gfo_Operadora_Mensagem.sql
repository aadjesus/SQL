alter table GFO_OPERADORA_MENSAGEM drop constraint PK_GFO_OPERADORA_MENSAGEM;

ALTER TABLE GFO_OPERADORA_MENSAGEM
ADD CONSTRAINT PK_GFO_OPERADORA_MENSAGEM
PRIMARY KEY (cod_operadora,cod_mensagem,cod_mensagem_ope ,cod_grupo_ope   )
USING INDEX TABLESPACE GLOBUS_INDEX;          
