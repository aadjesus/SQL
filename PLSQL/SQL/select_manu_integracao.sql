--select etapa, transaction_id,  count(*) from manu_integracao where table_name = 'MAN_OS' group by transaction_id, etapa




select * from 
manu_integracao
where id in(

select id
  from manu_integracao a
inner join  man_os b on b.codintos = SUBSTR(a.conteudo,INSTR(a.conteudo, ':') + 3,INSTR(a.conteudo, '}') -(INSTR(a.conteudo, ':') + 3 + 2))
where a.table_name = 'MAN_OS'
--  and a.etapa = 3
and a.transaction_id = '35.31.986400'
-- and b.dataaberturaos >= TO_DATE('01-01-2024', 'DD-MM-YYYY')
)


--delete manu_integracao  where etapa = 3 and table_name = 'MAN_OS' 
--select etapa, count(*) from manu_integracao where table_name = 'MAN_OS' group by etapa

select *
  from manu_integracao a
--inner join  man_os b on b.codintos = SUBSTR(a.conteudo,INSTR(a.conteudo, ':') + 3,INSTR(a.conteudo, '}') -(INSTR(a.conteudo, ':') + 3 + 2))
where a.table_name = 'MAN_OS_3'
-- and b.condicaoos = 'FC'


/*

select count(*)
  from manu_integracao a
 where a.table_name = 'MAN_OS'
   and exists (select 1
          from man_os b
         where b.codintos =
               to_number(SUBSTR(a.conteudo,
                                INSTR(a.conteudo, ':') + 3,
                                INSTR(a.conteudo, '}') -
                                (INSTR(a.conteudo, ':') + 3 + 2)))
           and b.condicaoos = 'FC')
           
*/