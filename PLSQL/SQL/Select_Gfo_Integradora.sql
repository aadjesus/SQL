Select Linha.Codintlinha Codintlinha
      ,To_Number(Decode(Veic.Codigo_Globus, 0, Null, Veic.Codigo_Globus)) Codigoveic
      ,Local.Cod_Localidade Cod_Localidade
      ,i.*
  From Gfo_Integradora  i
      ,t_Arr_Param_Prdt Veic
      
      ,(Select Linha.*
              ,Oper.Id_Empresa Tipo_Deteccao
          From Bgm_Cadlinhas                Linha
              ,Gfo_Operadora_Empresa_Filial Oper        
         Where Not Linha.Codigoimportacao Is Null
           And Linha.Codigoempresa = Oper.Codigoempresa
           And Linha.Codigofl = Oper.Codigofl
           And Oper.Cod_Operadora = 1) Linha
       
      ,(Select Distinct Local.Cod_Localidade
                       ,Local.Codigo_Integracao
                       ,Oper.Id_Empresa Tipo_Deteccao        
          From t_Esc_Localidade             Local
              ,Gfo_Locais_Empresafilial     Emp
              ,Gfo_Operadora_Empresa_Filial Oper        
         Where Not Local.Codigo_Integracao Is Null
           And Local.Cod_Localidade = Emp.Cod_Localidade
           And Emp.Codigoempresa = Oper.Codigoempresa
           And Emp.Codigofl = Oper.Codigofl
           And Oper.Cod_Operadora = 1) Local       
      ,Frt_Cadveiculos v

 Where Trim(i.Veiculo_Externo) = Trim(Veic.Codigo_Spark)
   And Veic.Tipo = 'V'
   And v.Codigoveic = Veic.Codigo_Globus
   And To_Char(i.Tipo_Deteccao) = Linha.Tipo_Deteccao(+)
   And Trim(i.Linha_Externo) = Trim(Linha.Codigoimportacao(+))
   And To_Char(i.Tipo_Deteccao) = Local.Tipo_Deteccao(+)
   And Trim(i.Local_Externo) = Trim(Local.Codigo_Integracao(+))
   And i.Integrado <> 'S'
   And i.Cod_Operadora = 1
   And i.Data_Ocorrencia Between
       To_Date('23/08/2011 21:00:00', 'DD/MM/YYYY HH24:MI:SS') And
       To_Date('23/08/2011 22:00:00', 'DD/MM/YYYY HH24:MI:SS')