-- Transforme colunas em linhas --
select * 
  from 
(select
	(select count(*) as Qtde from OS                          ) as OS,
	(select count(*) as Qtde from OSDefeito                   ) as Defeito,
	(select count(*) as Qtde from OSDefeitoAtraso             ) as DefeitoAtraso,
	(select count(*) as Qtde from OSDefeitoFuncionario        ) as DefeitoFuncionario,
	(select count(*) as Qtde from OSDefeitoFuncionarioExecucao) as DefeitoFuncionarioExecucao, 
	(select count(*) as Qtde from OSDefeitoFuncionarioServico ) as DefeitoFuncionarioServico,
	(select count(*) as Qtde from OSDefeitoMultiplicador	  ) as DefeitoMultiplicador,
	(select count(*) as Qtde from OSHistoricoPausaGeral		  ) as HistoricoPausaGeral,
	(select count(*) as Qtde from OSPendencia				  ) as Pendencia,
	(select count(*) as Qtde from OSPendenciaMotivo			  ) as PendenciaMotivo,
	(select count(*) as Qtde from OSPendenciaPlanoSobreVida	  ) as PendenciaPlanoSobreVida,
	(select count(*) as Qtde from OSPlanoDeRevisao			  ) as PlanoDeRevisao,
	(select count(*) as Qtde from OSServico					  ) as Servico,
	(select count(*) as Qtde from OSServicoAtraso			  ) as ServicoAtraso,
	(select count(*) as Qtde from OSServicoFuncionario		  ) as ServicoFuncionario,
	(select count(*) as Qtde from OSServicoFuncionarioExecucao) as ServicoFuncionarioExecucao, 
	(select count(*) as Qtde from OSServicoMultiplicador	  ) as ServicoMultiplicador,
	(select count(*) as Qtde from OSVeiculoValeta			  ) as VeiculoValeta) as Tabelas 
unpivot 
(
	Qtde For Nome in (OS
					 ,Defeito
					 ,DefeitoAtraso
					 ,DefeitoFuncionario
					 ,DefeitoFuncionarioExecucao
	                 ,DefeitoFuncionarioServico
					 ,DefeitoMultiplicador
					 ,HistoricoPausaGeral
					 ,Pendencia
					 ,PendenciaMotivo
					 ,PendenciaPlanoSobreVida
					 ,PlanoDeRevisao
					 ,Servico
					 ,ServicoAtraso
					 ,ServicoFuncionario
					 ,ServicoFuncionarioExecucao
					 ,ServicoMultiplicador
					 ,VeiculoValeta) 
) as Resultado
order by qtde desc

