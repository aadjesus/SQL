DECLARE 
	@vName        Varchar(100),
	@sql          Nvarchar(100),
	@vQtde        Int,
	@vHoraInicial DATETIME;
DECLARE @resultado TABLE (Tabela VARCHAR(500), Qtde int, Milissegundo int);

DECLARE cursor_table CURSOR FOR
	SELECT name 
	  FROM sys.tables;

OPEN cursor_table;
FETCH NEXT FROM cursor_table into @vName;

WHILE @@FETCH_STATUS = 0
BEGIN
   FETCH NEXT FROM cursor_table into @vName;
   --EXECUTE sys.sp_helpindex @objname = 'CotacaoProduto'

   Set @sql = N'Select @Qtde = count(1) from ' + @vName;     
   Set @vHoraInicial = GETDATE();   
   EXECUTE sp_executesql @sql , N'@Qtde int OUT', @Qtde = @vQtde OUT;

   INSERT INTO @resultado(Tabela, Qtde, Milissegundo) values (@vName, @vQtde, DATEDIFF(millisecond,@vHoraInicial,GETDATE()));
END

CLOSE cursor_table;
DEALLOCATE cursor_table;

  SELECT Tabela, Qtde, Milissegundo
    FROM @resultado
ORDER BY Qtde desc


--set statistics time on    
--WAITFOR DELAY '00:00:10'  -- Aguarda 10 segundos
--set statistics time off   -- printa o tempo de processo
