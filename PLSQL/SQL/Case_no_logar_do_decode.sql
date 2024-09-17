select 
 codigoveic
,(case 
   when codigoveic in (2,3,6)                then ' codigoveic in (2,3,6) '
   when codigoveic between 8 and 12          then ' codigoveic between 8 and 12 '
   when (codigoveic = 15 or codigoveic = 16) then ' codigoveic = 15 or codigoveic = 16 '   
   when codigoveic = 19                      then ' codigoveic = 19 '
                                             else ' restante '
  end) Tipo     
from 
frt_cadveiculos
where
codigoveic <= 21