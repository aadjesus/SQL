Declare
    Cursor c_Objeto Is
        Select object_name
          From User_Objects
         Where Status = 'INVALID'
               And OBJECT_TYPE = 'TRIGGER';
    v_erro Varchar2(2000);
Begin
    For Item In c_Objeto
    Loop
        v_erro := '';
        Begin
            Execute Immediate 'ALTER TRIGGER ' || Item.object_name ||
                              ' DISABLE';        
        Exception
            When Others Then
                v_erro := Sqlerrm;
        End;
        PR_LOG_INTEGRACAO('DISABLE TRIGGER:' || Item.object_name, v_erro);
    End Loop;
End;