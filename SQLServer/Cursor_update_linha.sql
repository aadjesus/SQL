DECLARE 
	@vCodigo AS varchar(10),
	@vDescricao AS varchar(40)

DECLARE cursor_linha CURSOR FOR
SELECT Descricao FROM Linha;

OPEN cursor_linha;
FETCH NEXT FROM cursor_linha into @vDescricao;

WHILE @@FETCH_STATUS = 0
BEGIN

	set @vCodigo = upper(SUBSTRING(@vDescricao,1,CHARINDEX(' ', @vDescricao)-1));
	if (CHARINDEX(upper(@vCodigo), 'ESPECIAL') > 0)
	begin
		set @vCodigo = SUBSTRING(@vDescricao,CHARINDEX(' ', @vDescricao)+1, 10);		
		set @vCodigo = SUBSTRING(@vCodigo,1,CHARINDEX(' ', @vCodigo)-1);
		set @vCodigo = 'ESPEC-' +  @vCodigo ;
	end

	--set @vCodigo = SUBSTRING(@vCodigo,1,CHARINDEX(' ', @vCodigo)-1);
	print @vCodigo;
	update Linha set Codigo = @vCodigo where CURRENT OF cursor_linha;   

	FETCH NEXT FROM cursor_linha into @vDescricao;
END

CLOSE cursor_linha;
DEALLOCATE cursor_linha;
GO
