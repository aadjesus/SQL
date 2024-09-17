Create Or Replace Procedure Xisto Is
  Cursor Agrup Is
    Select Codintlinha From Gfo_Itinerario Group By Codintlinha;
  v_qtde  Number;
Begin

  For Item_Agrup In Agrup Loop
    v_qtde := 0;
    For Vcontador In 1 .. 31 Loop     
      PRGFO_CONSOLIDARHISTDEDETEC(
                                  TO_DATE(to_char(Vcontador) || '/07/2010','DD/MM/YYYY')
                                  ,Item_Agrup.Codintlinha
                                  ,v_qtde );
      
    End Loop;
  End Loop;
End;
/