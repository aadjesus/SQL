select /*nivel3.indicemenu,
       nivel1.nome,
       nivel1.caption,
       nivel2.nome,
       nivel2.caption,
       nivel3.nome,
       nivel3.caption,
       */
 nivel1.indicemenu,
 nivel2.indicemenu,
 nivel3.indicemenu,
 '<ItemMenu><NomeItemMenu>' ||
 Decode(nivel3.nome, null, nivel2.nome, nivel3.nome) ||
 '</NomeItemMenu><Caption>' ||
 Decode(nivel3.nome, null, nivel2.caption, nivel3.caption) ||
 '</Caption><AssemblyName>BgmRodotec.Globus5.Cadastros.</AssemblyName><NomeClass></NomeClass><Icone></Icone><DataInclusao></DataInclusao><Usuario></Usuario><Parametro></Parametro></ItemMenu>'
  from (select a.indicemenu,
               a.nome,
               a.caption,
               Substr(a.indicemenu, 0, 2) nivel1,
               Substr(a.indicemenu, 3, 2) nivel2,
               Substr(a.indicemenu, 5, 2) nivel3
          from ctr_menusdosistema a
         where a.sistema = 'GFO'
           and Length(a.indicemenu) = 2) nivel1,
       
       (select a.indicemenu,
               a.nome,
               a.caption,
               Substr(a.indicemenu, 0, 2) nivel1,
               Substr(a.indicemenu, 3, 2) nivel2,
               Substr(a.indicemenu, 5, 2) nivel3
          from ctr_menusdosistema a
         where a.sistema = 'GFO'
           and Length(a.indicemenu) = 4) nivel2,
       
       (select a.indicemenu,
               a.nome,
               a.caption,
               Substr(a.indicemenu, 0, 2) nivel1,
               Substr(a.indicemenu, 3, 2) nivel2,
               Substr(a.indicemenu, 5, 2) nivel3
          from ctr_menusdosistema a
         where a.sistema = 'GFO'
           and Length(a.indicemenu) = 6) nivel3
 where nivel1.nivel1 = nivel2.nivel1
      
      --   and nivel1.nivel1 = nivel3.nivel1
      
   and nivel2.nivel1 = nivel3.nivel1(+)
   and nivel2.nivel2 = nivel3.nivel2(+)