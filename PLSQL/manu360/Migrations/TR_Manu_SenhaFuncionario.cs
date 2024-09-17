using FluentMigrator;

namespace BgmRodotec.Manutencao.Service.Migrations
{
    [Migration(8)]
    public class TR_Manu_SenhaFuncionario : Migration
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
