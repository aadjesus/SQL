select 'union select nomedosistema, descricaodosistema from ' || a.owner || '.CTR_CADASTROSISTEMAS where sistema = ''TRR''' 
  from all_all_tables a 
 where a.table_name = 'CTR_CADASTROSISTEMAS'
 
