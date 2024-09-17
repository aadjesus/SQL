CREATE TABLE TST_Trigger_Sequences(Id_Sequences NUMBER NOT NULL
                                  ,data_Sequences date )


CREATE TABLE TST_Trigger_Sequences_x(data_Sequences date )
                  
select nvl(max(a.id_sequences),0)+1 from TST_Trigger_Sequences a
    SELECT TST_Trigger_Sequences_SEQ.NEXTVAL      FROM DUAL

insert into TST_Trigger_Sequences(Data_Sequences) values (sysdate)
                  
create or replace trigger Atualiza_Trigger_Sequences
after INSERT OR UPDATE on TST_Trigger_Sequences_x for each row 
declare
  vId_Sequences NUMBER;
begin
  vId_Sequences := 0 ; 
  begin
    SELECT TST_Trigger_Sequences_SEQ.NEXTVAL 
      INTO vId_Sequences
      FROM DUAL;
  EXCEPTION 
    WHEN OTHERS THEN
      SELECT nvl(max(Id_Sequences),0)+1
        INTO vId_Sequences
        FROM TST_Trigger_Sequences
  end;    

  UPDATE TST_Trigger_Sequences SET 
         Id_Sequences = vId_Sequences
   WHERE data_Sequences = :NEW.data_Sequences;
  
end Atualiza_Trigger_Sequences;
                  

create sequence TST_Trigger_Sequences_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 5; 
