select Qtde_Com_Complemento,
       Qtde_Total,
       (Qtde_Com_Complemento * 100) / Qtde_Total as Media
  from (select sum(Qtde_Com_Complemento) as Qtde_Com_Complemento, count(*) as Qtde_Total
          from (select decode(descrcomplosprev,
                              null,
                              0,
                              decode(codigocadservi, null, 0, 1)) Qtde_Com_Complemento,
                       1 Qtde_Total
                  from man_osprevisto h
                 where exists (select 1
                          from man_os o
                         where o.dataaberturaos >=
                               TO_DATE('01/01/2015', 'DD/MM/YYYY')
                           and o.codintos = h.codintos)))