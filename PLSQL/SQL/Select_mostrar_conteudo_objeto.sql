select * from user_source a 
where upper(a.TEXT) like '%PR_MANU_INSERT_JSON%'
  and upper(a.TEXT) like '%MAN_OS%'
