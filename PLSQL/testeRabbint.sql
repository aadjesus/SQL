create or replace trigger TR_Teste_RabbitMQ After Insert Or Update Or Delete On broker for each row
-----------------------------------------
DECLARE
   CURSOR c_colunas is
    select COLUMN_NAME
         , count(*) over () tot_rows
    from USER_TAB_COLUMNS
    where TABLE_NAME = 'BROKER'; 
    
    rec   VARCHAR2(4000);
    jSon VARCHAR2(4000);
    --query VARCHAR2(4000);
    valor varchar2(4000);
    v1 varchar(50);
--------------------------------------------
begin
     for coluna in c_colunas loop
         begin
              --ql_stmt := 'INSERT INTO emp_tab VALUES (:1, :2, :3)';
              --EXECUTE IMMEDIATE sql_stmt USING v_emp_id, v_salary, v_salary;
         
              --EXECUTE IMMEDIATE ':new.' || coluna.COLUMN_NAME into valor;
              
              --dbms_output.put_line(valor);
               v1:=':NEW.'|| coluna.COLUMN_NAME;
         
               
               execute immediate 'select '|| v1 || ' from dual ' into valor;              
         
              --execute immediate 'select :new.'|| coluna.COLUMN_NAME || ' from dual ' into valor;              
              
              jSon := jSon ||'"'|| coluna.COLUMN_NAME ||'":'|| valor;
              
              if c_colunas%ROWCOUNT != coluna.tot_rows then               
                 jSon := jSon || ', ';
              end if;
              --"id": 1,
              
              --query := query || ':new.' || coluna.COLUMN_NAME ;
              --if c_colunas%ROWCOUNT != coluna.tot_rows then               
              --     query := query || ', ';
              --end if;
         end;
		 end loop;
     dbms_output.put_line(jSon);
     --query := ' select ' || query || ' from dual';
     --dbms_output.put_line(query);
    
    -- EXECUTE IMMEDIATE ' select ' || new_col_value || ' from dual';
  
  
  -- EXECUTE IMMEDIATE query INTO rec ;
--   DBMS_OUTPUT.PUT_LINE('Rec: ' || rec );

     --execute immediate 'select :old.'||REC.COLUMN_NAME|| ', :new.'||REC.COLUMN_NAME|| ' from dual' into old_col_value, new_col_value;

end TR_Teste_RabbitMQ;
