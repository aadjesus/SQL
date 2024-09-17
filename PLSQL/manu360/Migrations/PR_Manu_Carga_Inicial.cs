using FluentMigrator;

namespace BgmRodotec.Manutencao.Service.Migrations
{
    [Migration(6)]
    public class PR_Manu_Carga_Inicial : Migration
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
