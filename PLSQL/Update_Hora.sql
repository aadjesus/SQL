UPDATE funcionario 
SET horainiciotrabalho  = TO_DATE('01/01/1753 ' || TO_CHAR(horainiciotrabalho,'HH24:MI'),'DD/MM/YYYY HH24:MI:SS')
     , horafimtrabalho =      
     (CASE When   TO_DATE('01/01/1753 ' || TO_CHAR(horafimtrabalho,'HH24:MI'),'DD/MM/YYYY HH24:MI:SS') < TO_DATE('01/01/0001 ' || TO_CHAR(horainiciotrabalho,'HH24:MI'),'DD/MM/YYYY HH24:MI:SS')     
      THEN TO_DATE('02/01/1753 ' || TO_CHAR(horafimtrabalho,'HH24:MI'),'DD/MM/YYYY HH24:MI:SS')      
      ELSE TO_DATE('01/01/1753 ' || TO_CHAR(horafimtrabalho,'HH24:MI'),'DD/MM/YYYY HH24:MI:SS') End)

 ;      

UPDATE padraoserv
SET horainicio = TO_DATE('01/01/1753 ' || TO_CHAR(horainicio,'HH24:MI'),'DD/MM/YYYY HH24:MI:SS')
, horafim = 
  (CASE When   TO_DATE('01/01/1753 ' || TO_CHAR(horafim,'HH24:MI'),'DD/MM/YYYY HH24:MI:SS') < TO_DATE('01/01/0001 ' || TO_CHAR(horainicio,'HH24:MI'),'DD/MM/YYYY HH24:MI:SS')     
      THEN TO_DATE('02/01/1753 ' || TO_CHAR(horafim,'HH24:MI'),'DD/MM/YYYY HH24:MI:SS')      
      ELSE TO_DATE('01/01/1753 ' || TO_CHAR(horafim,'HH24:MI'),'DD/MM/YYYY HH24:MI:SS') End)          
