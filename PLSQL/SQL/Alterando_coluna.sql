--@c:\Users\alessandro.augusto\Documents\SQL\Sql\Alterando_Coluna.sql;
Clear;
PROMPT 
PROMPT ## ---------------------------------------------------------- ##
PROMPT ##                           1o Etapa                         ##
PROMPT ## ---------------------------------------------------------- ##
PROMPT ## 1o Criar tabela "XISTO"                                    ##
PROMPT ## 2o Mostrar estrurura                                       ##
PROMPT ## 3o Inserir dados                                           ##
PROMPT ## 4o Mostrar dados                                           ##
PROMPT ## ---------------------------------------------------------- ##
PROMPT 
PAUSE OK para continuar.;
Create Table XISTO (Descricao Varchar2(10),Valor Number(10,6) Not Null);
PROMPT 
Desc XISTO;
PROMPT 
Insert Into XISTO(Valor, Descricao) Values (1.123456,'A1'); -- Inserir dados
Insert Into XISTO(Valor, Descricao) Values (2.123456,'A2'); -- Inserir dados
PROMPT  
Select * From XISTO;                                     -- Verificar
PROMPT 
PROMPT ## 1o Etapa concluida
PAUSE OK para continuar.;
--------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
Clear;
PROMPT 
PROMPT ## ---------------------------------------------------------- ##
PROMPT ##                        2o Etapa                            ##
PROMPT ## ---------------------------------------------------------- ##
PROMPT ## 1o Incluir coluna temporaria "Valor1"                      ##
PROMPT ## 2o Mostrar nova estrurura                                  ##
PROMPT ## 3o Inserir os dados da coluna "Valor" para coluna "Valor1" ##
PROMPT ## 4o Mostrar dados                                           ##
PROMPT ## ---------------------------------------------------------- ##
PROMPT 
PAUSE OK para continuar.;
Alter Table XISTO Add(Valor1 Number(10,3)); -- Cria coluna temporaria
PROMPT 
Desc XISTO;                                 -- Mostra estrutura   
PROMPT 
Update XISTO Set Valor1 = Valor;            -- Grava os dados da coluna oficial para a temporaria
PROMPT 
Select * From XISTO;                        -- Verificar
PROMPT 
PROMPT ## 2o Etapa concluida
PAUSE OK para continuar.;
--------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
Clear;
PROMPT 
PROMPT ## ---------------------------------------------------------- ##
PROMPT ##                        3o Etapa                            ##
PROMPT ## ---------------------------------------------------------- ##
PROMPT ## 1o Apagar a coluna "Valor"                                 ##
PROMPT ## 2o Mostrar nova estrurura                                  ##
PROMPT ## 3o Mostrar dados                                           ##
PROMPT ## ---------------------------------------------------------- ##
PROMPT 
PAUSE;
Alter Table XISTO Drop Column Valor; -- Drop coluna oficial
PROMPT 
Desc XISTO;                          -- Mostra estrutura   
PROMPT 
Select * From XISTO;                 -- Verificar
PROMPT 
PROMPT ## 3o Etapa concluida
PAUSE OK para continuar.;
--------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
Clear;
PROMPT 
PROMPT ## ---------------------------------------------------------- ##
PROMPT ##                        4o Etapa                            ##
PROMPT ## ---------------------------------------------------------- ##
PROMPT ## 1o Incluir a coluna "Valor" com a nova estrutura           ##
PROMPT ## 2o Inserir os dados da coluna "Valor1" para coluna "Valor" ##
PROMPT ## 3o Alterar estrutura da coluna "Valor" para Not Null       ##
PROMPT ## 4o Mostrar nova estrurura                                  ##
PROMPT ## 3o Mostrar dados                                           ##
PROMPT ## ---------------------------------------------------------- ##
PROMPT 
PAUSE OK para continuar.;
Alter Table XISTO Add(Valor Number(10,3)); -- Cria coluna oficial novamente
PROMPT 
Update XISTO Set Valor = Valor1;           -- Grava os dados da coluna temporaria para a oficial
PROMPT 
Alter Table XISTO Modify Valor Not Null;   -- Altera coluna para not null
PROMPT 
Desc XISTO;                                -- Mostra estrutura   
Select * From XISTO;                       -- Verificar
PROMPT 
PROMPT ## 4o Etapa concluida
PAUSE OK para continuar.;
--------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
Clear;
PROMPT 
PROMPT ## ---------------------------------------------------------- ##
PROMPT ##                        5o Etapa                            ##
PROMPT ## ---------------------------------------------------------- ##
PROMPT ## 1o Apagar a coluna "Valor1"                                ##
PROMPT ## 2o Mostrar nova estrurura                                  ##
PROMPT ## 3o Mostrar dados                                           ##
PROMPT ## ---------------------------------------------------------- ##
PROMPT 
PAUSE OK para continuar.;
Alter Table XISTO Drop Column Valor1;  -- Drop coluna temporaria
PROMPT 
Desc XISTO;                            -- Mostra estrutura   
PROMPT 
Select * From XISTO;                   -- Verificar
PROMPT 
PROMPT ## 5o Etapa concluida
PAUSE OK para continuar.;
Clear;
--------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
Rollback;
Drop Table XISTO; 
PROMPT 
PROMPT ## Tabela exluida do banco

