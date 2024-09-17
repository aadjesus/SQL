Select Qtde_Com_Complemento,
       Qtde_Total,
       (Qtde_Com_Complemento * 100) / Qtde_Total as Media
  from (select (select count(*)
                  from man_osprevisto o
                 where descrcomplosprev is not null
                   and codigocadservi is not null
                   and exists (select 1
                          from man_os h
                         where h.dataaberturaos >=
                               TO_DATE('01/01/2015', 'DD/MM/YYYY')
                           and h.codintos = o.codintos)) as Qtde_Com_Complemento,
               (select count(*)
                  from man_osprevisto o
                 where exists (select 1
                          from man_os h
                         where h.dataaberturaos >=
                               TO_DATE('01/01/2015', 'DD/MM/YYYY')
                           and h.codintos = o.codintos)) as Qtde_Total
          from dual)