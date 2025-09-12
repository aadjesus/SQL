select a.sistema, a.caption, b.qtde
  from ctr_menusdosistema a
 inner join (select SUBSTR(indicemenu, 0, 2) as indicemenu,
                    count(*) as qtde,
                    sistema
               from ctr_menusdosistema
              group by SUBSTR(indicemenu, 0, 2), sistema) b on a.sistema = b.sistema
                                                           and a.indicemenu = b.indicemenu
--where a.sistema = 'ACD'

     
--select * from ctr_menusdosistema where sistema = 'ABA' and SUBSTR(indicemenu,0,2) = '00' caption = 'Cadastros'

--select 'union all select a.*, '''|| a.owner ||''' from ' || a.owner || '.acd_grauacidente a' from all_all_tables a where a.table_name = upper('acd_grauacidente')
