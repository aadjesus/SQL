DECLARE 
 @id_cotacao  INT, 
 @id_produto_grupo    INT 

set @id_cotacao = 145731
set @id_produto_grupo = 4

SELECT IdComprador
	 , IdCotacao
	 , IdFornecedor
	 , NomeFantasia
	 , SUM(QuantidadeCotacao) as QuantidadeCotacao
	 , SUM(QuantidadeRespondida) as QuantidadeRespondida
	 , SUM(QuantidadeNaoAtendida) as QuantidadeNaoAtendida
	 , CAST((CASE 
		  WHEN BloqueadoParaImportacao > 0 
		  THEN 1 
		  ELSE 0 
		   END) as BIT) as BloqueadoParaImportacao
	 , IdProdutoGrupo
				, DataLimite 
				, IdStatus 
				, CPGFS.Descricao as Status 
				, SelecionadoPeloComprador 
				, DataVisualizacao FROM 
(
	SELECT 
	Comp.Id as IdComprador,
	C.Id as IdCotacao,
	PG.Id as IdProdutoGrupo,
	F.Id as IdFornecedor,
	E.CNPJ as CNPJ,
	E.Nome_Fantasia as NomeFantasia,
	(CASE 
		WHEN CPGF.Id_Fornecedor IS NULL THEN C.Data_Limite_Inicial 
		ELSE CPGF.Data_Limite END) as DataLimite,
		1 as QuantidadeCotacao,
	(CASE 
		WHEN (EXISTS(SELECT CFPCC.Id 
			FROM CotacaoFornecedorProduto CFPCC
		WHERE
		CFPCC.Id_Cotacao = C.Id AND
		CFPCC.Id_Fornecedor = CF.Id_Fornecedor AND
		CFPCC.Id_Produto = CP.Id_Produto)) THEN 1 
		ELSE 0 END) as QuantidadeRespondida,
	(CASE 
		WHEN CFP.Quantidade_Atendida is null THEN 1 
		ELSE 0 END) as QuantidadeNaoAtendida,
	(CASE 
		when(CPGF.Id_Status is null AND C.Id_Status = 1  ) AND (C.Data_Limite_Inicial >= getdate()) then 1
		when(CPGF.Id_Status is null AND C.Id_Status = 1  ) AND (C.Data_Limite_Inicial <  getdate()) then 4
		when(CPGF.Id_Status is null AND C.Id_Status = 2  ) then 4
		when(CPGF.Id_Status is null AND C.Id_Status = 3  ) then 5
		ELSE CPGF.Id_Status END) as IdStatus,
	CPGF.Selecionado_Pelo_Comprador as SelecionadoPeloComprador,
	CPGF.Data_Visualizacao as DataVisualizacao,
	(SELECT Count(FBPI.Id) 
		FROM FornecedorBloqueadoParaImportacao FBPI
		WHERE FBPI.Id_Fornecedor = F.Id    
		AND FBPI.Id_Comprador  = Comp.Id) as BloqueadoParaImportacao

	FROM CotacaoProduto CP
	INNER JOIN Produto P                          ON P.Id = CP.Id_Produto
	INNER JOIN ProdutoGrupo PG                    ON PG.Id = P.Id_Produto_Grupo 
	INNER JOIN Cotacao C                          ON C.Id = CP.Id_Cotacao
	INNER JOIN CotacaoProdutoGrupo CPG            ON CPG.Id_Cotacao = C.Id AND CPG.Id_Produto_Grupo = PG.Id AND CPG.Id_Produto_Grupo = @id_produto_grupo 
	INNER JOIN Comprador Comp                     ON Comp.Id = C.Id_Comprador						
	LEFT JOIN CotacaoFornecedor CF                ON CF.Id_Cotacao = C.Id
	JOIN Fornecedor F                             ON F.Id = CF.Id_Fornecedor
	INNER JOIN Empresa E                          ON F.Id_Empresa = E.Id
	INNER JOIN CotacaoProdutoGrupoFornecedor CPGF ON CPGF.Id_Cotacao_Produto_Grupo = CPG.Id AND CPGF.Id_Fornecedor = F.Id
	LEFT JOIN CotacaoFornecedorProduto CFP        ON CFP.Id_Cotacao = C.Id AND CFP.Id_Fornecedor = CF.Id_Fornecedor AND CFP.Id_Produto = CP.Id_Produto
	LEFT JOIN ProdutoNaoAtendido PNA              ON PNA.Id_Produto = CP.Id_Produto AND PNA.Id_Fornecedor = F.Id

	WHERE PNA.Id IS NULL 
	AND  (
				(CPG.Publico = 0 AND CPGF.Id_Fornecedor IS NOT NULL) OR 
				(
					CPG.Publico = 1 
					AND (CPGF.Id_Fornecedor IS NULL OR (CPGF.Id_Fornecedor IS NOT NULL AND CPGF.Selecionado_Pelo_Comprador = 0))
					AND EXISTS (SELECT Id_Uf   
						FROM FornecedorRegiaoAtuacao 
						WHERE Id_Fornecedor = F.Id  
					INTERSECT  
						SELECT Id_Uf   
						FROM CotacaoProdutoGrupoUf 
						WHERE Id_Cotacao_Produto_Grupo = CPG.Id)
				) OR
				(CPG.Publico = 1 AND CPGF.Id_Fornecedor IS NOT NULL AND CPGF.Selecionado_Pelo_Comprador = 1)
			) 
     AND C.Id = @id_cotacao 
	 AND PG.Id = @id_produto_grupo 
	 AND F.Ativo = 1

) AS SubQ

