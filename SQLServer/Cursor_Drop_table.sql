DECLARE 
 @vName   varchar(100),
 @sqlDrop nvarchar(4000)

DECLARE cursor_table CURSOR FOR
SELECT name FROM SYSOBJECTS WHERE XTYPE='U';

OPEN cursor_table;
FETCH NEXT FROM cursor_table into @vName;

WHILE @@FETCH_STATUS = 0
BEGIN
   FETCH NEXT FROM cursor_table into @vName;
   --set @sqlDrop = 'drop table ' + @vName;   
   set @sqlDrop = 'delete ' + @vName;   
   EXECUTE sp_executesql @sqlDrop;
END

CLOSE cursor_table;
DEALLOCATE cursor_table;
GO
