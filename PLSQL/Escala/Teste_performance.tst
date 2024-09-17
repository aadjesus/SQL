PL/SQL Developer Test script 3.0
134
Declare
    tempo Number := dbms_utility.get_time();

    Cursor c_Func Is
        Select f.Codfunc,
               f.Chapafunc,
               f.Nomefunc,
               SUBSTR(nvl(f.Apelidofunc, ''), 1, 15) As Apelidofunc,
               f3.id_externo,
               (Select decode(Max(TPFUNCFIXA), 'MOT', 0, 1)
                  From OSASCO180417.BGM_FUFIXO_FUNCAO
                 Where codfuncao = f.codfuncao
                       And sistema = 'ESC') As funcao,
               f.HRSEMFUNCAO * 4 As tempo,
               (Case
                   When (
                         
                         Select Count(*)
                           From OSASCO180417.t_esc_habilitacaotipocarro a
                          Inner Join OSASCO180417.frt_tipodefrota b On a.cod_tpveic =
                                                                       b.codigotpfrota
                          Where a.cod_func = pf.cod_func
                                And b.classifictpfrota = 'M'
                         
                         ) > 0 Then
                    1
                   Else
                    0
               End) As escala,
               g.ID As IdGrupo,
               fl.id As IdFilial        
          From OSASCO180417.T_ESC_PARAMFUNC pf
         Inner Join OSASCO180417.VW_FUNCIONARIOS f On f.codintfunc = pf.cod_func
         Inner Join OSASCO180417.FLP_FUNCIONARIOS_COMPLEMENTAR f3 On F.CODINTFUNC = F3.codintfunc
         Inner Join OSASCO180417.flp_area a On a.codarea = f.CODAREA
         Inner Join EscalaTesteAle.grupofuncionario g On a.id_externo = g.idexterno
         Inner Join EscalaTesteAle.Empresa e On e.codigo = f.CODIGOEMPRESA
         Inner Join EscalaTesteAle.Filial fl On e.id = fl.idempresa And fl.codigo = f.CODIGOFL
          Left Join EscalaTesteAle.funcionario f1 On f3.id_externo = f1.idexterno;
Begin

    Update OSASCO180417.T_ESC_PARAMFUNC Set hor_entrada = hor_entrada;
    dbms_output.put_line('Update = ' || (dbms_utility.get_time - tempo) / 100);

    Rollback;

    tempo := dbms_utility.get_time();
    Insert Into EscalaTesteAle.Funcionario
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
        Select EscalaTesteAle.Seq_Funcionario.Nextval,
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
                          Inner Join OSASCO180417.frt_tipodefrota b On a.cod_tpveic =
                                                                       b.codigotpfrota
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
          Left Join EscalaTesteAle.funcionario f1 On f3.id_externo = f1.idexterno;

    dbms_output.put_line('Select Insert = ' || (dbms_utility.get_time - tempo) / 100);
    Rollback;

    tempo := dbms_utility.get_time();
    Forall indx In Indices Of c_Func
        Insert Into EscalaTesteAle.Funcionario
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
        Values
            (EscalaTesteAle.Seq_Funcionario.Nextval,
             indx.Codfunc,
             indx.Chapafunc,
             indx.Nomefunc,
             indx.Apelidofunc,
             indx.id_externo,
             indx.funcao,
             indx.escala,
             indx.tempo,
             1,
             indx.IdGrupo,
             indx.IdFilial);

    dbms_output.put_line('Select Insert = ' || (dbms_utility.get_time - tempo) / 100);
    Rollback;
End;
0
0
