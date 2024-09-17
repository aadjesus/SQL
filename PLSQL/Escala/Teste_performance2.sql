Update OSASCO180417.T_ESC_PARAMFUNC Set hor_entrada = hor_entrada; -- 14,485

SELECT COUNT(*) FROM EscalaTesteAle.Funcionario

Insert Into EscalaTesteAle.Funcionario   -- =  1,25
    (Id,
     registro,
     chapa,
     nome,
     apelido,
     idexterno,
     funcao,
     escala,
     cargahorariamensal,
     microonibus,
     idgrupofuncionario,
     IdFilial)
    Select Seq_Funcionario.Nextval,
     f.Codfunc,
     f.Chapafunc,
     f.Nomefunc,
     SUBSTR(nvl(f.Apelidofunc, ''), 1, 15),
     f3.id_externo,
     (Select decode(Max(TPFUNCFIXA), 'MOT', 0, 1)
        From OSASCO180417.BGM_FUFIXO_FUNCAO
       Where codfuncao = f.codfuncao
             And sistema = 'ESC'),
     1,
     f.HRSEMFUNCAO * 4,
     (Case
         When (
               
               Select Count(*)
                 From OSASCO180417.t_esc_habilitacaotipocarro a
                Inner Join OSASCO180417.frt_tipodefrota b On a.cod_tpveic = b.codigotpfrota
                Where a.cod_func = pf.cod_func
                      And b.classifictpfrota = 'M'
               
               ) > 0 Then
          1
         Else
          0
     End),
     g.ID,
     fl.id
    
      From OSASCO180417.T_ESC_PARAMFUNC pf
     Inner Join OSASCO180417.VW_FUNCIONARIOS f On f.codintfunc = pf.cod_func
     Inner Join OSASCO180417.FLP_FUNCIONARIOS_COMPLEMENTAR f3 On F.CODINTFUNC = F3.codintfunc
     Inner Join OSASCO180417.flp_area a On a.codarea = f.CODAREA
     Inner Join EscalaTesteAle.grupofuncionario g On a.id_externo = g.idexterno
     Inner Join EscalaTesteAle.Empresa e On e.codigo = f.CODIGOEMPRESA
     Inner Join EscalaTesteAle.Filial fl On e.id = fl.idempresa And fl.codigo = f.CODIGOFL
      Left Join EscalaTesteAle.funcionario f1 On f3.id_externo = f1.idexterno