Alter Table gfo_controleoperacional add(Ocorrencia_Horario NUMBER
                                       ,Ocorrencia_Comboio NUMBER
                                       ,Ocorrencia_Mensagem NUMBER
                                       ,Peso_Ocor NUMBER
                                       ,Peso_Ocor_Horario NUMBER
                                       ,Peso_Ocor_Comboio NUMBER
                                       ,Peso_Ocor_Mensagem NUMBER
                                       ,Prioridade_Ocor NUMBER
                                       ,Prioridade_Ocor_Horario NUMBER
                                       ,Prioridade_Ocor_Comboio NUMBER
                                       ,Prioridade_Ocor_Mensagem NUMBER
                                       ,Status_Servico VARCHAR2(1)
                                       ,Status_Hora VARCHAR2(1)
                                       ,HORA_LOCAL_PROG Date
                                       );

Alter Table gfo_controleoperacional add(usuario varchar2(15) );
                                       
