create or replace trigger tr_mtk_pendente
	 after insert or update or delete on mtk_ticket
	 for each row
declare
	 achougrupo boolean := false;
	 cursor cgrupodeatendimento(pmodulo sii_gruposatendimento_modulos.id_modulo%type) is
			select codigo_grupo
				from sii_gruposatendimento_modulos a
			 where id_modulo = pmodulo;
begin
	 if inserting then
			begin
				 for cursorgrupo in cgrupodeatendimento(:new.id_modulo) loop
						insert into mtk_ticketpendente
							 (id_ticket, codcliente, codigo_grupo)
						values
							 (:new.id, :new.codcliente, cursorgrupo.codigo_grupo);
				 
						achougrupo := true;
				 end loop;
			
				 if not achougrupo then
						insert into mtk_ticketpendente
							 (id_ticket, codcliente)
						values
							 (:new.id, :new.codcliente);
				 end if;
			
			end;
	 else
			begin
				 -- 5 = cancelado / 6 = concluido
				 if :new.status = 5 or :new.status = 6 or deleting then
						delete mtk_ticketpendente where id_ticket = :old.id;
				 end if;
			end;
	 end if;
end tr_mtk_pendente;
/