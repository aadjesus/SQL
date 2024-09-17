SELECT a.id + 1 AS inicio, 
       (
       
       SELECT MIN(B.id)   
          FROM ENC7_USUARIO  B
          WHERE B.id > A.id
          
          
          ) - 1 AS fim 
  FROM ENC7_USUARIO  A
  WHERE NOT EXISTS (
  SELECT * 
                      FROM ENC7_USUARIO  B
                      WHERE B.id = A.id + 1
                      )
        AND a.id < (SELECT MAX(id) FROM ENC7_USUARIO)