DECLARE @data_base date = '2023-02-1',  
	    @inicial datetime,
		@final datetime;  

Set @inicial = PARSE(CONCAT(CONVERT(VARCHAR, @data_base, 101), ' 08:00:00') as datetime);
Set @final   = PARSE(CONCAT(CONVERT(VARCHAR, @data_base, 101), ' 18:00:00') as datetime);

Insert Reserva (IdFuncionario, IdLocal, IdTipo, DataHoraReservadaInicial, DataHoraReservadaFinal) 
Select 1, Id, IdTipo, @inicial, @final 
  from Local
 where Descricao in ('Cadeira 1','')

--select * from local
--select * from Reserva
--delete Reserva where IdFuncionario = 1