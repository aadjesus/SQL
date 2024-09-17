Select a.PIECE
     , a.SQL_TEXT
  From v$sqltext a
 Inner Join v$open_cursor b On a.ADDRESS = b.ADDRESS And a.SQL_ID = b.SQL_ID AND a.HASH_VALUE = b.HASH_VALUE
 Where b.USER_NAME = 'SIITESTE'
   And b.CURSOR_TYPE = 'OPEN'
   and b.SQL_TEXT like 'UPDATE MTK_CLIENTE_RELACIONAMENTO%'
order by a.PIECE   



select sql_text,a.* from v$sqltext_with_newlines a
WHERE a.ADDRESS = '00007FFF22F211A0'

select * from v$session a
where username = 'ESCALATESTEALE'
AND a.PROGRAM = 'dotnet.exe'

select * from v$open_cursor a where a.ADDRESS = '00007FFF22F211A0'

select * from v$sqltext a where a.ADDRESS = '00007FFD5C653A08' ORDER BY piece




Select *
  From v$sqltext a
 Inner Join v$open_cursor b On a.ADDRESS = b.ADDRESS And a.SQL_ID = b.SQL_ID AND a.HASH_VALUE = b.HASH_VALUE
 Where b.USER_NAME = 'ESCALATESTEALE'
       And b.CURSOR_TYPE = 'OPEN'

select * from v$open_cursor where CURSOR_TYPE  = 'OPEN'        AND USER_NAME = 'ESCALATESTEALE'