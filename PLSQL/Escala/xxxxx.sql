       (Select  'empAut_g4' AS Banco, Count(*) AS Qtd From MOBIBRASIL180726.ctr_empautorizadas)  UNION ALL
       (Select  'empAut_g7' AS Banco, Count(*) AS Qtd From escalatesteale.empresaautorizada)       UNION ALL
       (Select  'Empresa_g4' AS Banco, Count(*) AS Qtd From MOBIBRASIL180726.Ctr_Cademp) UNION ALL
       (Select  'Empresa_g7' AS Banco, Count(*) AS Qtd From escalatesteale.empresa)        UNION ALL       
       (Select  'Filial_g4' AS Banco, Count(*) AS Qtd From MOBIBRASIL180726.ctr_filial) UNION ALL
       (Select  'Filial_g7' AS Banco, Count(*) AS Qtd From escalatesteale.filial)        UNION ALL
       (Select  'Area_g4' AS Banco, Count(*) AS Qtd From MOBIBRASIL180726.flp_area) UNION ALL
       (Select  'Area_g7' AS Banco, Count(*) AS Qtd From escalatesteale.grupofuncionario)       UNION ALL
       (Select  'Func_g4' AS Banco, Count(*) AS Qtd From MOBIBRASIL180726.T_ESC_PARAMFUNC) UNION ALL
       (Select  'Func_g7' AS Banco, Count(*) AS Qtd From escalatesteale.funcionario)        UNION ALL
       (Select  'TpFrota_g4' AS Banco, Count(*) AS Qtd From MOBIBRASIL180726.Frt_Tipodefrota) UNION ALL
       (Select  'TpFrota_g7' AS Banco, Count(*) AS Qtd From escalatesteale.tecnologia)        UNION ALL
       (Select  'Veiculo_g4' AS Banco, Count(*) AS Qtd From MOBIBRASIL180726.Frt_cadveiculos) UNION ALL
       (Select  'Veiculo_g7' AS Banco, Count(*) AS Qtd From escalatesteale.veiculo)        UNION ALL
       (Select  'Linha_g4' AS Banco, Count(*) AS Qtd From MOBIBRASIL180726.BGM_CADLINHAS) UNION ALL
       (Select  'Linha_g7' AS Banco, Count(*) AS Qtd From escalatesteale.linha)        UNION ALL
       (Select  'HabCar_g4' AS Banco, Count(*) AS Qtd From MOBIBRASIL180726.t_esc_habilitacaotipocarro) UNION ALL
       (Select  'HabCar_g7' AS Banco, Count(*) AS Qtd From escalatesteale.funcionariotecnologia)        UNION ALL
       (Select  'HabLin_g4' AS Banco, Count(*) AS Qtd From MOBIBRASIL180726.T_ESC_HABILITACAOLINHA) UNION ALL
       (Select  'HabLin_g7' AS Banco, Count(*) AS Qtd From escalatesteale.funcionariolinha)        UNION ALL
       (Select  'Usu_g4' AS Banco, Count(*) AS Qtd From MOBIBRASIL180726.Ctr_Cadastrodeusuarios) UNION ALL
       (Select  'Usu_g7' AS Banco, Count(*) AS Qtd From escalatesteale.Usuario)        UNION ALL       
       (Select  'UsuAut_g4' AS Banco, Count(*) AS Qtd From (SELECT codigoempresa, codigofl, usuario FROM MOBIBRASIL180726.Ctr_Usuariosporempfilgar GROUP BY codigoempresa, codigofl,usuario  ) ) UNION ALL
       (Select  'UsuAut_g7' AS Banco, Count(*) AS Qtd From escalatesteale.UsuarioFilial)        UNION ALL             
       (Select  'Padrao_g4' AS Banco, Count(*) AS Qtd From MOBIBRASIL180726.T_ESC_ESCALAPADRAO WHERE flg_ativa = 'S') UNION ALL
       (Select  'Padrao_g7' AS Banco, Count(*) AS Qtd From escalatesteale.padrao)        UNION ALL
       (Select  'PadraoServ_g4' AS Banco, Count(*) AS Qtd From MOBIBRASIL180726.T_ESC_SERVICOPADRAO B WHERE   Exists(Select 1 From MOBIBRASIL180726.T_ESC_ESCALAPADRAO a  WHERE a.COD_INTESCALA = b.COD_INTESCALA  AND a.flg_ativa = 'S') ) UNION ALL
       (Select  'PadraoServ_g7' AS Banco, Count(*) AS Qtd From escalatesteale.padraoserv) 

