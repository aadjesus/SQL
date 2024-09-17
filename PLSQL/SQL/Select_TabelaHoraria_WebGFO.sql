-------------------------------
------- ESCALA DIARIA ---------
-------------------------------

--- Escala programada do dia
Select Escaladiar0_.Cod_Intlinha   
      ,Servicoesc1_.Cod_Veic       
      ,Servicoesc1_.Cod_Servdiaria 
      ,Servicoesc1_.Cod_Motorista  
      ,Servicoesc1_.Cod_Intturno   
      ,Horarioesc2_.Cod_Hordiaria  
      ,Horarioesc2_.Hor_Saida      
      ,Horarioesc2_.Hor_Chegada    
      ,Horarioesc2_.Cod_Localidade 
      ,Horarioesc2_.Flg_Sentido    
  From t_Esc_Escaladiaria  Escaladiar0_
      ,t_Esc_Servicodiaria Servicoesc1_
      ,t_Esc_Horariodiaria Horarioesc2_
 Where (Escaladiar0_.Cod_Intlinha In (4055))
   And (Escaladiar0_.Dat_Escala = To_Date('12/11/2012 00:00:00','DD/MM/YYYY HH24:MI:SS'))
   And (Escaladiar0_.Cod_Intescala = Servicoesc1_.Cod_Intescala)
   And (Escaladiar0_.Dat_Escala = Servicoesc1_.Dat_Escala)
   And (Servicoesc1_.Cod_Intescala = Horarioesc2_.Cod_Intescala)
   And (Servicoesc1_.Dat_Escala = Horarioesc2_.Dat_Escala)
   And (Servicoesc1_.Cod_Servdiaria = Horarioesc2_.Cod_Intservdiaria)
   And (Servicoesc1_.Cod_Intturno = Horarioesc2_.Cod_Intturno)

--- Escala programada do dia considerando a hora do servico
  Select Escaladiar0_.Cod_Intlinha   
        ,Servicoesc1_.Cod_Veic       
        ,Servicoesc1_.Cod_Servdiaria 
        ,Servicoesc1_.Cod_Motorista  
        ,Servicoesc1_.Cod_Intturno   
        ,Horarioesc2_.Cod_Hordiaria  
        ,Horarioesc2_.Hor_Saida      
        ,Horarioesc2_.Hor_Chegada    
        ,Horarioesc2_.Cod_Localidade 
        ,Horarioesc2_.Flg_Sentido    
    From t_Esc_Escaladiaria  Escaladiar0_
        ,t_Esc_Servicodiaria Servicoesc1_
        ,t_Esc_Horariodiaria Horarioesc2_
   Where (Escaladiar0_.Cod_Intlinha In (4055))
     And (Escaladiar0_.Dat_Escala = To_Date('12/11/2012 00:00:00'))
     And (Escaladiar0_.Cod_Intescala = Servicoesc1_.Cod_Intescala)
     And (Escaladiar0_.Dat_Escala = Servicoesc1_.Dat_Escala)
     And (Servicoesc1_.Cod_Intescala = Horarioesc2_.Cod_Intescala)
     And (Servicoesc1_.Dat_Escala = Horarioesc2_.Dat_Escala)
     And (Servicoesc1_.Cod_Servdiaria = Horarioesc2_.Cod_Intservdiaria)
     And (Servicoesc1_.Cod_Intturno = Horarioesc2_.Cod_Intturno)
     And (((Escaladiar0_.Cod_Intlinha = 4055) And
         ((Servicoesc1_.Cod_Servdiaria Not In ('10A', '10B', '11A', '11B', '1C', '2A', '2B', '3A', '3B', '4A', '4B', '5A', '5B', '6A', '6B', '7A', '7B', '8A', '8B', '9A', '9B')))))
     And (To_Date('01/01/0001 00:00:00','DD/MM/YYYY HH24:MI:SS') Between Servicoesc1_.Hor_Inicio_Servico And Servicoesc1_.Hor_Fim_Servico)
     And (Horarioesc2_.Hor_Chegada =
         (Select Max(Horarioesc3_.Hor_Chegada)
             From t_Esc_Horariodiaria Horarioesc3_
            Where (Horarioesc3_.Cod_Intescala = Horarioesc2_.Cod_Intescala)
              And (Horarioesc3_.Dat_Escala = Horarioesc2_.Dat_Escala)
              And (Horarioesc3_.Cod_Intturno = Horarioesc2_.Cod_Intturno)
              And (Horarioesc3_.Cod_Intservdiaria =
                  Horarioesc2_.Cod_Intservdiaria)
              And (Horarioesc3_.Hor_Chegada < To_Date('01/01/1900 00:00:00','DD/MM/YYYY HH24:MI:SS'))
              And (Horarioesc3_.Hor_Chegada > To_Date('31/12/1899 23:00:00','DD/MM/YYYY HH24:MI:SS'))))              

