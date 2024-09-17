-------------- PESQUISA DADOS DO LOCAL INFORMADO --------------
Select *
  From t_Esc_Localidade Locaisdto0_
 Where Locaisdto0_.Cod_Localidade = 4127
-------------- PESQUISA LINHAS ASSOCIADAS AO PAINEL INFORMADO --------------
  Select *
    From Gfo_Painel_Linha This_
   Where This_.Codigoempresa = 8
     And This_.Codigofl = 9
     And This_.Cod_Painel = 1
-------------- PESQUISA O ITINERARIO DO LOCAL INFORMADO --------------
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
                             And This_0_0_0_.Vigencia_Inicial <= To_Date('19/07/2010 22:00:00', 'DD/MM/YYYY HH24:MI:SS'))
                     And This_0_0_.Codintlinha = This_0_.Codintlinha)
             And This_0_.Codintlinha = This_.Codintlinha
             And This_0_.Dia = 2)
     And (This_.Cod_Localidade In (4127));
-------------- PESQUISA MOVIMENTACAO DAS LINHAS DO ITINERARIO INFORMADO --------------
  Select *
    From Gfo_Controleoperacional_Atual This_
   Where This_.Cod_Localidade Is Not Null
     And This_.Data_Ocorrencia Between To_Date('19/07/2010 21:00:00', 'DD/MM/YYYY HH24:MI:SS') And To_Date('19/07/2010 22:00:00', 'DD/MM/YYYY HH24:MI:SS')
     And (This_.Codintlinha In
         (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?));
P0 = '19/07/2010 21:00:00', P1 = '19/07/2010 22:00:00', P2 = '26598', P3 = '26602', P4 = '2307', P5 = '26599', P6 = '26601', P7 = '26609', P8 = '1116', P9 = '26610', P10 = '26611', P11 = '26607', P12 = '26612', P13 = '26613', P14 = '26614', P15 = '26615', P16 = '26600', P17 = '1119', P18 = '26604', P19 = '26608', P20 = '26605', P21 = '26606'

-------------- PESQUISA O ITINERARIO DO LOCAL DA MOVIMENTACAO --------------
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
                             And This_0_0_0_.Vigencia_Inicial <= To_Date('19/07/2010 22:00:00', 'DD/MM/YYYY HH24:MI:SS'))
                     And This_0_0_.Codintlinha = This_0_.Codintlinha)
             And This_0_.Codintlinha = This_.Codintlinha
             And This_0_.Dia = 2)
     And (This_.Codintlinha In ())
     And (This_.Cod_Localidade In ())
-------------- PESQUISA MOVIMENTCAO -------------- 
  Select *
    From Gfo_Controleoperacional This_
   Where (This_.Id_Controle_Operacional In ())
-------------- PESQUISA ESCALA PROGRAMADA
  Select *
    From t_Esc_Escaladiaria  Escaladiar0_,
         t_Esc_Servicodiaria Servicoesc1_,
         t_Esc_Horariodiaria Horarioesc2_
   Where (Escaladiar0_.Cod_Intlinha In (1, 1, 1, 1, 1))
     And (Escaladiar0_.Dat_Escala = '19-jun-2010')
     And (Escaladiar0_.Cod_Intescala = Servicoesc1_.Cod_Intescala)
     And (Escaladiar0_.Dat_Escala = Servicoesc1_.Dat_Escala)
     And (Servicoesc1_.Cod_Intescala = Horarioesc2_.Cod_Intescala)
     And (Servicoesc1_.Dat_Escala = Horarioesc2_.Dat_Escala)
     And (Servicoesc1_.Cod_Servdiaria = Horarioesc2_.Cod_Intservdiaria)
     And (Servicoesc1_.Cod_Intturno = Horarioesc2_.Cod_Intturno)
     And (Horarioesc2_.Cod_Localidade = 4127)
     And (To_Date('19/07/2010 22:00:00', 'DD/MM/YYYY HH24:MI:SS') Between Horarioesc2_.Hor_Saida And Horarioesc2_.Hor_Chegada)

-------------- PESQUISA LINHAS  --------------
  Select *
    From Bgm_Cadlinhas This_
   Where (This_.Codintlinha In ())
-------------- PESQUISA LOCAIS -------------- 
  Select *
    From t_Esc_Localidade This_
   Where (This_.Cod_Localidade In ())
