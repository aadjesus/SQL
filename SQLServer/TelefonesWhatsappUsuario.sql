    Select a.Telefone_Whatsapp
	     , B.IdFornecedor
      from (SELECT CF.ID_FORNECEDOR  AS IdFornecedor
				, CPGF.Id_Usuario as a1
				, CF.Id_Usuario as a2
			 FROM CotacaoFornecedor        CF
		LEFT JOIN CotacaoFornecedorProduto CPGF  ON CF.Id_Cotacao   = CPGF.Id_Cotacao and CF.Id_Fornecedor = CPGF.Id_Fornecedor
		    WHERE CF.Id_Cotacao = 145728	  
              and CF.ID_FORNECEDOR in (9058, 517)) as B
inner join Usuario a on a.Id in (b.a1, b.a2)        
-----------------------------------------------------------------------------------------------------------------------------------------------
   SELECT CF.ID_FORNECEDOR        AS IdFornecedor
        , UCPGF.Telefone_Whatsapp AS WhatsappUCPGF
        , UCF.Telefone_Whatsapp   AS WhatsappUCF
		, CF.Id_Cotacao
     FROM CotacaoFornecedor        CF
LEFT JOIN CotacaoFornecedorProduto CPGF  ON CF.Id_Cotacao   = CPGF.Id_Cotacao and CF.Id_Fornecedor = CPGF.Id_Fornecedor
LEFT JOIN Usuario                  UCF   ON CF.Id_Usuario   = UCF.Id
LEFT JOIN Usuario                  UCPGF ON CPGF.Id_Usuario = UCPGF.Id
    WHERE (UCF.Telefone_Whatsapp is not null and UCPGF.Telefone_Whatsapp is not null)
      AND CF.Id_Cotacao = 145728	  
      and CF.ID_FORNECEDOR in (9058, 517)
	 -- AND CF.Id_Cotacao between  145000 and 145731  