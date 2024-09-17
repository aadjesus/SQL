-- 1o (Soltura de frota)
SELECT this_.ID_SOLTURA as ID1_169_0_, this_.Prefixo as Prefixo169_0_, this_.LINHA as LINHA169_0_, this_.TIPO as TIPO169_0_, this_.DATA_SOLTURA as DATA5_169_0_, this_.USUARIO as USUARIO169_0_, this_.Integrado as Integrado169_0_, this_.LOCALIDADE as LOCALIDADE169_0_ 
  FROM GFO_SOLTURADEFROTA this_ 
 WHERE this_.DATA_SOLTURA between TO_DATE('01/10/2009 00:00:00','DD/MM/YYYY HH24:MI:SS') 
                              and TO_DATE('01/10/2009 23:59:00','DD/MM/YYYY HH24:MI:SS') 
   and (this_.LOCALIDADE in (4007, 4008, 4009, 4010, 1, 2, 3, 7, 8, 174, 803, 829 )) 
   and (this_.LINHA in ('007'))
   
-- 2o (Veiculos da soltura)
SELECT this_.CODIGOVEIC as y0_, this_.PREFIXOVEIC as y1_, this_.CODIGOFL as y2_ 
  FROM FRT_CADVEICULOS this_ 
 WHERE this_.CODIGOEMPRESA = 8 
   and (this_.PREFIXOVEIC in ('0008773','0008784','0007905','0007720','0007813','0007737','0007737','0007813'   ))   
   and this_.CONDICAOVEIC = 'A'
   
-- 3o (Controle operacional)
SELECT min(this_.DATA_OCORRENCIA) as y0_, this_.COD_LOCALIDADE as y1_, this_.SENTIDO as y2_, this_.CODINTLINHA as y3_, this_.CODIGOVEIC as y4_, this_.COD_INTSERVDIARIA as y5_ 
  FROM GFO_CONTROLEOPERACIONAL this_ 
 WHERE this_.DATA_OCORRENCIA between TO_DATE('25/09/2009 00:00:00','DD/MM/YYYY HH24:MI:SS') 
                                 and TO_DATE('25/09/2009 23:59:00','DD/MM/YYYY HH24:MI:SS') 
   and this_.COD_MENSAGEM in (SELECT this_0_.COD_MENSAGEM as y0_ 
                                FROM GFO_MENSAGENS this_0_ 
                               WHERE not this_0_.TIPO_MENSAGEM = 3) 
   and (this_.COD_LOCALIDADE in (4007, 4008, 4009, 4010, 1, 2, 3, 7, 8, 174, 803, 829 )) 
   and (this_.CODINTLINHA in (26566)) 
GROUP BY this_.COD_LOCALIDADE, this_.SENTIDO, this_.CODINTLINHA, this_.CODIGOVEIC, this_.COD_INTSERVDIARIA

-- 4o (Veiculos do constrole operacional)
SELECT *
FROM FRT_CADVEICULOS this_
   , FRT_TIPODEFROTA tipodefrot2_ 
WHERE this_.CODIGOTPFROTA=tipodefrot2_.CODIGOTPFROTA(+) 
  AND (this_.CODIGOVEIC in (4473,4745,5438,6517))

-- 5o (Linhas do constrole operacional)
SELECT this_.CODINTLINHA as CODINTLI1_127_0_, this_.CODIGOORGCONC as CODIGOOR2_127_0_, this_.COD_LOCAL_TERMINAL_SEC as COD3_127_0_, this_.CODIGOEMPRESA as CODIGOEM4_127_0_, this_.COD_ESCALAGRUPOLINHA as COD5_127_0_, this_.CODIGOGA as CODIGOGA127_0_, this_.CODIGOLINHA as CODIGOLI7_127_0_, this_.NROFICIALLINHA as NROFICIA8_127_0_, this_.NOMELINHA as NOMELINHA127_0_, this_.NOMEABREVLINHA as NOMEABR10_127_0_, this_.LOTELINHA as LOTELINHA127_0_, this_.COMISSAOMOTLINHA as COMISSA12_127_0_, this_.COMISSAOCOBLINHA as COMISSA13_127_0_, this_.TIPODESERVICO as TIPODES14_127_0_, this_.DATAINICOPERACAOLINHA as DATAINI15_127_0_, this_.FLG_RESPGUIA as FLG16_127_0_, this_.CODIGOGRUPOLINHA as CODIGOG17_127_0_, this_.ORIGEMLINHA as ORIGEML18_127_0_, this_.DESTINOLINHA as DESTINO19_127_0_, this_.COD_AGENCIA_IDA as COD20_127_0_, this_.COD_AGENCIA_VOLTA as COD21_127_0_, this_.CODIGOTPLINHA as CODIGOT22_127_0_, this_.FLG_MUNIC_INTEREST as FLG23_127_0_, this_.ORDEM as ORDEM127_0_, this_.FLG_PAESE as FLG25_127_0_, this_.FLG_CIRCULAR as FLG26_127_0_, this_.LOG_ALTER as LOG27_127_0_, this_.CODIGOFL as CODIGOFL127_0_, this_.NAOCRITICACIRCULAR as NAOCRIT29_127_0_, this_.CODIGOIMPORTACAO as CODIGOI30_127_0_, this_.FLG_LINHA_PRINCIPAL as FLG31_127_0_, this_.DIGITASECAO as DIGITAS32_127_0_, this_.TIPOCIRCULAR as TIPOCIR33_127_0_, this_.DIGITAQTD as DIGITAQTD127_0_, this_.CODINTLINHACOMP as CODINTL35_127_0_, this_.TEMPOMINVIAGEM as TEMPOMI36_127_0_, this_.CODIGOLINHAMIN as CODIGOL37_127_0_, this_.DIGITAORIGEMDESTINO as DIGITAO38_127_0_, this_.COD_GRUPOLINHA_PVT as COD39_127_0_, this_.INTERVALO_COMBOIO as INTERVALO40_127_0_, this_.FATORRENOVACAO as FATORRE41_127_0_ 
  FROM BGM_CADLINHAS this_ 
 WHERE this_.CODINTLINHA in (26566) 

