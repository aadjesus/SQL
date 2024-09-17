Select a.Codintlinha    
     , a.Id_Itinerario  
     , a.Sentido        
     , a.Sequencial     
     , a.Tipo_Local     
     , a.Cod_Localidade 
     , a.Distancia      
     , a.Tempo          
  From Gfo_Itinerario_Itens a
 Where a.Id_Itinerario In (Select c.Id_Itinerario
                             From Gfo_Itinerario c
                            Where c.Vigencia_Inicial = (Select Max(d.Vigencia_Inicial)
                                                          From Gfo_Itinerario d
                                                         Where d.Codintlinha = a.codintlinha
                                                           And d.Id_Itinerario In (Select x.id_itinerario From Gfo_Itinerario_Dia x Where x.dia = 7 And x.codintlinha = a.codintlinha)
                                                           And d.Vigencia_Inicial <= TO_DATE('30/01/2011 15:00:00','DD/MM/YYYY HH24:MI:SS'))
                              And c.Codintlinha = a.codintlinha) 
                              
   And (a.Codintlinha In (26566))
   And a.Id_Itinerario In (Select x.id_itinerario From Gfo_Itinerario_Dia x Where x.dia = 7 And x.codintlinha = a.codintlinha)
   And a.Cod_Localidade In (Select e.Cod_Localidade
                              From t_Esc_Localidade e
                             Where e.Tipo_Local In (Select f.Tipo_Local
                                                      From Gfo_Tipolocal f
                                                     Where f.Ponto_Controle = 'S'))
 Order By a.Sequencial Asc

 