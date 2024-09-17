Select a.Veiculo_Externo
      ,a.Data_Ocorrencia
      ,a.Data_Gravacao
      ,a.Id_Integradora
  From Gfo_Integradora a
 Where a.Data_Ocorrencia Between
       To_Date('23/08/2011 10:00:00', 'DD/MM/YYYY HH24:MI:SS') And
       To_Date('23/08/2011 11:00:00', 'DD/MM/YYYY HH24:MI:SS')
   And a.Veiculo_Externo In
       (Select b.Codigo_Spark
          From t_Arr_Param_Prdt b
         Where b.Codigo_Globus In
               (Select c.Codigoveic From Gfo_Controleoperacional_Atual c))