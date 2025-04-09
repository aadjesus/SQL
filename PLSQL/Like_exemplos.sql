select *
  from RHTAON_DIALOGO_TITULO 
 where descricao LIKE 'A%'      -- Todas as strings que come�am com a letra A 
    or descricao LIKE '%A'      -- Todas as strings que terminam com a letra A 
    or descricao LIKE '%A%'     -- Todas as strings que tenham a letra A em qualquer posi��o 
    or descricao LIKE 'A_'      -- String de 2 caracteres que tenha a primeira letra A e o segundo caractere seja qualquer outro 
    or descricao LIKE '_A'      -- String de 2 caracteres em que o primeiro caractere seja qualquer um, e o �ltimo seja a letra A 
    or descricao LIKE '_A_'     -- String de 3 caracteres cuja segunda letra seja A, e o primeiro e terceiro caractere seja qualquer outro 
    or descricao LIKE '%A_'     -- Letra A na pen�ltima posi��o, e o �ltimo caractere seja qualquer outro 
    or descricao LIKE '_A%'     -- Letra A na segunda posi��o, sendo o primeiro caractere qualquer outro 
    or descricao LIKE '___'     -- String com exatos 3 caracteres 
    or descricao LIKE '%'       -- String com pelo menos 2 caracteres    
    or descricao LIKE '%';      -- Retorna todos os clientes que come�am com 'a' 
    or descricao LIKE 'a_';     -- Retorna tudo que come�am com 'a' e tem dois caracteres 
    or descricao LIKE '[a-c]%'; -- Retorna tudo que come�a entre 'a' at� 'c' 
    or descricao LIKE '[a-f]%'; -- Hifen (-) --Usando junto com colchetes para intervalos --Retorna tudo que come�a entre 'a' e 'f' 
    or descricao LIKE '%lia';   -- localizar todos clientes que terminam com 'lia' 
    or descricao LIKE '_a%';    -- localizar todos clientes que a segunda letra � 'a' 
    or descricao LIKE '[AF]%';  -- localizar todos que come�am com Aou F 
    or descricao LIKE '[^F]%';  -- localizar todos que N�O come�am com F use o para exce��o, ou seja, diferente do especificado 