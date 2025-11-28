--eTipoOperacao.ContasReceber = 10
--eTipoOperacao.Inclusao 		  = 0 
--eTipoOperacao.Atualizacao 	= 1

-- Consulta integracao 
UPDATE SFKMM_Integracao A 
   SET A.Etapa = 1
 WHERE RowNum        <= 999
   AND A.Data        >= sysdate-10
   AND A.NomeTabela   = 'ESFISS_NSTECH'
   AND A.TipoOperacao IN (10)
   AND A.Etapa       = 0
   AND EXISTS(SELECT 1
             FROM SFKMM_INTEGRACAO B
            WHERE A.VALORESPK    = B.VALORESPK
              AND B.NOMETABELA   = A.NOMETABELA
              AND B.ETAPA        = 2
              AND B.TIPOOPERACAO IN (0, 1))
------------------------------------------------------------------------------
-- Consulta para o envio
    SELECT A.ID AS ID_INTEGRACAO
         , D.CODIGOEMPRESA         
         , D.NRODOCTOCRC
         , D.EMISSAOCRC
         , D.OBSDOCTOCRC
         , D.SERIEDOCTOCRC
         , D.NROPARCELACRC
         , FC_CRC_VLRLIQUIDO(D.CODDOCTOCRC) AS VALOR_AMORTIZACAO
         , D.VENCIMENTOCRC
         , DECODE(F.NOMETABELA, NULL, 0, 1) AS ENVIOU_NF
         , DECODE(C.COD_ORGANOGRAMA_RATEIO, NULL, E.COD_ORGANOGRAMA, C.COD_ORGANOGRAMA_RATEIO) AS COD_ORGANOGRAMA
         , DECODE(C.CODORGANIZACIONAL_RATEIO, NULL, E.CODORGANIZACIONAL, C.CODORGANIZACIONAL_RATEIO) AS CODORGANIZACIONAL
      FROM SFKMM_INTEGRACAO  A
INNER JOIN ESFISS_NSTECH     B ON A.VALORESPK        = B.ID
INNER JOIN ESFISS            C ON B.ID               = C.CODISSINT
INNER JOIN CRCDOCTO          D ON C.CODDOCTOCRC      = D.CODDOCTOCRC
INNER JOIN CTRFAT_PARAMETROS E ON C.CODIGOEMPRESA    = E.CODIGOEMPRESA
                              AND C.CODIGOFL         = E.CODIGOFL  
                              AND C.TIPO_FATURAMENTO = E.TIPO_FATURAMENTO
 LEFT JOIN SFKMM_INTEGRACAO  F ON C.CODISSINT        = F.VALORESPK 
                              AND F.NOMETABELA       = 'ESFISS_NSTECH' 
                              AND F.ETAPA            = 2
                              AND F.TIPOOPERACAO     IN (0,1)
     WHERE A.NOMETABELA    = 'ESFISS_NSTECH' 
       AND A.ETAPA         = 1
       AND A.TIPOOPERACAO  = 10
       AND D.CODIGOEMPRESA = 2
  ORDER BY A.DATA              