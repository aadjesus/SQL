Create Table gfo_solturadefrota(dat_escala date not null
                               ,cod_servdiaria varchar2(5) not null   
                               ,cod_intturno number(2) not null
                               ,cod_intescala  number(6) not null                               
                               
                               ,cod_veic number not null
                               ,codintlinha number(5) not null
                               ,tipo varchar2(1) not null
                               ,data_soltura  date not null
                               ,usuario varchar2(15) not null
                               ,cod_localidade number(4) not null
                               );
                               
ALTER TABLE gfo_solturadefrota
ADD CONSTRAINT PK_gfo_solturadefrota
PRIMARY KEY (dat_escala,cod_servdiaria,cod_intturno,cod_intescala)
USING INDEX TABLESPACE GLOBUS_INDEX;                                                                                     

ALTER TABLE gfo_solturadefrota
       ADD  ( CONSTRAINT fk_gfosolturadefrt_cadveiculos
              FOREIGN KEY (cod_veic )
                             REFERENCES frt_cadveiculos ) 
                             ;                           
                
ALTER TABLE gfo_solturadefrota
       ADD  ( CONSTRAINT fk_gfosolturadefrt_cadlinhas
              FOREIGN KEY (codintlinha )
                             REFERENCES bgm_cadlinhas ) 
                             ;

ALTER TABLE gfo_solturadefrota
       ADD  ( CONSTRAINT fk_gfosolturadefrt_cadusu
              FOREIGN KEY (usuario )
                             REFERENCES ctr_cadastrodeusuarios ) 
                             ;
                             
ALTER TABLE gfo_solturadefrota
       ADD  ( CONSTRAINT fk_gfosolturadefrt_cadlocalid
              FOREIGN KEY (cod_localidade )
                             REFERENCES t_esc_localidade ) 