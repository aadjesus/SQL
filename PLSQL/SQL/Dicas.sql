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
select * from dict a where a.table_name like 'USER%'

select * from all_catalog
-- 1� USER_  = Retornam informa��es a respeito dos objestos cirados pelo usuario conectado               
-- 2� All_   = Retornam informa��es de todos objetos criados pelo usuario conectado,
--	       e tb informa��es sobre os objesot que o usuario possui algum tipo
--             de acesso(insercao/atualiza��o/remo��o e consulta)          
-- 3� DBA_   = Geralmente sao acessiveis pelo administrador do banco, retorna informa��es 
--             de todos objetos do banco, independentemente de quem � o proprietario ou 
--             do privilegio de acesso.    
--
-- VISAO Tipo de inform��es
-- AAA_TABLES         = inf sabre tab relacionadas
-- AAA_TAB_COMENTES   = comentarios do usuario com respeito a tab
-- AAA_TAB_COLUMNS    = inf sobres as colunas
-- AAA_VIEWS          = inf sobre visoes criadas no banco
-- AAA_INDEXES        = inf sobre indices
-- AAA_IND_COLUMNS    = inf sobre colunas q comp�em cada indice
-- AAA_CONS_COLUMNS   = inf sobre as colunas de cada restrincao
-- AAA_SEQUENCES      = inf sobre as sequencias
-- AAA_SYNONYMS       = inf sobre sinonimos
-- AAA_TRIGGERS       = inf sobre gatilhos de cada tab

------------------------------------------------------
-- Mostra todas Function do banco q contem MOT no nome
select * from user_objects  a where a.object_name like '%MOT%' and a.object_type='FUNCTION'

-------------------------------------------------------------
-- Mostra todas Function do banco q contem o MOT no ser corpo
select distinct b.name from user_source b where b.text like '%MOT%' and b.type='FUNCTION'

SELECT * FROM DBA_USERS WHERE DEFAULT_TABLESPACE = 'GLOBUS_TABLE'
