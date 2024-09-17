			SELECT *
			  FROM sys.foreign_keys a
		INNER JOIN sys.tables		b ON a.parent_object_id 	= b.object_id
		INNER JOIN sys.tables		c ON a.referenced_object_id = c.object_id
			 WHERE c.name = 'Tenant'
		  ORDER BY a.create_date DESC