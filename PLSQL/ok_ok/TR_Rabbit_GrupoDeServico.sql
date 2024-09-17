create or replace trigger TR_Rabbit_GrupoDeServico
  After Insert Or Update Or Delete On man_grupodeservico  
  for each row
declare
	  jSon varchar2(4000);
    operacao Integer;   
    codigo man_grupodeservico.codigogrpservi%TYPE;    
begin
    codigo := :new.codigogrpservi;
	  if Inserting Then
		   operacao := 0;       
    ELSIF Updating Then
       operacao := 1;       
    else
       operacao := 2;
       codigo := :old.codigogrpservi;
    end If;

    jSon := 
          chr(123) || 
          '''entidade'':' || 1 || ',' ||
          '''operacao'':' || operacao || ',' ||
          '''conteudo'':' || 
                   chr(123) || 
                   '''codigo'':' || codigo || ',' ||
                   '''descricao'':"' || :new.descricaogrpservi || '"'||
                   chr(125) ||
           chr(125);
    
    BEGIN
         if Rabbit_Enviar(jSon) then
            dbms_output.put_line(jSon);
         end if;
         
    EXCEPTION WHEN OTHERS THEN
         dbms_output.put_line(SQLERRM);
    END;
  
end TR_Rabbit_GrupoDeServico;
/
