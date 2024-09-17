-- Fazer backup

----- 1
use Auth2
backup database Auth2 
to disk = 'c:/tmp/xxxx.bak'
with init,
name ='aaaaaaa'

----- 2
use Auth2
backup database Auth2 
to disk = 'c:/tmp/xxxx 2.bak'
with differential,  -- Somente com oq está diferente com o ultimo backup
name ='bbbbbb'

-- Restaurar 
use master
restore database Auth
from disk 'c:/tmp/xxxx 2.bak'
with replace
