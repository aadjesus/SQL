declare @id_usuario int = 313, 
		@ids_fornecedores varchar(500) = '284', 
		@cod_cotacao varchar(500)='', 
		@nome_comprador varchar(500)='', 
		@DataLimiteMinima datetime='10-10-2022', 
		@idsStatusProdGrupoFornecedor varchar(10)='', 
		@agrupado int = 1, 
		@idsStatusCotacao varchar(10)='1,2,3'

EXEC SP_GRID_COTACAO @id_usuario,
	@ids_fornecedores,
	@cod_cotacao,
	@nome_comprador,
	@DataLimiteMinima,
	@idsStatusProdGrupoFornecedor,
	@agrupado,
	@idsStatusCotacao

SELECT *
  FROM information_schema.routines a
 WHERE routine_type  =  'PROCEDURE' 
   and a.SPECIFIC_NAME = 'SP_GRID_COTACAO'

select name 
  from sysobjects 
 where xtype = 'P' 
   and crdate between '2022-10-15' and '2022-10-18'