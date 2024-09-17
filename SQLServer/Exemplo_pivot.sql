-- Transforme linhas em colunas --
Select Descricao
	 , [0] as Nenhum
     , [1] as Câmbio
	 , [2] as Diferencial
	 , [3] as Motor
 from (  select count(*) as Qtde, a.TipoOleo, b.Descricao
		   from Oleo a 
		   inner join Tenant b on a.TenantId = b.Id
		   where a.TenantId = 1
	   group by a.TipoOleo, b.Descricao) as agrupamento
pivot (
	Sum(Qtde) 
	for TipoOleo in ([0],[1],[2],[3])
) as resultado
order by Descricao

select *
  from (
select a.TipoOleo
     , a.Saldo       as x1
	 , a.Saldo       as x2
  from Oleo a 
  
  where a.TenantId = 1
  and a.TipoOleo = 3
  ) as agrupamento2

unpivot (
	xxx For TipoOleo1 in (x1,x2)
) as resultado2



--select count(*) as Qtde, a.TipoOleo, b.Descricao
--		   from Oleo a 
--		   inner join Tenant b on a.TenantId = b.Id
--		   where a.TenantId = 1
--	   group by a.TipoOleo, b.Descricao

--select a.TipoOleo, b.Descricao
--		   from Oleo a 
--		   inner join Tenant b on a.TenantId = b.Id
--		   where a.TenantId = 1
