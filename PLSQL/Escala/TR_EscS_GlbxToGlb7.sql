Create Or Replace Trigger TR_EscS_GlbxToGlb7
    Before Insert Or Update Or Delete On T_ESC_SERVICOPADRAO
    For Each Row
Declare
    v_TipoOperacao  Number;
    v_idVeiculo     EscalaTeste2.Veiculo.Id%Type;
    v_idTipoDeDia   EscalaTeste2.Tipodedia.Id%Type;
    v_Esc_TipoDeDia T_ESC_TIPODIA%Rowtype;
    v_Dia           EscalaTeste2.Diadasemana.Dia%Type;
Begin
    Begin
        v_TipoOperacao := 0;
        If DELETING Then
            v_TipoOperacao := 2;
        End If;
    
        Begin
            Select b.id
              Into v_idVeiculo
              From frt_cadveiculos a
             Inner Join EscalaTeste2.Veiculo b On a.idexterno = b.idexterno
             Where a.codigoveic = :New.codveic;
        Exception
            When Others Then
                Return;
        End;
    
        If Inserting Or :New.idexterno Is Null Then
            :New.IdExterno := sys_guid();
            Insert Into EscalaTeste2.Escalapadraoservico
                (Id,
                 horainicio,
                 horafim,
                 grupo,
                 idexterno,
                 idescalapadrao,
                 idveiculo,
                 idservico)
            Values
                (SEQ_EmpresaAutorizada.Nextval,
                 horainicio,
                 horafim,
                 grupo,
                 idexterno,
                 idescalapadrao,
                 idveiculo,
                 idservico);
        Else
            Update EscalaTeste2.Escalapadraoservico
               Set codigo           = :New.cod_escala,
                   ativo            = decode(:New.flg_ativa, 'S', 1, 0),
                   idLinha          = v_idLinha,
                   idtipodedia      = v_idTipoDeDia,
                   DataHoraExclusao = (Case When v_TipoOperacao = 2 Then Sysdate Else Null End)
             Where IdExterno = :Old.IdExterno;
        End If;
    Exception
        When Others Then
            dbms_output.put_line(Sqlerrm);
    End;
End TR_EscS_GlbxToGlb7;
/