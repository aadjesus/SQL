using FluentMigrator;

namespace BgmRodotec.Manutencao.Service.Migrations
{
    [Migration(10)]
    public class Execute : Migration
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
