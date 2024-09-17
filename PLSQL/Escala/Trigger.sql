Create Or Replace Trigger TR_Linha
    Before Insert Or Update On Linha
    For Each Row
Begin
    If Inserting Then
        Begin
            If :New.idexterno Is Null Then
                :New.IdExterno := sys_guid();
            End If;
        
            :New.Id               := SQ_TESTE1TESTE2.Nextval;
            :New.DataHoraInclusao := Sysdate;
        End;
    End If;

    -- If Updating Then
    --   :New.DataHoraInclusao := Sysdate;
    ---    End If;
End TR_Linha;
/