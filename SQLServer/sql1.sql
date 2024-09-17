select a.*,b.codigo from NotificacaoUsuarioPedidoStatusAlterado a
inner join pedido b on a.id_pedido = b.id
where a.id_pedido in (344,345)
and a.id_usuario = 150


--sp_who

/*
update NotificacaoUsuarioPedidoStatusAlterado 
set enviada_notificacao =0, 
    enviado_email = 0,
    processada = 0
where id_pedido in (344,345)
and id_usuario = 150

select * from  pedidohistorico where id_pedido in (344,345)

delete NotificacaoUsuarioPedidoStatusAlterado where  id_pedido in (344,345) and id_usuario = 150
update pedidohistorico set notificacao_processada = 0
where id_pedido in (344,345)
*/

--SELECT * FROM LogService WHERE Job = 'NotificacaoPedidoStatusAlteradoJob' and event_id = 'Erro'

