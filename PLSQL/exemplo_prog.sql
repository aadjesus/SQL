DECLARE
     conteudo varchar2(4000);
     x1 BOOLEAN;
BEGIN
     SELECT a.conteudo INTO conteudo FROM Manu_Integracao a WHERE a.ID = 167986;
     
     DBMS_OUTPUT.PUT_LINE(conteudo);
     
     x1 := REGEXP_LIKE (conteudo,'''codigogrpservi'': "40"');
     
     IF x1 THEN 
         DBMS_OUTPUT.PUT_LINE('1');
     ELSE         
         DBMS_OUTPUT.PUT_LINE('2');
     END IF;
    --cast('abcdef' as varchar2(3)) v3,
    
     --DBMS_OUTPUT.PUT_LINE(cast(x1 AS VARCHAR2));
     --DBMS_OUTPUT.PUT_LINE(regexp_like (conteudo, '^[a-zA-Z .''-]+$') );
END;
  
  
