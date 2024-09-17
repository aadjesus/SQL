Set Head off
SET ECHO OFF
SET FEEDBACK OFF
SET PAGESIZE 50000
SPOOL c:\Temp\Teste.SQL;

Select 'Alter Table '|| Table_Name || ' Add(checksum varchar2(10));'
  From User_Tables
 Where Table_Name Like 'GFO%';

SPOOL Off

--@c:\Temp\Teste.SQL;