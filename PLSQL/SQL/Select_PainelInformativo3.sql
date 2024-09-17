Select a.*
  From (Select a.Sequencial As Seq_Iti_Inf,
               b.Sequencial As Seq_Iti_Mov,
               to_char(a.Tempo,'HH24:MI:SS') As Tempo_Iti_Inf,
               to_char(b.Tempo,'HH24:MI:SS') As Tempo_Iti_Mov,
               ((Abs(a.Tempo - b.Tempo) * 24) * 60) Tempo_Previsto_Iti,
               to_char(Data_Ocorrencia,'HH24:MI:SS') As Data_Ocorrencia,
--               a.Cod_Localidade As Loc_Iti_Inf,
               b.Cod_Localidade As Loc_Iti_Mov,
               d.Prefixoveic,
--               e.codigolinha,
               (Data_Ocorrencia + (((Abs(a.Tempo - b.Tempo) * 24) * 60) / 1440)) As Data_Ocorrencia_Mais_Tempo,               
               trunc((((Data_Ocorrencia + (((Abs(a.Tempo - b.Tempo) * 24) * 60) / 1440)) - To_Date('20/10/2010 16:24:00', 'DD/MM/YYYY HH24:MI:SS')) * 24) * 60) As TempoPrevisto              
          From (
          Select *
                  From Gfo_Itinerario_Itens This_
                 Where This_.Id_Itinerario In
                       (Select Max(This_0_.Id_Itinerario) As Y0_
                          From Gfo_Itinerario_Dia This_0_
                         Where This_0_.Id_Itinerario In
                               (Select This_0_0_.Id_Itinerario As Y0_
                                  From Gfo_Itinerario This_0_0_
                                 Where This_0_0_.Vigencia_Inicial =
                                       (Select Max(This_0_0_0_.Vigencia_Inicial) As Y0_
                                          From Gfo_Itinerario This_0_0_0_
                                         Where This_0_0_0_.Codintlinha =
                                               This_0_0_.Codintlinha
                                           And This_0_0_0_.Vigencia_Inicial <=
                                               To_Date('20/10/2010 00:00:00',
                                                       'DD/MM/YYYY HH24:MI:SS'))
                                   And This_0_0_.Codintlinha =
                                       This_0_.Codintlinha)
                           And This_0_.Codintlinha = This_.Codintlinha
                           And This_0_.Dia = 2)
                   And (This_.Cod_Localidade In (4126))
                   And (This_.Codintlinha In (26584))
                   ) a,
               (
               Select *
                  From Gfo_Itinerario_Itens This_
                 Where This_.Id_Itinerario In
                       (Select Max(This_0_.Id_Itinerario) As Y0_
                          From Gfo_Itinerario_Dia This_0_
                         Where This_0_.Id_Itinerario In
                               (Select This_0_0_.Id_Itinerario As Y0_
                                  From Gfo_Itinerario This_0_0_
                                 Where This_0_0_.Vigencia_Inicial =
                                       (Select Max(This_0_0_0_.Vigencia_Inicial) As Y0_
                                          From Gfo_Itinerario This_0_0_0_
                                         Where This_0_0_0_.Codintlinha =
                                               This_0_0_.Codintlinha
                                           And This_0_0_0_.Vigencia_Inicial <=
                                               To_Date('20/10/2010 00:00:00',
                                                       'DD/MM/YYYY HH24:MI:SS'))
                                   And This_0_0_.Codintlinha =
                                       This_0_.Codintlinha)
                           And This_0_.Codintlinha = This_.Codintlinha
                           And This_0_.Dia = 2)
                   And (This_.Codintlinha In (26584))
                   And (This_.Cod_Localidade In
                       (Select This_.Cod_Localidade
                           From Gfo_Controleoperacional This_
                          Where This_.Cod_Localidade Is Not Null
                            And This_.Data_Ocorrencia Between To_Date('20/10/2010 16:00:00', 'DD/MM/YYYY HH24:MI:SS') And To_Date('20/10/2010 17:00:00', 'DD/MM/YYYY HH24:MI:SS')
                            And (This_.Codintlinha In (26584))
                          Group By This_.Cod_Localidade))
                          ) b,
               (Select This_.Data_Ocorrencia,
                       This_.Codintlinha,
                       This_.Cod_Localidade,
                       This_.Codigoveic
                  From Gfo_Controleoperacional This_
                 Where This_.Cod_Localidade Is Not Null
                   And This_.Data_Ocorrencia Between To_Date('20/10/2010 16:00:00', 'DD/MM/YYYY HH24:MI:SS') And To_Date('20/10/2010 17:00:00', 'DD/MM/YYYY HH24:MI:SS')
                   And (This_.Codintlinha In (26584))) c,
               Frt_Cadveiculos d,
               bgm_cadlinhas   e
         Where a.Sequencial > b.Sequencial
           And a.Codintlinha = e.codintlinha
           And a.Codintlinha = b.Codintlinha
           And a.Codintlinha = c.Codintlinha
           And b.Cod_Localidade = c.Cod_Localidade
           And c.Codigoveic = d.Codigoveic
           ) a