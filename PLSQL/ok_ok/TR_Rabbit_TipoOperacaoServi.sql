create or replace trigger TR_Rabbit_TipoOperacaoServi
  After Insert Or Update Or Delete On man_tipooperacaoservi  
  for each row
declare
    jSon varchar2(4000);
    operacao Integer;   
    codigo man_tipooperacaoservi.codigotpoperservi%TYPE;    
begin
    codigo := :new.codigotpoperservi;
    if Inserting Then
       operacao := 0;
    ELSIF Updating Then
       operacao := 1;
    else
       operacao := 2;
       codigo := :old.codigotpoperservi;
    end If;
    
    jSon := 
          chr(123) || 
          '''entidade'':' || 0 || ',' ||
          '''operacao'':' || operacao || ',' ||
          '''conteudo'':' || 
                   chr(123) || 
                   '''codigo'':' || codigo || ',' ||
                   '''descricao'':"' || :new.descricaotpoperservi  ||'"'||
                   chr(125) ||
           chr(125);
            
    BEGIN
         if Rabbit_Enviar(jSon) then
            dbms_output.put_line(jSon);
         end if;
         
    EXCEPTION WHEN OTHERS THEN
         dbms_output.put_line(SQLERRM);
    END;
  
end TR_Rabbit_TipoOperacaoServi;
/
