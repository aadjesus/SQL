DECLARE @idLocal INT,
	    @idTipo INT,
		@idmapa int                 = 1, 
	    @idFuncionario int          = 11,--	Camila Martins Cipriano	camila.cipriano@bgmrodotec.com.br	1	1	NULL
		@inicial	   date         = '2025-11-11',
		@final		   date         = '2025-11-12',
		@horaInicial   varchar(5)   = '11:00',
		@horaFinal	   varchar(5)   = '21:00',
	    @motivo        varchar(100) = 'Workshop Sales & Marketing 2025'

IF CURSOR_STATUS('global', 'cursor_local') >= 0
BEGIN
    CLOSE cursor_local;
    DEALLOCATE cursor_local;
END

BEGIN TRY
BEGIN TRANSACTION
	WHILE @inicial <= @final 
	BEGIN
		PRINT 'Data: ' + CAST(@inicial AS VARCHAR);

		DECLARE cursor_local CURSOR FOR
			SELECT id, IdTipo 
			  FROM local 
			 WHERE idmapa = @idmapa;

		OPEN cursor_local;

		FETCH NEXT FROM cursor_local INTO @idLocal, @idTipo
		WHILE @@FETCH_STATUS = 0
		BEGIN
			PRINT 'Excluindo local: ' + CAST(@idLocal AS VARCHAR);

			delete reserva
			 where IdLocal =  @idLocal
			   and DATETRUNC(day, DataHoraReservadaInicial) = @inicial;

			PRINT 'Incluindo local: ' + CAST(@idLocal AS VARCHAR);
			insert into Reserva(IdFuncionario
							   ,IdLocal
							   ,IdTipo
							   ,DataOperacao
							   ,DataHoraReservadaInicial
							   ,DataHoraReservadaFinal
							   ,Motivo) 
			values(@idFuncionario
				  ,@idLocal
				  ,@idTipo
				  ,GETDATE()
				  ,CONVERT(datetime, CONCAT(@inicial,' ', @horaInicial), 120)
				  ,CONVERT(datetime, CONCAT(@inicial,' ', @horaFinal), 120)
				  ,@motivo)

			FETCH NEXT FROM cursor_local INTO @idLocal, @idTipo
		END;
		SET @inicial = DATEADD(DAY, 1, @inicial);

		CLOSE cursor_local;
		DEALLOCATE cursor_local;
	END;


    --ROLLBACK TRANSACTION
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	PRINT ERROR_MESSAGE()
	ROLLBACK TRANSACTION
END CATCH

--delete Reserva where motivo = 'Workshop Sales & Marketing 2025'
--select * from Reserva where motivo = 'Workshop Sales & Marketing 2025'

--delete Reserva where motivo = 'Workshop Sales & Marketing 2025'
--select * from Reserva where motivo = 'Workshop Sales & Marketing 2025'
 --select * from Reserva where DATETRUNC(day, DataHoraReservadaInicial) in ('2025-11-11','2025-11-12')