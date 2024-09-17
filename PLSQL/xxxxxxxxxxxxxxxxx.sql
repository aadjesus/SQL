Declare
    Cursor cur In
        Select column_name
          From user_tab_cols
         Where table_name = ora_dict_obj_name;
    sQuery Varchar2(1000);
Begin
    For data In cur
    Loop
        -- double single quote in UPDATE text
        sQuery := 'INSERT INTO auditor_table VALUES (' || ':NEW.' || data.column_name || ', :OLD.' || data.column_name ||  ', ''UPDATE'')';
        Execute Immediate sQuery;
    End Loop;
End;