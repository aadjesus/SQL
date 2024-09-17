create or replace trigger tr_sii_associaclientemodulo
	 before insert on sii_associaclientemodulo
	 for each row
begin
	 select id_modulo
     into :new.id_modulo
		 from sii_modulo
		where codsistema = :new.codsistema
			and codmodulo = :new.codmodulo;
end tr_sii_associaclientemodulo;