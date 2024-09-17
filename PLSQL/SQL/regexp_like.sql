/*    

regexp_like(aaaa,'^aaaa$|^bbbb$|^cccc*');



Create Table Tabela_Teste(
       id number,
       NOME varchar2(50));

Create Table Tabela_Teste2(
       id number,
       VALOR number);
        
insert into Tabela_Teste(id,NOME) values (1,'CancelamentodeDocumentosLote');   
insert into Tabela_Teste(id,NOME) values (1,'CancelamentodeDocumentos');   
insert into Tabela_Teste(id,NOME) values (2,'ExclusaoDeDocumentos1');   
insert into Tabela_Teste(id,NOME) values (3,'outros');   


select * from Tabela_Teste
select * from Tabela_Teste2
delete Tabela_Teste where id =1
delete Tabela_Teste2

        */

CREATE OR REPLACE TRIGGER TR_Tabela_Teste
  BEFORE INSERT OR DELETE ON Tabela_Teste
  FOR EACH ROW
DECLARE
  V_ID    number;
  V_NOMES VARCHAR2(100);
BEGIN
  V_NOMES := '^CancelamentodeDocumentos*|^ExclusaoDeDocumentos*';

  Dbms_Output.Put_Line('inser  ' || :NEW.NOME);
  Dbms_Output.Put_Line('delete ' || :OLD.NOME);

  IF NOT regexp_like(NVL(:NEW.NOME, :OLD.NOME), V_NOMES) THEN
    RETURN;
  END IF;

  select nvl(max(id),0) 
    into V_ID 
    from Tabela_Teste2 
   where id = NVL(:NEW.id, :OLD.id);

  if V_ID = 0 then
    V_ID := NVL(:NEW.id, :OLD.id); 
    insert into Tabela_Teste2 (id, valor) values (V_ID, 0);    
  end if;

  if regexp_like(:NEW.NOME, V_NOMES) then
    Dbms_Output.Put_Line('achou');
  end if;

  UPDATE Tabela_Teste2
     SET VALOR = (CASE WHEN regexp_like(:NEW.NOME, V_NOMES) THEN '1' ELSE '0' END)
   WHERE ID = V_ID;

  Dbms_Output.Put_Line('fim');
END TR_Tabela_Teste;