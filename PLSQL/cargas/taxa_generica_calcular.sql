-- select id,codigo, esporadico from enc7_cliente f             where f.id = 166020;
-- select id,id_cliente_tomador from enc7_taxa_generica_compl b where b.id_taxa_generica = 21 and b.data_hora_exclusao is  null; 

-- calcular
select *
  from ENC7_TAXA_GENERICA_COMPL taxageneri0_
 where taxageneri0_.ID_TAXA_GENERICA         = 21       
   and (taxageneri0_.ID_CLIENTE_REMETENTE    = 166020    or       taxageneri0_.ID_CLIENTE_REMETENTE is null)
   and (taxageneri0_.ID_CLIENTE_DESTINATARIO = 166020    or       taxageneri0_.ID_CLIENTE_DESTINATARIO is null)
   and (taxageneri0_.ID_CLIENTE_TOMADOR      = 167605 	 or 
     
        exists
        (select clientemod1_.Id
           from ENC7_CLIENTE clientemod1_
          where (clientemod1_.Id = taxageneri0_.ID_CLIENTE_TOMADOR or
                (clientemod1_.Id is null) and
                (taxageneri0_.ID_CLIENTE_TOMADOR is null))
            and clientemod1_.esporadico = 1) or
                
        taxageneri0_.ID_CLIENTE_TOMADOR is null)
   and (taxageneri0_.ID_CLASSIFICACAO_TRANSPORTE = 1      or taxageneri0_.ID_CLASSIFICACAO_TRANSPORTE is null)
   and (taxageneri0_.ID_GRUPO_PRODUTO            = 2      or taxageneri0_.ID_GRUPO_PRODUTO is null)
   and (taxageneri0_.ID_PRODUTO                  = 17     or taxageneri0_.ID_PRODUTO is null)
   and (taxageneri0_.ID_TP_VEICULO               = 1      or taxageneri0_.ID_TP_VEICULO is null)
   and (taxageneri0_.ID_TP_FRETE                 = 1      or taxageneri0_.ID_TP_FRETE is null)
   and (taxageneri0_.ID_LOCALIDADE_ORIGEM        = 669    or taxageneri0_.ID_LOCALIDADE_ORIGEM is null)
   and (taxageneri0_.ID_LOCALIDADE_DESTINO       = 669    or taxageneri0_.ID_LOCALIDADE_DESTINO is null)
   and (taxageneri0_.ID_BAIRRO_ORIGEM            = 11149  or taxageneri0_.ID_BAIRRO_ORIGEM is null)
   and (taxageneri0_.ID_BAIRRO_DESTINO           = 11149  or taxageneri0_.ID_BAIRRO_DESTINO is null)
   and (taxageneri0_.ID_UF_ORIGEM                = 7      or taxageneri0_.ID_UF_ORIGEM is null)
   and (taxageneri0_.ID_UF_DESTINO               = 7      or taxageneri0_.ID_UF_DESTINO is null)
   and trunc(taxageneri0_.DATA_VALIDADE) >= TO_DATE('2023-08-07','YYYY-MM-DD') 
   and trunc(taxageneri0_.DATA_VIGENCIA) <= TO_DATE('2023-08-07','YYYY-MM-DD')
   and (taxageneri0_.DATA_HORA_EXCLUSAO is null)
 order by (case            when taxageneri0_.ID_CLIENTE_REMETENTE                     is null then             17            else             0          end) asc,
          (case            when taxageneri0_.ID_CLIENTE_DESTINATARIO                  is null then             17            else             0          end) asc,
          (case            when taxageneri0_.ID_BAIRRO_ORIGEM                         is null then             17            else             0          end) asc,
          (case            when taxageneri0_.ID_BAIRRO_DESTINO                        is null then             17            else             0          end) asc,
          (case            when taxageneri0_.ID_PRODUTO                               is null then             17            else             0          end) asc,
          (case            when taxageneri0_.ID_LOCALIDADE_ORIGEM                     is null then             17            else             0          end) asc,
          (case            when taxageneri0_.ID_LOCALIDADE_DESTINO                    is null then             17            else             0          end) asc,
          (case            when taxageneri0_.ID_REGIAO_ORIGEM                         is null then             17            else             0          end) asc,
          (case            when taxageneri0_.ID_REGIAO_DESTINO                        is null then             17            else             0          end) asc,
          (case            when taxageneri0_.ID_GRUPO_PRODUTO                         is null then             17            else             0          end) asc,
          (case            when taxageneri0_.ID_TP_VEICULO                            is null then             17            else             0          end) asc,
          (case            when taxageneri0_.ID_CLASSIFICACAO_TRANSPORTE              is null then             17            else             0          end) asc,
          (case            when taxageneri0_.ID_UF_ORIGEM                             is null then             17            else             0          end) asc,
          (case            when taxageneri0_.ID_UF_DESTINO                            is null then             17            else             0          end) asc,
          (case            when taxageneri0_.ID_TP_FRETE                              is null then             17            else             0          end) asc,
          (case            when taxageneri0_.ID_CLIENTE_TOMADOR                       is null then             17            else             0          end) asc;
/*
:p0  = 21                   
:p1  = 166020               
:p2  = 166020               
:p3  = 166020               
:p4  = 0                    
:p5  = 1                    
:p6  = 2                    
:p7  = 17                   
:p8  = 1                    
:p9  = 1                    
:p10 = 669                 
:p11 = 669                 
:p12 = 11149               
:p13 = 11149               
:p14 = 7                   
:p15 = 7                   
:p16 = 2023 - 08 - 07T00 :00 :00.0000000 - 03 :00 Type :Date(0 :0 :0), 
:p17 = 2023 - 08 - 07T00 :00 :00.0000000 - 03 :00 Type :Date(0 :0 :0), 
*/