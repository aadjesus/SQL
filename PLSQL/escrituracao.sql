-- codModelo == '
select '57_E;55_E;67_E' AS codModelo
     , b.CODIGOEMPRESA     as empresa
     , b.CODIGOFL          as filial
     , b.RSOCIALEMPRESA    AS RSOCIAL
     , b.INSCRICAOEMPRESA  AS INSCRICAO     
     , a.dataemissao       as data_emissao
     , to_char(a.numero)   as numero     
     , a.SISTEMA     
     , a.chavedeacesso
  from BGM_XML_TERCEIROS a
    LEFT JOIN VW_FILIAL  b on a.empresa = b.CODIGOEMPRESA and a.filial = b.CODIGOFL
WHERE ROWNUM = 1
------------------------------------------------------------------------------------------------------------------------------------
union all
select '63_E' as codModelo
     , b.CODIGOEMPRESA     as empresa
     , b.CODIGOFL          as filial
     , b.RSOCIALEMPRESA    AS RSOCIAL
     , b.INSCRICAOEMPRESA  AS INSCRICAO     
     , a.data_emissao
     , a.numero
     , a.SISTEMA     
     , a.chavedeacesso
  from ESF_DOCUMENTO_ELETRONICO a
    LEFT JOIN VW_FILIAL  b on a.empresa = b.CODIGOEMPRESA and a.filial = b.CODIGOFL 
WHERE ROWNUM = 1
------------------------------------------------------------------------------------------------------------------------------------
union all
select '67_S' as codModelo
     , b.CODIGOEMPRESA     as empresa
     , b.CODIGOFL          as filial
     , b.RSOCIALEMPRESA    AS RSOCIAL
     , b.INSCRICAOEMPRESA  AS INSCRICAO     
     , a.data_emissao
     , to_char(a.ID_DOCUMENTO) as numero     
     , a.SISTEMA
     , a.CHAVE_DE_ACESSO as chavedeacesso
  from BGM_CTE_OS a
    LEFT JOIN VW_FILIAL  b on a.empresa = b.CODIGOEMPRESA and a.filial = b.CODIGOFL   
WHERE ROWNUM = 1
------------------------------------------------------------------------------------------------------------------------------------
union all
select '55_S' as codModelo
     , b.CODIGOEMPRESA     as empresa
     , b.CODIGOFL          as filial
     , b.RSOCIALEMPRESA    AS RSOCIAL
     , b.INSCRICAOEMPRESA  AS INSCRICAO     
     , a.dataemissao as data_emissao
     , to_char(a.NUMERONFE) as numero     
     , a.SISTEMA     
     , a.chavedeacesso
  from BGM_NOTAFISCAL_ELETRONICA a
    LEFT JOIN VW_FILIAL  b on a.empresa = b.CODIGOEMPRESA and a.filial = b.CODIGOFL     
WHERE ROWNUM = 1
------------------------------------------------------------------------------------------------------------------------------------
union all
SELECT '63_S' as codModelo
     , c.CODIGOEMPRESA     as empresa
     , c.CODIGOFL          as filial
     , c.RSOCIALEMPRESA    AS RSOCIAL
     , c.INSCRICAOEMPRESA  AS INSCRICAO     
     , a.DATA_ENVIO as data_emissao
     , to_char(a.NUMERO_NFSE_GERADO) as numero     
     , a.MODULO as SISTEMA     
     , CODIGO_VERIFICACAO as chavedeacesso
 FROM BGM_INTEGRADOR_NFSE a
LEFT JOIN ESFISS     b ON a.NUMERO_NFSE_GERADO = b.DOCUMENTOINI
LEFT JOIN VW_FILIAL  c on b.CODIGOEMPRESA = c.CODIGOEMPRESA and b.CODIGOFL = c.CODIGOFL      
WHERE ROWNUM = 1
------------------------------------------------------------------------------------------------------------------------------------
union all
select '57_S' as codModelo
     , b.CODIGOEMPRESA     as empresa
     , b.CODIGOFL          as filial
     , b.RSOCIALEMPRESA    AS RSOCIAL
     , b.INSCRICAOEMPRESA  AS INSCRICAO     
     , a.data_emissao
     , to_char(a.CONHECIMENTO) as numero          
     , a.SISTEMA     
     , a.chavedeacesso
FROM BGM_CTRC_ELETRONICO a    
    LEFT JOIN VW_FILIAL  b on a.empresa = b.CODIGOEMPRESA and a.filial = b.CODIGOFL
WHERE ROWNUM = 1