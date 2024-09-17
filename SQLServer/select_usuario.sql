DECLARE 
 @vUsername    Varchar(100),
 @vIdUserAuth  INT, 
 @vIdUser99    INT 

set @vUsername = 'aaa'

    select @vIdUser99 = a.id
         , @vIdUserAuth = b.Id
      from ComprasTeste.dbo.Usuario a
inner join Users b on a.Id_User = b.Id
     where b.Username = @vUsername

--set @vIdUser99 = 11206

delete UsersPhone 
 where Id_User = @vIdUserAuth

delete Users 
 where id = @vIdUserAuth

delete ComprasTeste.dbo.GrupoUsuario
 where Id_Usuario =  @vIdUser99

delete ComprasTeste.dbo.UsuarioProdutoGrupo
 where Id_Usuario =  @vIdUser99

delete ComprasTeste.dbo.UsuarioFornecedor 
 where Id_Usuario =  @vIdUser99

delete ComprasTeste.dbo.Usuario
 where id = @vIdUser99

 -- select * from ComprasTeste.dbo.Usuario