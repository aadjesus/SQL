--------------------------------------------------------------------------------------------------------------------------------------------------------------
--- Retorna os dados do painel 
--------------------------------------------------------------------------------------------------------------------------------------------------------------
Select *
  From Gfo_Painel a
 Where a.Codigoempresa = 8
   And a.Codigofl      = 9
   And a.Cod_Painel    = 16
--------------------------------------------------------------------------------------------------------------------------------------------------------------
--- Retorna as linhas do painel 
--------------------------------------------------------------------------------------------------------------------------------------------------------------
Select *
  From Gfo_Painel_Linha a
 Where a.Codigoempresa = 8
   And a.Codigofl      = 9
   And a.Cod_Painel    = 16
--------------------------------------------------------------------------------------------------------------------------------------------------------------
--- Retorna os parametros
--------------------------------------------------------------------------------------------------------------------------------------------------------------
Select *
  From Gfo_Parametros a
 Where a.Codigoempresa = 8
   And a.Codigofl      = 9
--------------------------------------------------------------------------------------------------------------------------------------------------------------
---  Retorna os itinerarios que fazem o local do painel
--------------------------------------------------------------------------------------------------------------------------------------------------------------
Select *
  From Gfo_Itinerario_Itens a
 Where a.Id_Itinerario In (Select b.Id_Itinerario 
                             From Gfo_Itinerario b
                            Where b.Vigencia_Inicial = (Select Max(c.Vigencia_Inicial) 
                                                          From Gfo_Itinerario c
                                                         Where c.Codintlinha = b.Codintlinha
                                                           And c.Id_Itinerario In (Select d.Id_Itinerario  
                                                                                     From Gfo_Itinerario_Dia c
                                                                                    Where d.Codintlinha = c.Codintlinha
                                                                                      And d.Dia = 3)
                                                           And c.Vigencia_Inicial <= To_Date('23/08/2011 00:00:00','DD/MM/YYYY HH24:MI:SS'))
                              And b.Codintlinha = a.Codintlinha)
   And a.Id_Itinerario In (Select b.Id_Itinerario
                             From Gfo_Itinerario_Dia b
                            Where b.Codintlinha = a.Codintlinha
                              And b.Dia = 3)
   And a.Codintlinha    In (1112, 1119, 26565, 26590, 26604, 26607)
   And a.Cod_Localidade In (4101)
--------------------------------------------------------------------------------------------------------------------------------------------------------------
---  Retorna os servicos dos itinerarios encontrados
--------------------------------------------------------------------------------------------------------------------------------------------------------------
Select *
  From Gfo_Itinerario_Servicos a
 Where (a.Id_Itinerario = ? And a.Codintlinha = ? And a.Sentido = ? And a.Sequencial = ?)
    Or (a.Id_Itinerario = ? And a.Codintlinha = ? And a.Sentido = ? And a.Sequencial = ?)
                
--------------------------------------------------------------------------------------------------------------------------------------------------------------
---  Retorna ultima localizacao do veiculo, conforme as linhas dos itinerarios encontrados no periodo de 1hr
--------------------------------------------------------------------------------------------------------------------------------------------------------------
Select a.Codigoveic
      ,a.Id_Controle_Operacional
      ,a.Codintlinha
      ,a.Cod_Localidade
      ,a.Data_Ocorrencia
  From Gfo_Controleoperacional_Atual a
 Where a.Cod_Localidade Is Not Null
   And a.Data_Ocorrencia >= To_Date('23/08/2011 20:00:00', 'DD/MM/YYYY HH24:MI:SS')
   And a.Codintlinha In (1112, 1119, 26565, 26590, 26604, 26607)
--------------------------------------------------------------------------------------------------------------------------------------------------------------
---  Retorna dados da controle operacional
--------------------------------------------------------------------------------------------------------------------------------------------------------------
Select a.Codintlinha
      ,a.Cod_Localidade
      ,a.Data_Ocorrencia
      ,a.Sentido
      ,a.Cod_Intservdiaria
      ,a.Cod_Hordiaria
      ,a.Cod_Intturno
      ,a.Codigoveic
  From Gfo_Controleoperacional a
 Where a.Id_Controle_Operacional In (482610506, 482625250) 
