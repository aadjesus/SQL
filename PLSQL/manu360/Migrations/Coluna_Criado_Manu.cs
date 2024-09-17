using FluentMigrator;

namespace BgmRodotec.Manutencao.Service.Migrations
{
    [Migration(12)]
    public class Coluna_Criado_Manu : Migration
    {
        public override void Up()
        {
            this.ExecuteScript();
        }

        public override void Down()
        {
        }
    }
}

