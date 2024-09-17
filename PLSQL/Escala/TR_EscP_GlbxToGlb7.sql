Create Or Replace Trigger TR_EscP_GlbxToGlb7
    Before Insert Or Update Or Delete On T_ESC_ESCALAPADRAO
    For Each Row
Declare
    v_TipoOperacao  Number;
    v_idLinha       EscalaTeste2.Linha.Id%Type;
    v_idTipoDeDia   EscalaTeste2.Tipodedia.Id%Type;
    v_Esc_TipoDeDia T_ESC_TIPODIA%Rowtype;
    v_Dia           EscalaTeste2.Diadasemana.Dia%Type;

    Function DiaDaSemana(
             p_Dia  EscalaTeste2.Diadasemana.Dia%Type,
             p_Flag Varchar2) Return Number Is
    Begin
        Return(Case When p_Flag = 'S' Then p_Dia Else - 1 End);
    End;

    Function DiaDaSemanaOk(
             p_Dia  EscalaTeste2.Diadasemana.Dia%Type,
             p_Flag Varchar) Return Boolean Is
    Begin
        Return DiaDaSemana(p_Dia, p_Flag) <> -1;
    End;

    Procedure IncluirDiaDaSemana(
              p_idTipoDeDia EscalaTeste2.Tipodedia.Id%Type,
              p_Dia                  EscalaTeste2.Diadasemana.Dia%Type,
              p_Flag                Varchar2) Is
        v_Dia EscalaTeste2.Diadasemana.Dia%Type;
    Begin
        v_Dia := DiaDaSemana(p_Dia, p_Flag);
        If v_Dia = -1 Then
            Return;
        End If;
    
        Insert Into EscalaTeste2.Diadasemana
            (id,
             Dia,
             Idtipodedia)
        Values
            (SEQ_EmpresaAutorizada.Nextval,
             v_Dia,
             p_idTipoDeDia);
    End;

    Function IncluirTipoDeDia(p_Esc_TipoDeDia T_ESC_TIPODIA%Rowtype)
        Return Number Is
    Begin
        v_idTipoDeDia := SEQ_EmpresaAutorizada.Nextval;
        Insert Into EscalaTeste2.Tipodedia
            (Id,
             Descricao)
        Values
            (v_idTipoDeDia,
             p_Esc_TipoDeDia.Desc_Tipodia);
    
        IncluirDiaDaSemana(v_idTipoDeDia, 0, v_Esc_TipoDeDia.FLG_DOMINGO);
        IncluirDiaDaSemana(v_idTipoDeDia, 1, v_Esc_TipoDeDia.FLG_SEGUNDA);
        IncluirDiaDaSemana(v_idTipoDeDia, 2, v_Esc_TipoDeDia.FLG_TERCA);
        IncluirDiaDaSemana(v_idTipoDeDia, 3, v_Esc_TipoDeDia.FLG_QUARTA);
        IncluirDiaDaSemana(v_idTipoDeDia, 4, v_Esc_TipoDeDia.FLG_QUINTA);
        IncluirDiaDaSemana(v_idTipoDeDia, 5, v_Esc_TipoDeDia.FLG_SEXTA);
        IncluirDiaDaSemana(v_idTipoDeDia, 6, v_Esc_TipoDeDia.FLG_SABADO);
        IncluirDiaDaSemana(v_idTipoDeDia, 7, v_Esc_TipoDeDia.FLG_FERIADO);
    
        Return v_idTipoDeDia;
    End;
Begin
    Begin
        If (:New.idexterno Is Not Null And
           :New.cod_escala = :Old.cod_escala And
           :New.COD_TIPODIA = :Old.COD_TIPODIA And
           :New.cod_intlinha = :Old.cod_intlinha And
           :New.flg_ativa = :Old.flg_ativa) Then
            Return;
        End If;
    
        v_TipoOperacao := 0;
        If DELETING Then
            v_TipoOperacao := 2;
        End If;
    
        Begin
            Select b.id
              Into v_idLinha
              From bgm_cadlinhas a
             Inner Join EscalaTeste2.Linha b On a.idexterno = b.idexterno
             Where a.codintlinha = :New.cod_intlinha;
        Exception
            When Others Then
                Return;
        End;
    
        Select *
          Into v_Esc_TipoDeDia
          From T_ESC_TIPODIA
         Where cod_inttipodia = :New.COD_TIPODIA;
    
        Begin
            Select Max(a.id)
              Into v_idTipoDeDia
              From EscalaTeste2.Tipodedia a
             Inner Join EscalaTeste2.Diadasemana b On a.id = b.idtipodedia
             Where (DECODE(v_Esc_TipoDeDia.FLG_DOMINGO, 'S', 0, -1) = b.dia Or
                   DECODE(v_Esc_TipoDeDia.FLG_SEGUNDA, 'S', 1, -1) = b.dia Or
                   DECODE(v_Esc_TipoDeDia.FLG_TERCA, 'S', 2, -1) = b.dia Or
                   DECODE(v_Esc_TipoDeDia.FLG_QUARTA, 'S', 3, -1) = b.dia Or
                   DECODE(v_Esc_TipoDeDia.FLG_QUINTA, 'S', 4, -1) = b.dia Or
                   DECODE(v_Esc_TipoDeDia.FLG_SEXTA, 'S', 5, -1) = b.dia Or
                   DECODE(v_Esc_TipoDeDia.FLG_SABADO, 'S', 6, -1) = b.dia Or
                   DECODE(v_Esc_TipoDeDia.FLG_FERIADO, 'S', 7, -1) = b.dia);
        Exception
            When Others Then
                Return;
                v_idTipoDeDia := IncluirTipoDeDia(v_Esc_TipoDeDia);
        End;
    
        If Inserting Or :New.idexterno Is Null Then
            :New.IdExterno := sys_guid();
            Insert Into EscalaTeste2.Escalapadrao
                (Id,
                 codigo,
                 --,observacao                 ,
                 ativo,
                 idlinha,
                 idtipodedia)
            Values
                (SEQ_EmpresaAutorizada.Nextval,
                 :New.cod_escala,
                 --,:NEW.
                 decode(:New.flg_ativa, 'S', 1, 0),
                 v_idLinha,
                 v_idTipoDeDia);
        Else
            Update EscalaTeste2.Escalapadrao
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
End TR_EscP_GlbxToGlb7;
/