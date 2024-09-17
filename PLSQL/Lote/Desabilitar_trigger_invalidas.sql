declare 
    Cursor c_Trigger IS
    Select  Object_Name
          From User_Objects 
         Where Instr(Object_Name, '_ESO_') > 0
               And Data_Object_Id Is Null
               And Object_Type = 'TRIGGER'
               AND Status = 'INVALID';    
Begin
    For itemTrigger In c_Trigger
    Loop
        EXECUTE IMMEDIATE 'ALTER TRIGGER ' || itemTrigger.Object_Name || ' '  || ' DISABLE';
    End Loop;
End;
