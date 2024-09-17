Select '"'|| Replace(TO_CHAR(c.latitude),',','.') ||','|| Replace(TO_CHAR(c.longitude),',','.') || '*"+'As Latitude_Longitude
     , 'new GLatLng('||  Replace(TO_CHAR(c.latitude),',','.') ||','|| Replace(TO_CHAR(c.longitude),',','.') ||'), 'As Latitude_Longitude
     , a.sentido,a.sequencial
  From gfo_itinerario_itens a
     , bgm_cadlinhas b
     , T_ESC_LOCALIDADE c
Where a.codintlinha = b.codintlinha
  And b.codintlinha = 26609
  And a.id_itinerario = 1
  And a.cod_localidade = c.cod_localidade  
  Order By a.sentido, a.sequencial, c.latitude, c.longitude 
  
--1	"-23.940738889,-46.384622222*"+	new GLatLng(-23.940738889,-46.384622222), 	I	1