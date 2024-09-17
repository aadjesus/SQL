alter table bgm_nfse_can add (DATA_HORA date,
                              USUARIO   varchar2(15))
                             

Alter Table bgm_nfse_can Add(Constraint fk_BGMNFSECAD_CADUSU
                            Foreign Key (usuario)
                             References ctr_cadastrodeusuarios );

                             
