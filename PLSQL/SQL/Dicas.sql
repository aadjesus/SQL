----------------------------------
-- Salva o SQL no arquivo definido
Sql.SaveToFile('H:\temp\teste.sql') ;

----------------------------------
-- Mostra as colunas de uma tabela
SELECT COLUMN_NAME QTD FROM USER_TAB_COLUMNS WHERE TABLE_NAME LIKE 'TUR%'

-------------------------------
-- Mostra todas tabelas do FRT
Select Table_Name From User_Tables Where Table_Name Like 'TUR%' 

--------------------------------------------------------------------------
-- Mostra todas tabelas com o significado de cada uma Dicionario do oracle
select * 
  from dict a where a.table_name like 'USER%'

select * from all_catalog
-- 1º USER_  = Retornam informações a respeito dos objetos criados pelo usuário conectado               
-- 2º All_   = Retornam informações de todos objetos criados pelo usuário conectado,
--	       	   e tb informações sobre os objetos que o usuário possui algum tipo
--             de acesso(inserção/atualização/remoção e consulta)          
-- 3º DBA_   = Geralmente sao acessíveis pelo administrador do banco, retorna informações 
--             de todos objetos do banco, independentemente de quem é o proprietário ou 
--             do privilegio de acesso.    
--
-- VISAO Tipo de informações
-- AAA_TABLES         = inf sabre tab relacionadas
-- AAA_TAB_COMENTES   = comentários do usuário com respeito a tab
-- AAA_TAB_COLUMNS    = inf sobres as colunas
-- AAA_VIEWS          = inf sobre visões criadas no banco
-- AAA_INDEXES        = inf sobre índices
-- AAA_IND_COLUMNS    = inf sobre colunas q compõem cada índice
-- AAA_CONS_COLUMNS   = inf sobre as colunas de cada restrição
-- AAA_SEQUENCES      = inf sobre as sequencias
-- AAA_SYNONYMS       = inf sobre sinônimos
-- AAA_TRIGGERS       = inf sobre gatilhos de cada tab

------------------------------------------------------
-- Mostra todas Function do banco q contem MOT no nome
select * 
  from user_objects  a 
 where a.object_name like '%MOT%' 
   and a.object_type='FUNCTION'

-------------------------------------------------------------
-- Mostra todas Function do banco q contem o MOT no ser corpo
select distinct b.name 
  from user_source b 
 where b.text like '%MOT%' 
   and b.type='FUNCTION'

SELECT * 
  FROM DBA_USERS 
 WHERE DEFAULT_TABLESPACE = 'GLOBUS_TABLE'
