--- https://www.revista-programar.info/artigos/planos-de-execucao-em-oracle/

-- 1
-- Gerando Plano de exeu��o

EXPLAIN PLAN FOR 
        SELECT * FROM Tabela

-- Analizando plano
 SELECT * FROM TABLE(dbms_xplan.display)

 -- 2
 -- Gerando Plano de exeu��o
--EXPLAIN PLAN FOR 
EXPLAIN PLAN SET STATEMENT_ID = 'NOME_PLANO' FOR
        SELECT * FROM empresa

-- Analizando plano
SELECT * FROM TABLE(dbms_xplan.display('plan_table', 'NOME_PLANO', 'all'));