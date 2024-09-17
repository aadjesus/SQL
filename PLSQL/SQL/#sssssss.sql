select * from BGM_ATUALIZAMENUS_GLB5, BGM_ATUALIZAMENUS_GLB5_CLI
where 
(indicemenu = 520201	and modulo = 'FRE') or
(indicemenu = 5113	  and modulo = 'ACD') or
(indicemenu = 510502	and modulo = 'SRH') or
(indicemenu = 510503	and modulo = 'SRH')


select * from ctr_concedente 

select a.indicemenu,a.modulo,count(*) from BGM_ATUALIZAMENUS_GLB5 a group by a.indicemenu,a.modulo

create table BGM_ATUALIZAMENUS_GLB5_CLI
(
  MODULO        VARCHAR2(3)
  NOME          VARCHAR2(30),
  CODIGOCLIENTE NUMBER(4),
  CHECKSUM      VARCHAR2(30)
)


select * from BGM_ATUALIZAMENUS_GLB5 a, BGM_ATUALIZAMENUS_GLB5_CLI b, ctr_concedente c
where a.modulo = b.modulo(+)
and a.nome = b.nome(+)
and b.codigocliente = c.codigocliente
and a.modulo = 'ABA'

select a.*,rowid from BGM_ATUALIZAMENUS_GLB5_CLI a

GL5	ABA	5112	  Tanque1	  Tanque
GL5	ABA	510802	Filiais1	Filiais
GL5	ABA	530101	ConsumoArla32	Consumo Arla 32*/

insert 