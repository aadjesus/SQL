using FluentMigrator;

namespace BgmRodotec.Manutencao.Service.Migrations
{
    [Migration(9)]
    public class TR_Manu_QtdeMatMarca : Migration
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
