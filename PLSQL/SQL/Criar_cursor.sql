CREATE OR REPLACE Procedure AtuValor
Is
  v_valor number(13,2)  ;          
  v_valorcorrmesatu number(13,2)  ;          
  v_date date ;
  Cursor Item Is
      select valorcorrmesatu
           , data
           , tipo
           , codigoempresa
           , codigofl
           , codigo
        from atfmovto
       where tipo   = 'DP'
         and codigo = 110061    
    order by codigoempresa
           , codigofl 
           , codigo
           , data  ;
Begin
  v_date := '01-jan-1999' ;
  For Items in Item Loop
    begin
      select valor
           , valorcorrmesatu  
           , max(data)
        into v_valor    
           , v_valorcorrmesatu  
           , v_date          
        from atfmovto 
       where tipo          =  Items.tipo
         and codigoempresa =  Items.codigoempresa
         and codigofl      =  Items.codigofl      
         and data         < Items.data
         and data > v_date
         and codigo        =  Items.codigo 
    group by valor
           , valorcorrmesatu ;
    EXCEPTION
      WHEN OTHERS THEN
        v_valor := 0 ;
        v_valorcorrmesatu := 0 ;
--        v_date  := sysdate ;
        v_date := '01-jan-1999' ;
    END;       

    If v_valor > 0 then
      Update atfmovto 
         set valorcorrmesatu = v_valorcorrmesatu + v_valor
       where tipo          =  Items.tipo
         and codigoempresa =  Items.codigoempresa
         and codigofl      =  Items.codigofl      
         and data          =  Items.data
         and codigo        =  Items.codigo ;          
    end if ;     
  End Loop;   
End AtuValor; 
/
EXECUTE Exp_Cursor 
COMMIT ;
DROP PROCEDURE Exp_Cursor ;

