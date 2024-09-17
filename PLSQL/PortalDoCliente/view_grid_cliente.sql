create or replace view view_grid_cliente as
SELECT CLI.CODCLIENTE AS COD_CLIENTE,
       NOMEFANTASIACLIENTE AS NOME_FANTASIA,
       CNPJCLIENTE AS CNPJ,
       CODGRUPOEMP AS COD_GRUPO_EMPRESA,
       RAZAOSOCIALCLIENTE AS RAZAO_SOCIAL,
       ATIVOCLIENTE AS ATIVO,
       RUACLIENTE AS RUA,
       NUMEROCLIENTE AS NUMERO,
       CIDADECLIENTE AS CIDADE,
       CODUFENDERECO AS COD_UF_ENDERECO,
       CEPCLIENTE AS CEP,
       EMAILCLIENTE AS EMAIL,
       ID_SLA AS ID_SLA,
       decode(nvl(atend_usuariochave, 'N'), 'N', 0, 'S', 1) as atend_usuariochave,
       decode(criticocliente, 'N', 0, 'S', 1) as cliente_critico,
       decode(globus_cloud, 'N', 0, 'S', 1) as globus_cloud,
       (select count(classificacaogrupo)
          from sii_grupoempresa
         where classificacaogrupo = '5'
           and codgrupoemp = CLI.codgrupoemp) as cliente_vip,
       (select classificacaogrupo
          from sii_grupoempresa
         where codgrupoemp = CLI.codgrupoemp) as curva_abc,
        CON.codcontrato AS cod_contrato,
        CON.tipocontrato AS tipo_contrato,
        CON.DATACONTRATO AS data_contrato

  FROM SII_CLIENTE CLI

  left join sii_contrato CON
  on CLI.codcliente = CON.codcliente
     and CON.ativocontrato = 'A'