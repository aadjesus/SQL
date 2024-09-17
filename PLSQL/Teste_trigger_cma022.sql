DECLARE 

BEGIN
    update cma022 
       set vigencia = vigencia 
     where recnum  = 1;

--select * from cma022;
--select * from cgs_taxasgenericas_ne;

END;