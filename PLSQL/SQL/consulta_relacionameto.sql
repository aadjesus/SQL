     Select a.table_name
          , a.column_name
          , a.constraint_name       
       From user_cons_columns   a
 inner Join user_constraints    b On a.constraint_name   = b.constraint_name
 inner Join user_constraints    c On b.r_constraint_name = c.constraint_name
      Where c.table_name = 'MTK_OPERADOR'
   Order By table_name;


Select a.table_name,
       Cast(a.column_name As Varchar(100)) As column_name,
       a.constraint_name,
       a.position,
       c_pk.table_name r_table_name,
       c_pk.constraint_name r_pk,
       Cast((Select ax.column_name
               From user_cons_columns ax
              Where ax.owner = c_pk.owner
                    And ax.constraint_name = c_pk.constraint_name
                    And ax.position = a.position) As Varchar(100)) As MainColumnName
  From user_cons_columns a
  Join user_constraints c On a.owner = c.owner  And a.constraint_name = c.constraint_name
  Join user_constraints c_pk On c.r_owner = c_pk.owner And c.r_constraint_name = c_pk.constraint_name
 Where upper(c_pk.table_name) = upper('MTK_OPERADOR')
 Order By table_name, constraint_name, position
 
 