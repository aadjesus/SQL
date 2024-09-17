--declare @UfComprador VARCHAR(2)='SP', 
--		@IdComprador INT=1126,
--		@IdStatusCotacao INT = 3, 
--		@CodigoCotacao VARCHAR(50) ='72967',
--		@IdStatusFornecedorProduto INT=2, 
--		@ProdutosCotados INT=0,

--declare @UfComprador VARCHAR(2)='RS', 
--		@IdComprador INT=7737,
--		@IdStatusCotacao INT = 3, 
--		@CodigoCotacao VARCHAR(50) ='248',
--		@IdStatusFornecedorProduto INT=2, 
--		@ProdutosCotados INT=0

declare @UfComprador VARCHAR(2)='SP', 
		@IdComprador INT=5009,
		@IdStatusCotacao INT = 3, 
		@CodigoCotacao VARCHAR(50) ='10565',
		@IdStatusFornecedorProduto INT=2, 
		@ProdutosCotados INT=0

declare @cmd nvarchar(max),
		@vTabela VARCHAR(100)

-- PROCEDURE
--Exec SP_GRID_DECISAO_COMPRAS  @UfComprador, @IdComprador, @IdStatusCotacao, @CodigoCotacao, @IdStatusFornecedorProduto, @ProdutosCotados

DECLARE Cursor_Tab_Temp CURSOR FOR  
	SELECT name	
	  FROM tempdb.sys.tables
	 WHERE name LIKE '#%';

OPEN Cursor_Tab_Temp;  
FETCH NEXT FROM Cursor_Tab_Temp INTO @vTabela;  
WHILE @@FETCH_STATUS = 0  
BEGIN
	set @cmd = 'DROP TABLE ' +  REPLACE(@vTabela,'_','') 	
	BEGIN TRY EXEC SP_EXECUTESQL @cmd; END TRY BEGIN CATCH  print '' END CATCH;  

	FETCH NEXT FROM Cursor_Tab_Temp INTO @vTabela;  
END;  
CLOSE Cursor_Tab_Temp;  
DEALLOCATE Cursor_Tab_Temp;  

--
CREATE TABLE #grid 
                 ( 
					idcotacaoproduto						INT,
					codigocotacao                           VARCHAR(20), 
					codigooriginalproduto                   VARCHAR(20), 
					descricaoproduto                        VARCHAR(200), 
					codigoproduto                           VARCHAR(20), 
					quantidadesolicitada                    DECIMAL(18,3), 
					valorunitarioproduto                    decimal(18,6), 
					descricaomarca                          varchar(200), 
					descricaounidademedida                  varchar(100), 
					valortotalicms                          decimal(18,3), 
					quantidadeatendida                      decimal(18,3), 
					nomefantasiafornecedor                  varchar(200), 
					pagamento                               varchar(20), 
					idcotacaofornecedor                     int, 
					idproduto                               int, 
					idfornecedor                            int, 
					uffornecedor                            varchar(2), 
					ufcomprador                             varchar(2), 
					dataabertura                            datetime, 
					datafechamento                          datetime, 
					idcotacao                               int, 
					idpedido                                int, 
					dataultimopedido                        datetime, 
					valorunitarioprodutoultimopedido        decimal(10,4), 
					valorunitarioprodutocomicmsultimopedido decimal(10,4), 
					nomefantasiafornecedorultimopedido      varchar(100), 
					idcomprador                             int, 
					descricaototal                          varchar(200), 
					descricaomarcacomprador                 varchar(3500),
					id_grupo_comprador						int 
                 ) 
--


