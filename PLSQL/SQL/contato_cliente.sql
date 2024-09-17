	
set head off
SET ECHO OFF
SET FEEDBACK OFF
SET PAGESIZE 50000
SPOOL c:\Temp\x1.sql;

Select 
'update sii_contatocliente set emailcontatocli=''' ||  emailcontatocli || ''', senhaweb= '''|| senhaweb || ''' where codcontato=''' || codcontato || ''' and codcliente = '''|| codcliente || '''; '
  From sii_contatocliente a
where ativocontatocli <> 'N' and emailcontatocli is not null 	and senhaweb is not null

SPOOL Off