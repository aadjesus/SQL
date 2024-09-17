DECLARE 
	@IdEscalaPadrao    AS INT, 
	@Id			   	   AS INT, 
	@IdEscalaPadraoAnt AS INT, 
	@Grupo             AS INT 

DECLARE contact_cursor CURSOR FOR
SELECT IdEscalaPadrao,Id FROM EscalaPadraoServico ORDER BY IdEscalaPadrao, HoraInicio;

OPEN contact_cursor;
FETCH NEXT FROM contact_cursor into @IdEscalaPadrao, @Id;

set @Grupo = 0;
set @IdEscalaPadraoAnt = @IdEscalaPadrao;


WHILE @@FETCH_STATUS = 0
BEGIN
   set @Grupo = @Grupo+1;
   update EscalaPadraoServico set grupo = @Grupo where Id = @Id;  

   FETCH NEXT FROM contact_cursor into @IdEscalaPadrao, @Id;

   IF @IdEscalaPadrao<>@IdEscalaPadraoAnt
   BEGIN
	set @Grupo = 0;
	set @IdEscalaPadraoAnt = @IdEscalaPadrao;
   END    
END

CLOSE contact_cursor;
DEALLOCATE contact_cursor;
GO
