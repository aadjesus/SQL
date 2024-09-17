Declare
Begin
    For item In (Select *
                   From User_Objects
                  Where 
                  GENERATED = 'N'
                  --object_type IN  ('PROCEDURE', 'SEQUENCE', 'FUNCTION', 'TABLE')
                  Order By created Desc)
    Loop
        Begin
            Execute Immediate 'DROP  ' || item.object_type || ' ' ||
                              item.object_name;
        Exception
            When Others Then
                dbms_output.put_line(item.object_name || ': ' || Sqlerrm);
        End;
    End Loop;
End;