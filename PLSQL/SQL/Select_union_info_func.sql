Insert Into informacaofuncionario
    (id,
     idfuncionario,
     tipo,
     bloquear,
     datahorainicio,
     datahorafim)
    Select seq_informacaofuncionario.Nextval,
           idfuncionario,
           tipo,
           bloquear,
           datahorainicio,
           datahorafim
      From (
             Select d.ID As idfuncionario,
                   (CASE When situacaofunc = 'D' THEN 3 ELSE 5 End) As tipo,
                   1 As bloquear,
                   Sysdate As datahorainicio,
                   TO_DATE('31/12/2050', 'DD/MM/YYYY') As datahorafim
              From MOBIBRASIL180726.T_ESC_PARAMFUNC a
             Inner Join MOBIBRASIL180726.Flp_Funcionarios b On a.cod_func = b.codintfunc
             Inner Join MOBIBRASIL180726.FLP_FUNCIONARIOS_COMPLEMENTAR c On a.cod_func = c.codintfunc
             Inner Join funcionario d On c.id_externo = d.idexterno
             Where b.situacaofunc <> 'A'
            Union ALL
                        
            Select d.ID As idfuncionario,
                   14 As tipo,
                   0 As bloquear,
                   a1.dtdocto - 30 As datahorainicio,
                   a1.dtdocto As datahorafim
              From MOBIBRASIL180726.FLP_DOCUMENTOS a1
             Inner Join MOBIBRASIL180726.T_ESC_PARAMFUNC a2 On a1.codintfunc = a2.cod_func
             Inner Join MOBIBRASIL180726.FLP_FUNCIONARIOS_COMPLEMENTAR c On a1.codintfunc = c.codintfunc
             Inner Join funcionario d On c.id_externo = d.idexterno
             Where a1.tipodocto = 'CNH'
                   And a1.dtdocto > Sysdate
                   And Not a1.dtdocto Is Null
            Union All
            
            Select d.ID As idfuncionario,
                   14 As tipo,
                   1 As bloquear,
                   a1.dtdocto As datahorainicio,
                   TO_DATE('31/12/2050', 'DD/MM/YYYY') As datahorafim
              From MOBIBRASIL180726.FLP_DOCUMENTOS a1
             Inner Join MOBIBRASIL180726.T_ESC_PARAMFUNC a2 On a1.codintfunc = a2.cod_func
             Inner Join MOBIBRASIL180726.FLP_FUNCIONARIOS_COMPLEMENTAR c On a1.codintfunc = c.codintfunc
             Inner Join funcionario d On c.id_externo = d.idexterno
             Where a1.tipodocto = 'CNH'
                   And a1.dtdocto > Sysdate
                   And Not a1.dtdocto Is Null)