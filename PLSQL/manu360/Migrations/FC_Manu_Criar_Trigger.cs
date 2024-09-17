using FluentMigrator;

namespace BgmRodotec.Manutencao.Service.Migrations
{
    [Migration(3)]
    public class FC_Manu_Criar_Trigger : Migration
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
