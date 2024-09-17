using FluentMigrator;

namespace BgmRodotec.Manutencao.Service.Migrations
{
    [Migration(4)]
    public class PR_Manu_Insert_JSon : Migration
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
