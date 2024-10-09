BEGIN TRY
BEGIN TRANSACTION
	declare @id int = -1;
	--select @id = id from Cotacao where Codigo = '10';
	
	PRINT @id
	if (@id > 0) 
	begin
		delete CotacaoProdutoMarca			 where id_cotacao_produto		in (select Id from CotacaoProduto	   where Id_Cotacao = @id);
		delete CotacaoProdutoEntrega		 where id_cotacao_produto		in (select Id from CotacaoProduto	   where Id_Cotacao = @id);
		delete CotacaoProdutoGrupoUf		 where Id_Cotacao_Produto_Grupo in (select Id from CotacaoProdutoGrupo where Id_Cotacao = @id);
		delete CotacaoProdutoGrupoFornecedor where Id_Cotacao_Produto_Grupo in (select Id from CotacaoProdutoGrupo where Id_Cotacao = @id);
		delete CotacaoProdutoGrupo			 where Id_Cotacao = @id;
		delete CotacaoProduto				 where Id_Cotacao = @id;
		delete CotacaoFornecedor			 where Id_Cotacao = @id;
		delete CotacaoFornecedorProduto	     where Id_Cotacao = @id;
		delete Cotacao						 where id		  = @id;
	end
	--COMMIT TRANSACTION
	--ROLLBACK TRANSACTION
END TRY
BEGIN CATCH
	PRINT ERROR_MESSAGE()
	ROLLBACK TRANSACTION
END CATCH

