create table glb_ged_tipo_arquivo(tipo varchar2(5))

Alter Table glb_ged_tipo_arquivo Add(
      Constraint PK_glb_ged_tparq 
      Primary Key(tipo) Using Index
      Tablespace Globus_Index);
