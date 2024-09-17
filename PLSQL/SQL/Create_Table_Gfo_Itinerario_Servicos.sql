-- GFO_ITINERARIO_ITENS \ t_esc_horariodiaria
Create Table GFO_ITINERARIO_Servicos (CODINTLINHA	Number(5)			
                                     ,ID_ITINERARIO	Number(3)			
                                     ,SENTIDO	Varchar2(1)
                                     ,SEQUENCIAL	Number
                                     ,COD_INTSERVDIARIA	Varchar2(5)			
                                     ,COD_HORDIARIA	Number(2)			
                                     ,COD_INTTURNO	Number(2)			                                              
                                     ,TEMPO	Date
                                     );
                                              
Alter Table GFO_ITINERARIO_Servicos
Add Constraint PK_GFOITINERARIOServicos
Primary Key (CODINTLINHA,ID_ITINERARIO,SENTIDO,SEQUENCIAL,COD_INTSERVDIARIA,COD_HORDIARIA,COD_INTTURNO)
Using Index Tablespace GLOBUS_INDEX;

Alter Table GFO_ITINERARIO_Servicos
Add ( Constraint fk_GFO_ITINERARIOServicos
Foreign Key (CODINTLINHA,ID_ITINERARIO,SENTIDO,SEQUENCIAL )
References GFO_ITINERARIO_ITENS );

--Drop Table GFO_ITINERARIO_ITENS_servicos