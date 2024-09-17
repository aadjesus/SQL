Create Table gfo_Grupo_Atendimento(Codigo_Interno Number Not Null 
                                  ,Codigo Number Not Null 
                                  ,Descricao varchar2(50)
                                  ,Cod_Cent_Fone Number Not Null 
                                  ,Porta number(10)
                                  ,Host varchar2(50)
                                  );                             
                                  
Alter Table gfo_Grupo_Atendimento Add(Constraint PK_gfo_Grupo_Atendimento
                                     Primary Key (Codigo_Interno)
                          Using Index Tablespace GLOBUS_INDEX);

Alter Table gfo_Grupo_Atendimento Add(Constraint fk_GFOGrupAtend_CentTele
                                     Foreign Key (Cod_Cent_Fone)
                                      References gfo_Central_Telefonica);

Create Table gfo_Grupo_Atendimento_Ramal(Codigo_Interno Number Not Null 
                                        ,Ramal number(5) Not Null 
                                        ,Telefone varchar2(20) Not Null
                                        ,Pre_Ligacao number(5) Not Null
                                        );                                           
                                           
Alter Table gfo_Grupo_Atendimento_Ramal Add(Constraint PK_gfo_Grupo_Atendimento_Ramal
                                           Primary Key (Codigo_Interno, Ramal)
                                Using Index Tablespace GLOBUS_INDEX);
                                           
