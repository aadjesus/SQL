create or replace trigger tr_mtk_desativaroperador_cont
	 after update on sii_contatocliente
	 for each row
begin
	 if :new.ativocontatocli   = 'N' then
			update mtk_operador
				 set ativo = 'N'
			 where usuario = :old.emailcontatocli
				 and senha = :old.senhaweb;
	 end if;
end tr_mtk_desativaroperador_cont;