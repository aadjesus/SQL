Create Table gfo_Central_Telefonica(codigo Number Not Null 
                                   ,Descricao varchar2(50));
                                   
Alter Table gfo_Central_Telefonica Add(Constraint PK_gfo_Central_Telefonica
                                       Primary Key (codigo)
                            Using Index Tablespace GLOBUS_INDEX);