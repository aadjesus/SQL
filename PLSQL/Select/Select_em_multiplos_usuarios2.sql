Select Decode(Rownum, 1, '', 'union all ') || 'SELECT max(length(codigolinha)) as tamanho, '''|| a.Owner ||''' from ' || a.Owner || '.bgm_cadlinhas'
  From Dba_Tables a
 Where a.Table_Name = upper( 'bgm_cadlinhas')


	
Select Decode(Rownum, 1, '', 'union all ') || 'SELECT Sum(decode(a.cod_motorista, Null, 0, 1)) qtde_mot, Sum(decode(a.cod_folgamot, Null, 0, 1)) qtde_mot_fol, Sum(decode(a.cod_cobrador, Null, 0, 1)) qtde_cob, Sum(decode(a.cod_folgaCob, Null, 0, 1)) qtde_cob_fo, '''|| a.owner ||''' as BASE  FROM '|| a.owner || '.t_esc_servicopadrao a INNER JOIN '|| a.owner ||'.t_esc_escalapadrao b ON a.cod_intescala = b.cod_intescala WHERE b.flg_ativa = ''S'''
  From Dba_Tables a
 Where a.Table_Name = upper( 't_esc_servicopadrao')

