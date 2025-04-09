-- c:\Users\Alessandro.Augusto\GitHub\SQL\PLSQL\JOINs no SQL.jpg

    SELECT * 
      FROM A 
INNER JOIN B ON A.key = B.key 

   SELECT * 
     FROM A 
FULL JOIN B ON A.key = B.key 

   SELECT * 
     FROM A 
FULL JOIN B ON A.key = B.key 
    WHERE A.key IS NULL 
       OR B.key IS NULL 

   SELECT * 
     FROM A 
LEFT JOIN B ON A.key = B.key 

   SELECT * 
     FROM A 
LEFT JOIN B ON A.key = B.key 
    WHERE B.key IS NULL 

    SELECT * 
      FROM A 
RIGHT JOIN B ON A.key = B.key 

    SELECT * 
      FROM A 
RIGHT JOIN B ON A.key = B.key 
     WHERE B.key IS NULL 