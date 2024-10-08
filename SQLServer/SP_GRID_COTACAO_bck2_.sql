/****** Object:  StoredProcedure [dbo].[SP_GRID_COTACAO_BKP_2]    Script Date: 23/02/2023 10:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_GRID_COTACAO_BKP_2] (@id_usuario int, @ids_fornecedores varchar(500), @cod_cotacao varchar(500), @nome_comprador varchar(500), 
@DataLimiteMinima datetime, @idsStatusProdGrupoFornecedor varchar(10), @agrupado int, @idsStatusCotacao varchar(10))
AS BEGIN

    Declare @vExisteUsuario	Int = 0

	SET TRANSACTION isolation level READ uncommitted
	
	SELECT CONVERT(INT, VALUE) AS IdStatusCotacao
	  INTO #StatusCotacao
	  FROM STRING_SPLIT(ISNULL(NULLIF(@idsStatusCotacao,''),'1,2,3'), ',');

	CREATE TABLE #cotacao (IdCotacao INT
		, CodigoCotacao VARCHAR(30)
		, IdComprador INT
		, Id_Status INT
		, Data_Limite_Inicial DATETIME
		, DataAbertura DATETIME
		, Observacao VARCHAR(1000));

	INSERT INTO #cotacao
	SELECT ct.Id
		 , ct.Codigo
		 , ct.Id_Comprador
		 , ct.Id_Status
		 , ct.Data_Limite_Inicial
		 , ct.Data_Abertura
		 , ct.Observacao
	  FROM COTACAO CT
	 INNER JOIN #StatusCotacao sct ON sct.IdStatusCotacao = CT.ID_STATUS
	 WHERE CT.Data_Abertura > @DataLimiteMinima
	   AND ((NULLIF(@cod_cotacao,'') IS NOT NULL AND ct.Codigo = @cod_cotacao) OR @cod_cotacao = '');

	CREATE CLUSTERED INDEX IDX_Grid_Cotacao_IdCotacao ON #cotacao (IdCotacao)
	CREATE NONCLUSTERED INDEX IDX_Grid_Cotacao_Comprador ON #cotacao (IdComprador)
	CREATE NONCLUSTERED INDEX IDX_Grid_Cotacao_CotacaoProduto ON #cotacao (IdCotacao) INCLUDE ([CodigoCotacao], [Observacao], [DataAbertura], [IdComprador], [id_Status], [Data_Limite_Inicial])
	CREATE NONCLUSTERED INDEX IDX_Grid_Cotacao_CotacaoProdutoGrupoFornecedor ON #cotacao (IdCotacao) INCLUDE ([Data_Limite_Inicial], [id_Status])

	CREATE TABLE #Fornecedor (IdFornecedor INT
		, NomeFornecedor VARCHAR(255)
		, CnpjFornecedor VARCHAR(20)
		, IdEmpresa INT
		, IdGrupoEmpresa INT);

	INSERT INTO #Fornecedor
	SELECT DISTINCT CAST(VALUE AS INT) AS IdFornecedor
	     , f.NomeFornecedor
		 , f.CnpjFornecedor
		 , f.IdEmpresa
		 , f.IdGrupoEmpresa	 
	 FROM STRING_SPLIT(@ids_fornecedores, ',')
	INNER JOIN vw_Fornecedor f ON f.IdFornecedor = CAST(VALUE AS INT)
	WHERE @ids_fornecedores <> ''
	
	CREATE CLUSTERED INDEX IDX_Grid_Fornecedor_IdFornecedor ON #Fornecedor (IdFornecedor)

	CREATE TABLE #comprador (IdComprador INT
		, NomeComprador VARCHAR(255)
		, CnpjComprador VARCHAR(20)
		, IdEmpresa INT
		, Id_Uf INT
		, UF VARCHAR(2));

	INSERT INTO #comprador
	SELECT DISTINCT cp.Id
		 , ec.Nome_Fantasia
		 , ec.CNPJ
		 , ec.Id
		 , ed.Id_Uf
		 , uf.Sigla
	FROM #cotacao ct
	INNER JOIN Comprador cp ON cp.Id = ct.IdComprador
	INNER JOIN Empresa ec ON ec.Id = cp.Id_Empresa
	LEFT JOIN Endereco ed ON ed.Id = ec.Id_Endereco
	LEFT JOIN UF uf ON ed.Id_Uf = uf.Id
	WHERE ((NULLIF(@nome_comprador,'') IS NOT NULL AND ec.Nome_Fantasia = @nome_comprador) OR @nome_comprador = '')

	CREATE CLUSTERED INDEX IDX_Grid_Comprador_IdComprador ON #Comprador (IdComprador)

	CREATE TABLE #CotacaoProduto (IdCotacao INT
	 	 , CodigoCotacao VARCHAR(30)
		 , Observacao VARCHAR(1000)
		 , Publico BIT
		 , DataAbertura DATETIME
		 , IdGrupoProduto INT
		 , IdComprador INT
		 , Id_Status INT
		 , GrupoProduto VARCHAR(150)
		 , IdCotacaoProdutoGrupo INT
		 , IdProduto INT
		 , Data_Limite_Inicial DATETIME
		 , IdCotacaoProduto INT);

	INSERT INTO #CotacaoProduto
	SELECT ct.IdCotacao
		 , ct.CodigoCotacao
		 , ct.Observacao
		 , cpg.Publico
		 , ct.DataAbertura
		 , pg.Id AS IdGrupoProduto
		 , ct.IdComprador
		 , ct.Id_Status
		 , pg.Descricao AS GrupoProduto
		 , cpg.Id AS IdCotacaoProdutoGrupo
		 , cp.Id_Produto AS IdProduto
		 , ct.Data_Limite_Inicial
		 , cp.Id AS IdCotacaoProduto	
	  FROM #cotacao ct
	 INNER JOIN CotacaoProduto cp ON cp.Id_Cotacao = ct.IdCotacao
	 INNER JOIN Produto p ON p.Id = cp.Id_Produto
	 INNER JOIN ProdutoGrupo pg ON pg.Id = p.Id_Produto_Grupo
	 INNER JOIN CotacaoProdutoGrupo cpg ON cpg.Id_Cotacao = cp.Id_Cotacao AND cpg.Id_Produto_Grupo = pg.Id

	CREATE CLUSTERED INDEX IDX_Grid_CotacaoProduto_IdgrupoProduto ON #CotacaoProduto (IdGrupoProduto);
	CREATE NONCLUSTERED INDEX IDX_Grid_CotacaoProduto_IdCotacao ON #CotacaoProduto (IdCotacao);
	CREATE NONCLUSTERED INDEX IDX_Grid_CotacaoProduto_IdComprador ON #CotacaoProduto (IdComprador);

	CREATE TABLE #CotacaoProdutoGrupoFornecedor (IdCotacaoProdutoGrupo INT
		 , SelecionadoPeloComprador BIT
		 , DataLimite DATETIME
		 , Id_Status INT
		 , PermitidoEditar BIT
		 , UsuarioVisualizacao NVARCHAR(200)
		 , DataVisualizacao DATETIME
		 , IdFornecedor INT
		 , ObservacaoCotacaoProdutoGrupo VARCHAR(1000)
		 , ObservacaoCotacaoProdutoGrupoFornecedor VARCHAR(500));

    INSERT INTO #CotacaoProdutoGrupoFornecedor
	SELECT DISTINCT cpg.Id AS IdCotacaoProdutoGrupo
		 , isnull(cpgf.Selecionado_Pelo_Comprador,0) AS SelecionadoPeloComprador
		 , CASE WHEN CPGF.Data_Limite IS NULL THEN ct.Data_Limite_Inicial ELSE CPGF.Data_Limite END AS DataLimite
		 , (CASE WHEN(CPGF.Id_Status IS NULL AND ct.Id_Status = 1) AND (ct.Data_Limite_Inicial >= GETDATE()) THEN 1
				WHEN(CPGF.Id_Status IS NULL AND ct.Id_Status = 1) AND (ct.Data_Limite_Inicial < GETDATE()) THEN 4
				WHEN(CPGF.Id_Status IS NULL AND ct.Id_Status = 2) THEN 4
				WHEN(CPGF.Id_Status IS NULL AND ct.Id_Status = 3) THEN 5
			ELSE CPGF.Id_Status END) AS Id_Status
		 , (CASE WHEN(CPGF.Id_Status IS NULL AND ct.Id_Status = 1) AND (ct.Data_Limite_Inicial >= GETDATE()) THEN 1
				WHEN(CPGF.Id_Status IS NOT NULL AND CPGF.Id_Status IN(1, 2, 3) AND(CPGF.Data_Limite >= GETDATE())) THEN 1
			ELSE 0 END)  AS PermitidoEditar
		 , cpgf.Usuario_Visualizacao AS UsuarioVisualizacao
		 , cpgf.Data_Visualizacao AS DataVisualizacao
		 , F.IdFornecedor
		 , cpg.Observacao as ObservacaoCotacaoProdutoGrupo
		 , cpgf.Observacao as ObservacaoCotacaoProdutoGrupoFornecedor	
	FROM #cotacao ct
	INNER JOIN CotacaoProduto cp ON cp.Id_Cotacao = ct.IdCotacao
	INNER JOIN Produto p ON p.Id = cp.Id_Produto
	INNER JOIN ProdutoGrupo pg ON pg.Id = p.Id_Produto_Grupo
	INNER JOIN CotacaoProdutoGrupo cpg ON cpg.Id_Cotacao = cp.Id_Cotacao AND cpg.Id_Produto_Grupo = pg.Id
	CROSS JOIN #Fornecedor f
	LEFT JOIN CotacaoProdutoGrupoFornecedor cpgf ON cpgf.Id_Cotacao_Produto_Grupo = cpg.Id AND f.IdFornecedor = cpgf.Id_Fornecedor

	CREATE CLUSTERED INDEX IDX_Grid_CotacaoProdutoGrupoFornecedor_Id_Status ON #CotacaoProdutoGrupoFornecedor (Id_Status);	
	
	CREATE TABLE #StatusProdGrupoFornecedor (IdStatusProdGrupoFornecedor INT
		 , Descricao VARCHAR(100));

	INSERT INTO #StatusProdGrupoFornecedor
	SELECT DISTINCT cpgfs.Id AS IdStatusProdGrupoFornecedor, cpgfs.Descricao	
	FROM CotacaoProdutoGrupoFornecedorStatus cpgfs
	INNER JOIN #CotacaoProdutoGrupoFornecedor cpgf ON cpgfs.Id = cpgf.Id_Status

	CREATE CLUSTERED INDEX IDX_Grid_StatusProdGrupoFornecedor_IdStatusProdGrupoFornecedor ON #StatusProdGrupoFornecedor (IdStatusProdGrupoFornecedor);	
	CREATE NONCLUSTERED INDEX IDX_Grid_StatusProdGrupoFornecedor_IdFornecedor ON #CotacaoProdutoGrupoFornecedor (IdFornecedor);
	CREATE NONCLUSTERED INDEX IDX_Grid_StatusProdGrupoFornecedor_IdCotacaoProdutoGrupo ON #CotacaoProdutoGrupoFornecedor (IdCotacaoProdutoGrupo);
	CREATE NONCLUSTERED INDEX IDX_Grid_StatusProdGrupoFornecedor_DataLimite ON #CotacaoProdutoGrupoFornecedor (DataLimite);

   CREATE TABLE #ProdutoGrupoCompradorAssociacao (Id_Produto_Grupo_Comprador INT
       , IdComprador VARCHAR(255)
       , Id_Produto_Grupo INT);

   INSERT INTO #ProdutoGrupoCompradorAssociacao
   SELECT DISTINCT pgca.Id_Produto_Grupo_Comprador
         , IdComprador INT
         , pgca.Id_Produto_Grupo
      FROM #CotacaoProduto cf
     INNER JOIN ProdutoGrupoComprador pgc ON pgc.Id_Comprador = cf.IdComprador
     INNER JOIN ProdutoGrupoCompradorAssociacao pgca ON pgca.Id_Produto_Grupo_Comprador = pgc.Id AND pgca.Id_Produto_Grupo = cf.IdGrupoProduto

	 set @vExisteUsuario =
	 (SELECT Count(Id_Comprador) 
	   FROM UsuarioAtendeSomenteComprador 
	  WHERE Id_Usuario = @id_usuario)

   CREATE TABLE #resul (IdCotacao INT
	    , CodigoCotacao VARCHAR(30)
	    , QuantidadeCotacao INT
	    , QuantidadeAtendida INT
	    , Publico BIT
	    , DataAbertura DATETIME
	    , Observacao VARCHAR(1500)
	    , DataLimite DATETIME
	    , SelecionadoPeloComprador BIT
	    , PermitidoEditar BIT
	    , DataVisualizacao DATETIME
	    , UsuarioVisualizacao NVARCHAR(200)
	    , IdStatusProdGrupoFornecedor INT
	    , DescricaoStatusProdGrupoFornecedor VARCHAR(100)
	    , IdGrupoProduto INT
	    , GrupoProduto VARCHAR(150)
	    , IdComprador INT
	    , IdFornecedor INT
	    , UF VARCHAR(2)
		, NomeComprador VARCHAR(255)
		, CnpjComprador VARCHAR(20)
		, NomeFornecedor VARCHAR(255)
		, CnpjFornecedor VARCHAR(20)		
		);

	INSERT INTO #resul
	SELECT cp.IdCotacao
	     , cp.CodigoCotacao
		 , (CASE WHEN CP.IdCotacaoProduto IS NULL THEN 0 ELSE 1 END) AS QuantidadeCotacao
		 , (CASE WHEN CFP.Id			  IS NULL THEN 0 ELSE 1 END) AS QuantidadeAtendida
		 , cp.Publico 
		 , cp.DataAbertura
		 , substring( CONCAT ( cp.Observacao, ' ', cpgf.ObservacaoCotacaoProdutoGrupo, ' ', cpgf.ObservacaoCotacaoProdutoGrupoFornecedor ),1,1500) AS Observacao
		 , cpgf.DataLimite
		 , cpgf.SelecionadoPeloComprador
		 , cpgf.PermitidoEditar
		 , cpgf.DataVisualizacao
		 , cpgf.UsuarioVisualizacao
		 , spgf.IdStatusProdGrupoFornecedor
		 , spgf.Descricao AS DescricaoStatusProdGrupoFornecedor
		 , cp.IdGrupoProduto
		 , cp.GrupoProduto
		 , cp.IdComprador
		 , f.IdFornecedor
		 , co.UF
		 , co.NomeComprador
		 , co.CnpjComprador
		 , f.NomeFornecedor
		 , f.CnpjFornecedor

	FROM #CotacaoProduto cp
	INNER JOIN #Comprador co ON cp.IdComprador = co.IdComprador
	CROSS JOIN #Fornecedor f
	LEFT JOIN #CotacaoProdutoGrupoFornecedor cpgf ON cpgf.IdCotacaoProdutoGrupo = cp.IdCotacaoProdutoGrupo AND cpgf.IdFornecedor = f.IdFornecedor
	LEFT JOIN #StatusProdGrupoFornecedor spgf ON spgf.IdStatusProdGrupoFornecedor = cpgf.Id_Status
	LEFT JOIN CotacaoFornecedorProduto cfp ON cfp.Id_Cotacao = cp.IdCotacao AND cfp.Id_Produto = cp.IdProduto AND cfp.Id_Fornecedor = f.IdFornecedor
	LEFT JOIN ProdutoNaoAtendido pna ON pna.Id_Produto = cp.IdProduto AND pna.Id_Fornecedor = f.IdFornecedor
	LEFT JOIN FornecedorBloqueadoParaImportacao fbpi ON fbpi.Id_Comprador = co.IdComprador AND fbpi.Id_Fornecedor = f.IdFornecedor
	
	WHERE cpgf.DataLimite > @DataLimiteMinima AND pna.Id IS NULL AND fbpi.Id IS NULL
	AND cp.IdCotacao = 406000
	AND (  @vExisteUsuario = 0
			OR (@vExisteUsuario > 0 And EXISTS (SELECT Id_Comprador FROM UsuarioAtendeSomenteComprador WHERE Id_Comprador  = cp.IdComprador AND Id_Usuario = @id_usuario)))	
	
	AND (
		EXISTS (SELECT Id_Produto_Grupo
			      FROM UsuarioProdutoGrupo upg
				 WHERE upg.Id_Usuario = @id_usuario AND upg.Id_Produto_Grupo = cp.IdGrupoProduto) 
		
		OR EXISTS(SELECT PGCA.Id_Produto_Grupo_Comprador FROM vw_ProdutoGrupoCompradorAssociacao PGCA
														WHERE PGCA.Id_Produto_Grupo = cp.IdGrupoProduto
														  AND PGCA.Id_Comprador = cp.IdComprador
														  AND PGCA.Id_Produto_Grupo_Comprador IN (SELECT PGCA.Id_Produto_Grupo_Comprador 
																									FROM vw_ProdutoGrupoCompradorAssociacao PGCA
																								   INNER JOIN UsuarioProdutoGrupo UPG ON UPG.Id_Usuario = @id_usuario AND UPG.Id_Produto_Grupo = PGCA.Id_Produto_Grupo)))
	
	AND (
		EXISTS (SELECT pgca.Id_Produto_Grupo_Comprador
				  FROM vw_ProdutoGrupoCompradorAssociacao pgca			
				 WHERE pgca.Id_Produto_Grupo = cp.IdGrupoProduto 
				   AND pgca.Id_Comprador = cp.IdComprador
				   AND pgca.Id_Produto_Grupo_Comprador IN (SELECT pgca2.Id_Produto_Grupo_Comprador
															 FROM vw_ProdutoGrupoCompradorAssociacao pgca2
															INNER JOIN FornecedorProdutoGrupo fpg ON fpg.Id_Produto_Grupo = pgca2.Id_Produto_Grupo AND fpg.Id_Fornecedor = f.IdFornecedor
														    WHERE pgca.Id_Comprador = cp.IdComprador))
		OR EXISTS (SELECT Id_Produto_Grupo
					 FROM FornecedorProdutoGrupo fpg
					WHERE fpg.Id_Fornecedor = f.IdFornecedor AND fpg.Id_Produto_Grupo = cp.IdGrupoProduto))
	
	AND (
		   (cp.Publico = 0 
		    AND cpgf.IdFornecedor IS NOT NULL 
			AND cpgf.SelecionadoPeloComprador = 1) 
		OR (cp.Publico = 1 
			AND (cpgf.IdFornecedor IS NULL OR (cpgf.IdFornecedor IS NOT NULL AND cpgf.SelecionadoPeloComprador = 0))
			AND EXISTS (SELECT Id FROM FornecedorRegiaoAtuacao FRA WHERE FRA.Id_Fornecedor = F.IdFornecedor AND FRA.Id_Uf = co.Id_Uf)) 
		OR (cp.Publico = 1 AND cpgf.IdFornecedor IS NOT NULL AND cpgf.SelecionadoPeloComprador = 1))
	
	AND NOT EXISTS (SELECT cbge.Id_Comprador 
					  FROM CompradorBloqueadoGrupoEmpresa cbge 
					 WHERE f.IdGrupoEmpresa = cbge.Id_Grupo AND cbge.Id_Comprador = cp.IdComprador)
	
	GROUP BY cp.IdCotacao, cp.CodigoCotacao, cp.DataAbertura
			, substring( CONCAT ( cp.Observacao, ' ', cpgf.ObservacaoCotacaoProdutoGrupo, ' ', cpgf.ObservacaoCotacaoProdutoGrupoFornecedor ),1,1500)
			, cp.Publico, 
			cpgf.DataLimite, cpgf.SelecionadoPeloComprador, cpgf.PermitidoEditar, cpgf.DataVisualizacao, cpgf.UsuarioVisualizacao,
			spgf.IdStatusProdGrupoFornecedor, spgf.Descricao, cp.IdGrupoProduto, cp.GrupoProduto, cp.IdCotacaoProduto, CFP.Id, cp.IdComprador, f.IdFornecedor, co.UF, co.NomeComprador , co.CnpjComprador, f.NomeFornecedor, f.CnpjFornecedor


	OPTION (OPTIMIZE FOR ( @DataLimiteMinima = '2022-04-01' ))
	
	CREATE CLUSTERED INDEX IDX2_Result_IdFornecedor ON #resul (IdFornecedor);	
	CREATE NONCLUSTERED INDEX IDX2_Result_IdComprador ON #resul (IdComprador);

	IF (@agrupado = 1)
	BEGIN
		CREATE INDEX IDX2_Result_Observacao_2 ON #resul (IdFornecedor, IdCotacao, Observacao);

	    CREATE TABLE #final (IdComprador INT
		    , NomeComprador VARCHAR(255)
		    , CnpjComprador VARCHAR(20)
		    , IdFornecedor INT
		    , NomeFornecedor VARCHAR(255)
		    , CnpjFornecedor VARCHAR(20)
		    , IdCotacao INT
		    , Publico BIT
		    , CodigoCotacao VARCHAR(30)
		    , DataAbertura DATETIME
		    , Observacao NVARCHAR(MAX)
			, QuantidadeCotacao INT
		    , QuantidadeAtendida INT
		    , DataLimite DATETIME
		    , SelecionadoPeloComprador BIT
		    , PermitidoEditar BIT
		    , DataVisualizacao DATETIME
		    , IdStatusProdGrupoFornecedor INT
			);

		INSERT INTO #final

		SELECT r.IdComprador
		     , r.NomeComprador
		     , r.CnpjComprador
		     , r.IdFornecedor
		     , r.NomeFornecedor
		     , r.CnpjFornecedor
		     , r.IdCotacao
		     , r.Publico
		     , r.CodigoCotacao
		     , r.DataAbertura
		     , Observacao = STUFF((SELECT   N'/ ' + r2.Observacao 
		     						   FROM #resul AS r2
		     						   WHERE r2.IdFornecedor = r.IdFornecedor and r2.IdCotacao = r.IdCotacao and r2.Observacao != '' 
		     						   FOR XML PATH(N'')), 1, 2, N'')

             , SUM(QuantidadeCotacao) AS QuantidadeCotacao
		     , SUM(QuantidadeAtendida) AS QuantidadeAtendida
		     , MAX(r.DataLimite) AS DataLimite
			 , CAST(MIN(CAST(r.SelecionadoPeloComprador AS INT)) AS BIT) AS SelecionadoPeloComprador
		     , CAST(MIN(CAST(r.PermitidoEditar AS INT)) AS BIT) as PermitidoEdita
		     , MIN(r.DataVisualizacao) AS DataVisualizacao
		     , MIN(r.IdStatusProdGrupoFornecedor) AS IdStatusProdGrupoFornecedor        
		FROM #resul r
		GROUP BY r.IdComprador, r.CnpjComprador, r.IdFornecedor, r.NomeFornecedor, r.CnpjFornecedor, r.IdCotacao,
				 r.CodigoCotacao, r.DataAbertura, r.Publico, r.NomeComprador, r.IdFornecedor

		CREATE CLUSTERED INDEX IDX_Grid_Final ON #final (IdFornecedor);

		SELECT f.IdComprador
		     , f.IdStatusProdGrupoFornecedor AS IdStatus
			 , f.NomeComprador
			 , f.CnpjComprador
			 , f.IdFornecedor
			 , f.NomeFornecedor
			 , f.CnpjFornecedor
			 , f.IdCotacao
			 , f.CodigoCotacao
			 , f.QuantidadeAtendida
			 , f.QuantidadeCotacao
			 , f.DataAbertura
			 , f.DataLimite
			 , spgf.Descricao AS [Status]
			 , f.Observacao
			 , CAST(f.Publico AS BIT) AS Publico
			 , CAST(f.SelecionadoPeloComprador AS BIT) AS SelecionadoPeloComprador
			 , CAST(f.PermitidoEditar AS BIT) AS PermitidoEditar
			 , r.UsuarioVisualizacao
			 , f.DataVisualizacao
			 , r.UF
		FROM #final f
		INNER JOIN #resul r ON r.IdFornecedor = f.IdFornecedor AND f.IdCotacao = r.IdCotacao AND ISNULL(f.DataVisualizacao,0) = ISNULL(r.DataVisualizacao,0)
		LEFT JOIN #StatusProdGrupoFornecedor spgf ON spgf.IdStatusProdGrupoFornecedor = f.IdStatusProdGrupoFornecedor
		GROUP BY f.IdComprador
		       , f.IdStatusProdGrupoFornecedor
			   , f.NomeComprador
			   , f.CnpjComprador
			   , f.IdFornecedor
			   , f.NomeFornecedor
			   , f.CnpjFornecedor
			   , f.IdCotacao
			   , f.CodigoCotacao
			   , f.QuantidadeAtendida
			   , f.QuantidadeCotacao
			   , f.DataAbertura
			   , f.DataLimite
			   , spgf.Descricao
			   , f.Observacao
			   , f.Publico
			   , f.SelecionadoPeloComprador
			   , f.PermitidoEditar
			   , r.UsuarioVisualizacao
			   , f.DataVisualizacao
			   , r.UF
	END
	
	ELSE
	BEGIN

	CREATE NONCLUSTERED INDEX IDX_Grid_Result_IdStatusProdGrupoFornecedor ON #resul (IdStatusProdGrupoFornecedor);

	SELECT r.IdComprador
		 , r.IdStatusProdGrupoFornecedor AS IdStatus
		 , r.NomeComprador
		 , r.CnpjComprador
		 , r.IdFornecedor
		 , r.NomeFornecedor
		 , r.CnpjFornecedor
		 , IdCotacao
		 , CodigoCotacao
		 , IdGrupoProduto
		 , GrupoProduto
		 , SUM(QuantidadeAtendida) AS QuantidadeAtendida
		 , SUM(QuantidadeCotacao) AS QuantidadeCotacao
		 , DataAbertura
		 , DataLimite
		 , DescricaoStatusProdGrupoFornecedor AS [Status]
		 , Observacao
		 , CAST(r.Publico AS BIT) AS Publico
		 , CAST(SelecionadoPeloComprador AS BIT) AS SelecionadoPeloComprador
		 , CAST(PermitidoEditar AS BIT) AS PermitidoEditar
		 , UsuarioVisualizacao
		 , DataVisualizacao
		 , r.UF
	FROM #resul r
	
	INNER JOIN STRING_SPLIT(@idsStatusProdGrupoFornecedor, ',') ids ON CAST(ids.VALUE AS INT) = r.IdStatusProdGrupoFornecedor AND @idsStatusProdGrupoFornecedor <> ''

	GROUP BY r.IdComprador, r.IdStatusProdGrupoFornecedor, r.NomeComprador, r.CnpjComprador, r.IdFornecedor, r.NomeFornecedor, r.CnpjFornecedor, IdCotacao,
			 CodigoCotacao, IdGrupoProduto, GrupoProduto, DataAbertura, DataLimite, DescricaoStatusProdGrupoFornecedor, Observacao, r.Publico,  
			 SelecionadoPeloComprador, PermitidoEditar, UsuarioVisualizacao, DataVisualizacao, r.UF

	END
END