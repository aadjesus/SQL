-- 1
--//  if (Usuario = GLOBUS) or (Usuario = MANAGER) or (NaoValidaUsuario) then // Não consiste pelo grupo
SELECT E.CODIGOEMPRESA
     , A.RSOCIALEMPRESA
     , A.CHECKSUMEMPRESA
     , A.CODINTEMPAUT
     , A.INSCRICAOEMPRESA
     , A.NOMEFANTASIAEMPRESA
     , C.SISTEMA
  FROM CTR_CADEMP              E
     , CTR_EMPAUTORIZADAS      A
     , CTR_AUTORIZACAOSISTEMAS C
 WHERE E.CODINTEMPAUT = A.CODINTEMPAUT
   AND E.CODINTEMPAUT = C.CODINTEMPAUT
   AND C.SISTEMA = 'ACD'
 ORDER BY E.CODIGOEMPRESA;
 

-- 2
--    //se trabalha com filtro de usuário por empresa
--    if (vFiltraUsuEmp_CadEmp) and (Pos(Sistema, ,FLP,FRQ,SRH,ATF,CPG,CRC,CTB,BCO,ESF,) <= 0) then  // SIM 34702 
SELECT DISTINCT 
       E.CODIGOEMPRESA
     , A.RSOCIALEMPRESA
     , A.CHECKSUMEMPRESA
     , A.CODINTEMPAUT
     , A.INSCRICAOEMPRESA
     , A.NOMEFANTASIAEMPRESA
     , C.SISTEMA
  FROM CTR_CADEMP               E
     , CTR_EMPAUTORIZADAS       A
     , CTR_AUTORIZACAOSISTEMAS  C 
 WHERE E.CODIGOEMPRESA IN (SELECT DISTINCT E.CODIGOEMPRESA
                             FROM CTR_CADEMP               E
                                , CTR_EMPAUTORIZADAS       A
                                , CTR_AUTORIZACAOSISTEMAS  C
                                , CTR_USUARIOSPOREMPFILGAR U
                            WHERE E.CODINTEMPAUT  = A.CODINTEMPAUT
                              AND E.CODINTEMPAUT  = C.CODINTEMPAUT
                              AND E.CODIGOEMPRESA = U.CODIGOEMPRESA
                              AND C.SISTEMA       = 'ACD'
                              AND U.USUARIO       = 'ABINALDO')
   AND C.SISTEMA      = 'ACD'
   AND E.CODINTEMPAUT = A.CODINTEMPAUT
 ORDER BY E.CODIGOEMPRESA;
 
-- 3 
-- if (not pIgnoraPermissaoUsuario) then
SELECT DISTINCT 
       E.CODIGOEMPRESA
     , A.RSOCIALEMPRESA
     , A.CHECKSUMEMPRESA
     , A.CODINTEMPAUT
     , A.INSCRICAOEMPRESA
     , A.NOMEFANTASIAEMPRESA
     , C.SISTEMA
  FROM CTR_CADEMP              E
     , CTR_EMPAUTORIZADAS      A
     , CTR_AUTORIZACAOSISTEMAS C
 WHERE E.CODIGOEMPRESA IN      
       (SELECT DISTINCT F.CODIGOEMPRESA
          FROM CTR_FILIAL              F
             , CTR_EMPAUTORIZADAS      A
             , CTR_AUTORIZACAOSISTEMAS C
             , CTR_CADASTRODEUSUARIOS  CADU
             , CTR_AUTORIZACAOUSUARIOS AU
             , CTR_GRUPOUSUARIOS       GU 
         WHERE F.CODINTEMPAUT  = AU.CODINTEMPAUT
           AND AU.CODIGOGRPUSU = CADU.CODIGOGRPUSU
           AND GU.CODIGOGRPUSU = CADU.CODIGOGRPUSU
           AND F.CODINTEMPAUT  = A.CODINTEMPAUT
           AND F.CODINTEMPAUT  = C.CODINTEMPAUT
           AND C.SISTEMA       = 'ACD'
           AND CADU.USUARIO    = 'ABINALDO')
   AND C.SISTEMA      = 'ACD'
   AND E.CODINTEMPAUT = A.CODINTEMPAUT
 ORDER BY E.CODIGOEMPRESA;
 
--4 
-- if (pIgnoraPermissaoUsuario) then
SELECT DISTINCT 
       E.CODIGOEMPRESA
     , A.RSOCIALEMPRESA
     , A.CHECKSUMEMPRESA
     , A.CODINTEMPAUT
     , A.INSCRICAOEMPRESA
     , A.NOMEFANTASIAEMPRESA
     , C.SISTEMA
  FROM CTR_CADEMP               E
     , CTR_EMPAUTORIZADAS       A
     , CTR_AUTORIZACAOSISTEMAS  C
 WHERE E.CODIGOEMPRESA IN (SELECT DISTINCT 
                                  F.CODIGOEMPRESA
                             FROM CTR_FILIAL              F
                                , CTR_EMPAUTORIZADAS      A
                                , CTR_AUTORIZACAOSISTEMAS C
                                , CTR_CADASTRODEUSUARIOS  CADU
                            WHERE F.CODINTEMPAUT = A.CODINTEMPAUT
                              AND F.CODINTEMPAUT = C.CODINTEMPAUT
                              AND C.SISTEMA      = 'ACD'
                              AND CADU.USUARIO   = 'ABINALDO')
   AND C.SISTEMA      = 'ACD'
   AND E.CODINTEMPAUT = A.CODINTEMPAUT
 ORDER BY E.CODIGOEMPRESA