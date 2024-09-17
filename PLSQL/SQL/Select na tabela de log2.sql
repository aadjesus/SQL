select 
A.Textolog
from
ctr_log a
where
    a.sistema = 'PNE'
and a.datalog = TO_DATE('03/10/2006 00:00:00', 'DD/MM/YYYY HH24:MI:SS')
AND a.horalog >= TO_DATE('18:00:00', 'HH24:MI:SS')
and a.textolog like 'Relatorio%'
                     

