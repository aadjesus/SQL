WITH OBJS AS (SELECT *
                                 FROM empresa a
                               WHERE a.ID BETWEEN 1 AND 100)     
SELECT *
   FROM  OBJS O
     JOIN empresaautorizada b ON o.idempresaautorizada = b.id
               

SELECT *
    FROM empresa a
      JOIN empresaautorizada b ON a.idempresaautorizada = b.ID
 WHERE a.ID BETWEEN 1 AND 100