Create Table ctr_CUNFIGURACOESUSUARIO(id_configuracao number
                                     ,sistema varchar2(3) NOT NULL
                                     ,usuario varchar2(15) NOT NULL
                                     ,chave varchar2(100) NOT NULL
                                     ,dataINCLUSAO date NOT NULL
                                     ,dataALTERACAO date NOT NULL
                                     ,ITEM number(3) DEFAULT 1 NOT NULL
                                     ,valor varchar2(4000) 
                                     )
                                     
