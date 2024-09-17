select x.*
     , abs(DATEDIFF(SECOND, x.Ini , x.Fin)) 
  from (select a.Sent_Date as Ini
             , (select min(b.Sent_Date) 
                  from Email b
                 where b.Sent_Date > a.Sent_Date)  as Fin 
          from Email a
         where a.Sent_Date > '2021-01-01'
      --order by a.Sent_Date
      ) x 