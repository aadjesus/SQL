Select r.owner
      , r.table_name
      , r.constraint_name 
From    user_constraints r
      , user_constraints o 
Where   r.r_owner = o.owner
       And  r.r_constraint_name = o.constraint_name
       And  o.constraint_type In ('P', 'U')
       And  r.constraint_type = 'R'
       And  o.table_name = upper('frt_tipodefrota')
--              And  r.table_name = upper('t_Esc_Paramfunc')

--select b.CHAPAFUNC from t_Esc_Paramfunc a ,vw_funcionarios b where a.cod_func = b.CODINTFUNC
--select * from T_ESC_TECNOLOGIAFROTA
--select * from T_TRF_LINHA_TIPOFROTA