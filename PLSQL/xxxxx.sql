   select xmlsTerceiros.ID_NFE_CTE
        , xmlsTerceiros.serie
        , xmlsTerceiros.numero
        , xmlsTerceiros.dataEmissao
        , xmlsTerceiros.dataGerou
        , xmlsTerceiros.CHAVEDEACESSO
        , xmlsTerceiros.TIPO_NOTA
        , xmlsTerceiros.conferido
        , xmlsTerceiros.CONTEUDO_CLOB
        , xmlsTerceiros.conteudoXml
        , xmlsTerceiros.CODINTNF_ESFNF
        , xmlsTerceiros.CODINTNF_BGMNF
        , xmlsTerceiros.sistema
        
        , nfeTurismoEntradaCteOs.CODINTNF         
        , nfeTurismoEntradaCteOs.VALORTOTALNF
        
        , nfeTurismoEntradaEsf.codigoEmpresa
        , nfeTurismoEntradaEsf.ICMSVALORENTRA
        , nfeTurismoEntradaEsf.IPIVALORENTRA
        
        , esfFilialEsfEntrada.CODIGOEMPRESA,esfFilialEsfEntrada.CODIGOFL,esfFilialEsfEntrada.RSOCIALEMPRESA, esfFilialEsfEntrada.INSCRICAOEMPRESA, esfFilialEsfEntrada.NOMEFANTASIAEMPRESA
        , esfFilialTurismo.CODIGOEMPRESA,esfFilialTurismo.CODIGOFL,esfFilialTurismo.RSOCIALEMPRESA, esfFilialTurismo.INSCRICAOEMPRESA, esfFilialTurismo.NOMEFANTASIAEMPRESA
        
                
from BGM_XML_TERCEIROS        xmlsTerceiros
left join TUR_NOTAFISCAL      nfeTurismoEntradaCteOs on xmlsTerceiros.CODINTNF_BGMNF = nfeTurismoEntradaCteOs.CODINTNF
left join ESFENTRA            nfeTurismoEntradaEsf on nfeTurismoEntradaCteOs.CODDOCTOESF = nfeTurismoEntradaEsf.CODDOCTOESF
left join VW_FILIAL           esfFilialEsfEntrada on nfeTurismoEntradaEsf.codigoempresa = esfFilialEsfEntrada.CODIGOEMPRESA and nfeTurismoEntradaEsf.codigofl = esfFilialEsfEntrada.CODIGOFL
left join VW_FILIAL           esfFilialTurismo on nfeTurismoEntradaCteOs.codigoempresa = esfFilialTurismo.CODIGOEMPRESA and nfeTurismoEntradaCteOs.codigofl = esfFilialTurismo.CODIGOFL
left join BGM_NFINTEGRACAOESF bgmNotaFiscal
          
--select  nfeTurismoEntradaCteOs.CODINTNF, nfeTurismoEntradaCteOs.VALORTOTALNF from TUR_NOTAFISCAL b
--select  nfeTurismoEntradaEsf.codigoEmpresa,nfeTurismoEntradaEsf.ICMSVALORENTRA,nfeTurismoEntradaEsf.IPIVALORENTRA from ESFENTRA c
--select esfFilialEsfEntrada.CODIGOEMPRESA,esfFilialEsfEntrada.CODIGOFL,esfFilialEsfEntrada.RSOCIALEMPRESA, esfFilialEsfEntrada.INSCRICAOEMPRESA, esfFilialEsfEntrada.NOMEFANTASIAEMPRESA from VW_FILIAL d
--
