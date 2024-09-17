Select a.Codintlinha,
       Count(a.Codintveiculo),
       a.Localidade,
       a.Codintveiculo,
       To_Char(Programado, 'HH24') Hora,
       To_Char(Programado, 'DD') Dia,
       a.Ocorrencia,
       a.Ocorrencia_Horario,
       a.Ocorrencia_Comboio,
       a.Ocorrencia_Mensagem,
       a.Ocorrencia_Prognaorea,
       a.Ocorrencia_Reanaoprog,
       Sum(a.Peso),
       Sum(a.Peso_Ocor_Comboio),
       Sum(a.Peso_Ocor_Horario),
       Sum(a.Peso_Ocor_Mensagem),
       Sum(a.Peso_Ocor_Prognaorea),
       Sum(a.Peso_Ocor_Reanaoprog),
       Sum(a.Prioridade),
       Sum(a.Prioridade_Ocor_Comboio),
       Sum(a.Prioridade_Ocor_Horario),
       Sum(a.Prioridade_Ocor_Mensagem),
       Sum(a.Prioridade_Ocor_Prognaorea),
       Sum(a.Prioridade_Ocor_Reanaoprog)
  From Gfo_Gerencial_Itinerario a
 Where a.Codintlinha = 4055
   And Nvl(a.Codintveiculo, 0) > 0
   And a.Programado Between
       To_Date('01/12/2010 00:00:00', 'DD/MM/YYYY HH24:MI:SS') And
       To_Date('31/12/2010 00:00:00', 'DD/MM/YYYY HH24:MI:SS')
 Group By a.Codintlinha,
          a.Localidade,
          a.Codintveiculo,
          To_Char(Programado, 'HH24'),
          To_Char(Programado, 'DD'),
          a.Ocorrencia,
          a.Ocorrencia_Horario,
          a.Ocorrencia_Comboio,
          a.Ocorrencia_Mensagem,
          a.Ocorrencia_Prognaorea,
          a.Ocorrencia_Reanaoprog