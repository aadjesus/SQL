--select * from BB160318.est_unidademedida
--select * from GRUPONIFF161005.est_unidademedida
--select * from DBA_USERS

Select Decode(Rownum, 1, '', 'union all ') || 'select * from ' || a.Owner || '.est_unidademedida'
  From Dba_Tables a
 Where a.Table_Name = upper( 'est_unidademedida')