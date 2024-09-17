create or replace procedure Atualiza_bgm_velocimetro
Is
  vDataIni  date;
  vDataFin  date;

  Cursor Veic Is
    select 
       codigoveic
      ,codigoempresa
      ,codigofl
    from 
      frt_cadveiculos ;

  Cursor Transf(pCodigoVeic Integer) Is 
    select 
       codigoveic
      ,datatransveic
      ,codigoempresaorigem
      ,codigoflorigem
    from 
      frt_transferenciaveic 
    Where
      CodigoVeic = pCodigoVeic ;
      
begin
  For Item_Veic in veic Loop
    
    For Item_Transf in Transf(Item_Veic.CodigoVeic) Loop
      vDataIni := Item_Transf.datatransveic ;
      if vDataFin = null then
        UPDATE
          bgm_velocimetro
        SET
           codigoempresa = Item_Transf.codigoempresaorigem
          ,codigofl = Item_Transf.codigoflorigem
        WHERE
              CODIGOVEIC = Item_Transf.codigoveic
          and dataveloc <= vDataIni 
          and codigoempresa is null;
       else
        UPDATE
          bgm_velocimetro
        SET
           codigoempresa = Item_Transf.codigoempresaorigem
          ,codigofl = Item_Transf.codigoflorigem
        WHERE
              CODIGOVEIC = Item_Transf.codigoveic
          and dataveloc between vDataIni and vDataFin
          and codigoempresa is null;
       end if;   
       vDataFin := vDataIni ;
    End Loop ;   
    
    UPDATE
      bgm_velocimetro
    SET
       codigoempresa = Item_Veic.codigoveic
      ,codigofl = Item_Veic.codigofl
    WHERE
          CODIGOVEIC = Item_Veic.codigoveic
      and codigoempresa is null;
      
  End Loop ;   
  
end Atualiza_bgm_velocimetro;
/
