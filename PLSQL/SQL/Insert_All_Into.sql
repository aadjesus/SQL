Select * From Teste1;
Select * From Teste2;

Insert All Into Teste1
  (Cod_Teste1,
   Des_Teste1)
Values
  (Contador,
   'TESTE1(' || To_Char(Contador) || ')') Into Teste2
  (Cod_Teste1,
   Cod_Teste2,
   Des_Teste2)
Values
  (Contador,
   (Select Nvl(Max(Cod_Teste2), 0) + 1 From Teste2),
   '  TESTE2(' || To_Char(Contador) || ')')

  Select Nvl(Max(t.Cod_Teste1), 0) + 1 Contador From Teste1 t