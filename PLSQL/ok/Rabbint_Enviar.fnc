create or replace function Rabbint_Enviar(texto in varchar2) return boolean is
  enviou boolean;  
  atualizar boolean;   
  Function Executar(pTipo integer, pRabbint Rabbint%ROWTYPE) Return boolean Is
      retorno number;
      exchange varchar2(100);
   Begin   
     BEGIN
          exchange := nvl(pRabbint.exchange,'BgmRodotec_Manu360');

          if pTipo = 1 and pRabbint.Declare_Process = 0 Then 
             retorno := Rabbit_Exchange(exchange, pRabbint.Exchange_Type ,pRabbint.Host ,pRabbint.Port,pRabbint.Vhost , pRabbint.Username, pRabbint.Password);  
          ELSIF pTipo = 2 Then
             retorno := Rabbit_Publish(exchange, nvl(pRabbint.Exchange_Key,' '), texto, pRabbint.Host, pRabbint.Port, pRabbint.Vhost, pRabbint.Username, pRabbint.Password);
          end If;
          
          return retorno = 0;
       EXCEPTION WHEN OTHERS THEN                  
           dbms_output.put_line(SQLERRM);               
           return false;
       END;
   End;   
begin
  for fRabbint in (Select * From Rabbint) loop
      enviou := Executar(1,fRabbint) and Executar(2,fRabbint);
      if enviou then
         update Rabbint set Rabbint.Declare_Process = 1 
          where Rabbint.Host = fRabbint.Host
            and Rabbint.Port = fRabbint.Port;
         atualizar := true;
      end if;    
	end loop;

  if atualizar then
     commit;
  end if;     
  
  return enviou;
end Rabbint_Enviar;
/
