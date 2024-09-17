



CREATE TABLE ValueTable (id INT);  
BEGIN TRANSACTION;  
       INSERT INTO ValueTable VALUES(1);  
       INSERT INTO ValueTable VALUES(2);  
ROLLBACK;  

--COMMIT;  
--ROLLBACK; 
