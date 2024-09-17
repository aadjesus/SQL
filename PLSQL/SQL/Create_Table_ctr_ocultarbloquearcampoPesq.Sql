Create Table ctr_ocultarbloquearcampoPesq(Codigo_Interno Number
                                         ,Campo varchar2(100) 
                                         ,Coluna varchar2(100))
                                         ;
                                                                                 
Alter Table ctr_ocultarbloquearcampoPesq Add(Constraint Pk_ctrocultarbloquearcampPesq
                        Primary Key(Codigo_Interno, Campo, Coluna) Using Index
                        Tablespace Globus_Index)
                        ;
                        
Alter Table ctr_ocultarbloquearcampoPesq Add(Constraint Fk_ctrocultarbloquearPesq_Camp
                        Foreign Key(Codigo_Interno, Campo) 
                        References ctr_ocultarbloquearcampos)
                        ;
                        
                                        
                                       