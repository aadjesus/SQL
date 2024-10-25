-- 1
//If ((not vFiltraUsuariosGaragem) and (not vFiltraUsuGar_CadEmp)) or
//    (vNuncaFiltraGaragemPorUsu) or (vcAplicacao.Usuario = 'GLOBUS') Or
//    (vcAplicacao.Usuario = 'MANAGER') Or (NaoValidaUsuario) Then
//  Não consiste pelo grupo

  SELECT CTR_GARAGEM.CODIGOGA
       , CTR_GARAGEM.NOMEGA 
    FROM CTR_GARAGEM
       , CTR_FILIAL_GAR 
   WHERE CTR_FILIAL_GAR.ATIVO         = 'S' 
     AND CTR_FILIAL_GAR.CODIGOEMPRESA = 1
     AND CTR_FILIAL_GAR.CODIGOFL      = 1
     AND CTR_GARAGEM.CODIGOGA         = CTR_FILIAL_GAR.CODIGOGA 
ORDER BY CTR_GARAGEM.CODIGOGA;

-- 2
    SELECT CTR_GARAGEM.CODIGOGA
         , CTR_GARAGEM.NOMEGA 
      FROM CTR_GARAGEM
         , CTR_FILIAL_GAR
         , CTR_FILIAL          F
         , CGS_ACESSOSUSUARIOS U 
     WHERE CTR_FILIAL_GAR.ATIVO         = 'S' 
       AND CTR_FILIAL_GAR.CODIGOEMPRESA = 1
       AND CTR_FILIAL_GAR.CODIGOFL      = 1
       AND CTR_GARAGEM.CODIGOGA         = CTR_FILIAL_GAR.CODIGOGA 
       AND F.CODIGOEMPRESA              = CTR_FILIAL_GAR.CODIGOEMPRESA 
       AND F.CODIGOFL                   = CTR_FILIAL_GAR.CODIGOFL 
       AND U.CODIGOEMPRESA              = CTR_FILIAL_GAR.CODIGOEMPRESA 
       AND U.CODIGOFL                   = CTR_FILIAL_GAR.CODIGOFL 
       AND U.CODIGOGA                   = CTR_FILIAL_GAR.CODIGOGA 
       AND U.USUARIO                    = 'ABINALDO'

 UNION ALL 

      SELECT CTR_GARAGEM.CODIGOGA
           , CTR_GARAGEM.NOMEGA 
        FROM CTR_GARAGEM
           , CTR_FILIAL_GAR
           , CTR_FILIAL F
           , CTR_USUARIOSPOREMPFILGAR U 
       WHERE CTR_FILIAL_GAR.ATIVO         = 'S' 
         AND CTR_FILIAL_GAR.CODIGOEMPRESA = 1
         AND CTR_FILIAL_GAR.CODIGOFL      = 1
         AND CTR_GARAGEM.CODIGOGA         = CTR_FILIAL_GAR.CODIGOGA 
         AND F.CODIGOEMPRESA              = CTR_FILIAL_GAR.CODIGOEMPRESA 
         AND F.CODIGOFL                   = CTR_FILIAL_GAR.CODIGOFL 
         AND U.CODIGOEMPRESA              = CTR_FILIAL_GAR.CODIGOEMPRESA 
         AND U.CODIGOFL                   = CTR_FILIAL_GAR.CODIGOFL 
         AND U.CODIGOGA                   = CTR_FILIAL_GAR.CODIGOGA 
         AND U.USUARIO                    = 'ABINALDO'
    ORDER BY CODIGOGA;
