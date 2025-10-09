select 'union select FN_GERACAO_POR_DATA(a.DTNASCTOFUNC) as geracao, count(*) as qtde' || 
       '  from ' || a.username || '.FLP_FUNCIONARIOS a' || 
       ' where exists(select 1 ' ||
       '                from   ' || a.username || '.CTR_CADASTRODEUSUARIOS b ' ||
       '               where A.CODINTFUNC = B.CODINTFUNC' ||
       '                 and b.ativo = ''S''   ) ' ||
       'group by FN_GERACAO_POR_DATA(a.DTNASCTOFUNC)'       
  from all_users a
 where exists (select 1
          from all_tables b
         where a.username = b.owner
           and b.table_name IN
               ('CTR_CADASTRODEUSUARIOS', 'FLP_FUNCIONARIOS'))

CREATE
    OR REPLACE FUNCTION FN_GERACAO_POR_DATA(p_data_nasc DATE) RETURN
 VARCHAR2 IS v_ano NUMBER;
v_geracao VARCHAR2(30);
BEGIN
  v_ano := EXTRACT(YEAR FROM p_data_nasc);

  IF v_ano BETWEEN 1946 AND 1964 THEN
    v_geracao := 'Baby Boomers';
  ELSIF v_ano BETWEEN 1965 AND 1980 THEN
    v_geracao := 'Geração X';
  ELSIF v_ano BETWEEN 1981 AND 1996 THEN
    v_geracao := 'Geração Y (Millennials)';
  ELSIF v_ano BETWEEN 1997 AND 2012 THEN
    v_geracao := 'Geração Z';
  ELSIF v_ano >= 2013 THEN
    v_geracao := 'Geração Alfa';
  ELSE
    v_geracao := 'Antes dos Baby Boomers';
  END IF;

  RETURN v_geracao;
END;


--select geracao, sum(qtde) qtde  from (
--) group by geracao