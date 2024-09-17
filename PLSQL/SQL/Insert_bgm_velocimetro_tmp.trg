create or replace trigger INSERT_bgm_velocimetro_tmp
after insert on bgm_velocimetro for each row
declare
  vCODIGOEMPRESA NUMBER(3); 
  vCODIGOFL NUMBER(3); 
begin
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
  
    INSERT INTO bgm_velocimetro_tmp
      (CODIGOVEIC,DATAVELOC,SEQUENCIAVELOC,HORAVELOC,SEQVELOC,CODIGOEMPRESA,CODIGOFL      )
    VALUES
     (:NEW.CODIGOVEIC,:NEW.DATAVELOC,:NEW.SEQUENCIAVELOC,:NEW.HORAVELOC,:NEW.SEQVELOC, vCODIGOEMPRESA, vCODIGOFL);            
  
end INSERT_bgm_velocimetro_tmp;
/
