SELECT


 (SELECT COUNT(*)
	 FROM Man_Osprevisto Osprevisto
	INNER JOIN Man_Planoderevisao Pr ON Osprevisto.Codigoplanrev = Pr.Codigoplanrev
	WHERE Osprevisto.Codintos = Os.Codintos) Qtde
,Os.*

  FROM Man_Os Os
 WHERE Os.Condicaoos = 'AB'
	AND Os.Dataaberturaos >= '01-jan-2017'
	AND Os.Codigoempresa = 1
	AND Codigofl = 4
	AND Codigoga = 2
	AND NOT EXISTS (SELECT 1
			 FROM Man_Osprevisto Osprevisto
			INNER JOIN Man_Planoderevisao Pr ON Osprevisto.Codigoplanrev = Pr.Codigoplanrev
			WHERE Osprevisto.Codintos = Os.Codintos
			  AND (Pr.Trocaoleoplanrev = 'S' OR Pr.Trocaoleocxcambio = 'S' OR Pr.Trocaoleocxdif = 'S'))