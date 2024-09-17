Create Table gfo_parametros_sms(integradora Number
                               ,short_code Number
                               ,conta Varchar2(30)                  
                               ,codigo_integracao Varchar2(30)
                               ,Cod_Int_param Number
                               );
                                                            
Alter Table gfo_parametros_sms Add Constraint PK_gfo_parametros_sms
                                   Primary Key (Cod_Int_param)
                                   Using Index Tablespace GLOBUS_INDEX
                                   ;

Create Unique Index IDXGFO_Parametros_Sms
                 On gfo_parametros_sms(integradora, short_code, conta) 
                 Tablespace GLOBUS_INDEX
                 ;

Create Table gfo_mensagens_sms(Id_sms Number Not Null 
                              ,Cod_Int_param Number 
                              ,data_recebimento Date Not Null
                              ,Num_Cel_Usuario varchar2(100) not Null
                              ,data_envio Date
                              ,id_integradora Varchar2(20)                               
                              ,mensagem Varchar2(200)
                              ,data_hora Date Not Null
                              ,status_envio Varchar2(100)
                              );

Alter Table gfo_mensagens_sms Add(Constraint PK_gfo_mensagens_sms
                                             Primary Key (Id_sms)
                                             Using Index Tablespace GLOBUS_INDEX                                  
                                 ,Constraint FK_parametros_mensagens_sms
                                             Foreign Key (Cod_Int_param)
                                             References gfo_parametros_sms
                                 );