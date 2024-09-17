DECLARE	@vSql NVARCHAR(Max)
	  ,	@vTabela   NVARCHAR(100)
	  ,	@vDataBase DATE = Cast(GetDate()-7 as date);

DELETE FROM LogLimpezaNotificacao;

DECLARE sql_cursor CURSOR FOR
	Select a.name
	     , trim(b.texto_sql) 
      From sys.tables  a
      Join (Select value texto_sql From STRING_SPLIT('
				DELETE a FROM NotificacaoUsuarioPedidoVisualizado    a INNER JOIN Pedido  b ON a.Id_Pedido  = b.Id WHERE b.Data_hora     < @vDataBase;
				DELETE a FROM NotificacaoUsuarioNovoPedido           a INNER JOIN Pedido  b ON a.Id_Pedido  = b.Id WHERE b.Data_hora     < @vDataBase;
				DELETE a FROM NotificacaoUsuarioPedidoStatusAlterado a INNER JOIN Pedido  b ON a.Id_Pedido  = b.Id WHERE b.Data_hora     < @vDataBase;
				DELETE a FROM NotificacaoUsuarioPedidoNaoVisualizado a INNER JOIN Pedido  b ON a.Id_Pedido  = b.Id WHERE b.Data_hora     < @vDataBase;		 
				DELETE a FROM NotificacaoUsuarioNovaCotacao          a INNER JOIN Cotacao b ON a.Id_Cotacao = b.Id WHERE b.Data_Abertura < @vDataBase;
				DELETE a FROM NotificacaoUsuarioCotacaoAExpirar      a WHERE a.Data_Limite_Cotacao < @vDataBase;
				DELETE a FROM LogService							 a WHERE a.Date < @vDataBase
				',';')) b on UPPER(b.texto_sql) like UPPER('%'+a.name+'%')
	 Where (a.name like 'Notificacao%' or a.name = 'LogService')
	   and a.name != 'Notificacao';

OPEN sql_cursor;
FETCH NEXT FROM sql_cursor into  @vTabela, @vSql;
WHILE @@FETCH_STATUS = 0
BEGIN
	print @vTabela
	EXECUTE sys.sp_executesql @vSql, N'@vDataBase DATE', @vDataBase;
	INSERT INTO LogLimpezaNotificacao VALUES(@vTabela, GETUTCDATE());

	FETCH NEXT FROM sql_cursor into  @vTabela, @vSql ;	
End
Close sql_cursor;
DEALLOCATE sql_cursor;