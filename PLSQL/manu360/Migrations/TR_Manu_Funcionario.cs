using FluentMigrator;

namespace BgmRodotec.Manutencao.Service.Migrations
{
    [Migration(7)]
    public class TR_Manu_Funcionario : Migration
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
