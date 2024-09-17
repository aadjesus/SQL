PL/SQL Developer Test script 3.0
19
Create Or Replace Procedure Teste_trigger Is
    v_cod_intescala Number;  
BEGIN

  --insert into GRANELEIRO211201.CTR_MENUSAOUSUARIO (usuario, sistema, indicemenu, nome ) values ()
  BEGIN
  
    update CTR_MENUSAOUSUARIO
       set nome = 'CancelamentodeDocumentos'
     where usuario = 'GLOBUS7'
       and sistema = 'CGS'
       and indicemenu = '020030';
  
  EXCEPTION
    WHEN OTHERS THEN
      RETURN;
  END;

end;
0
0