-- Todas as informacoes sobre Cotacao e todos os produtos da Cotacao 
		SELECT c.Id AS IdCotacao, c.Codigo AS CodigoCotacao, c.Id_Comprador, cp.Id AS idcotacaoproduto, c.id_tipo_vencimento_pagto
			 , c.data_abertura AS dataabertura, c.data_limite_inicial AS datafechamento, p.id AS idproduto, cp.quantidade
			 , p.descricao AS descricaoproduto, p.codigo_produto AS codigoproduto, p.codigo_original AS codigooriginalproduto
			 , um.descricao AS descricaounidademedida, p.Id_grupo_Comprador
		  INTO #cotacaoproduto 
		  FROM cotacao c 
	INNER JOIN cotacaoproduto cp ON cp.id_cotacao = c.id 
	INNER JOIN produto p ON p.id = cp.id_produto
	 LEFT JOIN unidademedida um ON um.id = p.id_unidade_medida
		 WHERE c.id_status = @IdStatusCotacao 
		   AND c.id_comprador = @IdComprador 
		   AND c.codigo = @CodigoCotacao 
--


--Insere as informações que os dois selects do union irão usar
		SELECT c.idcotacaoproduto, c.codigocotacao,c.codigooriginalproduto,c.descricaoproduto,c.codigoproduto,c.quantidade AS quantidadesolicitada
			 , cfp.Desconto_Unitario as xxx1
			 , cfp.Desconto_Unitario_Porcentagem as xxx2
			 , (cfp.valor_unitario - ISNULL(cfp.Desconto_Unitario, ISNULL((cfp.valor_unitario * (cfp.Desconto_Unitario_Porcentagem / 100)), 0)) ) AS valorunitarioproduto1
			 , cfp.valor_unitario AS valorunitarioproduto
			 , m.descricao AS descricaomarca,c.descricaounidademedida,NULL AS valortotalicms
			 , cfp.quantidade_atendida AS quantidadeatendida, e.nome_fantasia AS nomefantasiafornecedor,cf.id AS idcotacaofornecedor,c.idproduto
			 , cf.id_fornecedor AS idfornecedor,c.dataabertura, c.datafechamento, c.idcotacao,uf.sigla AS uffornecedor
			 , concat(NULLIF(c.descricaoproduto + ' - ', ' - '), c.codigooriginalproduto , ' / ', c.descricaounidademedida, ' / ', c.codigoproduto, ' / ') AS descricaototal
			 , cf.id_tipo_vencimento_pagto,c.Id_Comprador,c.Id_grupo_Comprador
		  INTO #cotacaoFornecedor 
		  FROM #cotacaoproduto c 
	INNER JOIN cotacaofornecedor cf ON cf.id_cotacao = c.idcotacao 
	INNER JOIN fornecedor f ON f.id = cf.id_fornecedor 
	INNER JOIN empresa e ON e.id = f .id_empresa 
	INNER JOIN cotacaofornecedorproduto cfp ON c.idcotacao = cfp.id_cotacao AND cfp.id_fornecedor = f.id AND cfp.id_produto = c.idproduto
	INNER JOIN marca m ON m.id = cfp.id_marca 
	 LEFT JOIN endereco ed ON ed.id = e.id_endereco 
	 LEFT JOIN uf uf ON uf.id = ed.id_uf 
		 WHERE cfp.id_status = @IdStatusFornecedorproduto 
--

