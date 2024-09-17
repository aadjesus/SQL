Select a.Codintlinha    As Codintli1_146_0_,
       a.Id_Itinerario  As Id2_146_0_,
       a.Sentido        As Sentido146_0_,
       a.Sequencial     As Sequencial146_0_,
       a.Tipo_Local     As Tipo5_146_0_,
       a.Cod_Localidade As Cod6_146_0_,
       a.Distancia      As Distancia146_0_,
       a.Tempo          As Tempo146_0_
  From Gfo_Itinerario_Itens a
 Where a.Id_Itinerario In (Select Max(b.Id_Itinerario)
                             From Gfo_Itinerario_Dia b
                            Where b.Id_Itinerario In (Select c.Id_Itinerario
                                                        From Gfo_Itinerario c
                                                       Where c.Vigencia_Inicial = (Select Max(d.Vigencia_Inicial)
                                                                                     From Gfo_Itinerario d
                                                                                    Where d.Codintlinha = c.Codintlinha
                                                                                      And d.Vigencia_Inicial <= TO_DATE('30/01/2011 15:00:00','DD/MM/YYYY HH24:MI:SS')) -- 21=U / 22=S / 23=D
                                                         And c.Codintlinha = b.Codintlinha)                                                                           -- 28=U / 29=S / 30=D
                              And b.Codintlinha = a.Codintlinha
                              And b.Dia = 1) ----  U=2,3,4,5,6 / S=7 / D=1
   And (a.Codintlinha In (26566))
   And a.Cod_Localidade In (Select e.Cod_Localidade
                              From t_Esc_Localidade e
                             Where e.Tipo_Local In (Select f.Tipo_Local
                                                      From Gfo_Tipolocal f
                                                     Where f.Ponto_Controle = 'S'))
 Order By a.Sequencial Asc

-- RESULTADO 
-- Id 5 = U , VIG = 18/01 
-- Id 7 = S , VIG = 18/01 
-- Id 6 = D , VIG = 18/01 
-- Id 8 = U , VIG = 25/01 

 