  ------------------------------------------------------------------------ 1
  -- Apagar FK do TipoDocto com a Item 
  Alter Table Glb_Ged_Tipodocto_Item 
  Drop Constraint Fk_Tpdocto_Item;

  -- Cria FK do TipoDocto com a Item novamente, mais agora com Delete Cascade
  Alter Table Glb_Ged_Tipodocto_Item 
  Add Constraint Fk_Tpdocto_Item 
  Foreign Key(Id_Tipodocto) 
  References Glb_Ged_Tipodocto(Id_Tipodocto) 
  On Delete Cascade;

  ------------------------------------------------------------------------ 2  
  -- Adicionar a coluna Id_TipoDocto
  Alter Table Glb_Ged_Aut_Grp Add(Id_Tipodocto Number Not Null);

  -- Apagar PK grupo
  Alter Table Glb_Ged_Aut_Grp Drop Constraint Xpkglb_Ged_Aut_Grp;

  -- Cria PK grupo novamente mais agora com as colunas Id_TipoDocto,CodigoGrpUsu
  Alter Table Glb_Ged_Aut_Grp 
  Add Constraint Xpkglb_Ged_Aut_Grp 
  Primary Key(Id_Tipodocto,Codigogrpusu)
  Using Index Tablespace Globus_Index;

  -- Cria FK do TipoDocto com a grupo
  Alter Table Glb_Ged_Aut_Grp 
  Add Constraint Fk_Tpdocto_Autgrp 
  Foreign Key(Id_Tipodocto) 
  References Glb_Ged_Tipodocto(Id_Tipodocto) 
  On Delete Cascade;
  ------------------------------------------------------------------------ 3

  -- Adicionar a coluna Id_TipoDocto
  Alter Table Glb_Ged_Aut_Usuarios Add(Id_Tipodocto Number Not Null);

  -- Apagar PK usuario
  Alter Table Glb_Ged_Aut_Usuarios Drop Constraint Xpkglb_Ged_Aut_Usuarios;

  -- Cria PK usuario novamente mais agora com as colunas Id_TipoDocto,Usuario
  Alter Table Glb_Ged_Aut_Usuarios 
  Add Constraint Xpkglb_Ged_Aut_Usuarios 
  Primary Key(Id_Tipodocto,Usuario)
  Using Index Tablespace Globus_Index;

  -- Cria FK do TipoDocto com a usuarios
  Alter Table Glb_Ged_Aut_Usuarios 
  Add Constraint Fk_Tpdocto_Autusuarios 
  Foreign Key(Id_Tipodocto) 
  References Glb_Ged_Tipodocto(Id_Tipodocto) 
  On Delete Cascade;