--Select *
--From 
--padrao   a
--Where Exists(select * from linha b where a.IDLINHA = b.ID and b.codigo in ('006', 'RESERVA'));

select * from padrao

delete padrao where id != 315

select * from FUNCIONARIO

--Delete funcionario a
-- Where Not (Exists (Select 1 From PADRAOSERVFUNC b Where a.ID = b.IDFUNCIONARIO)
--   or (a.IDFILIAL = 54
--   And a.id Between 6200 And 6250
--   And Exists (Select 1 From FUNCIONARIOLINHA c Where a.ID = c.IDFUNCIONARIO
--)))