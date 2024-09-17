using FluentMigrator;

namespace BgmRodotec.Manutencao.Service.Migrations
{
    public static class ExtensionMigrations
    {

        public static void ExecuteScript(
           this Migration objeto)
        {
            objeto.Execute.EmbeddedScript(objeto.GetType().Name + ".sql");           
        }
    }
}
