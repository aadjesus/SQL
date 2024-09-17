select a.textolog 
from ctr_log a 
where a.sistema = 'CGS' and a.textolog like '%manifesto%' and a.datalog = '17-nov-03'
--delete ctr_log a where a.sistema = 'CGS' and a.textolog like '%manifesto%' and a.datalog = '17-nov-03'