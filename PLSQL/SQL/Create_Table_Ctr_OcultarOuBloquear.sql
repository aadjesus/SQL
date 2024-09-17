Create Table ctr_ocultarbloquear(Codigo_Interno Number
                                                               ,ASSEMBLY_NAME Varchar2(200)
                                                               ,DATA_inclusao Date
                                                               ,DATA_ALTERACAO Date );
                                                                                   
Alter Table ctr_ocultarbloquear Add(Constraint Pk_CtrOcultarBloquearCampo
                        Primary Key(Codigo_Interno) Using Index
                        Tablespace Globus_Index);
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Create Table Ctr_OcultarBloquearUsuarios(Codigo_Interno Number
                                                                                ,Usuario Varchar2(15) );

Alter Table Ctr_OcultarBloquearUsuarios Add(Constraint Pk_CtrOcultarBloquearUsuarios
                        Primary Key(Codigo_Interno, Usuario) Using Index
                        Tablespace Globus_Index);


Alter Table Ctr_OcultarBloquearUsuarios Add(Constraint Fk_CtrOcultBloq_usuarios
                        Foreign Key(Codigo_Interno) 
                        References ctr_ocultarbloquear);

Alter Table Ctr_OcultarBloquearUsuarios Add(Constraint Fk_CtrOcultBloqUsu_CtrUsuario
                        Foreign Key(Usuario) 
                        References Ctr_Cadastrodeusuarios);                        
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Create Table Ctr_OcultarBloquearCampos(Codigo_Interno Number
                                                                              ,Campo Varchar2(100)
                                                                              ,Bloquear Varchar2(1));
                        
Alter Table Ctr_OcultarBloquearCampos Add(Constraint Pk_Ctr_OcultarBloquearCampos
                            Primary Key(Codigo_Interno, Campo) Using Index
                            Tablespace Globus_Index);
                        
Alter Table Ctr_OcultarBloquearCampos Add(Constraint Fk_CtrOcultBloq_campos
                        Foreign Key(Codigo_Interno) 
                        References ctr_ocultarbloquear);                        
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Alter Table  ctr_cadastrodeusuarios  Add(Verificar_Acesso_Aos_Campos Varchar2(1) Default 'S');                    


--Alter Table  ctr_cadastrodeusuarios  Drop Column Verificar_Acesso_Aos_Campos