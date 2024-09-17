create or replace view view_itens_versao as
select
t.codigosas as id,
t.tiposassim as tipo,
t.codigosas,
t.upgrade1 as upgrade,--divulga_cliente
decode(t.upgrade1, 'N', 0, 'S', 1) as divulgacliente2,
t.publicacaosas as publicacao,
(case when (t.upgrade1 = 'S') then
   nvl(t.publicacaosas,t.solicitacaosas) 
 else
   t.solicitacaosas  end) solicitacaosas,
t2.dtefetivaentrega as dataentrega,
t.codmodulo,
t3.descricaomodulo,
t3.codsistema,
t4.descricaolocalsistema,
t3.abreviadomodulo,
sii_cliente.nomefantasiacliente,
t.url_video,
(select count(sii_sas_videos.codigosas) from sii_sas_videos where sii_sas_videos.codigosas = t.codigosas
and sii_sas_videos.tiposassim = t.tiposassim and sii_sas_videos.tipo_docto = '2') as qtd_anexo,
t.divulgacliente,
t.codcliente,
decode(t.criticosas, 'N', 0, 'S', 1) as criticosas,
case when (t.severidade = 0) then 1 else 0 end as severidade,
t.datarecebimentosas,
t.terminoprevistosas,
t.dataentregasas,
t.tempoexecucaosas / 1000 as tempoexecucaosas,
decode(t.entregagarantidasas, 'N', 0, 'S', 1) as entregagarantidasas,
sii_contatocliente.nomecontatocli,
sii_contatocliente.emailcontatocli,
sii_contatocliente.telefonecontatocli,
to_number(trim(t.statussas)) as statussas,
sii_gruposatendimento_modulos.codigo_grupo,
sii_gruposatendimento.descricao as nome_grupo_atendimento,
(select listagg(id_artigo, ',') within group (order by id_artigo) from bdc_artigo_palavra where palavra_chave = 'PSE' || t.codigosas) as orientacoes_ecm,
case when (t.dt_garantiu_entrega is null) then 0 else 1 end as garantiu_entrega,
(select LISTAGG(protocolo,',') WITHIN GROUP (ORDER BY protocolo)
               from mtk_ticket_sas
               inner join mtk_ticket on mtk_ticket_sas.id_ticket = mtk_ticket.id
               where mtk_ticket_sas.codigo_sas = t.codigosas and mtk_ticket_sas.tipo_sas_sim = t.tiposassim
       )
        as ticketsassociados
from sii_sas t
inner join sii_entrega t2
on t2.tiposassim = t.tiposassim and t2.codigosas = t.codigosas
inner join sii_modulo t3
on t3.codmodulo = t.codmodulo and t3.codsistema = t.codsistema
inner join sii_localnomodulo t4
on t4.codmodulo = t.codmodulo and t4.codsistema = t.codsistema
and t4.codlocalsistema = t.codlocalsistema
left join sii_cliente on t.codcliente = sii_cliente.codcliente
left join sii_contatocliente on t.codcliente = sii_contatocliente.codcliente
and t.codcontatosolicitacao = sii_contatocliente.codcontato
inner join sii_modulo on sii_modulo.codmodulo = T.Codmodulo
and sii_modulo.codsistema = t.codsistema
left join sii_gruposatendimento_modulos on sii_gruposatendimento_modulos.id_modulo = sii_modulo.id_modulo
left join sii_gruposatendimento on sii_gruposatendimento_modulos.codigo_grupo = sii_gruposatendimento.codigo_grupo
where
t.codsistema in ('GLB', 'GL5') and
t.codmodulo <> 'AMB' and
t.tiposolicitacaosas <> 'T' and
t.codatividade <> 32 and
t2.dtefetivaentrega is not null
--and rownum <=1000
--and t.Upgrade1 = 'S'

