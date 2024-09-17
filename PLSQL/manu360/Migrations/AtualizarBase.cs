using FluentMigrator.Runner;
using FluentMigrator.Runner.Announcers;
using FluentMigrator.Runner.Initialization;
using FluentMigrator.Runner.Processors;
using FluentMigrator.Runner.Processors.Oracle;
using System;
using System.Configuration;
using System.Linq;
using System.Reflection;

namespace BgmRodotec.Manutencao.Service.Migrations
{
    class AtualizarBase
    {
        public static void Instalar()
        {
            new AtualizarBase().InstalarOuDesinstalar(false);
        }

        public static void Desinstalar()
        {
            new AtualizarBase().InstalarOuDesinstalar(true);
        }

        private void InstalarOuDesinstalar(bool desinstalar)
        {
            var announcer = new TextWriterAnnouncer(t =>
            {
                if (t != Environment.NewLine)
                    Console.WriteLine(t);
            })
            {
                ShowSql = false
            };
            var assembly = Assembly.GetAssembly(typeof(AtualizarBase));

            var runnerContext = new RunnerContext(announcer)
            {
                PreviewOnly = false,
                Timeout = 300
            };

            var options = new ProcessorOptions
            {
                PreviewOnly = runnerContext.PreviewOnly,
                Timeout = runnerContext.Timeout,
            };

            var factory = new OracleProcessorFactory();
            using (var processor = factory.Create(ConfigurationManager.AppSettings["GLOBUS_CONNECTION_STRING"].Replace("Provider=OraOLEDB.Oracle;", ""), announcer, options))
            {
                var runner = new MigrationRunner(assembly, runnerContext, processor);

                if (!desinstalar && runner.MigrationLoader.LoadMigrations().Count == runner.VersionLoader.VersionInfo.AppliedMigrations().Count())
                    return;

                Console.WriteLine(("/* ").PadRight(78, '=') + " */");
                Console.WriteLine(("/* " + (desinstalar ? "Desi" : "I") + "nstalando script's ").PadRight(78, '=') + " */");
                if (desinstalar)
                    runner.MigrateDown(0);
                else
                {
                    runner.MigrateUp(true);

                    //var lista = runner.MigrationLoader.LoadMigrations();
                    //foreach (var item in lista)
                    //{
                    //    try
                    //    {
                    //        runner.MigrateUp(item.Key);
                    //    }
                    //    catch (Exception ex)
                    //    {
                    //        System.Diagnostics.Debug.WriteLine(ex);
                    //    }
                    //}
                }

                Console.WriteLine(("/* ").PadRight(78, '=') + " */");
            }

        }
    }
}
