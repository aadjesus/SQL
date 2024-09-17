Select /*+ index(a jr_gfo_gerencial_itinerario) */
       a.Codintlinha,
       a.Codintveiculo,
       a.Localidade,
       a.Codintveiculo,
       a.programado,
       a.Ocorrencia,
       a.Ocorrencia_Horario,
       a.Ocorrencia_Comboio,
       a.Ocorrencia_Mensagem,
       a.Ocorrencia_Prognaorea,
       a.Ocorrencia_Reanaoprog,
       a.Peso,
       a.Peso_Ocor_Comboio,
       a.Peso_Ocor_Horario,
       a.Peso_Ocor_Mensagem,
       a.Peso_Ocor_Prognaorea,
       a.Peso_Ocor_Reanaoprog,a.sentido
  From Gfo_Gerencial_Itinerario a
 Where a.Codintlinha In (1111, 1113, 1116, 1119, 1198, 1199, 1206, 1207, 1504, 2201, 2253, 2264, 2265, 2302, 2307, 2310, 4055, 25473, 25512, 25514, 25530, 25534, 26582, 26585, 26598, 26599, 26600, 26601, 26603, 26604, 26605, 26606, 26607, 26608, 26609, 26610, 26611, 26612, 26613, 26614, 26615 )
   And a.localidade In (4037, 4063, 4065, 4073, 4074, 4082, 4094, 4095, 4101, 4108, 4109, 4117, 4125, 4126, 4127, 4129, 4138, 4140, 4141, 4152, 4158, 4162, 4168, 4178, 4180, 4183, 4185, 4186, 4188, 4189, 4197, 4199, 4284, 4288, 8948, 8952, 8953, 8962, 8964, 8965, 9012, 9094, 9100, 9102)
   And a.codintveiculo In (4466, 4608, 4621, 4626, 4632, 4635, 4647, 4653, 4745, 5416, 5418, 5419, 5420, 5497, 5626, 5694, 5700, 5701, 5709, 5829, 6088, 6096, 6150, 6194, 6282, 6288, 6476, 6477, 6514, 6524, 6526, 6546, 6669, 6671, 7298, 7367, 7369, 7370, 7390, 7621, 7628, 7908 )
   And a.Programado Between
       To_Date('01/12/2010 00:00:00', 'DD/MM/YYYY HH24:MI:SS') And
       To_Date('11/12/2010 00:00:00', 'DD/MM/YYYY HH24:MI:SS')
