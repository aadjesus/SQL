Select a.Sequencial
      ,c.Sequencial
      ,a.Sentido
      ,a.Distancia As Distanciaa
      ,c.Distancia As Distanciab
      ,a.Tempo As Tempoa
      ,c.Tempo As Tempob
      , decode( Sign(c.Distancia - a.Distancia),  -1 ,'Distancia', 
        decode( Sign(c.Tempo - a.Tempo),-1, 'Tempo',''))
  From Gfo_Itinerario_Itens a
      ,(Select b.Sequencial - 1 ProximaSeq
              ,b.Sequencial
              ,b.Sentido
              ,b.Distancia
              ,b.Codintlinha
              ,b.Id_Itinerario
              ,b.Tempo
          From Gfo_Itinerario_Itens b) c
 Where a.Sequencial = c.ProximaSeq(+)   
   And a.Codintlinha = c.codintlinha(+)   
   And a.Id_Itinerario = c.id_itinerario(+)   
   And a.Sentido = c.sentido(+)         
   And (Sign(c.Distancia - a.Distancia) < 0 Or
        Sign(c.Tempo - a.Tempo) < 0)
--   And a.Codintlinha = 25534
--   And a.Id_Itinerario = 6        