LEFT JOIN CotacaoProdutoGrupoFornecedorStatus CPGFS ON
CPGFS.Id = SubQ.IdStatus

GROUP BY IdComprador
	   , IdCotacao
	   , IdFornecedor
	   , NomeFantasia
	   , BloqueadoParaImportacao
	   , IdProdutoGrupo, DataLimite, IdStatus, CPGFS.Descricao, SelecionadoPeloComprador, DataVisualizacao
ORDER BY QuantidadeRespondida  DESC
	   , NomeFantasia ASC
	   , QuantidadeNaoAtendida DESC


/*
   SELECT CF.ID_FORNECEDOR        AS IdFornecedor
        , UCPGF.Telefone_Whatsapp AS WhatsappUCPGF
        , UCF.Telefone_Whatsapp   AS WhatsappUCF
     FROM CotacaoFornecedor        CF
LEFT JOIN CotacaoFornecedorProduto CPGF  ON CF.Id_Cotacao   = CPGF.Id_Cotacao and CF.Id_Fornecedor = CPGF.Id_Fornecedor
LEFT JOIN Usuario                  UCF   ON CF.Id_Usuario   = UCF.Id
LEFT JOIN Usuario                  UCPGF ON CPGF.Id_Usuario = UCPGF.Id
    WHERE (UCF.Telefone_Whatsapp is not null Or UCPGF.Telefone_Whatsapp is not null)
      AND CF.Id_Cotacao = 3121
      and CF.ID_FORNECEDOR in (9191,9058,9233,82,517,192,9125)

Select a.Telefone_Whatsapp 
  from Usuario a
 where Exists(   Select 1
				   FROM CotacaoFornecedor        CF
			  LEFT JOIN CotacaoFornecedorProduto CPGF ON CF.Id_Cotacao = CPGF.Id_Cotacao and CF.Id_Fornecedor = CPGF.Id_Fornecedor
			      where CF.Id_Cotacao = 3121
				    and CF.ID_FORNECEDOR in (9191,9058,9233,82,517,192,9125)
				    and a.Id in (CF.Id_Usuario , CPGF.Id_Usuario)

 )


*/


-- quantidadeRespondida = 0                                                              -> Visualizaram
-- quantidadeRespondida > 0 && quantidadeRespondida < quantidadeCotacao                  -> Cotando
-- quantidadeRespondida = quantidadeCotacao && quantidadeNaoAtendida = quantidadeCotacao -> Não Atendida
-- quantidadeRespondida = quantidadeCotacao                                              -> Cotaram
-- quantidadeRespondida > 0 && quantidadeRespondida < quantidadeCotacao && status != aberto    -> CotandoParci


--  if (itemAggregate.QuantidadeRespondida == 0 && itemAggregate.DataVisualizacao != null)
--		itemAggregate.StatusAndamento = eCotacaoStatusAndamento.Visualizaram.ToString();
--
--	else if (itemAggregate.QuantidadeRespondida == itemAggregate.QuantidadeCotacao && itemAggregate.QuantidadeNaoAtendida == itemAggregate.QuantidadeCotacao)
--		itemAggregate.StatusAndamento = eCotacaoStatusAndamento.Recusaram.ToString();
--
--	else if (itemAggregate.QuantidadeRespondida == itemAggregate.QuantidadeCotacao)
--		itemAggregate.StatusAndamento = eCotacaoStatusAndamento.Cotaram.ToString();
--
--	else if (itemAggregate.QuantidadeRespondida != itemAggregate.QuantidadeCotacao)
--	{
--		itemAggregate.StatusAndamento = (itemAggregate.IdStatus == (int)eCotacaoProdutoGrupoFornecedorStatus.Aberta
--			? funcTextoCotPar(eCotacaoStatusAndamento.Cotando)
--			: "Cotaram Parcialmente");
--	}
--
