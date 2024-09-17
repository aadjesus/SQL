--FORALL
Declare
    Cursor C_FUNCIONARIOS Is
        Select * From MOBIBRASIL180726.T_ESC_PARAMFUNC;

    Type T_FUNCIONARIO Is Table Of MOBIBRASIL180726.T_ESC_PARAMFUNC%Rowtype;
    V_FUNCIONARIO T_FUNCIONARIO;
Begin
    Open C_FUNCIONARIOS;
    Loop
        Fetch C_FUNCIONARIOS Bulk Collect
            Into V_FUNCIONARIO Limit 5000;
    
        Forall i In 1 .. V_FUNCIONARIO.Count
                         PR_T_ESC_PARAMFUNC(V_FUNCIONARIO(i), 0) ;
    
        Commit;
        Exit When C_FUNCIONARIOS%Notfound;
    End Loop;

    Close C_FUNCIONARIOS;
End;