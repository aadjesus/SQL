using FluentMigrator;

namespace BgmRodotec.Manutencao.Service.Migrations
{
    [Migration(1)]
    public class Create_Objects : Migration
    {
        public override void Up()
        {
            this.ExecuteScript();
        }

        public override void Down()
        {
            Execute.EmbeddedScript("Down.sql");
        }
    }
}
