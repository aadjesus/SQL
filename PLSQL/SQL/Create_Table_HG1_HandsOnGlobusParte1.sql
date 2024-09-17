
Create Table HG1_HandsOnGlobusParte1(Codigo Number Not Null 
                                    ,Descricao varchar2(50)
                                    ,vigencia_inicial Date Not Null 
                                    ,Ativa varchar2(1)
                                    ,Valor Number(8,2)
                                    );                             
                                  
Alter Table HG1_HandsOnGlobusParte1 Add(Constraint PK_HG1_HandsOnGlobusParte1
                                     Primary Key (Codigo)
                          Using Index Tablespace GLOBUS_INDEX);