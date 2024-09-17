---------------------------------------------------------------------------------------------------------------
--- Retorna o local do painel informado
---------------------------------------------------------------------------------------------------------------
select *
  from t_esc_localidade locaisdto0_
 where locaisdto0_.cod_localidade = 4101
---------------------------------------------------------------------------------------------------------------
--- Retorna as linhas associadas no painel
---------------------------------------------------------------------------------------------------------------
     select *
       from gfo_painel_linha this_
      where this_.codigoempresa = 8
            and this_.codigofl = 9
            and this_.cod_painel = 8            
---------------------------------------------------------------------------------------------------------------
--- Retorna as linhas do painel
---------------------------------------------------------------------------------------------------------------
     select *       
     from bgm_cadlinhas this_
      where (this_.codintlinha in (1112,1119,26565,26590, 26604,26607))
---------------------------------------------------------------------------------------------------------------
---  Retorna os itinerarios que fazem o local e da linha"se informada"
---------------------------------------------------------------------------------------------------------------
     select *
       from gfo_itinerario_itens this_
      where this_.id_itinerario in
            (select this_0_.id_itinerario as y0_
               from gfo_itinerario this_0_
              where this_0_.vigencia_inicial =
                    (select max(this_0_0_.vigencia_inicial) as y0_
                       from gfo_itinerario this_0_0_
                      where this_0_0_.codintlinha = this_0_.codintlinha
                            and this_0_0_.id_itinerario in
                            (select this_0_0_0_.id_itinerario as y0_
                                   from gfo_itinerario_dia this_0_0_0_
                                  where this_0_0_0_.codintlinha = this_0_0_.codintlinha
                                        and this_0_0_0_.dia = 3)
                            and this_0_0_.vigencia_inicial <= TO_DATE('23/08/2011 00:00:00','DD/MM/YYYY HH24:MI:SS'))
                    and this_0_.codintlinha = this_.codintlinha)
            and this_.id_itinerario in (select this_0_.id_itinerario as y0_
                                          from gfo_itinerario_dia this_0_
                                         where this_0_.codintlinha = this_.codintlinha
                                               and this_0_.dia = 3)
            and (this_.codintlinha in (1112,1119,26565,26590, 26604,26607))
            and (this_.cod_localidade in (4101))
---------------------------------------------------------------------------------------------------------------
---  Retorna os servicos dos itinerarios encontrados
---------------------------------------------------------------------------------------------------------------
     Select *
       from gfo_itinerario_servicos this_
      where ((this_.id_itinerario = 002 and this_.codintlinha = 26604 and this_.sentido = 'I' And this_.sequencial = 41) or 
                   ((this_.id_itinerario = 002 and this_.codintlinha = 01112 And this_.sentido = 'I' and this_.sequencial = 15)) or
                   ((this_.id_itinerario = 006 and this_.codintlinha = 26590 and this_.sentido = 'I' And this_.sequencial = 15)) or 
                   ((this_.id_itinerario = 007 and this_.codintlinha = 26565 And this_.sentido = 'V' and this_.sequencial = 17)) or
                   ((this_.id_itinerario = 101 and this_.codintlinha = 26607 and this_.sentido = 'I' And this_.sequencial = 41)) or 
                   ((this_.id_itinerario = 101 and this_.codintlinha = 01119 And this_.sentido = 'I' and this_.sequencial = 14)))
---------------------------------------------------------------------------------------------------------------
---  Retorna ultima localizacao do veiculo, conforme as linhas dos itinerarios encontrados no periodo de 1hr
---------------------------------------------------------------------------------------------------------------
     Select *
       from gfo_controleoperacional_atual this_
      where this_.cod_localidade is not null
            and this_.data_ocorrencia between TO_DATE('23/08/2011 20:00:00','DD/MM/YYYY HH24:MI:SS') and TO_DATE('23/08/2011 12:00:00','DD/MM/YYYY HH24:MI:SS')
            and (this_.codintlinha in (1112,1119,26565,26590, 26604,26607))
---------------------------------------------------------------------------------------------------------------
-- Retorna os itinerarios que fazem o local da ultima localizacao do veiculo
---------------------------------------------------------------------------------------------------------------
     select *
       from gfo_itinerario_itens this_
      where this_.id_itinerario in
            (select this_0_.id_itinerario as y0_
               from gfo_itinerario this_0_
              where this_0_.vigencia_inicial =
                    (select max(this_0_0_.vigencia_inicial) as y0_
                       from gfo_itinerario this_0_0_
                      where this_0_0_.codintlinha = this_0_.codintlinha
                            and this_0_0_.id_itinerario in
                            (select this_0_0_0_.id_itinerario as y0_
                                   from gfo_itinerario_dia this_0_0_0_
                                  where this_0_0_0_.codintlinha = this_0_0_.codintlinha
                                        and this_0_0_0_.dia = 3)
                            and this_0_0_.vigencia_inicial <= TO_DATE('23/08/2011 00:00:00','DD/MM/YYYY HH24:MI:SS'))
                    and this_0_.codintlinha = this_.codintlinha)
            and this_.id_itinerario in (select this_0_.id_itinerario as y0_
                                          from gfo_itinerario_dia this_0_
                                         where this_0_.codintlinha = this_.codintlinha
                                               and this_0_.dia = 3)
            and (this_.codintlinha in (1119,1112, 26565))
            and (this_.cod_localidade in (2,9125, 4105))
---------------------------------------------------------------------------------------------------------------
---  Retorna os servicos dos itinerarios encontrados da ultima localizacao do veiculo
---------------------------------------------------------------------------------------------------------------
     select*
       from gfo_itinerario_servicos this_
      where ((this_.id_itinerario = 2 and this_.codintlinha = 1112 and this_.sentido = 'V' And this_.sequencial = 18) or 
                  ((this_.id_itinerario = 7 and this_.codintlinha = 26565 And this_.sentido = 'V' and this_.sequencial = 32)))
---------------------------------------------------------------------------------------------------------------
---  Retorna dados da controle operacional
---------------------------------------------------------------------------------------------------------------
     select *
       from gfo_controleoperacional this_
      where (this_.id_controle_operacional in (414884151))

            
