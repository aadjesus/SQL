Create Table Ctr_Xml(Codigo_Interno Number
                    ,Usuario Varchar2(15) Not Null
                    ,Sistema Varchar2(3)
                    ,Data_Alteracao Date);

Alter Table Ctr_Xml Add(Constraint Pk_Ctr_Xml
                        Primary Key(Codigo_Interno) Using Index
                        Tablespace Globus_Index);

Alter Table Ctr_Xml Add(Constraint Fk_CtrXml_CtrCadUsu
                        Foreign Key(Usuario) 
                        References Ctr_Cadastrodeusuarios);

Alter Table Ctr_Xml Add(Constraint Fk_CtrXml_CtrCadSis
                        Foreign Key(Sistema) 
                        References Ctr_Cadastrosistemas);
                                     
Create Table Ctr_XmlItens(Codigo_Interno Number
                         ,Chave Varchar2(100) Not Null
                         ,Estrutura_Xml Long);
                                      
Alter Table Ctr_XmlItens Add(Constraint Pk_Ctr_XmlItens
                            Primary Key(Codigo_Interno, Chave) Using Index
                            Tablespace Globus_Index);
                                      
Alter Table Ctr_XmlItens Add(Constraint Fk_CtrXml_CtrXmlItens
                            Foreign Key(Codigo_Interno) 
                            References Ctr_Xml);
                                      