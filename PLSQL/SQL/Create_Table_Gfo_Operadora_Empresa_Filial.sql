Create Table Gfo_Operadora_empresa_filial(cod_operadora number(3)
                                         ,codigoempresa number(3)  
                                         ,codigofl number(3)
                                         ,id_empresa varchar2(10)
                                         ,id_operadora varchar2(10)
                                         );
                                          
ALTER TABLE Gfo_Operadora_empresa_filial 
ADD CONSTRAINT PK_Gfo_Operadora_empresa_fil
PRIMARY KEY (cod_operadora, codigoempresa, codigofl)
USING INDEX TABLESPACE GLOBUS_INDEX

ALTER TABLE Gfo_Operadora_empresa_filial
ADD ( CONSTRAINT fk_GfoOperadoraEmpFil_ope
FOREIGN KEY (cod_operadora )
REFERENCES gfo_operadora ) 

ALTER TABLE Gfo_Operadora_empresa_filial
ADD ( CONSTRAINT fk_GfoOperadoraEmpFil_filial
FOREIGN KEY (codigoempresa, codigofl )
REFERENCES ctr_filial ) 
