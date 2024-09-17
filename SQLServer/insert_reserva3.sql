DECLARE @inicial	   date = '2023-09-01',
		@final		   date = '2023-09-10',
		@horaInicial   varchar(5) = '08:00',
		@horaFinal	   varchar(5) = '18:00',
		@tipoDia	   numeric = 1,	
		@idLocal	   numeric = 63,
		@idTipo		   numeric = 1,	
		@idFuncionario numeric = 1006,
		@motivo		   varchar(100) = 'Teste'

WHILE @inicial <= @final
BEGIN	
	Set @tipoDia = DATEPART(WEEKDAY,@inicial);

	if @tipoDia > 1 and @tipoDia < 7
		insert into Reserva( IdFuncionario
						   , IdLocal
						   , IdTipo
						   , DataOperacao
						   , DataHoraReservadaInicial
						   , DataHoraReservadaFinal
						   , Motivo) 
					 values( @idFuncionario
					 	   , @idLocal
						   , @idTipo
						   , GETDATE()
						   , CONVERT(datetime, CONCAT(@inicial,' ', @horaInicial),120 )
						   , CONVERT(datetime, CONCAT(@inicial,' ', @horaFinal),120 )
						   , @motivo)

    SET @inicial = DATEADD(DAY, 1, @inicial)
END
--delete reserva
--select * from reserva