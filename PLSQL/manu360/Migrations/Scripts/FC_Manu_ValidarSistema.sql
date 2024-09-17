Create Or Replace Function Fc_Manu_Validarsistema Return Boolean Is
  v_Qtde Number;
Begin
  Select Count(*)
    Into v_Qtde
    From Ctr_Cadastrosistemas
   Where Sistema = '360';
  Return(v_Qtde > 0);
End Fc_Manu_Validarsistema;