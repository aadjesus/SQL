Create Or Replace Procedure Pr_Mtk_Incluiroperador Is
Begin
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
			   CodigoFuncionario)
              Select Seq_Mtk_Operador.Nextval
                    ,a.Nomeabreviadofuncionario
                    ,a.Senhadeacessofuncionario
                    ,'S'
                    ,a.Nomefuncionario
                    ,a.Nomeabreviadofuncionario
                    ,0
                    ,b.Descricaofuncao
                    ,a.Email1funcionario
					,a.CodigoFuncionario
              From Sii_Funcionario a
                  ,Sii_Funcao      b
              Where a.Ativofuncionario = 'A'
                    And a.Codfuncao = b.Codfuncao
                    And a.Nomeabreviadofuncionario Is Not Null
                    And Not Exists
               (Select Id From Mtk_Operador c Where c.Usuario = a.Nomeabreviadofuncionario);
       Commit;

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
              Select Seq_Mtk_Operador.Nextval
                    ,a.Emailcontatocli
                    ,a.Senhaweb
                    ,'S'
                    ,a.Nomecontatocli
                    ,a.Nomereduzidocontatocli
                    ,1
                    ,a.Cargocontatocli
                    ,a.Emailcontatocli
              From Sii_Contatocliente a
              Where a.Ativocontatocli = 'S'
                    And a.Emailcontatocli Is Not Null
                    And Not Exists
               (Select c.Id From Mtk_Operador c Where c.Usuario = a.Emailcontatocli)
                    And a.Codcontato = (Select Max(b.Codcontato)
                                        From Sii_Contatocliente b
                                        Where b.Emailcontatocli Is Not Null
                                              And a.Emailcontatocli = b.Emailcontatocli
                                        Group By b.Emailcontatocli);
       Commit;

       Insert Into Mtk_Operadorcliente
              (Codcliente,
               Id_Operador)
              Select b.Codcliente
                    ,a.Id
              From Mtk_Operador a
                  ,(Select Max(b.Codcliente) Codcliente
                          ,b.Emailcontatocli
                    From Sii_Contatocliente b
                    Where b.Emailcontatocli Is Not Null
                    Group By b.Emailcontatocli) b
              Where a.Usuario = b.Emailcontatocli
                    And Not Exists (Select Id
                     From Mtk_Operadorcliente
                     Where Id = a.Id
                           And Codcliente = b.Codcliente);
       Commit;
End Pr_Mtk_Incluiroperador;