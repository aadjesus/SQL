/*

regra para carga incial 
      CONDICAOOS               = 'AB'
      SERVICOINTEXTOS          = 'I'
      nvl(FECHAMENTO_MANU,'N') = 'N'
      nvl(EXECUCAO_MANU,  'N') = 'N'
      dataaberturaos           = (sysdate-200)


         (nvl(:New.CONDICAOOS     ,'-')= 'FC' AND nvl(:Old.CONDICAOOS     ,'-') = 'FC') OR
         (nvl(:New.EXECUCAO_MANU  ,'-')= 'S'  AND nvl(:Old.EXECUCAO_MANU  ,'-') = 'S' ) OR
         (nvl(:New.FECHAMENTO_MANU,'-')= 'S'  AND nvl(:Old.FECHAMENTO_MANU,'-') = 'S' ) OR
         (nvl(:New.SERVICOINTEXTOS,'-')= 'E'  AND nvl(:Old.SERVICOINTEXTOS,'-') = 'E' ) OR
   
*/
Create Or Replace Trigger Teste_MAN_OS
  After Insert Or Update Or Delete On MAN_OS
  For Each Row
Declare
Begin
     IF (
	       (Updating AND
	        nvl(:New.CODINTOS             ,0)       = nvl(:Old.CODINTOS             ,0)       AND
		      nvl(:New.KMEXECUCAOOS         ,0)       = nvl(:Old.KMEXECUCAOOS         ,0)       AND
		      nvl(:New.CODIGOEMPRESA        ,0)       = nvl(:Old.CODIGOEMPRESA        ,0)       AND
		      nvl(:New.CODIGOFL             ,0)       = nvl(:Old.CODIGOFL             ,0)       AND
		      nvl(:New.CODIGOGA             ,0)       = nvl(:Old.CODIGOGA             ,0)       AND
		      nvl(:New.NUMEROOS             ,0)       = nvl(:Old.NUMEROOS             ,0)       AND
		      nvl(:New.CODIGOVEIC           ,0)       = nvl(:Old.CODIGOVEIC           ,0)       AND
		      nvl(:New.EXECUCAO_MANU        ,'-')     = nvl(:Old.EXECUCAO_MANU        ,'-')     AND
		      nvl(:New.CONDICAOOS           ,'-')     = nvl(:Old.CONDICAOOS           ,'-')     AND
		      nvl(:New.FECHAMENTO_MANU      ,'-')     = nvl(:Old.FECHAMENTO_MANU      ,'-')     AND
		      nvl(:New.TIPOOS               ,'-')     = nvl(:Old.TIPOOS               ,'-')     AND
		      nvl(:New.SERVICOINTEXTOS      ,'-')     = nvl(:Old.SERVICOINTEXTOS      ,'-')     AND
		      nvl(:New.DATAFECHAMENTOOS     ,sysdate) = nvl(:Old.DATAFECHAMENTOOS     ,sysdate) AND
		      nvl(:New.DATAABERTURAOS       ,sysdate) = nvl(:Old.DATAABERTURAOS       ,sysdate) AND
		      nvl(:New.DATARETORNOPROGRAMADO,sysdate) = nvl(:Old.DATARETORNOPROGRAMADO,sysdate) AND
		      nvl(:New.HORARETORNOPROGRAMADO,sysdate) = nvl(:Old.HORARETORNOPROGRAMADO,sysdate) AND
		      nvl(:New.PRAZOENTREGA1        ,sysdate) = nvl(:Old.PRAZOENTREGA1        ,sysdate) AND
		      nvl(:New.HORAENTREGA1         ,sysdate) = nvl(:Old.HORAENTREGA1         ,sysdate)))
     Then
         DBMS_OUTPUT.PUT_LINE('retorno');
         Return;
     End If;

     DBMS_OUTPUT.PUT_LINE('fim');
end;
