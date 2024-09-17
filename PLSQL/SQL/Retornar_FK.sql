select *
from user_constraints

where r_constraint_name in (
    select constraint_name
    from user_constraints
    where table_name='MTK_SLA'
);