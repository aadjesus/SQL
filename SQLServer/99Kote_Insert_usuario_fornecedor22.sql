--select * from Users where Username = 'viagroup'
--select * from [Auth].[dbo].[Users] where Username = 'viagroup'

--select max(id) from Users  where email like '%bruna.aguiar%'

--8417
--8037 [dbo].[Users]

--insert into Users (id, CPF, EMAIL, NOME, Password, Username) 
--           values (8417
--				  ,'69484528090'
--				  ,'bruna.aguiar@kmm.com.br'
--				  ,'Comprador Comercial'
--				  ,'d1bc2a60fa1d5f5254a70f8abc86f046'
--				  ,'viagroup')

--select * from Users  where email like '%bruna.aguiar%'

--Select CPF, EMAIL, NOME, Password, Username from Users a
--insert into Users (CPF, EMAIL, NOME, Password, Username) 
--           values ('69484528090'
--				  ,'bruna.aguiar@kmm.com.br'
--				  ,'Comprador Comercial'
--				  ,'d1bc2a60fa1d5f5254a70f8abc86f046'
--				  ,'viagroup')

--select * from Empresa a where a.CNPJ in ('07031916002959','12898982000160')
select * from Comprador a1 where a1.Id_Empresa in (33693,33737)
select * from usuariocomprador a2 where a2.Id_Comprador in (7977,7978)

tabelas - 
	Empresa	    	 (cadastro da empresa), 
	Comprador	     (empresa virou comprador), 
	Users		     (cadastro do user), 
	Usuario		 	 (user se transformou em usuário), 
	usuariocomprador (usuario se transformou em comprador)

insert into usuario (Id_User, Ativo, Id_Perfil)
             values (8417, 1, 4)

select count(*) from Users


select a.Id, a.Id_User, a.Ativo, a.Id_Perfil  from usuario a where a.Id_User in (58,6036,6437, 8417);
select * from Users a where a.id in (58,6036,6437)

select * from Perfil
select count(*) from Users
6313
5936

insert into usuariocomprador(
	Id_Comprador, 
	Id_Usuario, 
	Administrador) 
	values (
	(select max(a1.Id) from comprador a1  where exists(select 1 from empresa  b1 where a1.Id_Empresa = b1.Id and b1.cnpj = '12898982000160')),
	8417, 
	0)	