create or replace trigger tr_mtk_atualizagrupoatend
	 before insert on sii_gruposatendimento_func
	 for each row
begin
	 select a.id
		 into :new.id_operador
		 from mtk_operador a inner join sii_funcionario b
     on a.codigofuncionario = b.codigofuncionario 
		where b.codigofuncionario = :new.codigofuncionario
			and a.perfil = 0;
end tr_mtk_atualizagrupoatend;