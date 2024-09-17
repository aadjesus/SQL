Alter Table gfo_gerencial_itinerario Add(STATUS_SERVICO             VARCHAR2(1)
                                        ,STATUS_HORA                VARCHAR2(1)
                                        ,OCORRENCIA_HORARIO         NUMBER
                                        ,OCORRENCIA_COMBOIO         NUMBER
                                        ,OCORRENCIA_MENSAGEM        NUMBER
                                        ,OCORRENCIA_PROGNAOREA      NUMBER
                                        ,OCORRENCIA_REANAOPROG      Number
                                        ,PESO_OCOR_HORARIO          NUMBER
                                        ,PESO_OCOR_COMBOIO          NUMBER
                                        ,PESO_OCOR_MENSAGEM         NUMBER
                                        ,PESO_OCOR_PROGNAOREA       NUMBER
                                        ,PESO_OCOR_REANAOPROG       Number 
                                        ,PRIORIDADE_OCOR_HORARIO    NUMBER
                                        ,PRIORIDADE_OCOR_COMBOIO    NUMBER
                                        ,PRIORIDADE_OCOR_MENSAGEM   NUMBER
                                        ,PRIORIDADE_OCOR_PROGNAOREA NUMBER
                                        ,PRIORIDADE_OCOR_REANAOPROG Number
                                        ,CONSOLIDADO                VARCHAR2(1) Default 'N'
                                        )