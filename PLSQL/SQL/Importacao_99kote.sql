--select * from CPR_PARAMINTEGRACAOGL4GL7
--update CPR_PARAMINTEGRACAOGL4GL7 set idclient = 'GLOBUS_000543', senha = 'T3EXHU4LW5RJ8P7V'
--update CPR_PARAMINTEGRACAOGL4GL7 set idclient = 'API_NNKOTE', senha = 'secret'

--Incluir usuario ---------------------------------------------------------------------------------------------------------------------
--select a.*,rowid from CPR_SERV_G4_G7_USU a
--update CPR_SERV_G4_G7_USU set status = 'X' where acao = 9 and nrinscricao = '38864318003';  

--Alterar usuario ---------------------------------------------------------------------------------------------------------------------
--select a.*,rowid from CPR_SERV_G4_G7_USU a
--update CPR_SERV_G4_G7_USU set status = 'X' where acao = 10 and nrinscricao = '38864318003'; 

--Excluir logs 
--select * from CPR_SERV_G4_G7_LOG_USU b where trunc(b.datahoraenvio) = trunc(sysdate) order by b.datahoraenvio
--delete CPR_SERV_G4_G7_LOG_USU b where trunc(b.datahoraenvio) = trunc(sysdate)

--situacao usu ---------------------------------------------------------------------------------------------------------------------
--select * from CPR_G7_VALIDARUSUARIO where nrinscricao = '38864318003'; 
--update CPR_G7_VALIDARUSUARIO set status = 'X' where nrinscricao = '38864318003'; 
--select * from Cpr_G7_Validarusuario_Log where nrinscricao = '38864318003'; 
--delete Cpr_G7_Validarusuario_Retorno where nrinscricao = '38864318003'; 
--delete Cpr_G7_Validarusuario_Log where nrinscricao = '38864318003'; 

--enviar cotacao ---------------------------------------------------------------------------------------------------------------------
--SELECT * FROM CPR_SERV_G4_G7 SV WHERE acao = 1 and nrcota = 90753 
--SELECT * FROM CPR_SERV_G4_G7_LOG where trunc(datahoraenvio) = trunc(sysdate)
--update CPR_SERV_G4_G7 set status = 'X' WHERE acao = 1 and nrcota = 90753 
--delete CPR_SERV_G4_G7_LOG where trunc(datahoraenvio) = trunc(sysdate)

--select a.*,rowid from CPR_COTACAO_GLB7 a where nrcota = 90753 

--enviar pedido ---------------------------------------------------------------------------------------------------------------------
--SELECT * FROM CPR_SERV_G4_G7_PED where numeropedido = 206856
--SELECT * FROM CPR_SERV_G4_G7_PED where numeropedido = 206853

--SELECT * FROM CPR_SERV_G4_G7_LOG_PED where trunc(datahoraenvio) = trunc(sysdate)

--update CPR_SERV_G4_G7_PED set status = 'X' WHERE acao = 5 and numeropedido = 206853
 
--select * from cpr_pedidocompras

select * from CPR_PEDIDOCOMPRAS where numeropedido = 206853