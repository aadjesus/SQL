create materialized view view_cliente_visita as 
select 
  a.codigorelatorio CodRV, -- Grid Principal
  b.codcliente CodCliente,
  a.datarelatorio Data_Visita, -- Grid Principal (exibir somente data )
  e.descricaosetor Setor, -- Grid Principal 
  c.nomeabreviadofuncionario Analista,  -- Grid Principal
  A.HORAINICIALRELATORIO INICIO,  -- Grid Principal (exibir somente horas)
  A.HORAFINALRELATORIO TERMINO, -- Grid Principal (exibir somente horas)
  round(((a.horafinalrelatorio-a.horainicialrelatorio)*1440/60), 2) Horas,  -- Grid Principal
  to_lob(a.dificuldadesencontradas) dificuldades, -- Nunca apresentar para o cliente - Grid Principal

  D.CODSISTEMA SISTEMA,-- Detalhes
  D.CODMODULO MODULO,-- Detalhes
  D.HORASDETALHE HORAS_DETALHE,-- Detalhes
  G.DESCATIVIDADE ATIVIDADE,-- Detalhes
  to_lob(d.problemadetalhe) detalhe,-- Detalhe
  d.usuariostreinados treinados-- Detalhe

from 
  sii_relatoriodevisitas a,
  sii_cliente b,
  sii_funcionario c,
  sii_detalherv d,
  sii_setor e,
  sii_grupoempresa f,
  SII_ATIVIDADE G
where   
  a.codcliente = b.codcliente and
  a.codfuncpreencherv = c.codigofuncionario and
  a.codigorelatorio = d.codigorelatorio and
  c.codsetor = e.codsetor and
  b.codgrupoemp = f.codgrupoemp
  AND G.CODATIVIDADE = D.CODATIVIDADE