create or replace procedure pr_mtk_teste is

	 cursor c_modulo is
			select codsistema, descricaomodulo, id_modulo
				from sii_modulo
			 where moduloativo = 'S';

	 cursor c_cliente is
			select x.codcliente
				from sii_cliente x, sii_contrato b, sii_acessototal c
			 where x.codcliente = b.codcliente
				 and x.codcliente = c.codcliente
				 and b.ativocontrato = 'A'
				 and x.ativocliente = 'A'
				 and c.datalimitedeuso > '01-jan-2015';

	 id number := 0;

begin
	 for modulo in c_modulo loop
			for cliente in c_cliente loop
				 begin
				 
						select nvl(max(id), 0) + 1 into id from mtk_ticket;
				 
						insert into mtk_ticket
							 (id,
								protocolo,
								assunto,
								status,
								data_hora_abertura,
								codcliente,
								id_modulo)
						values
							 (id,
								modulo.codsistema || '_' || id,
								'Teste - ' || modulo.descricaomodulo,
								1,
								sysdate,
								cliente.codcliente,
								modulo.id_modulo);
				 
						insert into mtk_ticketdetalhes
							 (id,
								origem,
								peso,
								prioridade,
								natureza,
								divulgar_big,
								avaliacao_cliente,
								avaliacao_n2,
								data_proxima_acao,
								lido,
								id_severidade)
						values
							 (id,
								'1',
								'1',
								'1',
								'1',
								'N',
								'N',
								'N',
								sysdate,
								'N',
								1
								
								);
				 
				 end;
			end loop;
			commit;
	 end loop;
end pr_mtk_teste;
/