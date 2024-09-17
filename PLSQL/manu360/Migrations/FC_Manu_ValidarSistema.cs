using FluentMigrator;

namespace BgmRodotec.Manutencao.Service.Migrations
{
    [Migration(2)]
    public class FC_Manu_ValidarSistema : Migration
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