-- Insere respostas de produtos da Cotacao que nao geraram pedido e nao venceram 
INSERT INTO #grid 
    SELECT cf.idcotacaoproduto,cf.codigocotacao, cf.codigooriginalproduto,cf.descricaoproduto,cf.codigoproduto,cf.quantidadesolicitada,cf.valorunitarioproduto,
	cf.descricaomarca,cf.descricaounidademedida,cf.valortotalicms,cf.quantidadeatendida,cf.nomefantasiafornecedor,
	concat(ctf.numero_parcelas_pagamento, 'x, ', ctf.dias_pagamento, ' ', tvpc.codigo) AS pagamento,
	cf.idcotacaofornecedor,cf.idproduto,cf.idfornecedor,cf.uffornecedor,
	@UfComprador      AS ufcomprador,cf.dataabertura, cf.datafechamento, cf.idcotacao, NULL AS idpedido,NULL AS dataultimopedido,
	NULL AS valorunitarioprodutoultimopedido,null AS valorunitarioprodutocomicmsultimopedido,NULL AS nomefantasiafornecedorultimopedido,cf.id_comprador AS idcomprador,
	cf.descricaototal,NULL AS descricaomarcacomprador,cf.id_grupo_comprador
    FROM #cotacaofornecedor cf
	INNER JOIN		CotacaoFornecedor ctf ON ctf.Id = cf.idcotacaofornecedor
    LEFT JOIN		tipovencimentopagamento tvpc ON tvpc.id = cf.id_tipo_vencimento_pagto 
    WHERE NOT EXISTS 
                    (SELECT			pp.id 
                     FROM			produto p 
                     INNER JOIN		pedidoproduto pp ON pp.id_produto = p.id
					 INNER JOIN		pedido ped ON ped.id = pp.id_pedido 
                     WHERE			p.Id = cf.idproduto
                     AND			ped.id_cotacao_fornecedor = cf.IdCotacaoFornecedor)
					
    UNION -- Insere respostas de produtos da cotacao que geraram pedido e venceram 
    SELECT 
		cf.idcotacaoproduto,cf.codigocotacao, p.Codigo_Original	AS codigooriginalproduto,p.Descricao			AS descricaoproduto,p.Codigo_Produto	AS codigoproduto,cf.quantidadesolicitada,
		cf.valorunitarioproduto,cf.descricaomarca,cf.descricaounidademedida,cf.valortotalicms,
		SUM(pp.quantidade)           AS quantidadeatendida,
		cf.nomefantasiafornecedor,concat(ped.numero_parcelas_pagamento, 'x, ', ped.dias_pagamento, ' ', tvpp.codigo)  AS pagamento,cf.idcotacaofornecedor,
		max(p.id) AS idproduto,
		cf.idfornecedor,cf.uffornecedor,@UfComprador  AS ufcomprador,cf.dataabertura, cf.datafechamento, cf.idcotacao, 
		max(pp.id_pedido) AS idpedido,
		NULL              AS dataultimopedido,NULL              AS valorunitarioprodutoultimopedido,NULL              AS valorunitarioprodutocomicmsultimopedido,NULL              AS nomefantasiafornecedorultimopedido,@IdComprador      AS idcomprador,descricaototal,null AS descricaomarcacomprador,cf.id_grupo_comprador
    FROM            #cotacaofornecedor  cf
    INNER JOIN      pedido ped ON ped.id_cotacao_fornecedor = cf.IdCotacaoFornecedor
    INNER JOIN		produto p ON p.Id = cf.idproduto
	INNER JOIN      pedidoproduto pp ON pp.id_pedido = ped.id AND pp.id_produto = p.id
    LEFT JOIN       tipovencimentopagamento tvpp ON tvpp.id = ped.id_tipo_vencimento_pagto	
	GROUP BY cf.idcotacaoproduto,cf.codigocotacao, p.Codigo_Original,p.Descricao,p.Codigo_Produto,cf.quantidadesolicitada,cf.valorunitarioproduto,
		cf.descricaomarca,cf.descricaounidademedida,cf.valortotalicms,cf.nomefantasiafornecedor,cf.idcotacaofornecedor,
		cf.idfornecedor,cf.uffornecedor,cf.dataabertura, cf.datafechamento, cf.idcotacao, descricaototal,concat(ped.numero_parcelas_pagamento, 'x, ', ped.dias_pagamento, ' ', tvpp.codigo),cf.id_grupo_comprador		
--

-- Isola dos selects a função de calculo difal e o stuff para a junção das marcas em uma linha só
UPDATE #grid
	SET valortotalicms = valorunitarioproduto + dbo.calculoicmsedifal(@UfComprador, uffornecedor, valorunitarioproduto),
	descricaomarcacomprador = STUFF((SELECT ', ' + m.descricao 
									   FROM marca m 
							     INNER JOIN cotacaoprodutomarca cpm ON cpm.id_marca = m.id 
									  WHERE cpm.id_cotacao_produto = idcotacaoproduto FOR xml path('') ), 1, 2, '')
