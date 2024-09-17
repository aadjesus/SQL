using FluentMigrator;

namespace BgmRodotec.Manutencao.Service.Migrations
{
    [Migration(11)]
    public class Rodar_Carga_Inicial : Migration
    {
        public override void Down()
        {            
        }
        public override void Up()
        {
            //Migration obsoleta. Porém, não pode ser excluída, pois esse número de versão 11 já está reservado
            //Execute.Sql("DELETE FROM MANU_CARGA_INICIAL WHERE TABLE_NAME in ('MAN_CADASTRODESERVICOS', 'EST_PARAMETRO', 'ABA_CADTIPOOLEOCOMBO')");
            //Execute.Sql("BEGIN PR_MANU_CARGA_INICIAL(1); END;");
        }
    }
}
