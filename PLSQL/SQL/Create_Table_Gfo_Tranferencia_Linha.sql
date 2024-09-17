Create Table gfo_Tranferencia_linha(usuarioOrigem Varchar2(15) Not Null 
                                   ,usuarioDestino Varchar2(15) Not Null 
                                   ,codintlinha Number Not Null 
                                   ,DataTranferencia Date Not Null 
                                   ,DataRetorno Date
                                   );
                                   
Alter Table gfo_Tranferencia_linha 
Add Constraint PK_gfo_Tranferencia_linha
Primary Key (usuarioOrigem, usuarioDestino, codintlinha)
Using Index Tablespace GLOBUS_INDEX;
                                   
Alter Table gfo_Tranferencia_linha  
Add ( Constraint fk_GFOTranf_linha 
Foreign Key (codintlinha )
References bgm_cadlinhas ) ;

Alter Table gfo_Tranferencia_linha  
Add ( Constraint fk_GFOTranf_usuarioOri
Foreign Key (usuarioOrigem )
References ctr_cadastrodeusuarios ) ;

Alter Table gfo_Tranferencia_linha  
Add ( Constraint fk_GFOTranf_usuarioDest
Foreign Key (usuarioDestino )
References ctr_cadastrodeusuarios ) ;
