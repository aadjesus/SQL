      select 'OS', count(*) from OS
union select 'Defeito', count(*) from OSDefeito
union select 'DefeitoAtraso', count(*) from OSDefeitoAtraso
union select 'DefeitoFuncionario', count(*) from OSDefeitoFuncionario
union select 'DefeitoFuncionarioExecucao', count(*) from OSDefeitoFuncionarioExecucao
union select 'DefeitoFuncionarioServico', count(*) from OSDefeitoFuncionarioServico
union select 'DefeitoMultiplicador', count(*) from OSDefeitoMultiplicador
union select 'HistoricoPausaGeral', count(*) from OSHistoricoPausaGeral
union select 'Pendencia', count(*) from OSPendencia
union select 'PendenciaMotivo', count(*) from OSPendenciaMotivo
union select 'PendenciaPlanoSobreVida', count(*) from OSPendenciaPlanoSobreVida
union select 'PlanoDeRevisao', count(*) from OSPlanoDeRevisao
union select 'Servico', count(*) from OSServico
union select 'ServicoAtraso', count(*) from OSServicoAtraso
union select 'ServicoFuncionario', count(*) from OSServicoFuncionario
union select 'ServicoFuncionarioExecucao', count(*) from OSServicoFuncionarioExecucao
union select 'ServicoMultiplicador', count(*) from OSServicoMultiplicador
union select 'VeiculoValeta ', count(*) from OSVeiculoValeta