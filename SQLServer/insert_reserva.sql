DECLARE @inicial	   datetime = '2023-02-1',
		@final		   datetime = '2023-02-1',
		@cadeira	   numeric,
		@idFuncionario numeric

If NOT EXISTS (select id from funcionario where Nome = 'TI')
Begin	
	Insert Into Funcionario(Nome, Email) values ('TI','TI')
End

Set @inicial       = PARSE(CONCAT(CONVERT(VARCHAR, @inicial, 101), ' 08:00:00') as Datetime);
Set @final	       = PARSE(CONCAT(CONVERT(VARCHAR, @final,   101), ' 18:00:00') as Datetime);
Set @idFuncionario = (select id from funcionario where Nome = 'TI' )

WHILE @inicial <= cast('2022-1-10' as datetime)
BEGIN	    
    IF NOT EXISTS (select id from Reserva where IdLocal = 53 and DataHoraReservadaInicial = @inicial)
	begin
		insert into Reserva (IdFuncionario, IdLocal, IdTipo, DataOperacao, DataHoraReservadaInicial, DataHoraReservadaFinal) 
		             values (@idFuncionario, 53, 1, GETDATE(), @inicial, @final)
	end

    IF NOT EXISTS (select id from Reserva where IdLocal = 54 and DataHoraReservadaInicial = @inicial)
	begin
		insert into Reserva (IdFuncionario, IdLocal, IdTipo, DataOperacao, DataHoraReservadaInicial, DataHoraReservadaFinal) 
		             values (@idFuncionario, 54, 1, GETDATE(), @inicial, @final)
	end

    IF NOT EXISTS (select id from Reserva where IdLocal = 59 and DataHoraReservadaInicial = @inicial)
	begin
		insert into Reserva (IdFuncionario, IdLocal, IdTipo, DataOperacao, DataHoraReservadaInicial, DataHoraReservadaFinal) 
		             values (@idFuncionario, 59, 1, GETDATE(), @inicial, @final)
	end

    IF NOT EXISTS (select id from Reserva where IdLocal = 60 and DataHoraReservadaInicial = @inicial)
	begin
		insert into Reserva (IdFuncionario, IdLocal, IdTipo, DataOperacao, DataHoraReservadaInicial, DataHoraReservadaFinal) 
		             values (@idFuncionario, 60, 1, GETDATE(), @inicial, @final)
	end

    SET @inicial = DATEADD(DAY, 1, @inicial) 
    SET @final   = DATEADD(DAY, 1, @final)     
END
