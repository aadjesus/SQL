SELECT A.TABLE_NAME
  FROM USER_tables A
 WHERE (A.TABLE_NAME LIKE '%CAD%' 
     OR A.TABLE_NAME LIKE '%CADASTRO%')
   and exists (select 1
                 from USER_TAB_COLUMNS b
                where a.TABLE_NAME = b.table_name
                  AND (b.COLUMN_NAME LIKE 'NOME%' 
                    OR b.COLUMN_NAME LIKE 'DESC%' 
                    OR b.COLUMN_NAME LIKE 'DESCRIÇÃO%' 
                    OR b.COLUMN_NAME LIKE 'CÓDIGO%' 
                    OR b.COLUMN_NAME LIKE 'COD%'))