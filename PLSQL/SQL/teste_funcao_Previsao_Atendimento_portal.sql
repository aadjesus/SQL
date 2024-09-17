PL/SQL Developer Test script 3.0
54
declare 
  v_id					       mtk_ticket.id%Type;
  v_data_hora_abertura mtk_ticket.data_hora_abertura%Type;
  v_codsistema			   sii_modulo.codsistema%Type;
  v_prioridade			   mtk_ticketdetalhes.prioridade%Type;
  v_severidade			   mtk_ticketdetalhes.severidade%Type;
  v_nivel					     sii_cliente.nivel%Type;
  v_id_sla				     sii_cliente.id_sla%Type;
  v_criticocliente		 sii_cliente.criticocliente%Type;
  v_vip					       sii_cliente.vip%Type;    
  v_retorno            DATE;         
begin

select a.id
     , a.data_hora_abertura
     , e.codsistema
     , b.prioridade
     , b.severidade
     , c.nivel
     , c.id_sla
     , c.criticocliente
     , c.vip
  INTO v_id
     , v_data_hora_abertura
     , v_codsistema
     , v_prioridade
     , v_severidade
     , v_nivel
     , v_id_sla
     , v_criticocliente
     , v_vip
  from mtk_ticket a
  left join mtk_ticketdetalhes   b on a.id         = b.id
 inner join sii_cliente          c on a.codcliente = c.codcliente
  left join mtk_sla              d on c.id_sla     = d.id
  left join mtk_sla              d1 on c.nivel     = d1.id
 inner join sii_modulo           e on a.id_modulo  = e.id_modulo 
 where a.id in (723202);

 
 v_retorno := FC_Previsao_AtendimentoTMP(
           v_id, 
           v_data_hora_abertura, 
           v_codsistema, 
           v_prioridade, 
           v_severidade, 
           v_nivel, 
           v_id_sla, 
           v_criticocliente, 
           v_vip);
           
  DBMS_OUTPUT.PUT_LINE(to_char(v_retorno, 'DD/MM/YYYY HH24:MI:SS'));           

end;
0
6
p_DataBase
v_Retorno
v_Hora
v_HoraFim
v_QtdeDias
