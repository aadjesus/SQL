
Select Decode(Rownum, 1, '', 'union all ') || 'select max(length(descricao)) as tamanho, '''|| Owner ||''' as usuario from ' || Owner || '.T_Esc_Servicoprogramacao'
  From Dba_Tables 
   Where Table_Name = upper( 'T_Esc_Servicoprogramacao')
 
