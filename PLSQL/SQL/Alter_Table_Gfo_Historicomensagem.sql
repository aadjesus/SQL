-- 1º Apagar oq existe
Alter Table GFO_HISTORICOMENSAGEM Drop Constraint XPKGFO_HISTORICOMENSAGEM;
Drop Index XPKGFO_HISTORICOMENSAGEM;

Alter Table GFO_HISTORICOMENSAGEM Drop Column motorista;
Alter Table GFO_HISTORICOMENSAGEM Drop Column id_motorista;

-- 2º Incluir novos campos 
Alter Table GFO_HISTORICOMENSAGEM Add(id_mensagem Number 
                                     ,tipo varchar2(1) Default 'N'
                                     ,id_controle_operacional Number  
                                     ,id_mensagemRetorno Number
                                     ,origem varchar2(1) Default 'I'
                                     ,usuario varchar2(15) 
                                     );                           

Alter Table GFO_HISTORICOMENSAGEM Add(data_Leitura Date);

-- 3º Criar pk e fk
Alter Table GFO_HISTORICOMENSAGEM 
Add Constraint PK_GFO_HISTORICOMENSAGEM
Primary Key (id_mensagem)
Using Index Tablespace GLOBUS_INDEX;

Alter Table GFO_HISTORICOMENSAGEM 
Add ( Constraint fk_GFOHISTORICOmsg_ctrlope
Foreign Key (id_controle_operacional )
References gfo_controleoperacional ) 

Alter Table GFO_HISTORICOMENSAGEM 
Add ( Constraint fk_GFOHISTORICOmsg_cadusu
Foreign Key (usuario )
References ctr_cadastrodeusuarios ) 