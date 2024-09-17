create or replace procedure teste_Rabbint is
   erro varchar2(999);     
   Function Executar(pTipo integer, pBroker Broker%ROWTYPE) Return boolean Is
      retorno number;
   Begin   
     BEGIN
          if pTipo = 1 Then     
            retorno := amqp_exchange_declare(pBroker.broker_id, 'BgmRodotec_Manu360', 'fanout');
          else
            retorno := amqp_publish(pBroker.broker_id, 'BgmRodotec_Manu360', pBroker.host, 'RabbitMQ rocks!');     
          end If;          
          
          return true;
       EXCEPTION WHEN OTHERS THEN                  
           if erro != SQLERRM then    
           begin           
               dbms_output.put_line(SQLERRM);               
               erro := SQLERRM;
           end;
           end if;
           return false;
       END;
   End;     
begin  
  for broker in (Select * From Broker) loop
  BEGIN
       erro := ' ';
       dbms_output.put_line('Id: '|| broker.broker_id || ', Host: ' || broker.host);
       for i in 1..100 loop         
           if Executar(1,broker) then
              dbms_output.put_line('Ok:' || broker.host );
           end If;  
           EXIT WHEN not Executar(2,broker);
       end loop;  
       dbms_output.put_line(' ');
  end;
	end loop;
end teste_Rabbint;
/
