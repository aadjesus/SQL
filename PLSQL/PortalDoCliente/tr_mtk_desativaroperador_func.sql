create or replace trigger tr_mtk_desativaroperador_func
	 after update on sii_funcionario
	 for each row
begin
	 if :new.ativofuncionario = 'I' then
			update mtk_operador
				 set ativo = 'N'
			 where usuario = :old.nomeabreviadofuncionario
				 and senha = :old.senhadeacessofuncionario;
	 end if;
end tr_mtk_desativaroperador_func;