Select col_0_0_, col_1_0_, col_2_0_, col_3_0_, col_4_0_, col_5_0_, col_6_0_
  From (Select funcionari0_.Id                 As col_0_0_,
               funcionari0_.Chapa              As col_1_0_,
               funcionari0_.HoraInicioTrabalho As col_2_0_,
               funcionari0_.HoraFimTrabalho    As col_3_0_,
               funcionari0_.Funcao             As col_4_0_,
               funcionari0_.MicroOnibus        As col_5_0_,
               funcionari0_.CargaHorariaMensal As col_6_0_
          From Funcionario funcionari0_
         Where funcionari0_.Escala = 1
               And funcionari0_.DataHoraExclusao Is Null
               And
               Not (Exists
                 (Select informacoe1_.Id
                       From InformacaoFuncionario informacoe1_
                      Where funcionari0_.Id = informacoe1_.IdFuncionario
                            And informacoe1_.Bloquear = 1
                            And :p0 >= trunc(informacoe1_.DataHoraInicio)
                            And :p1 <= trunc(informacoe1_.DataHoraFim)))
               And funcionari0_.Funcao = :p2
               And funcionari0_.Chapa > :p3
               And
               (Exists
                (Select escalapadr2_.Id
                   From PadraoServ escalapadr2_
                  Where (escalapadr2_.Id <> :p4 Or escalapadr2_.Id Is Null)
                        AND  (funcionari0_.HoraInicioTrabalho >=  escalapadr2_.HoraInicio And funcionari0_.HoraFimTrabalho <= escalapadr2_.HoraInicio Or
                                    escalapadr2_.HoraFim >=  funcionari0_.HoraInicioTrabalho AND  escalapadr2_.HoraFim <= funcionari0_.HoraFimTrabalho)
                        And
                        Not (Exists (Select escalapadr3_.Id
                                       From PadraoServFunc escalapadr3_
                                      Inner Join PadraoServ escalapadr4_ On escalapadr3_.IdPadraoServ =  escalapadr4_.Id
                                      Where (escalapadr3_.IdFuncionario Is Not Null)
                                            And (escalapadr3_.IdFuncionario = funcionari0_.Id OR  (escalapadr3_.IdFuncionario Is Null) AND  (funcionari0_.Id Is Null))
                                            And escalapadr3_.IdPadraoServ = :p5
                                            And (escalapadr4_.HoraInicio >=  escalapadr2_.HoraInicio AND escalapadr4_.HoraFim <= escalapadr2_.HoraInicio Or
                                                      escalapadr2_.HoraFim >= escalapadr4_.HoraInicio AND escalapadr2_.HoraFim <=  escalapadr4_.HoraFim)))
                        And Not (Exists
                          (Select escaladiar5_.Id
                                    From DiariaServFunc escaladiar5_
                                   Inner Join DiariaServ escaladiar6_ On escaladiar5_.IdDiariaServ = escaladiar6_.Id
                                   Inner Join Diaria escaladiar7_ On escaladiar6_.IdDiaria = escaladiar7_.Id
                                   Inner Join PadraoServ escalapadr8_ On escaladiar6_.IdPadraoServ = escalapadr8_.Id
                                   Where (escaladiar5_.IdFuncionario Is Not Null)
                                         And (escaladiar5_.IdFuncionario = funcionari0_.Id OR  (escaladiar5_.IdFuncionario Is Null) AND (funcionari0_.Id Is Null))
                                         And (escaladiar6_.IdPadraoServ Is Null)
                                         And escaladiar6_.IdPadraoServ = :p6
                                         And trunc(escaladiar7_.Data) = :p7
                                         And (escalapadr8_.HoraInicio >= escalapadr2_.HoraInicio AND escalapadr8_.HoraFim <= escalapadr2_.HoraInicio Or
                                         escalapadr2_.HoraFim >= escalapadr8_.HoraInicio AND escalapadr2_.HoraFim <= escalapadr8_.HoraFim)))))
               And
               (Exists (Select linhas9_.Id
                          From FuncionarioLinha linhas9_
                         Inner Join Linha linhamodel10_ On linhas9_.IdLinha = linhamodel10_.ID AND linhamodel10_.Ativo = 1 AND linhamodel10_.DataHoraExclusao Is Null
                         Where funcionari0_.Id = linhas9_.IdFuncionario
                               And linhamodel10_.IdFilial = :p8))
               And
               (Exists (Select tecnologia11_.Id
                          From FuncionarioTecnologia tecnologia11_
                         Where funcionari0_.Id = tecnologia11_.IdFuncionario
                               And tecnologia11_.IdTecnologia = :p9))
         Order By funcionari0_.Chapa Asc)
 Where rownum <= :p10