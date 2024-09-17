create or replace function EnviarParaRabbint(texto in varchar2) return boolean is
  enviou boolean;  
  Function Executar(pTipo integer, pBroker Broker%ROWTYPE) Return boolean Is
      retorno number;
      exchange varchar2(100);
   Begin   
     BEGIN
          exchange := pBroker.exchange;
          if exchange is null then
             exchange := 'BgmRodotec_Manu360';
          end if;
          if pTipo = 1 and pBroker.Declare_Process = 0 Then 
             retorno := amqp_exchange_declare(exchange, 'fanout',pBroker.Host ,pBroker.Port, '/', pBroker.Username, pBroker.Password);  
             
             
            -- update Broker set Declare_Process = 1 
            -- where BROKER_ID = pBroker.Broker_Id 
              -- and HOST = pBroker.Host 
               --and PORT = pBroker.Port;
             
          ELSIF pTipo = 2 Then     
             retorno :=  amqp_publish(exchange, ' ', texto, pBroker.Host ,pBroker.Port, '/', pBroker.Username, pBroker.Password);            
          end If;
          
          return retorno != 0;
       EXCEPTION WHEN OTHERS THEN                  
           dbms_output.put_line(SQLERRM);               
           return false;
       END;
   End;   
begin
  for broker in (Select * From Broker) loop
      enviou := Executar(1,broker) and Executar(2,broker);
	end loop;
  
  return enviou;
end EnviarParaRabbint;
/
