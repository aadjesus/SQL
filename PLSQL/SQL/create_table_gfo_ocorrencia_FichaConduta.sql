Create Table GFO_Ocorrencia_Detalhe(ocorrencia Number
                                   ,codocorr Number(3)
                                   ,Observacao Varchar2(4000) 
                                   ,codigoempresa number(3) 
                                   ,codigofl number(3) 
                                   );
                 
Alter Table GFO_Ocorrencia_Detalhe Add(Constraint PK_GFOOcorrencia_Detalhe
                                       Primary Key (ocorrencia, codigoempresa, codigofl, codocorr)
                                       Using Index Tablespace GLOBUS_INDEX);
                           
Alter Table GFO_Ocorrencia_Detalhe Add(Constraint fk_GFOOcorDet_GfoOcor
                                       Foreign Key (ocorrencia)
                                       References gfo_ocorrencia);
                                            
Alter Table GFO_Ocorrencia_Detalhe Add(Constraint fk_GFOOcorDet_CtrFil
                                       Foreign Key (codigoempresa,codigofl)
                                       References ctr_filial);

Alter Table GFO_Ocorrencia_Detalhe Add(Constraint fk_GFOOcorDet_FrqOcor
                                       Foreign Key (codocorr)
                                       References frq_ocorrencia);

