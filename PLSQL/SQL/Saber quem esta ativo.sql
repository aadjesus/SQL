SELECT  OSUSER,RPAD(PROGRAM,30),username,a.*  FROM V$SESSION a
where 
OSUSER = 'alessandro'
ORDER BY PROGRAM

