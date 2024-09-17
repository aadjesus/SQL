-- IN (15 sec)
select a.codigoempresa,a.codigofl from est_movto a
where
LPAD(a.codigoempresa,3,'0') ||LPAD(a.CODIGOFL,3,'0') in (001001,001002,003001,062001,062002)
group by
a.codigoempresa,a.codigofl
--------------------------------------------------------------------------------------
-- LIKE (5 sec)
select a.codigoempresa,a.codigofl from est_movto a
where
',001001,001002,003001,062001,062002,' like  '%,' || LPAD(a.codigoempresa,3,'0') ||LPAD(a.CODIGOFL,3,'0') || ',%'
group by
a.codigoempresa,a.codigofl
--------------------------------------------------------------------------------------
-- OR (2,5 sec)
select a.codigoempresa,a.codigofl from est_movto a
where
(a.codigoempresa =  1 and a.codigofl = 1 or
 a.codigoempresa =  1 and a.codigofl = 2 or
 a.codigoempresa =  3 and a.codigofl = 1 or
 a.codigoempresa = 62 and a.codigofl = 1 or
 a.codigoempresa = 62 and a.codigofl = 2)
group by
a.codigoempresa,a.codigofl

--	Testes executados na aurea1904 ora901
