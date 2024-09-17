create or replace trigger Atualiza_bgm_velocimetro
after insert on bgm_velocimetro for each row 
declare
  vCODIGOEMPRESA NUMBER(3);
  vCODIGOFL NUMBER(3);
begin
  vCODIGOEMPRESA := 0 ; 
  vCODIGOFL := 0 ; 
  begin
    SELECT 
       codigoempresaorigem
      ,codigoflorigem  
    INTO
       vCODIGOEMPRESA
      ,vCODIGOFL
    FROM
      frt_transferenciaveic
    WHERE
          CODIGOVEIC    = :NEW.codigoveic 
      and datatransveic = :NEW.dataveloc ;
  EXCEPTION 
    WHEN OTHERS THEN
      SELECT 
         codigoempresa
        ,codigofl
      INTO
         vCODIGOEMPRESA
        ,vCODIGOFL
      FROM
        frt_cadveiculos
      WHERE
        CODIGOVEIC = :NEW.codigoveic ;  
  end;    

  UPDATE bgm_velocimetro SET 
     codigoempresa = vCODIGOEMPRESA
    ,codigofl = vCODIGOFL
  WHERE 
    CodigoVeic = :NEW.CodigoVeic 
  And dataveloc = :NEW.dataveloc   
  and sequenciaveloc = :NEW.sequenciaveloc 
  and seqveloc = :NEW.seqveloc ;
  
end Atualiza_bgm_velocimetro;
