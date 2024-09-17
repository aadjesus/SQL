
DECLARE 
                       
CREATE OR REPLACE PROCEDURE teste_integracao AS                       
  --UPDATE PLANALTO181228.RDA_PLANEJAMENTO FF SET FF.SENTIDO = FF.SENTIDO                                      
 -- SELECT * FROM PLANTAOTESTE.PROGRAMADO WHERE IDEXTERNO = '83FE19816426425FE053050010AC4058'
 
 
   v_id_chave NUMBER := 0;
   v_iddiaria NUMBER := 0;

  CURSOR c_projeta_diaria IS
     Select pl1.ID idprogramado,
            pl2.ID As idprogramadotrecho,
            t.id_externo AS  id_externo_trecho, 
            t.codintfunc,
            t.codintveic
            a3.DATA
       From RDA_ESCALA_DIARIA         a3,
            RDA_ESCALA_DIARIA_TRECHOS T,
            RDA_GRUPO_ESCALA_TRECHOS  c3,        
            Rda_Planejamento         kk,
            rda_planejamento_trechos kk3,        
            plantaoteste.programado       pl1,
            plantaoteste.programadotrecho pl2 
      Where A3.CODINTDIARIA = T.CODINTDIARIA
            And A3.CODINTGRUPO = c3.CODINTGRUPO
            And T.CODINTTRECHO = C3.CODINTTRECHO
            And c3.codintplanej = kk.codintplanej       
            And kk.codintplanej = kk3.codintplanej
            And c3.cod_loc_origem_planej = kk3.cod_loc_origem
            And c3.cod_loc_destino_planej = kk3.cod_loc_destino       
            And pl1.ID = pl2.idprogramado
            And kk.id_externo = pl1.idexterno
            And kk3.id_externo = pl2.idexterno
            ORDER BY pl1.ID;
       
           
BEGIN

   

 --remover da diaria  campoidexterno 
  FOR r_diaria IN c_projeta_diaria LOOP
  
  
      IF   v_id_chave <> r_diaria.idprogramado THEN 
         
         SELECT seq_diaria.NEXTVAL INTO  v_iddiaria FROM dual;
      
          INSERT INTO diaria (id ,idprogramado,data  ) VALUES( v_iddiaria, r_diaria.idprogramado,r_diaria.DATA  );
          
         v_id_chave := r_diaria.idprogramado;        
         
     END IF;  
     
     /*  r_diaria.idprogramado,
    
        r_diaria.codintfunc;
        r_diaria.codintveic;
       */
     
     INSERT INTO diariatrecho(seq_diariatrecho.NEXTVAL ,  r_diaria.id_externo_trecho, v_iddiaria , NULL, r_diaria.idprogramadotrecho,  NULL );
     
  
  END LOOP;

END;
/
  
SELECT * FROM RDA_PLANEJAMENTO_PARADAS

Select Count(1), codintdiaria
  From RDA_ESCALA_DIARIA_TRECHOS
 Group By codintdiaria
Having Count(1) > 5;

Select Count(1), tipo
  From RDA_ESCALA_DIARIA_TRECHOS
 Group By tipo
Having Count(1) > 5;

/*Porjeção de Diaria*/
Select d.codintgrupo, D.CODINTDIARIA, t.tipo
  From RDA_ESCALA_DIARIA_TRECHOS T, 
            RDA_ESCALA_DIARIA D
 Where D.CODINTDIARIA = T.CODINTDIARIA
--       And D.CODINTDIARIA = 39724
       And t.tipo = 'TRC'
       AND d.codintgrupo IS NOT NULL
       AND d.DATA >=  (Select MAX(DATA) - 7 From RDA_ESCALA_DIARIA WHERE DATA < SYSDATE) 
       GROUP BY d.codintgrupo, D.CODINTDIARIA, t.tipo;
 
Select pr.ID
  From RDA_ESCALA_DIARIA        a3,
            RDA_GRUPO_ESCALA         b3,
           RDA_GRUPO_ESCALA_TRECHOS c3,
           rda_planejamento kk,
           programacao pr
 WHERE pr.idexterno = kk.id_externo
      AND kk.codintplanej =  c3.codintplanej
      AND a3.codintgrupo = b3.codintgrupo
       And b3.codintgrupo = c3.codintgrupo
       AND a3.codintgrupo = 44      
       And a3.CODINTDIARIA = 39724
       AND c3.tipo = 'TRC'       
       GROUP BY pr.IDj;
       
       
SELECT * FROM rda_planejamento kk WHERE kk.codintplanej = 1       
 

SELECT *
       FROM RDA_ESCALA_DIARIA_TRECHOS T,
            RDA_ESCALA_DIARIA D
              WHERE D.CODINTDIARIA = T.CODINTDIARIA
                AND D.DATA = '12/MAR/2019' 
                AND D.CODINTDIARIA = 39726;
                       
Select *
  From RDA_PLANEJAMENTO a1, RDA_PLANEJAMENTO_TRECHOS a2  
  WHERE a1.CODINTPLANEJ = a2.CODINTPLANEJ
AND  a1.servico = '1026117001'
                            

Select P.*
  From RDA_PLANEJAMENTO PP,
       RDA_PLANEJAMENTO_TRECHOS P,
       (
        
        Select G.CODINTPLANEJ,
                G.COD_LOC_ORIGEM_PLANEJ,
                G.COD_LOC_DESTINO_PLANEJ
          From RDA_GRUPO_ESCALA_TRECHOS G, RDA_GRUPO_ESCALA GG
         Where GG.CODINTGRUPO = G.CODINTGRUPO
               And (G.CODINTTRECHO, G.COD_LOC_ORIGEM_PLANEJ,
                G.COD_LOC_DESTINO_PLANEJ) In
               (
                    
                    Select T.CODINTTRECHO, T.COD_LOC_ORIGEM, T.COD_LOC_DESTINO
                      From RDA_ESCALA_DIARIA_TRECHOS T, RDA_ESCALA_DIARIA D
                     Where D.CODINTDIARIA = T.CODINTDIARIA
                           And D.DATA = '12/MAR/2019'
                           And D.CODINTDIARIA = 39726)
        
        ) AB
 Where PP.CODINTPLANEJ = P.CODINTPLANEJ
       And AB.CODINTPLANEJ = P.CODINTPLANEJ
       And AB.COD_LOC_ORIGEM_PLANEJ = P.COD_LOC_ORIGEM
       And AB.COD_LOC_DESTINO_PLANEJ = P.COD_LOC_DESTINO