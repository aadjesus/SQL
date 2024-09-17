SELECT *
  FROM GFO_HISTORICOMENSAGEM this_ 
 WHERE this_.DATA between TO_DATE('05/04/2010 00:00:00','DD/MM/YYYY HH24:MI:SS') 
                      and TO_DATE('05/04/2010 16:11:53','DD/MM/YYYY HH24:MI:SS') 
   and this_.ORIGEM = 'I' 
   and (this_.DATA_LEITURA = TO_DATE('01/01/0001 00:00:00','DD/MM/YYYY HH24:MI:SS') or this_.DATA_LEITURA is null) 
   and ((this_.ID_MENSAGEMRETORNO is null and this_.ID_MENSAGEM not in 
   (SELECT this_0_.ID_MENSAGEMRETORNO as y0_ 
      FROM GFO_HISTORICOMENSAGEM this_0_ 
     WHERE this_0_.DATA between TO_DATE('05/04/2010 00:00:00','DD/MM/YYYY HH24:MI:SS') 
                            and TO_DATE('05/04/2010 16:11:53','DD/MM/YYYY HH24:MI:SS') 
       and (this_0_.DATA_LEITURA = TO_DATE('01/01/0001 00:00:00','DD/MM/YYYY HH24:MI:SS') or this_0_.DATA_LEITURA is null) 
   and this_0_.ID_MENSAGEMRETORNO is not null)) 
    or (this_.ID_MENSAGEMRETORNO is not null))    
