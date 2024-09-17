select * from faturamento a
inner join fornecedor b on a.id_fornecedor = b.id
inner join empresa c on b.id_empresa = c.id
where c.cnpj = '23014965000139'


select * from pedido a
inner join fornecedor b on a.id_fornecedor = b.id
inner join empresa c on b.id_empresa = c.id
where c.cnpj = '23014965000139'


update pedido set id_faturamento = null
where exists(select b.id 
			   from fornecedor b  
         inner join empresa c on b.id_empresa = c.id
              where pedido.id_fornecedor = b.id
                and c.cnpj = '23014965000139')