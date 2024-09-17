-- 4º Criar tabelas, pks, e fks relacionadas ao envio 
Create Table Gfo_Operadora_Mensagem(cod_operadora number(3)
                                   ,cod_mensagem  number(4) 
                                   ,cod_mensagem_ope varchar2(10)
                                   ,cod_grupo_ope varchar2(10)
                                   );                                   
                                   
ALTER TABLE Gfo_Operadora_Mensagem 
ADD CONSTRAINT PK_Gfo_Operadora_Mensagem
PRIMARY KEY (cod_operadora, cod_mensagem)
USING INDEX TABLESPACE GLOBUS_INDEX

ALTER TABLE Gfo_Operadora_Mensagem 
ADD ( CONSTRAINT fk_GfoOperadoraMsg_Opre
FOREIGN KEY (cod_operadora )
REFERENCES gfo_operadora ) 

ALTER TABLE Gfo_Operadora_Mensagem 
ADD ( CONSTRAINT fk_GfoOperadoraMsg_Msg
FOREIGN KEY (cod_mensagem ) 
REFERENCES gfo_mensagens ) 
                                    
