SELECT *
  FROM GFO_ITINERARIO_ITENS this_ 
 WHERE this_.CODINTLINHA = 2201
   and this_.ID_ITINERARIO in 
   (SELECT max(this_0_.ID_ITINERARIO) as y0_ 
      FROM GFO_ITINERARIO_DIA this_0_ 
     WHERE this_0_.CODINTLINHA = 2201
       and this_0_.DIA = 7
       and this_0_.ID_ITINERARIO in 
       (SELECT this_0_0_.ID_ITINERARIO as y0_ 
          FROM GFO_ITINERARIO this_0_0_ 
         WHERE this_0_0_.CODINTLINHA = 2201
           and this_0_0_.VIGENCIA_INICIAL = 
           (SELECT max(this_0_0_0_.VIGENCIA_INICIAL) as y0_ 
              FROM GFO_ITINERARIO this_0_0_0_ 
             WHERE this_0_0_0_.CODINTLINHA = 2201
               and this_0_0_0_.VIGENCIA_INICIAL <= TO_DATE('02/02/2010 15:00:00','DD/MM/YYYY HH24:MI:SS')
           )
        )
   ) 
   and this_.COD_LOCALIDADE in 
   (SELECT this_0_.COD_LOCALIDADE as y0_ 
      FROM T_ESC_LOCALIDADE this_0_ 
     WHERE this_0_.TIPO_LOCAL in 
     (SELECT this_0_0_.TIPO_LOCAL as y0_ 
        FROM GFO_TIPOLOCAL this_0_0_ 
       WHERE this_0_0_.PONTO_CONTROLE = 'S'
     )
  ) 
ORDER BY this_.SEQUENCIAL Asc
