Create Or Replace Trigger TR_Diaria
    Before Insert Or Update Or Delete On diaria
    For Each Row
Declare
    v_cod_intescala OSASCO180417.T_ESC_ESCALAPADRAO.cod_intescala%Type;
    v_dat_escala    OSASCO180417.T_ESC_ESCALADIARIA.dat_escala%Type;
    v_cod_tipodia   OSASCO180417.T_ESC_ESCALAPADRAO.cod_tipodia%Type;
    v_cod_intlinha  OSASCO180417.T_ESC_ESCALAPADRAO.cod_intlinha%Type;

    Cursor c_Servico --(p_id  padrao) 
    Is
        Select  a.cod_servdiaria,
                 a.cod_intturno,
                 a.cod_intescala,
                 a.codveic,
                 a.cod_motorista,
                 a.cod_cobrador        
          From OSASCO180417.T_ESC_SERVICOPADRAO a
         Inner Join padraoserv b On a.id_externo = b.Idexterno
         LEFT JOIN diariaserv c ON b.ID = c.idpadraoserv         
        Where b.idpadrao = :New.idpadrao
        ;

    --Where cod_servico = :New.cod_servico
    --    And cod_intprograma = :New.cod_intprograma
    --  And cod_intturno = :New.cod_intturno
    
Begin
    Begin
        If (:New.gerou = 0) Then
            Return;
        End If;
    
        Select a.cod_intescala, b.dat_escala, a.cod_tipodia, a.cod_intlinha
          Into v_cod_intescala, v_dat_escala, v_cod_tipodia, v_cod_intlinha
          From OSASCO180417.T_ESC_ESCALAPADRAO a
          Left Join OSASCO180417.T_ESC_ESCALADIARIA b On a.cod_intescala = b.cod_intescala And b.dat_escala =  :New.DATA
         Inner Join padrao c On a.id_externo = c.Idexterno
         Where c.ID = :New.idpadrao;
    
        If v_dat_escala = Null Then
            Insert Into OSASCO180417.T_ESC_ESCALADIARIA
                (cod_intescala,
                 dat_escala,
                 cod_tipodia,
                 cod_intlinha,
                 dat_alter)
            Values
                (v_cod_intescala,
                 :New.DATA,
                 v_cod_tipodia,
                 v_cod_intlinha,
                 Sysdate);
        Else
            Update OSASCO180417.T_ESC_ESCALADIARIA
               Set dat_alter = Sysdate
             Where cod_intescala = v_cod_intescala
                   And dat_escala = :New.DATA;
        
        End If;
    
        For itemServico In c_Servico
        Loop
            Insert Into OSASCO180417.T_ESC_SERVICODIARIA
                (dat_escala,
                 cod_servdiaria,
                 cod_intturno,
                 cod_intescala,
                 cod_veic,
                 cod_motorista,
                 cod_cobrador)
            Values
                (:New.DATA,
                 itemServico.cod_servdiaria,
                 itemServico.cod_intturno,
                 itemServico.cod_intescala,
                 itemServico.cod_veic,
                 itemServico.cod_motorista,
                 itemServico.cod_cobrador);
        End Loop;
    
        --T_ESC_ESCALADIARIA   -- DAT_ESCALA, COD_INTESCALA
        --T_ESC_SERVICODIARIA
        --T_ESC_HORARIOSDIARIA
        --T_ESC_INTERVALOSDIARIA
    
    Exception
        When Others Then
            dbms_output.put_line(Sqlerrm);
    End;
End TR_Diaria;