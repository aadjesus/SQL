create or replace function Rabbit_Enviar(texto in varchar2) return boolean is
  enviou boolean;  
  atualizar boolean;   
  Function Executar(pTipo integer, pRabbit Rabbint%ROWTYPE) Return boolean Is
      retorno number;
      exchange varchar2(100);
   Begin   
     BEGIN
          exchange := nvl(pRabbit.exchange,'BgmRodotec_Manu360');

          if pTipo = 1 and pRabbit.Declare_Process = 0 Then 
             retorno := Rabbit_Exchange(exchange, pRabbit.Exchange_Type ,pRabbit.Host ,pRabbit.Port,pRabbit.Vhost , pRabbit.Username, pRabbit.Password);  
          ELSIF pTipo = 2 Then
             retorno := Rabbit_Publish(exchange, nvl(pRabbit.Exchange_Key,' '), texto, pRabbit.Host, pRabbit.Port, pRabbit.Vhost, pRabbit.Username, pRabbit.Password);
          end If;
          
          return retorno = 0;
       EXCEPTION WHEN OTHERS THEN                  
           dbms_output.put_line(SQLERRM);               
           return false;
       END;
   End;   
begin
  for fRabbit in (Select * From Rabbit) loop
      enviou := Executar(1,fRabbit) and Executar(2,fRabbit);
      if enviou then
         update Rabbit set Declare_Process = 1
          where Host = fRabbit.Host
            and Port = fRabbit.Port;
         atualizar := true;
      end if;    
	end loop;

  if atualizar then
     commit;
  end if;     
  
  return enviou;
end Rabbit_Enviar;
/
