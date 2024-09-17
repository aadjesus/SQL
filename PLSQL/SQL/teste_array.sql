Declare
  Type t_Array_Col Is Table Of Varchar2(1000);
  Type t_Array_Rec Is Record(
     Table_Name Varchar2(30)
    ,Colunas    t_Array_Col);
  Type t_Array_Tab Is Table Of t_Array_Rec Index By Binary_Integer;
  v_Array t_Array_Tab;
  v_Index Number;
  Procedure AdicionarTabela(p_Table_Name Varchar2, p_Colunas t_Array_Col) Is
  Begin
    v_Index := v_Index + 1;
    v_Array(v_Index).Table_Name := p_Table_Name;
    v_Array(v_Index).Colunas := p_Colunas;
  End;

Begin
  v_Index := 0;
  Adicionartabela('zzz', t_Array_Col('aaa1', 'aaaa2'));
  Adicionartabela('zzz3', t_Array_Col());
  For x In 1 .. v_Array.Count
  Loop
    Dbms_Output.Put_Line(v_Array(x).Table_Name);
    For y In 1 .. v_Array(x).Colunas.Count
    Loop
      Dbms_Output.Put_Line(v_Array(x).Colunas(y));
    End Loop;
  End Loop;
End;