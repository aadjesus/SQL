CREATE TABLE CTR_INTEGRACOESAUTORIZADAS (ID_AUTORIZADA Number
                                        ,NOME_AUTORIZADA varchar2(100) 
                                        ,USUARIO_AUTORIZADA varchar2(100) 
                                        ,DESCRICAO_AUTORIZADA varchar2(100)
                                        ,CHECKSUM_AUTORIZADA number)
                                        
Alter Table CTR_INTEGRACOESAUTORIZADAS Add(Constraint Pk_CTR_INTEGRACOESAUTORIZADAS
                                           Primary Key(ID_AUTORIZADA) Using Index
                                           Tablespace Globus_Index);                                        
