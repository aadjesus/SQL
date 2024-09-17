select 
(select count(*) from GrupoServico) as GrupoServico,
(select count(*) from TipoDeOperacao) as TipoDeOperacao,
(select count(*) from PlanoDeRevisao) as PlanoDeRevisao,
(select count(*) from Defeito) as Defeito,
(select count(*) from Setor) as Setor,
(select count(*) from Servico) as Servico,
(select count(*) from EmpresaAutorizada) as EmpresaAutorizada,
(select count(*) from Empresa) as Empresa,
(select count(*) from Filial) as Filial,
(select count(*) from Garagem) as Garagem,--					  
(select count(*) from Local) as Local,
(select count(*) from ModeloMotor) as ModeloMotor,
(select count(*) from Veiculo) as Veiculo,
(select COUNT(*) from Funcionario) as Funcionario

--select *
----a.Prefixo,COUNT(*) 
--from Veiculo a
--where prefixo = '0027443'
--group by
--a.Prefixo
--order by
--COUNT(*) 

--select * from GrupoServico
--select * from TipoDeOperacao
--update TipoDeOperacao set descricao = descricao where id = 8


--MAN_GRUPODESERVICO		-0140
--MAN_TIPOOPERACAOSERVI		-0041
--MAN_PLANODEREVISAO		-0078
--MAN_CADDEFEITOS			-0382
--FLP_SETOR					-0042
--MAN_CADASTRODESERVICOS	-1330*
--CTR_EMPAUTORIZADAS		-0020
--CTR_CADEMP				-0084
--CTR_FILIAL				-0112
--CTR_GARAGEM				-0047
--CTR_FILIAL_GAR			-0030
--CTR_CADLOCAL				-0023
--MOT_MODELOMOTOR			-0063
--FRT_CADVEICULOS			-1377*

--9	12	9	15	3	15	3	3	5	9	1	6	120	12
--select * from Local f where f.Codigo in(1,801,802,806)
--select * from Empresa f where f.Codigo in (1,370,380,382)
