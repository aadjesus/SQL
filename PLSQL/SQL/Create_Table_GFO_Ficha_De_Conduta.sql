Create Table GFO_Ficha_De_Conduta(id_Ficha_De_Conduta Number Not Null
                                 ,id_controle_operacional Number Not Null
                                 ,codocorr number(3) NOT Null
                                 ,Data date Not Null
                                 ,Observacao Varchar2(4000) 
                                 ,usuario Varchar2(15) Not Null
                                ); 
                                
Alter Table GFO_Ficha_De_Conduta Add(Constraint PK_GFOFichaDeConduta
                                     Primary Key (id_Ficha_De_Conduta)
                                     Using Index Tablespace GLOBUS_INDEX);

Alter Table GFO_Ficha_De_Conduta Add(Constraint fk_GFOFichaCondGFOControleop
                                     Foreign Key (id_controle_operacional)
                                     References gfo_controleoperacional);

Alter Table GFO_Ficha_De_Conduta Add(Constraint fk_GFOFichaCondFrqOcor
                                     Foreign Key (codocorr)
                                     References frq_ocorrencia);

Alter Table GFO_Ficha_De_Conduta Add(Constraint fk_GFOFichaCondCTRsuario
                                     Foreign Key (usuario)
                                     References ctr_cadastrodeusuarios);

