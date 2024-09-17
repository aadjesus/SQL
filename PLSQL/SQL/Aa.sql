SELECT distinct other.table_name "TABELA PAI",
this.constraint_name FROM
USER_CONSTRAINTS this, USER_CONSTRAINTS other 
WHERE other.constraint_name = this.r_constraint_name 
AND this.table_name IN ('TRF_TARIFA') 
AND this.constraint_type = 'R'
ORDER BY 1 
/


PROMPT Verifica dependentes

SELECT other.table_name "TABELA FILHA", other.constraint_name 
FROM USER_CONSTRAINTS this,USER_CONSTRAINTS other 
WHERE this.constraint_name = other.r_constraint_name 
AND this.table_name IN ('TRF_TARIFA') 
AND other.constraint_type = 'R' 
AND other.r_owner = this.owner
ORDER BY 1
/
