

insert into UsuarioFornecedor(
	Id_Fornecedor, 
	Id_Usuario, 
	Administrador, 
	Ativo) values (
	(select max(a1.Id) from fornecedor a1  where exists(select 1 from empresa	b1 where a1.Id_Empresa = b1.Id and b1.cnpj = '22135856000107')),
	(select max(a2.Id) from Usuario	   a2  where exists(select 1 from Users		b2 where a2.Id_User    = b2.Id and b2.cpf  = '00881441783')), 
	0,
	1	)
	
insert into usuariocomprador(
	Id_Comprador, 
	Id_Usuario, 
	Administrador) 
	values (
	(select max(a1.Id) from comprador a1  where exists(select 1 from empresa  b1 where a1.Id_Empresa = b1.Id and b1.cnpj = '07031916002959')),
	(select max(a2.Id) from Usuario	  a2  where exists(select 1 from Users	  b2 where a2.Id_User    = b2.Id and b2.cpf  = '22769093827')), 
	0)	