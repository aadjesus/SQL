select *
  from RHTAON_DIALOGO_TITULO 
 where descricao LIKE 'A%'      -- Todas as strings que começam com a letra A 
    or descricao LIKE '%A'      -- Todas as strings que terminam com a letra A 
    or descricao LIKE '%A%'     -- Todas as strings que tenham a letra A em qualquer posição 
    or descricao LIKE 'A_'      -- String de 2 caracteres que tenha a primeira letra A e o segundo caractere seja qualquer outro 
    or descricao LIKE '_A'      -- String de 2 caracteres em que o primeiro caractere seja qualquer um, e o último seja a letra A 
    or descricao LIKE '_A_'     -- String de 3 caracteres cuja segunda letra seja A, e o primeiro e terceiro caractere seja qualquer outro 
    or descricao LIKE '%A_'     -- Letra A na penúltima posição, e o último caractere seja qualquer outro 
    or descricao LIKE '_A%'     -- Letra A na segunda posição, sendo o primeiro caractere qualquer outro 
    or descricao LIKE '___'     -- String com exatos 3 caracteres 
    or descricao LIKE '%'       -- String com pelo menos 2 caracteres    
    or descricao LIKE '%';      -- Retorna todos os clientes que começam com 'a' 
    or descricao LIKE 'a_';     -- Retorna tudo que começam com 'a' e tem dois caracteres 
    or descricao LIKE '[a-c]%'; -- Retorna tudo que começa entre 'a' até 'c' 
    or descricao LIKE '[a-f]%'; -- Hifen (-) --Usando junto com colchetes para intervalos --Retorna tudo que começa entre 'a' e 'f' 
    or descricao LIKE '%lia';   -- localizar todos clientes que terminam com 'lia' 
    or descricao LIKE '_a%';    -- localizar todos clientes que a segunda letra é 'a' 
    or descricao LIKE '[AF]%';  -- localizar todos que começam com Aou F 
    or descricao LIKE '[^F]%';  -- localizar todos que NÃO começam com F use o para exceção, ou seja, diferente do especificado 