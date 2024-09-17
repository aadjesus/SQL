Create Table Ctr_LogClasse(Codigo_Interno Number
                          ,Usuario Varchar2(15) 
                          ,MaquinaUsuario Varchar2(50) 
                          ,Sistema Varchar2(3)
                          ,Data_inclusao Date 
                          ,Tipo Varchar2(1)
                          ,Classe Varchar2(200)
                          ,Ids Varchar2(4000)
                          ,Valores_Ids Varchar2(4000)
                          ,Propriedades Varchar2(4000)
                          ,Valores_Propriedades Varchar2(4000)
                          ,Texto Varchar2(2000)
                          ,Codigo_Interno_Grupo Number
                          );
                          
Alter Table Ctr_LogClasse Add(Constraint Pk_Ctr_LogClasse
                              Primary Key(Codigo_Interno) Using Index
                              Tablespace Globus_Index);

Alter Table Ctr_LogClasse Add(Constraint Fk_CtrLogClasse_CtrCadUsu
                              Foreign Key(Usuario) 
                              References Ctr_Cadastrodeusuarios);

Alter Table Ctr_LogClasse Add(Constraint Fk_CtrLogClasse_CtrCadSis
                              Foreign Key(Sistema) 
                              References Ctr_Cadastrosistemas);
                        
Alter Table Ctr_LogClasse Add(Constraint Fk_CtrLogClasse_CtrLogClasse
                              Foreign Key(Codigo_Interno_Grupo) 
                              References Ctr_LogClasse);
Select * From Ctr_LogClasse