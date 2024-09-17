DECLARE @json NVARCHAR(MAX)
SET @json='[
{"CodigoOriginalProduto":"000601011", "CodigoCotacao":"72967","ValorTotalIcms":100.000},
{"CodigoOriginalProduto":"000601011"},
{"CodigoOriginalProduto":"9144-SDUBO","CodigoCotacao":"72967","ValorTotalIcms":100.000},
{"CodigoOriginalProduto":"000601011", "CodigoCotacao":"72967","ValorTotalIcms":106.000},
{"CodigoOriginalProduto":"9144-SDUBO","CodigoCotacao":"72967","ValorTotalIcms":106.000},
{"CodigoOriginalProduto":"9144-SDUBO"},
{"CodigoOriginalProduto":"000601011", "CodigoCotacao":"72967","ValorTotalIcms":106.000},
{"CodigoOriginalProduto":"9144-SDUBO","CodigoCotacao":"72967","ValorTotalIcms":106.000}
]';

SELECT 


DENSE_RANK() over (PARTITION BY CodigoOriginalProduto, CodigoCotacao ORDER BY ValorTotalIcms) as Rankeamento,  
ROW_NUMBER() over (order by CodigoCotacao, CodigoOriginalProduto)  as IdProduto 

--CAST(ISNULL(DENSE_RANK() OVER (PARTITION BY CodigoOriginalProduto, CodigoCotacao ORDER BY ValorTotalIcms),0) AS INT) AS Rankeamento
     --, CodigoOriginalProduto
	 --, CodigoCotacao
	 --, ValorTotalIcms
  FROM OPENJSON (@json)  
	   WITH (CodigoOriginalProduto varchar(200)  '$.CodigoOriginalProduto',  
			 CodigoCotacao         varchar(200)  '$.CodigoCotacao',  
			 ValorTotalIcms		   decimal(10,6) '$.ValorTotalIcms') A
ORDER BY CodigoCotacao
       , CodigoOriginalProduto
	   , 1
