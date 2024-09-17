create table GLB_GED_TIPODOCTO
(
       ID 	                    Number,	-- (PK)
--       Codigo 	                Number,
       Versao                   Number,
       Descricao	              Varchar2(50),
       Ativo	                  Varchar2(1),
       Cod_Categoria 	          Number,	-- (FK)
       Cod_Sub_Categoria 	      Number,	-- (FK)
       TipoDocto_Associa_Globus	Number	--(Cte, Funcionarios, Veículos...)
);

Alter Table GLB_GED_TIPODOCTO
Add Constraint PK_GED_TIPODOCTO
Primary Key(ID) Using Index
Tablespace Globus_Index;

create table GLB_GED_TIPODOCTO_ITEM
(
       ID 	                    Number,	-- (PK)
       ID_TipoDocto             Number,	-- (FK)
       Nome_Campo               Varchar2(50),
       Tipo	                    Number,	
       Tamanho	                Number(5),
       Obrigatorio	            Varchar2(1),
       Utiliza_Leitor	          Varchar2(1),
       Ordem_Visualizacao       Number(5)
);

Alter Table GLB_GED_TIPODOCTO_ITEM
Add Constraint PK_GED_TIPODOCTO_ITEM
Primary Key(ID) Using Index
Tablespace Globus_Index;

Alter Table GLB_GED_TIPODOCTO_ITEM 
Add Constraint Fk_GED_TIPODOCTO_GED_ITEM
Foreign Key(ID_TipoDocto) 
References GLB_GED_TIPODOCTO;
