/*Select Decode(Rownum, 1, '', 'union all ') || 'select max(length(descricaocadservi)) ,'''|| a.Owner ||''' as usuario from ' || a.Owner || '.man_cadastrodeservicos'
  From Dba_Tables a
 Where a.Table_Name = upper( 'man_cadastrodeservicos')
 
*/

--Select Decode(Rownum, 1, '', 'union all ') || 'select count(*) ,'''|| a.Owner ||''' as usuario from ' || a.Owner || '.man_osprevisto where descrcomplosprev is not null and codigocadservi is not null  '

Select Decode(Rownum, 1, '', 'union all ') || 

'select Qtde_Com_Complemento,'||
'       Qtde_Total,'||
'       (Qtde_Com_Complemento * 100) / Qtde_Total as Media, '''|| a.Owner ||''' as usuario ' ||
'  from (select sum(Qtde_Com_Complemento) as Qtde_Com_Complemento, count(*) as Qtde_Total'||
'          from (select decode(descrcomplosprev,null,0,decode(codigocadservi, null, 0, 1)) Qtde_Com_Complemento,'||
'                       1 Qtde_Total'||
'                  from ' || a.Owner || '.man_osprevisto h'||
'                 where exists (select 1'||
'                          from ' || a.Owner || '.man_os o'||
'                         where o.dataaberturaos >='||
'                               TO_DATE(''01/01/2015'', ''DD/MM/YYYY'')'||
'                           and o.codintos = h.codintos)))'

  From Dba_Tables a
 Where a.Table_Name = upper( 'man_osprevisto')



-- select max(length(descricaodefeito)) from man_caddefeitos b
--select max(length(descricaocadservi)) from man_cadastrodeservicos b
--select * from man_osprevisto
--select * from man_osrealizado

--Select Table_Name From User_Tables Where Table_Name Like 'MAN_%' 









 
 