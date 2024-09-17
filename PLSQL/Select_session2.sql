Select a1.*
  From v$sqltext a1
 Inner Join v$open_cursor b1 On a1.ADDRESS = b1.ADDRESS
                                And a1.SQL_ID = b1.SQL_ID
                                And a1.HASH_VALUE = b1.HASH_VALUE
 Where b1.USER_NAME = 'ESCALATESTEALE'
       And b1.CURSOR_TYPE = 'OPEN'
       --AND b1.SQL_ID = 'b50ap70789cfn'
       And Exists
 (Select 1
          From v$sqltext a2
         Inner Join v$open_cursor b2 On a2.ADDRESS = b2.ADDRESS
                                        And a2.SQL_ID = b2.SQL_ID
                                        And a2.HASH_VALUE = b2.HASH_VALUE
         Where b2.SQL_EXEC_ID Is Null
             And upper(a2.SQL_TEXT) Like upper('%HoraInicioTrabalho%')
               And a1.SQL_ID = a2.SQL_ID
               And b1.SADDR = b2.SADDR)
 Order By a1.ADDRESS, piece