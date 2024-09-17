select 
a.Data_Hora,
DATEADD(day, -5, a.Data_Hora),
DATEDIFF(DAY,  DATEADD(day, -1, a.Data_Hora), GETDATE())
from 
Pedido a
-------------------------------


select *
  from Pedido ped
 inner join Fornecedor forn on ped.Id_Fornecedor = forn.Id
 inner join Empresa emp on forn.Id_Empresa = emp.Id --AND emp.Cnpj In (@p0)

 where forn.Preferencia_Faturamento = 15
   and ped.Data_Hora >=
       coalesce(
	   
	   DATEADD(day, -5, 
	   (select max(fat.Emissao)
                  from Faturamento fat
                 where fat.Id_Fornecedor = ped.Id_Fornecedor)),
                '2017-08-10')
   and ped.Data_Hora <= '2017-09-09'
   --and (ped.Id_Faturamento is null)
   



----------------------------------


update Pedido set Id_Faturamento = 95 where Observacao != 'teste faturamento'
update Pedido set Id_Faturamento = null where Observacao = 'teste faturamento'
delete Faturamento where id != 95

------------------------------------
select
coalesce(
	   
	   DATEADD(day, -5, 
	   (
	   
select max(fat.Emissao)
                  from Faturamento fat
                 where fat.Id_Fornecedor = 1
				 ))
				 ,'2017-08-10')

--------------

select a.id,(select b.CNPJ from Empresa b where b.Id= a.Id_Empresa) 
from Fornecedor a
