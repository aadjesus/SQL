create or replace function Tras_Dados_Para_Painel(pCodigoEmpresa number, 
                                                  pCodigoFilial  number, 
                                                  pCodigoPainel  Number) Return String Is
begin
  BEGIN
    SELECT DATAFERIADO 
      INTO vResult 
      FROM FINFERIA_EMPRESAFILIAL
     WHERE (DATAFERIADO = pData) 
       AND (CODIGOEMPRESA = pEmpresa) 
       AND (CODIGOFL = pFilial);
       
    Select *
      From Gfo_Painel a
     Where a.Codigoempresa = pCodigoEmpresa
       And a.Codigofl      = pCodigoFilial
       And a.Cod_Painel    = pCodigoPainel
       
  EXCEPTION
  WHEN OTHERS THEN
    vResult := Null;
  END;
  RETURN(vResult);                                                  

end;

/

/*
CREATE OR REPLACE FUNCTION BUSCAFERIADO(pData DATE, pEmpresa NUMBER, pFilial NUMBER)
  RETURN DATE IS
  vResult DATE;
BEGIN
  BEGIN
    SELECT DATAFERIADO INTO vResult FROM FINFERIA_EMPRESAFILIAL
    WHERE (DATAFERIADO = pData) AND (CODIGOEMPRESA = pEmpresa) AND (CODIGOFL = pFilial);
  EXCEPTION
  WHEN OTHERS THEN
    vResult := Null;
  END;
  RETURN(vResult);
END;
*/