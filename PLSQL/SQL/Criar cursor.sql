CREATE OR REPLACE Procedure Agrupamento 
Is
  Cursor Agrup Is
    select 
      distinct 
      a.codigomodcarroc,
      b.descricaomodcarroc,
      b.caracteristicamodcarroc,
      b.capacsentadomodcarroc,
      b.possuiarcondicionadomodcarroc,
      b.toaletemodcarroc
    from 
      tur_disponibilidademodcarroc a,
      frt_modcarroc b
    where
      a.codigomodcarroc = b.codigomodcarroc ;
Begin
  For Item_Agrup in Agrup Loop
    Insert into tur_agrupamento (
      CODIGOAGRUP,
      NOMEAGRUP,
      CARACTERISTICAAGRUP,
      CAPACSENTADOAGRUP,
      TOALETEAGRUP,
      POSSUIARCONDAGRUP 
     )  values (
        Item_Agrup.codigomodcarroc,
        Item_Agrup.descricaomodcarroc,
        Item_Agrup.caracteristicamodcarroc,
        Item_Agrup.capacsentadomodcarroc,
        Item_Agrup.possuiarcondicionadomodcarroc,
        Item_Agrup.toaletemodcarroc
     ) ;    
    Insert into TUR_AGRUPAMENTOMODCARROC (
       CODIGOAGRUP ,
       CODIGOMODCARROC
     )  values (
        Item_Agrup.codigomodcarroc,
        Item_Agrup.codigomodcarroc
     ) ;     
  End Loop ;   
End; 
/