--------------------------------------------------------------------------------------------------------------------------------------------------------------
---  Retorna as detecções dos veiculos encontrados ENTRE a menor data hora da ultima detecção e p SYSDATE + 1hr
--------------------------------------------------------------------------------------------------------------------------------------------------------------
Select a.Codigoveic 
      ,a.Latitude   
      ,a.Longitude  
  From Gfo_Controleoperacional a
 Where a.Codigoveic In (?, ?) And
       a.Data_Ocorrencia >= To_Date('23/08/2011 20:00:00', 'DD/MM/YYYY HH24:MI:SS') And 
       a.Data_Ocorrencia <= To_Date('23/08/2011 20:00:00', 'DD/MM/YYYY HH24:MI:SS')    
--------------------------------------------------------------------------------------------------------------------------------------------------------------
---  Retorna os itinerarios que fazem o local da ultima localizacao do veiculo
--------------------------------------------------------------------------------------------------------------------------------------------------------------
Select *
  From Gfo_Itinerario_Itens a
 Where a.Id_Itinerario In (Select b.Id_Itinerario 
                             From Gfo_Itinerario b
                            Where b.Vigencia_Inicial = (Select Max(c.Vigencia_Inicial) 
                                                          From Gfo_Itinerario c
                                                         Where c.Codintlinha = b.Codintlinha
                                                           And c.Id_Itinerario In (Select d.Id_Itinerario  
                                                                                     From Gfo_Itinerario_Dia c
                                                                                    Where d.Codintlinha = c.Codintlinha
                                                                                       And d.Dia = 3)
                                                           And c.Vigencia_Inicial <= To_Date('23/08/2011 00:00:00','DD/MM/YYYY HH24:MI:SS'))
                              And b.Codintlinha = a.Codintlinha)
   And a.Id_Itinerario In (Select b.Id_Itinerario
                             From Gfo_Itinerario_Dia b
                            Where b.Codintlinha = a.Codintlinha
                              And b.Dia = 3)
   And a.Codintlinha    In (1112, 1119, 26565, 26590, 26604, 26607)
   And a.Cod_Localidade In (4101)
--------------------------------------------------------------------------------------------------------------------------------------------------------------
---  Retorna os servicos dos itinerarios encontrados
--------------------------------------------------------------------------------------------------------------------------------------------------------------
Select *
  From Gfo_Itinerario_Servicos a
 Where (a.Id_Itinerario = ? And a.Codintlinha = ? And a.Sentido = ? And a.Sequencial = ?)
    Or (a.Id_Itinerario = ? And a.Codintlinha = ? And a.Sentido = ? And a.Sequencial = ?)
--------------------------------------------------------------------------------------------------------------------------------------------------------------
---  Retorna o proximo ponto de controle entre o ponto ultima detecçõa e o ponto do painel
--------------------------------------------------------------------------------------------------------------------------------------------------------------
Select *
  From Gfo_Itinerario_Itens a
 Where a.Cod_Localidade In (Select b.Cod_Localidade 
                              From t_Esc_Localidade b
                             Where b.Tipo_Local In (Select c.Tipo_Local
                                                      From Gfo_Tipolocal c
                                                     Where c.Ponto_Controle = 'S'))
   And (a.Codintlinha = ? And a.Id_Itinerario = ? And a.Sentido = ? And a.Sequencial Between ? And ?)
    Or (a.Codintlinha = ? And a.Id_Itinerario = ? And a.Sentido = ? And a.Sequencial Between ? And ?)
--------------------------------------------------------------------------------------------------------------------------------------------------------------
---  Retorna os servicos dos itinerarios encontrados
--------------------------------------------------------------------------------------------------------------------------------------------------------------
Select *
  From Gfo_Itinerario_Servicos a
 Where (a.Id_Itinerario = ? And a.Codintlinha = ? And a.Sentido = ? And a.Sequencial = ?)
    Or (a.Id_Itinerario = ? And a.Codintlinha = ? And a.Sentido = ? And a.Sequencial = ?)    
--------------------------------------------------------------------------------------------------------------------------------------------------------------
--- Retorna os dados das linhas
--------------------------------------------------------------------------------------------------------------------------------------------------------------
Select a.Codigolinha
      ,a.Codintlinha
  From Bgm_Cadlinhas a
 Where a.Codintlinha In (?, ?, ?)