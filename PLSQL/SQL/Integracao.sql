----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ConsultarCotacaoJob

SELECT SV.NRCOTA             
     , SV.GRPCOMPRA          
     , SV.CODIGOFORN         
     , SV.ACAO               
     , SV.STATUS             
     , SV.VISIVEL_TODOS_FORN 
     , FL.CODIGOEMPRESA      
     , FL.CODIGOFL           
     , SV.PUBLICA            
     , SV.USUARIO            
     , EP.INSCRICAOEMPRESA   
  FROM CPR_SERV_G4_G7 SV, CTR_FILIAL FL, CTR_EMPAUTORIZADAS EP
 WHERE SV.CODIGOEMPRESA = FL.CODIGOEMPRESA
   AND SV.CODIGOFL = FL.CODIGOFL
   AND EP.CODINTEMPAUT = FL.CODINTEMPAUT
   AND SV.ACAO = 2
   AND SV.NRCOTA = 90759

--select * from CPR_SERV_G4_G7 where ACAO = 2 and NRCOTA = 90759
--select * from Cpr_Serv_G4_G7_Log where ACAO = 2 and NRCOTA = 90759
--update CPR_SERV_G4_G7 set STATUS = 'X' where ACAO = 2 and NRCOTA in ( 90759)

/*

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- fechar cotacao

SELECT SV.NRCOTA,
       SV.GRPCOMPRA,
       SV.CODIGOFORN,
       SV.ACAO,
       SV.STATUS,
       SV.VISIVEL_TODOS_FORN,
       FL.CODIGOEMPRESA,
       FL.CODIGOFL,
       SV.PUBLICA,
       SV.USUARIO,
       EP.INSCRICAOEMPRESA
  FROM CPR_SERV_G4_G7 SV
     , CTR_FILIAL FL
     , CTR_EMPAUTORIZADAS EP
 WHERE SV.CODIGOEMPRESA = FL.CODIGOEMPRESA
   AND SV.CODIGOFL = FL.CODIGOFL
   AND EP.CODINTEMPAUT = FL.CODINTEMPAUT
   AND SV.ACAO = 3
--   AND SV.STATUS = 'X'
   and SV.NRCOTA in ( 90753)


--select * from CPR_SERV_G4_G7 where ACAO = 3 and NRCOTA = 90753
--select * from Cpr_Serv_G4_G7_Log where ACAO = 3 and NRCOTA = 90753
--update CPR_SERV_G4_G7 set STATUS = 'X' where ACAO = 3 and NRCOTA in ( 90753)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Autlizar pedido

SELECT SV.NUMEROPEDIDO,
       SV.ACAO,
       SV.STATUS,
       SV.USUARIO,
       PD.CODIGOEMPRESA,
       PD.CODIGOFL,
       (CASE  WHEN US.USUARIO IS NULL THEN PD.USUARIOGEROUPEDIDO ELSE US.NOMEUSUARIO END) as "UsuarioGerouPedido"
  FROM CPR_SERV_G4_G7_PED     SV,
       CPR_PEDIDOCOMPRAS      PD,
       CTR_CADASTRODEUSUARIOS US
 WHERE SV.NUMEROPEDIDO = PD.NUMEROPEDIDO
   AND PD.USUARIOGEROUPEDIDO = US.USUARIO(+)
   and SV.numeropedido = 206854  
   AND SV.ACAO = 12
   AND SV.STATUS = 'X'
   


SELECT B.INSCRICAOEMPRESA    
     , A.EMAILFL             
     , A.IESTADUALFL         
     , A.INSCMUNICIPALFL     
     , B.NOMEFANTASIAEMPRESA 
     , B.RSOCIALEMPRESA      
     , A.CODIGOEMPRESA       
     , A.CODIGOFL            
  FROM CTR_FILIAL A
     , CTR_EMPAUTORIZADAS B
 WHERE A.CODINTEMPAUT = B.CODINTEMPAUT
   AND A.CODIGOEMPRESA = 1
   AND A.CODIGOFL = 1
   
--   61318333000158


select a.*,rowid from CPR_PARAMINTEGRACAOGL4GL7 a    -- T3EXHU4LW5RJ8P7V

select * from CPR_SERV_G4_G7_LOG_PED where acao = 12 and numeropedido = 206854   
select * from CPR_SERV_G4_G7_PED where acao = 12 and numeropedido = 206854   

update CPR_SERV_G4_G7_PED set status = 'X' where acao = 12 and numeropedido = 206854   

*/