Create Table ctr_Ocultarbloqueargrupousu(Codigo_Interno Number
                                        ,Codigogrpusu number(3))
                                        
Alter Table ctr_Ocultarbloqueargrupousu Add(Constraint Pk_ctrOcultarbloqueargrupousu
                        Primary Key(Codigo_Interno, Codigogrpusu) Using Index
                        Tablespace Globus_Index)
                        
Alter Table ctr_Ocultarbloqueargrupousu Add(Constraint Fk_CtrOcultBloqGrup_CtrGrupUsu
                        Foreign Key(Codigogrpusu) 
                        References CTR_GRUPOUSUARIOS)
                        
