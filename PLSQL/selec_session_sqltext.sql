Select a.PIECE
     , a.SQL_TEXT
     , b.*
  From v$sqltext a
 Inner Join v$open_cursor b On a.ADDRESS = b.ADDRESS And a.SQL_ID = b.SQL_ID AND a.HASH_VALUE = b.HASH_VALUE
 Where  b.SQL_TEXT like '%ACD_MODELOVEICTERCEIRO%'
order by a.PIECE   
