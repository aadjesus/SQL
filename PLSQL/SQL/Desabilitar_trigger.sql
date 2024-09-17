Declare
    Cursor c_Triggers Is
        Select Object_Name
          From User_Objects
         Where Instr(Object_Name, '_ESO_') > 0
               And Data_Object_Id Is Null
               And Object_Type = 'TRIGGER'
               And status = 'INVALID';
Begin
    For item_trigger In c_Triggers
    Loop
        Execute Immediate 'ALTER TRIGGER ' || item_trigger.Object_Name || ' DISABLE';
    End Loop;
End;