﻿
using FluentMigrator;

namespace BgmRodotec.Manutencao.Service.Migrations
{
    /// <summary>
    /// Setup - A.K.A. Migração zero. É um pequeno truque para que tenhamos o 
    /// controle do rollback até o ponto zero da base de dados.
    /// </summary>
    /// <remarks>
    /// Esta classe não deve conter nada nos metodos e up e down
    /// </remarks>
    [Migration(0, "Carga inicial")]
    public class Setup : Migration
    {
        public override void Up()
        {
        }

        public override void Down()
        {
        }
    }
}
