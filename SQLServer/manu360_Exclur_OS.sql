IF OBJECT_ID('Excluir_Os') IS NOT NULL
BEGIN 
    DROP PROCEDURE Excluir_Os
END
GO

CREATE OR ALTER PROCEDURE Excluir_Dados(@v_QtdeDias INT = 365) AS 
BEGIN            
	BEGIN TRY
    BEGIN TRANSACTION
		DECLARE v_Cursor CURSOR FOR 
			SELECT value FROM STRING_SPLIT('
				OSVeiculoValeta;
				OSDefeitoMultiplicador;
				OSServicoFuncionarioExecucao;
				OSServicoFuncionario;
				OSServicoAtraso;
				OSServico;
				OSPlanoDeRevisao;
				OSPendenciaPlanoSobreVida;
				OSPendenciaMotivo;
				OSPendencia;
				OSHistoricoPausaGeral;
				OSServicoMultiplicador;
				OSDefeitoFuncionarioServico;
				OSDefeitoFuncionarioExecucao;
				OSDefeitoFuncionario;
				OSDefeitoAtraso;
				OSDefeito;
				OS', ';');

		DECLARE @v_Tabela NVARCHAR(500)
		DECLARE @v_Sql	  NVARCHAR(500)

		OPEN v_Cursor  
		FETCH NEXT FROM v_Cursor INTO @v_Tabela

		WHILE @@FETCH_STATUS = 0  
		BEGIN  
			PRINT @v_Tabela + '----'
			SET @v_Sql = 'Delete From ' + @v_Tabela + ' Where TenantId = ' + cast(@v_TenantId AS NVARCHAR)

			EXECUTE sp_executesql @v_Sql
			
			FETCH NEXT FROM v_Cursor INTO @v_Tabela 
		END   

		--COMMIT TRANSACTION
		ROLLBACK TRANSACTION
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE()
		ROLLBACK TRANSACTION
	END CATCH

	CLOSE v_Cursor;  
	DEALLOCATE v_Cursor;
END --Procedure