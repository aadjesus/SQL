select sum(s.row_count) from sys.dm_db_partition_stats s
where object_name(object_id) = ''
and s.index_id in(0,1)