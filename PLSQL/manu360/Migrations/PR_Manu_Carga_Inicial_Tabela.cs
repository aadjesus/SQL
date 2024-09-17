using FluentMigrator;

namespace BgmRodotec.Manutencao.Service.Migrations
{
    [Migration(5)]
    public class PR_Manu_Carga_Inicial_Tabela : Migration
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
