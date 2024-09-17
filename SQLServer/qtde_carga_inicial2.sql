IF OBJECT_ID ( 'Teste', 'P' ) IS NOT NULL 
    DROP PROCEDURE Teste;
GO

CREATE procedure Teste(@tabela int, @tenantId int)
AS 
        DECLARE @qtde AS int ;      
		DECLARE @sql VARCHAR = 'select count(*) from '+ @tabela +' where TenantId = '+ @tenantId;

		EXECUTE @sql;

        --set @qtde = (select count(*) from GrupoServico where TenantId = @tenantId);
		

		print (tabela + ': '+ CAST(@qtde     AS varchar(4)));
    --return
GO
EXEC Teste 'GrupoServico', 1;
