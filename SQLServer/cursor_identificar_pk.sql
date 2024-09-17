--EXEC sp_fkeys @pktable_name = 'TableName', @pktable_owner = 'dbo'

DECLARE 
	@Id AS INT

DECLARE contact_cursor CURSOR FOR
	EXEC sp_fkeys 'Usuario';

OPEN contact_cursor;
FETCH NEXT FROM contact_cursor into  @Id;

WHILE @@FETCH_STATUS = 0
BEGIN
   if ISNULL((select max(Id)  from Cliente where Id = @Id),0) = 0
   BEGIN
	PRINT @Id;
   END   

   FETCH NEXT FROM contact_cursor into @Id;
END

CLOSE contact_cursor;
DEALLOCATE contact_cursor;
GO
