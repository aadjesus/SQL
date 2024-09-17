Select *
  From Gl5_Log_2013_09       a
      ,Gl5_Log_Campo_2013_09 b
      ,Gl5_Log_Sac_2013_09   c

 Where a.Id = b.Idlog(+)
   And a.Id = c.Idlog(+)
   
--delete Gl5_Log_2013_09

Select Ora_Hash('123456') as Ora_Hash,
       --ORA_ROWSCN('123456') as ORA_ROWSCN,
       Owa_opt_lock.checksum('123456') as checksum
From Dual