--- Escala programada do plantao
  Select Saidarecol0_.Codintlinha      
        ,Saidarecol0_.Cod_Servdiaria   
        ,Saidarecol0_.Cod_Intturno     
        ,Saidarecol0_.Codigoveic       
        ,Saidarecol0_.Codintmot        
        ,Saidarecol0_.Horasaidagaragem 
        ,Saidarecol0_.Horarecolhida    
        ,Saidarecol0_.Cod_Intescala    
    From Plt_Saidarecolhida Saidarecol0_
   Where (Saidarecol0_.Codintlinha In (4055))
     And (Saidarecol0_.Dtsaida = To_Date('12/11/2012 00:00:00'))
     And (To_Date('01/01/0001 00:00:00') Between Saidarecol0_.Horasaidagaragem And Saidarecol0_.Horarecolhida);         

-------------------------------
------- ESCALA PADRAO ---------
-------------------------------

--- Tipo de dias da empresa filial
  Select This_.Cod_Inttipodia 
        ,This_.Cod_Empresa    
        ,This_.Cod_Filial     
        ,This_.Desc_Tipodia   
        ,This_.Flg_Segunda    
        ,This_.Cod_Tipodia    
        ,This_.Flg_Terca      
        ,This_.Flg_Quarta     
        ,This_.Flg_Quinta     
        ,This_.Flg_Sexta      
        ,This_.Flg_Sabado     
        ,This_.Flg_Domingo    
        ,This_.Flg_Feriado    
        ,This_.Cod_Sistema    
    From t_Esc_Tipodia This_
   Where (This_.Cod_Empresa = 8 And (This_.Cod_Filial = 9) And (This_.Cod_Sistema = 'ESC'))

--- Escala padrao para os tipo de dias encontrados
  Select This_.Cod_Intescala   
        ,This_.Cod_Intprograma 
        ,This_.Cod_Tipodia     
        ,This_.Cod_Intlinha    
        ,This_.Codigoempresa   
        ,This_.Cod_Escala      
        ,This_.Codigofl        
        ,This_.Dat_Elaboracao  
        ,This_.Flg_Ativa       
        ,This_.Nom_Elaborador  
        ,This_.Desc_Motivoelab 
        ,This_.Dat_Alter       
        ,This_.Nom_Usuaralter  
        ,This_.Cod_Seq_Folga   
        ,This_.Codintmot       
        ,This_.Codintcob       
    From t_Esc_Escalapadrao This_
   Where (This_.Flg_Ativa = 'S' And (This_.Cod_Intlinha = 4055) And ((This_.Cod_Tipodia In (34, 35, 36, 78))))

--- Sericos da Escala padrao para os tipo de dias encontrados
  Select This_.Cod_Servico              
        ,This_.Cod_Intprograma         
        ,This_.Cod_Intescala           
        ,This_.Cod_Intturno            
        ,This_.Cod_Subgrupomot         
        ,This_.Cod_Posicaomotorista    
        ,This_.Cod_Subgrupocob         
        ,This_.Cod_Posicaocob          
        ,This_.Codveic                 
        ,This_.Cod_Grupolinha          
        ,This_.Flg_Tipo                
        ,This_.Cod_Motorista           
        ,This_.Cod_Cobrador            
        ,This_.Cod_Folgamot            
        ,This_.Cod_Folgacob            
        ,This_.Flg_Segpegada           
        ,This_.Codigoseq_Mot           
        ,This_.Codigoseq_Cob           
        ,This_.Codigoseq_Veic          
        ,This_.Cod_Subgrupomotaux      
        ,This_.Cod_Posicaomotoristaaux 
        ,This_.Cod_Motoristaaux        
        ,This_.Codigoseq_Motaux        
        ,This_.Cod_Folgamotaux         
    From t_Esc_Servicopadrao This_
   Where ((This_.Cod_Intescala In (31906,31946,31986)))

--- horarios da Escala padrao para os tipo de dias encontrados
  Select This_.Cod_Servico       
        ,This_.Cod_Intprograma 
        ,This_.Cod_Horarioprog 
        ,This_.Cod_Intturno    
        ,This_.Flg_Sentido     
        ,This_.Cod_Atividade   
        ,This_.Hor_Saida       
        ,This_.Hor_Chegada     
        ,This_.Codintlinha     
        ,This_.Tempo_Ativ      
        ,This_.Tempo_Placa     
        ,This_.Tempo_Viag      
        ,This_.Cod_Sufixo      
        ,This_.Cod_Localidade  
        ,This_.Identificador   
    From t_Esc_Horarioprogramacao This_
   Where ((This_.Cod_Intprograma In (5811,5352,5353)) And
         ((This_.Cod_Servico In ('10A','10B','11A','11B','1C','2A','2B','3A','3B','4A','4B','5A','5B','6A','6B','7A','7B','8A','8B','9A','9B','1A','1B'))) And
         ((This_.Cod_Intturno In (19,20))))
         


