create or replace view view_grid_tickets as
select T.id as id,
T.data_hora_sistema,
       (
       case when ((status = 1 or (select count(id) from mtk_tramite where id_ticket = T.id) <= 1) and retorna_tipooperador(T.id) = 1) then '1' --ticket aberto e não respondido
            when (retorna_tipooperador(T.id) = 2 and (status = 1 or (select count(id) from mtk_tramite where id_ticket = T.id) <= 1)) then '2' --chamado aberto pela telefonista e não respondido
            when (retorna_tipooperador(T.id) = 1 and status != 7) then '3' --cliente respondeu e nós não
            when (status = 8) then '4' --chamado reaberto
            else '' end --definir os outros...
       ) as sinalizador,
       T.protocolo,
       T.assunto as assunto,
       mtk_ticketdetalhes.natureza,
       mtk_ticketdetalhes.origem as origem,
       T.data_hora_abertura as data_hora_abertura,
       T.data_hora_conclusao as data_hora_conclusao,
       T.Data_Hora_Limite as data_hora_limite,
       T.status,
       sii_cliente.codcliente as codigo_cliente,
       sii_cliente.nomefantasiacliente as nome_cliente,
       sii_modulo.codsistema as id_sistema,
       sii_modulo.codmodulo as codigo_modulo,
       mtk_ticketdetalhes.data_proxima_acao as data_proxima_acao,
       mtk_ticketdetalhes.peso,
       (CAST(
          (
          case 
          when mtk_ticketdetalhes.sla is  null then 0
          else (mtk_ticketdetalhes.sla / 60)
          end
          )
         AS NUMBER(10,2))
        ) as tempo_percorrido_sla_horas,
       (
        CAST(
          (
          select case 
                 when tempo_limite is null then 9999 
                 else (tempo_limite/60) end 
          from mtk_sla 
          where mtk_sla.id = 
               (select id_sla from sii_cliente where sii_cliente.codcliente = T.codcliente)
          )
        AS NUMBER(10,2))        
        ) as tempo_limite_sla_horas,
       mtk_ticketdetalhes.prioridade,
       mtk_ticketdetalhes.severidade,
       T.id_operador as operador_responsavel,
       mtk_ticketdetalhes.avaliacao_cliente as avaliacao_cliente,
	     mtk_ticketdetalhes.avaliacao_n2 as avaliacao_n2,
       T.id_operador_contato as id_operador_contato,
       (select count(id) from mtk_tramite where id_ticket = T.id) as quantidade_tramites,
       (select max(data_hora) from mtk_tramite where id_ticket = T.id) as data_hora_tramite,
       operador_atendente.nome_abreviado as nome_operador,
       operador_contato.nome as nome_contato,
       sii_gruposatendimento_modulos.codigo_grupo,
       sii_gruposatendimento.descricao as nome_grupo_atendimento,
	   decode(nvl(sii_cliente.atend_usuariochave,'N'), 'N', 0, 'S', 1) as atend_usuariochave,
       decode(sii_cliente.criticocliente, 'N', 0, 'S', 1) as cliente_critico,
       decode(sii_cliente.globus_cloud, 'N', 0, 'S', 1) as globus_cloud,
       (
       select count(classificacaogrupo) from sii_grupoempresa
       where classificacaogrupo = '5' and codgrupoemp = sii_cliente.codgrupoemp
       ) as cliente_vip,
       (
       select classificacaogrupo from sii_grupoempresa
       where codgrupoemp = sii_cliente.codgrupoemp
       ) as curva_abc,
       (
       select count(mtk_anexo.id) from mtk_anexo
       inner join mtk_tramite on mtk_tramite.id = mtk_anexo.id_tramite
       where id_ticket = T.id
       ) as anexo,
       retorna_ticketlido(T.id, T.id_operador) as lido_operador,
       upper(T.assunto) as assunto_pesquisa,
       (
       case when (T.grupo_tipo = '2') then 2
			when (T.grupo_tipo = '3') then 3
			else (case when (sii_gruposatendimento_func.grupo_tipo is null) then 1
				  else sii_gruposatendimento_func.grupo_tipo end) end
       ) as grupo_tipo,
       (select max(id_operador) from mtk_tramite
       inner join (select max(data_hora) as data_hora, id_ticket from mtk_tramite
       where escalado_n2 = 'S' group by id_ticket) tramites2 on
       tramites2.id_ticket = mtk_tramite.id_ticket and
       tramites2.data_hora = mtk_tramite.data_hora
       where mtk_tramite.id_ticket = T.id and escalado_n2 = 'S') as operador_escala,
       (select LISTAGG('PSE'||codigo_sas,',') WITHIN GROUP (ORDER BY codigo_sas)
               from mtk_ticket_sas
               where mtk_ticket_sas.id_ticket = T.id and mtk_ticket_sas.tipo_sas_sim = '0'
       ) || ';' ||
       (select LISTAGG('SIM'||codigo_sas,',') WITHIN GROUP (ORDER BY codigo_sas)
               from mtk_ticket_sas
               where mtk_ticket_sas.id_ticket = T.id and mtk_ticket_sas.tipo_sas_sim = '1'
       )
        as adequacoes,
        round((sysdate - sii_contrato.datacontrato) / 365, 0) as tempo_contrato,
        operador_contato.observacao as observacao
from mtk_ticket T
left join mtk_ticketdetalhes on mtk_ticketdetalhes.id = T.id
inner join sii_cliente on sii_cliente.codcliente = T.codcliente
left join sii_contrato on sii_cliente.codcliente = sii_contrato.codcliente and sii_contrato.ativocontrato = 'A'
inner join sii_modulo on sii_modulo.id_modulo = T.id_modulo
left join sii_gruposatendimento_modulos on sii_gruposatendimento_modulos.id_modulo = sii_modulo.id_modulo
left join sii_gruposatendimento on sii_gruposatendimento_modulos.codigo_grupo = sii_gruposatendimento.codigo_grupo
left join sii_gruposatendimento_func on sii_gruposatendimento_func.id_operador = T.id_operador and sii_gruposatendimento.codigo_grupo = sii_gruposatendimento_func.codigo_grupo
left join mtk_operador operador_atendente on operador_atendente.id = T.id_operador
left join mtk_operador operador_contato on operador_contato.id = T.id_operador_contato
inner join sii_sistema on sii_sistema.codsistema = sii_modulo.codsistema