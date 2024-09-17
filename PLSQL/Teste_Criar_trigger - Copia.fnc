create or replace function Teste_Criar_trigger(nome_tabela in varchar2) return varchar2 is
       sql_trigger varchar2(4000);  
       json_colunas varchar2(4000);  
       enter varchar2(10);  
       nome_trigger varchar2(40);
       CURSOR c_colunas is            
              Select COLUMN_NAME, count(*) over () tot_rows
                From USER_TAB_COLUMNS
               Where table_name = upper(nome_tabela);         
begin
     enter := chr(10);       
     nome_trigger := 'TR_RABBIT_' || upper(SUBSTR(nome_tabela,INSTR(nome_tabela,'_')+1,20));
     
     for coluna in c_colunas     
     loop   
           json_colunas := json_colunas || '                    ''''''' || LOWER(coluna.COLUMN_NAME) || ''''': "'' || :NEW.' || coluna.COLUMN_NAME || ' || ''"'' || ';
           
           if c_colunas%ROWCOUNT != coluna.tot_rows then               
                 json_colunas := json_colunas || ''', '' || ' ;
           end if;           
           json_colunas := json_colunas || enter;
     end loop;
          
     sql_trigger := 'create or replace trigger '|| nome_trigger ||' After Insert Or Update Or Delete On '|| nome_tabela ||' for each row ' || enter;
     sql_trigger := sql_trigger || 'declare                                               ' || enter;
     sql_trigger := sql_trigger || '    jSon varchar2(4000);	                            ' || enter;
     sql_trigger := sql_trigger || '    operacao Integer;   	                            ' || enter;
     sql_trigger := sql_trigger || 'begin					                                        ' || enter;
     sql_trigger := sql_trigger || '     If Inserting Then	                              ' || enter;
     sql_trigger := sql_trigger || '        operacao := 0;	                              ' || enter;
     sql_trigger := sql_trigger || '     ElsIf Updating Then	                            ' || enter;
     sql_trigger := sql_trigger || '        operacao := 1;	                              ' || enter;
     sql_trigger := sql_trigger || '     Else				                                      ' || enter;
     sql_trigger := sql_trigger || '        operacao := 2;	                              ' || enter;
     sql_trigger := sql_trigger || '     End If;				                                  ' || enter;
     sql_trigger := sql_trigger || '     jSon :=                                          ' || enter;     
     sql_trigger := sql_trigger || '           chr(123) || 								                ' || enter;
     sql_trigger := sql_trigger || '       ''''''entidade'''':'' || 0 || '','' ||			    ' || enter;
     sql_trigger := sql_trigger || '       ''''''operacao'''':'' || operacao || '','' ||	' || enter;
     sql_trigger := sql_trigger || '       ''''''conteudo'''':'' || 						          ' || enter;
     sql_trigger := sql_trigger || '                    chr(123) ||                       ' || enter;
     sql_trigger := sql_trigger ||                      json_colunas ;
     sql_trigger := sql_trigger || '                    chr(125) ||                       ' || enter;
     sql_trigger := sql_trigger || '            chr(125);                                 ' || enter;            
     sql_trigger := sql_trigger || '    dbms_output.put_line(jSon);                       ' || enter;  
     sql_trigger := sql_trigger || 'end '|| nome_trigger ||';                             ' || enter;
     sql_trigger := sql_trigger || '/                                                     ' || enter;    
  
     return(sql_trigger);
end Teste_Criar_trigger;
/
