create or replace trigger UPDATE_bgm_velocimetro
-- after insert on bgm_velocimetro_tmp for each row
instead of on bgm_velocimetro_tmp for each row
begin
  UPDATE bgm_velocimetro SET 
     codigoempresa = :NEW.CODIGOEMPRESA
    ,codigofl = :NEW.CODIGOFL
  WHERE 
        CodigoVeic = :NEW.CodigoVeic 
    and CODIGOVEIC	 = :NEW.CODIGOVEIC	
    and DATAVELOC	 = :NEW.DATAVELOC	
    and SEQUENCIAVELOC	= :NEW.SEQUENCIAVELOC	
    and HORAVELOC	= :NEW.HORAVELOC	
    and SEQVELOC	= :NEW.SEQVELOC	
    ;  
end UPDATE_bgm_velocimetro;
/
