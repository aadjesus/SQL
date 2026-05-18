-- codModelo == '
select '57_E;55_E;67_E' AS codModelo
     , a.ID_NFE_CTE        as ID
     , b.CODIGOEMPRESA     as empresa
     , b.CODIGOFL          as filial
     , b.RSOCIALEMPRESA    AS RSOCIAL
     , b.INSCRICAOEMPRESA  AS INSCRICAO     
     , a.dataemissao       as data_emissao
     , to_char(a.numero)   as numero     
     , to_char(a.serie)    as serie
     , a.SISTEMA     
     , a.chavedeacesso
     , a.conferido
     , a.etapa_importacao
     , a.CONTEUDOXML               AS CONTEUDO_XML     
  from BGM_XML_TERCEIROS a
LEFT JOIN VW_FILIAL  b on a.empresa = b.CODIGOEMPRESA and a.filial = b.CODIGOFL
WHERE ROWNUM = 1
------------------------------------------------------------------------------------------------------------------------------------
union all
select '63_E' as codModelo
     , a.ID
     , b.CODIGOEMPRESA     as empresa
     , b.CODIGOFL          as filial
     , b.RSOCIALEMPRESA    AS RSOCIAL
     , b.INSCRICAOEMPRESA  AS INSCRICAO     
     , a.data_emissao
     , a.numero
     , a.serie
     , a.SISTEMA     
     , a.chavedeacesso
     , a.conferido
     , a.etapa_importacao
     , null as CONTEUDO_XML
  from ESF_DOCUMENTO_ELETRONICO a
    LEFT JOIN VW_FILIAL  b on a.empresa = b.CODIGOEMPRESA and a.filial = b.CODIGOFL 
WHERE ROWNUM = 1
------------------------------------------------------------------------------------------------------------------------------------
union all
select '67_S' as codModelo
     , a.ID_CTE            as ID
     , b.CODIGOEMPRESA     as empresa
     , b.CODIGOFL          as filial
     , b.RSOCIALEMPRESA    AS RSOCIAL
     , b.INSCRICAOEMPRESA  AS INSCRICAO     
     , a.data_emissao
     , to_char(a.ID_DOCUMENTO) as numero     
     , '' as serie
     , a.SISTEMA
     , a.CHAVE_DE_ACESSO as chavedeacesso
     , a.conferido
     , a.etapa_importacao
     , a.CONTEUDO                 AS CONTEUDO_XML
  from BGM_CTE_OS a
    LEFT JOIN VW_FILIAL  b on a.empresa = b.CODIGOEMPRESA and a.filial = b.CODIGOFL   
WHERE ROWNUM = 1
------------------------------------------------------------------------------------------------------------------------------------
union all
select '55_S' as codModelo
     , a.ID_NFE            as ID
     , b.CODIGOEMPRESA     as empresa
     , b.CODIGOFL          as filial
     , b.RSOCIALEMPRESA    AS RSOCIAL
     , b.INSCRICAOEMPRESA  AS INSCRICAO     
     , a.dataemissao as data_emissao
     , to_char(a.NUMERONFE) as numero     
     , '' as serie
     , a.SISTEMA     
     , a.chavedeacesso
     , a.conferido     
     , a.etapa_importacao
     , a.CONTEUDONF               AS CONTEUDO_XML
  from BGM_NOTAFISCAL_ELETRONICA a
    LEFT JOIN VW_FILIAL  b on a.empresa = b.CODIGOEMPRESA and a.filial = b.CODIGOFL     
WHERE ROWNUM = 1
------------------------------------------------------------------------------------------------------------------------------------
union all
SELECT '63_S' as codModelo
     , a.ID
     , c.CODIGOEMPRESA     as empresa
     , c.CODIGOFL          as filial
     , c.RSOCIALEMPRESA    AS RSOCIAL
     , c.INSCRICAOEMPRESA  AS INSCRICAO     
     , a.DATA_ENVIO as data_emissao
     , to_char(a.NUMERO_NFSE_GERADO) as numero     
     , a.SERIE_RPS
     , a.MODULO as SISTEMA     
     , CODIGO_VERIFICACAO as chavedeacesso
     , a.conferido
     , a.etapa_importacao
     , null as CONTEUDO_XML
 FROM BGM_INTEGRADOR_NFSE a
LEFT JOIN ESFISS     b ON a.NUMERO_NFSE_GERADO = b.DOCUMENTOINI
LEFT JOIN VW_FILIAL  c on b.CODIGOEMPRESA = c.CODIGOEMPRESA and b.CODIGOFL = c.CODIGOFL      
WHERE ROWNUM = 1
------------------------------------------------------------------------------------------------------------------------------------
union all
select '57_S' as codModelo
     , a.ID_CTE            as ID
     , b.CODIGOEMPRESA     as empresa
     , b.CODIGOFL          as filial
     , b.RSOCIALEMPRESA    AS RSOCIAL
     , b.INSCRICAOEMPRESA  AS INSCRICAO     
     , a.data_emissao
     , to_char(a.CONHECIMENTO) as numero          
     , a.serie
     , a.SISTEMA     
     , a.chavedeacesso
     , a.conferido
     , a.etapa_importacao
     , a.CONTEUDO                AS CONTEUDO_XML
FROM BGM_CTRC_ELETRONICO a    
    LEFT JOIN VW_FILIAL  b on a.empresa = b.CODIGOEMPRESA and a.filial = b.CODIGOFL
WHERE ROWNUM = 1