create or replace procedure pr_sii_associaclientemodulo is
	 cursor c_modulo is
			select codsistema, codmodulo, id_modulo from sii_modulo;
begin
	 for item_cursor in c_modulo() loop
			update sii_associaclientemodulo
				 set id_modulo = item_cursor.id_modulo
			 where codsistema = item_cursor.codsistema
				 and codmodulo = item_cursor.codmodulo
                 and id_modulo is null;
			commit;
	 end loop;
end pr_sii_associaclientemodulo;
