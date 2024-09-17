--select * from Tenant

SELECT
    fk.name 'FK Name',
    tp.name 'Parent table',
    cp.name, --cp.column_id,
    --tr.name 'Refrenced table',
    --cr.name, cr.column_id
	tr.create_date
	
FROM		   sys.foreign_keys fk
INNER JOIN     sys.tables tp ON fk.parent_object_id = tp.object_id

INNER JOIN     sys.tables tr ON fk.referenced_object_id = tr.object_id
INNER JOIN     sys.foreign_key_columns fkc ON fkc.constraint_object_id = fk.object_id
INNER JOIN     sys.columns cp ON fkc.parent_column_id = cp.column_id AND fkc.parent_object_id = cp.object_id
INNER JOIN     sys.columns cr ON fkc.referenced_column_id = cr.column_id AND fkc.referenced_object_id = cr.object_id

where  --fk.name = 'FK_Filial_Tenant'
tr.name = 'Tenant'
order by tr.object_id --tr.create_date
--select count(1) from sys.tables

