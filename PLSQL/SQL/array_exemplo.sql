select a.column_value as 
  from table(sys.odcivarchar2list('aaaa','bbbb','cccc')) a

with Item(id, name, descr) as
(
 select 'id1', 'name1', 'description containing Test'   from dual union all
 select 'id2', 'name2', 'description containing Others' from dual union all
 select 'id3', 'name3', 'description containing nothing interesting' from dual
)
SELECT 
    ID,
    NAME,
    descr,
    case
        when instr(Descr, 'Test') != 0 then 'contains Test' 
        when instr(Descr, 'Other')!= 0 then 'contains Other'
        Else 'No Match'
    End as "Match"
From Item

/*
------------------ 1
SELECT 
       REGEXP_SUBSTR( t.list, '([^,]*)($|,)', 1, l.lvl, NULL, 1 ) AS item,
       l.lvl
FROM   (select 'aaa, b, c' as list from dual) t
       CROSS APPLY
       (
         SELECT LEVEL AS lvl
           FROM DUAL
         CONNECT BY LEVEL <= REGEXP_COUNT( t.list, ',' ) + 1
       ) l;
	   
------------------ 2	   
SELECT
    TRIM(REGEXP_SUBSTR(sua_string, '[^,]+', 1, LEVEL)) AS sua_coluna
FROM
    (SELECT 'valor1,valor2,valor3,valor4' AS sua_string FROM DUAL)
CONNECT BY
    LEVEL <= LENGTH(sua_string) - LENGTH(REPLACE(sua_string, ',', '')) + 1;	   
	   
*/