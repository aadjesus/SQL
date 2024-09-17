--    select 'ALTER INDEX '+ b.name +' ON '+ a.name +' REORGANIZE; '+ CHAR(13) +'ALTER INDEX '+ b.name +' ON '+ a.name +' REBUILD;' as comando
    select a.name 
		 , b.name			
		 , STUFF((SELECT ', ' + co.name
		            FROM sys.index_columns ic
			        join sys.columns       co on co.column_id = ic.column_id				   
			       where ic.object_id = b.object_id 
			         and ic.index_id = b.index_id 
			         and co.object_id = b.object_id FOR xml path('')), 1, 1, '')
		 --, b.*	
		 , a.modify_date
      from sys.tables  a
inner join sys.indexes b on a.object_id = b.object_id
	 where b.index_id > 0	   
	   and b.is_primary_key = 0
	   and (UPPER(b.name) like 'IDX2%' or UPPER(b.name) like 'NCI%')
	   --and a.name in ('Pedido')

	   order by a.modify_date


--CREATE INDEX IDX2_PEDIDO ON PEDIDO (Id_Cotacao_Fornecedor) WITH (ONLINE = ON)
--CREATE INDEX IDX2_COTACAO ON COTACAO (Data_Limite_Inicial) WITH (ONLINE = ON)