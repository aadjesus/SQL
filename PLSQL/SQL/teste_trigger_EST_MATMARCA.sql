PL/SQL Developer Test script 3.0
23
DECLARE 
   V_IDITEM NUMBER;
   V_IDITEMMARCA NUMBER;
BEGIN

     Dbms_Output.Put_Line( 'insert' );
     
--     insert into MOBIBRASIL220525.EST_MATMARCA 
--        (codigomatint, codigomarcamat, aceitamovtomatmarca)
--     values
--        (6154, 773, 'S');

     Dbms_Output.Put_Line( 'update' );
     update MOBIBRASIL220525.EST_MATMARCA 
        set aceitamovtomatmarca = 'S'
        where codigomatint = 1639 -- 6154
         and codigomarcamat = 999; --773;       
            
     Dbms_Output.Put_Line( 'delete' );   
     delete MOBIBRASIL220525.EST_MATMARCA where codigomatint =  6154 and codigomarcamat = 773;
                 
--     rollback;      
ENd;
0
0
