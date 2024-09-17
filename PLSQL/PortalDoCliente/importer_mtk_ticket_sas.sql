      
DECLARE
   CURSOR c1 is
    SELECT 
           T.ID,
--           TD.Natureza,
           TD.numero_adequacao,
           case (TD.Natureza)
                when '2' then '0'
                when '3' then '1'
           end as tipo_sas
    FROM MTK_TicketDetalhes TD
    
    Inner Join MTK_Ticket T ON 
    T.id = TD.ID
    
    Where 
          TD.numero_adequacao is not null 
          and IS_NUMBER (TD.numero_adequacao) = 'TRUE'
          and Natureza in (2,3); --Alteracao,Correcao
   id NUMBER(10);
   numero_adequacao varchar2(1000);
   tipo_sas varchar2(1);
BEGIN
   OPEN c1;
   FOR i IN 1..20000 LOOP
       BEGIN
            FETCH c1 INTO id, numero_adequacao,tipo_sas;
            EXIT WHEN c1%NOTFOUND;  /* in case the number requested */
                                    /* is more than the total       */
            INSERT INTO MTK_TICKET_SAS VALUES (id, tipo_sas, numero_adequacao);
            COMMIT;
      EXCEPTION
         WHEN OTHERS THEN  -- handles all other errors
            NULL;
      END;
   END LOOP;
   CLOSE c1;
END;

SELECT * FROM MTK_TICKET_SAS