--

--Insere todos so produtos que nao tiveram respostas   
 --INSERT INTO #grid (CodigoOriginalProduto, DescricaoProduto, CodigoProduto,
 --          quantidadesolicitada, descricaototal, descricaounidademedida, idproduto, idcomprador, id_grupo_comprador,
	--	   dataabertura)
	--	SELECT DISTINCT cp.codigooriginalproduto, 
	--					cp.descricaoproduto, 
	--					cp.codigoproduto, 
	--					cp.quantidade AS quantidadesolicitada, 
	--					Concat(cp.descricaoproduto , ' - ', cp.codigooriginalproduto, ' / ', cp.descricaounidademedida, ' / ', cp.codigoproduto),
	--					cp.descricaounidademedida, 
	--					cp.idproduto, 
	--					cp.id_comprador ,
	--					cp.id_grupo_comprador,
	--					cp.dataabertura
	--	FROM            #cotacaoproduto cp 
	--	LEFT JOIN       #grid g ON g.idproduto = cp.idproduto
	--	LEFT JOIN       cotacaofornecedor cf ON cf.id_cotacao = cp.idcotacao 
	--	LEFT JOIN       cotacaofornecedor cf2 ON cf.id = cf.id AND g.idcotacaofornecedor = cf2.id 
	--	WHERE           cf2.id IS NULL 
--

-- Traz informação de todos os ultimos pedidos dos produtos do grupo comprador
--    SELECT MAX(ped.id) AS id_pedido, g.idproduto
--	  INTO #tmp
--   	  FROM #grid g 
--INNER JOIN pedidoproduto pp ON g.idproduto = pp.id_produto
--INNER JOIN pedido ped ON pp.id_pedido = ped.id
--	 WHERE ped.data_hora_entrada < g.dataabertura
--  GROUP BY g.idproduto
--

-- Insere informacoes sobre ultimo pedido dos produtos da Cotacao 
--INSERT INTO #grid (--DataUltimoPedido
--				  valorunitarioprodutoultimopedido
--				 , valorunitarioprodutocomicmsultimopedido
--				 , nomefantasiafornecedorultimopedido
--				 , descricaoproduto
--				 , descricaototal
--				 , descricaomarcacomprador
--				 , idproduto
--				 , quantidadesolicitada
--				 , codigooriginalproduto
--				 , id_grupo_comprador)
--	SELECT DISTINCT --NULLIF(ped.data_hora_entrada, getdate()), 
--				cast(pp.valor_unitario as decimal(18,3)),
--				cast(pp.valor_unitario + dbo.Calculoicmsedifal(@UfComprador, uf.sigla, pp.valor_unitario) as decimal(18,3)),
--				e.nome_fantasia, 
--				g.descricaoproduto, 
--				g.descricaototal, 
--				g.descricaomarcacomprador,
--				pp.Id_Produto,
--				g.quantidadesolicitada, 
--				g.codigooriginalproduto,
--				g.id_grupo_comprador
--	FROM            #tmp ok 
--	INNER JOIN      #grid g ON ok.idproduto = g.idproduto
--	INNER JOIN		pedidoproduto pp ON pp.id_pedido = ok.id_pedido AND ok.idproduto = pp.Id_Produto
--	INNER JOIN		pedido ped ON ped.id = pp.Id_Pedido
--	INNER JOIN      fornecedor f ON f.id = ped.id_fornecedor 
--	INNER JOIN      empresa e ON e.id = f.id_empresa 
--	LEFT JOIN       endereco ed ON ed.id = e.id_endereco 
--	LEFT JOIN       uf uf ON uf.id = ed.id_uf
--

--select * from #cotacaoproduto x1
--select * from #cotacaoFornecedor x2

select x3.valortotalicms, x3.valorunitarioproduto 
, x3.uffornecedor
,dbo.calculoicmsedifal('SP', x3.uffornecedor, x3.valorunitarioproduto) 
from #grid x3 order by x3.valortotalicms