-- 5o (Parametros)
SELECT this_.CODIGOEMPRESA as CODIGOEM1_97_0_, this_.CODIGOFL as CODIGOFL97_0_, this_.MINUTOS_ATRASO as MINUTOS3_97_0_, this_.MINUTOS_ADIANTADO as MINUTOS4_97_0_, this_.OCORRENCIA_COMBOIO as OCORRENCIA5_97_0_, this_.OCORRENCIA_ATRASO as OCORRENCIA6_97_0_, this_.OCORRENCIA_ADIANTADO as OCORRENCIA7_97_0_, this_.OCORRENCIA_NOHORARIO as OCORRENCIA8_97_0_, this_.OCORRENCIA_PROGNAOREA as OCORRENCIA9_97_0_, this_.OCORRENCIA_REANAOPROG as OCORRENCIA10_97_0_ 
  FROM GFO_PARAMETROS this_
  
-- 6o (Plantao)
SELECT this_.COD_SERVDIARIA as y0_, this_.COD_INTTURNO as y1_, this_.HORASAIDAGARAGEM as y2_, this_.CODIGOVEIC as y3_, this_.CODINTLINHA as y4_, this_.DTSAIDA as y5_ 
  FROM PLT_SAIDARECOLHIDA this_ 
 WHERE (this_.CODINTLINHA in (26566)) 
   and (this_.CODIGOVEIC in (4473,4745,5438,6517)) 
   and this_.DTSAIDA >= TO_DATE('25/09/2009 00:00:00','DD/MM/YYYY HH24:MI:SS')  
   and this_.DTSAIDA <= TO_DATE('25/09/2009 23:59:00','DD/MM/YYYY HH24:MI:SS')  
   and this_.HORASAIDAGARAGEM >= TO_DATE('25/09/2009 00:00:00','DD/MM/YYYY HH24:MI:SS')  
   and this_.HORASAIDAGARAGEM <= TO_DATE('25/09/2009 23:59:00','DD/MM/YYYY HH24:MI:SS')  
    -- 7o (Escala)
select servicoesc1_.COD_SERVDIARIA as x0_0_, servicoesc1_.COD_INTTURNO as x1_0_, servicoesc1_.HOR_INICIO_SERVICO as x2_0_, servicoesc1_.HOR_SAIDA_GARAGEM as x3_0_, servicoesc1_.COD_VEIC as x4_0_, escaladiar0_.COD_INTLINHA as x5_0_, escaladiar0_.DAT_ESCALA as x6_0_, horarioesc2_.COD_HORDIARIA as x7_0_ 
  from T_ESC_ESCALADIARIA escaladiar0_, T_ESC_SERVICODIARIA servicoesc1_, T_ESC_HORARIODIARIA horarioesc2_ 
 where (escaladiar0_.COD_INTESCALA=servicoesc1_.COD_INTESCALA )
   And (escaladiar0_.DAT_ESCALA=servicoesc1_.DAT_ESCALA )
   And (servicoesc1_.COD_INTESCALA=horarioesc2_.COD_INTESCALA )
   And (servicoesc1_.DAT_ESCALA=horarioesc2_.DAT_ESCALA )
   And (servicoesc1_.COD_SERVDIARIA=horarioesc2_.COD_INTSERVDIARIA )
   And (servicoesc1_.COD_INTTURNO=horarioesc2_.COD_INTTURNO )
   And (escaladiar0_.DAT_ESCALA between TO_DATE('25/09/2009 00:00:00','DD/MM/YYYY HH24:MI:SS')  
                                    and TO_DATE('25/09/2009 23:59:00','DD/MM/YYYY HH24:MI:SS')  )
   And (escaladiar0_.COD_INTLINHA In (26566) )
   And (servicoesc1_.COD_PEG_MOT in(4007, 4008, 4009, 4010, 1, 2, 3, 7, 8, 174, 803, 829))
   And (servicoesc1_.COD_VEIC in(4473,4745,5438,6517))
   And (servicoesc1_.HOR_SAIDA_GARAGEM is not Null )
   And (servicoesc1_.HOR_SAIDA_GARAGEM=(select Min(servicoesc3_.HOR_SAIDA_GARAGEM) 
                                          from T_ESC_SERVICODIARIA servicoesc3_ 
                                         where (servicoesc1_.DAT_ESCALA=servicoesc3_.DAT_ESCALA )
                                           And (servicoesc3_.HOR_SAIDA_GARAGEM between TO_DATE('25/09/2009 00:00:00','DD/MM/YYYY HH24:MI:SS')   
                                                                                   and TO_DATE('25/09/2009 23:59:00','DD/MM/YYYY HH24:MI:SS')   )
                                           And (servicoesc3_.COD_VEIC in(4473,4745,5438,6517))
                                           And (servicoesc3_.COD_PEG_MOT in(4007, 4008, 4009, 4010, 1, 2, 3, 7, 8, 174, 803, 829))))