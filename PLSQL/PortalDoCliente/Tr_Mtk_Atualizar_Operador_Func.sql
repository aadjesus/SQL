Create Or Replace Trigger Tr_Mtk_Atualizar_Operador_Func
       After Insert Or Update Or Delete On Sii_Funcionario
       For Each Row
Declare
       v_Id              Mtk_Operador.Id%Type;
	   v_Ativo           Mtk_Operador.Ativo%Type;
       v_Descricaofuncao Sii_Funcao.Descricaofuncao%Type;
       v_Perfil        Mtk_Operador.Perfil%Type;
Begin
       v_Perfil := 0;
       
       If :New.Codfuncao = '006' Then
           v_Perfil := 2;
       End If;
       
       If :New.Nomeabreviadofuncionario Is Null Then
              Return;
       End If;  
	   
	   If Deleting Or :New.Ativofuncionario = 'I' Then
              Update Mtk_Operador
              Set Ativo = 'N'
              Where Usuario = :New.Nomeabreviadofuncionario;
              Return;
       End If;

       Begin
              Select Id
              Into v_Id
              From Mtk_Operador
              Where Perfil = 0
                    And Usuario = :New.Nomeabreviadofuncionario;
       Exception
              When Others Then
                    v_Id := 0;
       End;             

		If v_Id = 0 Then                           
              Begin
                     Select Descricaofuncao
                     Into v_Descricaofuncao
                     From Sii_Funcao
                     Where Codfuncao = :New.Codfuncao;
              Exception
                     When Others Then
                     v_Descricaofuncao := '';
              End;
        
              Insert Into Mtk_Operador
                     (Id,
                      Usuario,
                      Senha,
                      Ativo,
                      Nome,
                      Nome_Abreviado,
                      Perfil,
                      Cargo,
                      Email)
              Values
                     (Seq_Mtk_Operador.Nextval,
                      :New.Nomeabreviadofuncionario,
                      :New.Senhadeacessofuncionario,
                      'S',
                      :New.Nomefuncionario,
                      :New.Nomeabreviadofuncionario,
                      v_Perfil,
                      v_Descricaofuncao,
                      :New.Email1funcionario);
       Else
           Update Mtk_Operador
           Set Ativo = 'S', Perfil = v_Perfil
           Where Usuario = :New.Nomeabreviadofuncionario;
       End If;
End Tr_Mtk_Atualizar_Operador_Func;