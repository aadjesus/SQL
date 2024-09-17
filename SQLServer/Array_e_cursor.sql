DECLARE 
	@Id AS INT

DECLARE contact_cursor CURSOR FOR
SELECT value Id FROM STRING_SPLIT('74,80,84,90,91,95,99,100,102,109,119,118,131,135,110',',');

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
