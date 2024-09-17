Create Or Replace Trigger Tr_Mtk_Desativaroperador_Clien
       After Update On Sii_Cliente
       For Each Row
Begin
       If :New.Ativocliente = 'I' Then
              Update Sii_Contatocliente
              Set Ativocontatocli = 'N'
              Where Codcliente = :Old.Codcliente;
       End If;
End Tr_Mtk_Desativaroperador_Clien;