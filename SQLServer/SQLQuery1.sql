select a.Codigo,a.Id, a.Data_Visualizacao_Fornecedor, d.Descricao, c.*
 from Pedido a
inner join Fornecedor b on a.Id_Fornecedor = b.Id
inner join Empresa c on b.Id_Empresa = c.Id
inner join PedidoStatus d on a.Id_Status = d.Id
where 
--a.Data_Visualizacao_Fornecedor is null
--and 
a.Codigo = '000073'
and a.Id = 151


select * from NotificacaoUsuarioPedidoVisualizado x where x.Id_Pedido = 151
select * from NotificacaoUsuarioPedidoStatusAlterado x where x.Id_Pedido = 151