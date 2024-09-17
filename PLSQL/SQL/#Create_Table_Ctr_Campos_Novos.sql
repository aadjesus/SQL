-- 1o: Colocar cadastro de usuarios opcoes:
--      a. Opcao para criar novos campos,que vai ser habilitada se o mesmo tambem for o administrador 
--      b. Opcao para acessar os campos criados
-- 2o: Limitar criacao de campos (No maximo 99 nomero a ser analizado)
--      a. x
-- 3o: Criar a nova tabela quando a mesma nao existir
--      a. Nomenclatura nome_tabela_atua_novos_compos
--      b. pk chave = 

Create Table Ctr_Campos_Novos(Codigo_Interno number
                             ,Nome_Tabela_Pai Varchar2(50)
                             ,Nome_Tabela_Nova Varchar2(50)
                             ,Usuario Varchar2(15) Not Null
                             ,Sistema Varchar2(3)
                             ,Data_Criacao Date
                             ,Nome_Campo Varchar2(50)     -- O nome do campo vai ser composto pelo tipo + numero. Ex: String01
                             ,Descricao_Campo Varchar2(50)
                             ,Tipo_Campo Varchar2(1)      -- Controlar os tipos possiveis Ex: Varchar2, boolean, Date, number
                             ,Tamanho number              -- Tamanho do campo limite maximo para Varchar2 = 4000 e Number = 20
                             ,Permisoes Varchar2(3)       -- Incluir \ Alterar \ Visualizar
                             );

Alter Table Ctr_Campos_Novos Add(Constraint Pk_Ctr_Campos_Novos
                                 Primary Key(Codigo_Interno) Using Index
                                 Tablespace Globus_Index);

Alter Table Ctr_Campos_Novos Add(Constraint Fk_CtrLogClasse_CtrCadUsu
                                 Foreign Key(Usuario) 
                                 References Ctr_Cadastrodeusuarios);

Alter Table Ctr_Campos_Novos Add(Constraint Fk_CtrLogClasse_CtrCadSis
                                 Foreign Key(Sistema) 
                                 References Ctr_Cadastrosistemas);
                        
                        
                        
                             