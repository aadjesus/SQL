-- Exemplo para execução 
-- EXEC Excluir_Dados @v_TenantId = -1

IF OBJECT_ID('Excluir_Dados') IS NOT NULL
BEGIN 
    DROP PROCEDURE Excluir_Dados
END
GO
 
CREATE OR ALTER PROCEDURE Excluir_Dados(@v_TenantId INT = -1) AS 
BEGIN            
	BEGIN TRY
    BEGIN TRANSACTION
		DECLARE v_Cursor CURSOR FOR 
			SELECT value FROM STRING_SPLIT('
				VeiculoSemAtraso;
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
				OS;
				Veiculo;
				Valeta;
				UsuarioEmpresaAssociacao;
				ServicoEmpresaAssociacao;
				ModeloMotorOleo;
				Oleo;
				GrupoFuncionarioAssociacao;
				FuncionarioOutrasAtividades;
				FuncionarioDisponibilidade;
				FuncionarioAutorizadoInformarAtraso;
				Funcionario;
				DefeitoEmpresaAssociacao;
				EmpresaAssociacao;
				Filial;
				Empresa;
				EmpresaAutorizada;
				Garagem;
				GrupoFuncionario;
				ServicoTipoDeOperacaoTipoDeVeiculo;
				ServicoTipoDeOperacao;
				ServicoGrupoDeRevisaoPlanoDeRevisao;
				Servico;
				Defeito;
				GrupoServico;
				GrupoValeta;
				Local;
				ModeloMotor;
				Parametro;
				GrupoDeRevisaoPlanoDeRevisao;
				PlanoDeRevisao;
				Setor;
				TipoDeOperacao;
				TipoDeVeiculo;
				Usuario;
				GrupoDeRevisao;
				Motivo', ';');

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