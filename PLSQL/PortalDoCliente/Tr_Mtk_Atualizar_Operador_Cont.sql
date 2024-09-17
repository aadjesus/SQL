Create Or Replace Trigger Tr_Mtk_Atualizar_Operador_Cont
       After Insert Or Update Or Delete On Sii_Contatocliente
       For Each Row
Declare
       v_Id Mtk_Operador.Id%Type;
       v_Senha Mtk_Operador.Senha%Type;
       v_QtdTotal NUMBER(8);
       v_QtdAtivoN NUMBER(8);

	   Procedure Atualizar_Chave Is
	   Begin       
			Update Mtk_Operador
			Set Usuario = :New.Emailcontatocli, Email = :New.Emailcontatocli
			Where Usuario = :Old.Emailcontatocli;
       End;
	   
	   Procedure Atualizar_Operador(p_Ativo Mtk_Operador.Ativo%Type, p_Senha Mtk_Operador.Senha%Type) Is
              v_Ativo Mtk_Operador.Ativo%Type;
       Begin     
             v_QtdTotal := 0;
             v_QtdAtivoN := 0;
             
             Begin
                    Select count(*)
                    Into v_QtdTotal
                    From Sii_Contatocliente
                    Where Emailcontatocli = :New.Emailcontatocli
                    And Codcliente <> :New.Codcliente;
             Exception
                    When Others Then
                          v_QtdTotal := 0;
             End;   
             
             Begin
                    Select count(*)
                    Into v_QtdAtivoN
                    From Sii_Contatocliente
                    Where Emailcontatocli = :New.Emailcontatocli
                    And Codcliente <> :New.Codcliente 
                    And Ativocontatocli = 'N';
             Exception
                    When Others Then
                          v_QtdAtivoN := 0;
             End;                                  
             
              If :New.Aprovado <> 'S' And v_QtdTotal - v_QtdAtivoN = 0 Then
                 v_Ativo := 'N';
              Else
                 v_Ativo := p_Ativo;
              End If;
              
              If p_Senha Is Null And :New.Senhaweb Is Not Null And :Old.Senhaweb Is Null Then
                  Update Mtk_Operador
                  Set Ativo = v_Ativo, Senha = :New.Senhaweb
                  Where Perfil = 1
                        And Usuario = :New.Emailcontatocli;
              Else
                  Update Mtk_Operador
                  Set Ativo = v_Ativo
                  Where Perfil = 1
                        And Usuario = :New.Emailcontatocli;
              End If;
       End;

       Function Incluiro_Operador Return Number Is
              v_Ativo Mtk_Operador.Ativo%Type;
       Begin
              v_Id := Seq_Mtk_Operador.Nextval;
              
              If :New.Aprovado <> 'S' Then
                 v_Ativo := 'N';
              Else
                 v_Ativo := :New.Ativocontatocli;
              End If;
              
              Insert Into Mtk_Operador
                     (Id,
                      Usuario,
                      Senha,
                      Ativo,
                      Nome,
                      Nome_Abreviado,
                      Perfil,
                      Cargo,
                      Email,
					  Telefone,
					  Ramal)
              Values
                     (v_Id,
                      :New.Emailcontatocli,
                      :New.Senhaweb,
                      v_Ativo,
                      :New.Nomecontatocli,
                      :New.Nomereduzidocontatocli,
                      1,
                      :New.Cargocontatocli,
                      :New.Emailcontatocli,
					  :New.Telefonecontatocli,
					  :New.Ramalcontatocli);
              Return v_Id;
       End;
Begin
       If :New.Emailcontatocli Is Null Then
              Return;
       End If;
	   
	   If Updating And :New.Emailcontatocli <> :Old.Emailcontatocli Then
			Atualizar_Chave();
	   End If;

	   If Deleting Or (Updating And :New.Senhaweb Is Null And :Old.Senhaweb Is Not Null) Then
              Atualizar_Operador('N', :Old.Senhaweb);
              Return;
       End If;

	   Begin
              Select Id, Senha
              Into v_Id, v_Senha
              From Mtk_Operador
              Where Perfil = 1
                    And Usuario = :New.Emailcontatocli;
       Exception
              When Others Then
                     v_Id := 0;
       End;

       If v_Id = 0 Then
              v_Id := Incluiro_Operador();
       Else
              Begin
                     Atualizar_Operador(:New.Ativocontatocli, v_Senha);

                     Begin
                            Select 0
                            Into v_Id
                            From Mtk_Operadorcliente
                            Where Id_Operador = v_Id
                                  And Codcliente = :New.Codcliente;
                     Exception
                            When Others Then
                                   v_Id := v_Id;
                     End;
              End;
       End If;

       If v_Id <> 0 Then
              Insert Into Mtk_Operadorcliente
                     (Id_Operador,
                      Codcliente)
              Values
                     (v_Id,
                      :New.Codcliente);
       End If;

End Tr_Mtk_Atualizar_Operador_Cont;