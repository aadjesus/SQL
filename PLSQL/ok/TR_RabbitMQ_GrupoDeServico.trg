create or replace trigger TR_RabbitMQ_GrupoDeServico
  After Insert Or Update Or Delete On man_grupodeservico  
  for each row
declare
	  jSon varchar2(4000);
    operacao Integer;   
begin
	  if Inserting Then
		   operacao := 0;
    ELSIF Updating Then
       operacao := 1;
    else
       operacao := 2;
    end If;

    jSon := 
          chr(123) || 
          '''entidade'':' || 1 || ',' ||
          '''operacao'':' || operacao || ',' ||
          '''conteudo'':' || 
                   chr(123) || 
                   '''codigo'':' || :new.codigogrpservi || ',' ||
                   '''descricao'':"' || :new.descricaogrpservi || '"'||
                   chr(125) ||
           chr(125);
    
    BEGIN
         if EnviarParaRabbint(jSon) then
            dbms_output.put_line(jSon);
         end if;
         
    EXCEPTION WHEN OTHERS THEN
         dbms_output.put_line(SQLERRM);
    END;
  
end TR_RabbitMQ_GrupoDeServico;
/
