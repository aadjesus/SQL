-- Apagar um campo de uma tabela
Alter Table TABELA Drop Column CAMPO ;

-- Criar colunas
Alter Table TABELA ADD ( CAMPO1 NUMBER(15,3),
                         CAMPO2 VARCHAR2(1) DEFAULT 'A',
                         CAMPO2 VARCHAR2(50) ) ;
-- Criar tabela
Creat Table NOME_TABELA ( CAMPO1 NUMBER,
                          CAMPO2 VARCHAR2(10) ) ; 

-- Inserir registro
Insert Into Tabela (Campo1,Campo2 ) Values (1,2)

-- Altera registro
Update TABELA Set Campo1 = 2 And Campo2 = 4 Where Campo1 = 5

-- Apagar registro
Delete TABELA Where Campo1 = 5


 