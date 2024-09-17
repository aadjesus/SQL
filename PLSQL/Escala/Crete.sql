
/*
DROP USER EscalaTeste2 Cascade;
CREATE USER EscalaTeste2 IDENTIFIED BY EscalaTeste2 DEFAULT TABLESPACE GLOBUS_TABLE;
GRANT DBA TO EscalaTeste2;
GRANT CONNECT TO EscalaTeste2;
*/

CREATE USER books_admin IDENTIFIED BY MyPassword;
GRANT CONNECT TO books_admin;
GRANT CONNECT, RESOURCE, DBA TO books_admin;
GRANT CREATE SESSION GRANT ANY PRIVILEGE TO books_admin;
GRANT UNLIMITED TABLESPACE TO books_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON schema.books TO books_admin;

GRANT SELECT, INSERT, UPDATE, DELETE  on frt_cadveiculos TO EscalaTeste2;

grant execute on procedurename to all;

grant select on delirio.valores_if to test;

GRANT CREATE ANY TRIGGER TO EscalaTeste2;

select * from EscalaTeste2.Versioninfo
select * from EscalaTeste2.veiculo
select * from EscalaTeste2.funcionario
select * from EscalaTeste2.EscalaPadraoServico;
select * from EscalaTeste2.Tecnologia

drop table EscalaTeste2.EscalaPadraoServicoFuncionario ;
drop table EscalaTeste2.EscalaPadraoServicoViagem;
drop table EscalaTeste2.EscalaPadraoServico;
drop table EscalaTeste2.Servico;
drop table EscalaTeste2.EscalaPadrao;
drop table EscalaTeste2.DiaDaSemana;
drop table EscalaTeste2.TipoDeDia;

delete EscalaTeste2.Servico;
delete EscalaTeste2.EscalaPadrao;

select * from EscalaTeste2.EscalaPadrao where id = 1482
select * from EscalaTeste2.Veiculo where id = 632
select * from EscalaTeste2.Servico where id = 1521
select * from EscalaTeste2.EscalaPadraoservico  where id = 1084
select * from EscalaTeste2.EscalaPadraoServicoViagem

Select Max(f.Id)
                  From   EscalaTeste2.Filial f
                  Inner  Join EscalaTeste2.Empresa e On f.IdEmpresa = e.Id
                  Where  e.Codigo = :New. codigoempresa
                         And f.Codigo = :New.codigof
                         
alter table frt_cadveiculos  add(idexterno varchar2(40)  )
alter table bgm_cadlinhas  add(idexterno varchar2(40)  )
alter table Flp_Funcionarios  add(idexterno varchar2(40)  )
alter table frt_tipodefrota add(idexterno varchar2(40)  )
alter table T_ESC_ESCALAPADRAO add(idexterno varchar2(40)  default sys_ )

alter table  escalateste2.Escalapadrao add(DataHoraExclusao raw(16)  )

select count(*) from escalateste2.Veiculo
select count(*) from frt_cadveiculos

update frt_tipodefrota set descricaotpfrota = descricaotpfrota;
update frt_cadveiculos set viradaroletaveic = viradaroletaveic;

grant update, insert on escalateste2.Tecnologia to VIASUL180418;
grant update, insert on escalateste2.Funcionario to VIASUL180418;
grant update, insert on escalateste2.Linha to VIASUL180418;
GRANT CREATE ANY TRIGGER TO VIASUL180418;
GRANT EXECUTE ANY PROCEDURE TO VIASUL180418;

grant update, insert, select on escalateste2.Tecnologia to VIASUL180418;
grant update, insert, select on escalateste2.Escalapadrao to VIASUL180418;

grant update, insert, select on escalateste2.Tipodedia to VIASUL180418;
grant update, insert, select on escalateste2.Diadasemana to VIASUL180418;


grant select on SYS.DBA_DATA_FILES to EscalaTeste2;
grant select on SYS.DBA_FREE_SPACE to EscalaTeste2;
grant select on SYS.DBA_SEGMENTS to EscalaTeste2;
grant select on SYS.DBA_TABLESPACES to EscalaTeste2;
grant select on SYS.DBA_TEMP_FILES to EscalaTeste2;
grant select on SYS.V_$SESSION to EscalaTeste2;
grant select on SYS.V_$SORT_SEGMENT to EscalaTeste2;
-- Grant/Revoke role privileges 
grant connect to EscalaTeste2;
grant dba to EscalaTeste2;
grant imp_full_database to EscalaTeste2;
grant resource to EscalaTeste2;
grant select_catalog_role to EscalaTeste2;
-- Grant/Revoke system privileges 
grant create public synonym to EscalaTeste2;
grant debug any procedure to EscalaTeste2;
grant debug connect session to EscalaTeste2;
grant select any table to EscalaTeste2;
grant unlimited tablespace to EscalaTeste2;
select * from BGM_GLB7_CARGA_INICIAL
