select a.id 
     , a.data_hora_abertura as abertura 
     
     , FC_Previsao_AtendimentoTMP(a.id, a.data_hora_abertura, e.codsistema, b.prioridade, b.severidade, c.nivel, c.id_sla, c.criticocliente, c.vip) AS PREVISAO_ATENDIMENTO              
     
     , b.prioridade
     , b.severidade
     , c.codcliente
     , c.criticocliente as critico
     , c.nivel
     , c.vip
     , nvl(d.id                ,d1.id                ) as id
     , nvl(d.emergencia        ,d1.emergencia        ) as emergencia
     , nvl(d.operacao_degradada,d1.operacao_degradada) as degradada
     , nvl(d.prioridade_alta   ,d1.prioridade_alta   ) as alta
     , nvl(d.prioridade_media  ,d1.prioridade_media  ) as media
     , nvl(d.prioridade_baixa  ,d1.prioridade_baixa  ) as baixa  -- select * from MTK_TRAMITE where ID_TICKET = 723268
     , CASE WHEN  
           (SELECT NVL(MAX(ID),0)         
              FROM MTK_TRAMITE 
             WHERE ID_TICKET = a.id
               AND STATUS_ATUAL != 3) = 0 Or b.prioridade is null THEN 'Sim' Else '' End Em_Andamento
  from mtk_ticket a
  left join mtk_ticketdetalhes   b on a.id         = b.id
 inner join sii_cliente          c on a.codcliente = c.codcliente
  left join mtk_sla              d on c.id_sla     = d.id
  left join mtk_sla              d1 on c.nivel     = d1.id
 inner join sii_modulo           e on a.id_modulo  = e.id_modulo 
 where a.data_hora_abertura >= '01/01/2024'
-- and a.id in (723202)
-- and a.id in (723203, 723468,723454,723455,723473	)
-- and b.prioridade is null
 order by a.data_hora_abertura
 