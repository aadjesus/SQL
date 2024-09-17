namespace BgmRodotec.Manutencao.Service.Migrations
{

    using FluentMigrator.VersionTableInfo;

    [VersionTableMetaData]
    public class ManuVersionInfo : DefaultVersionTableMetaData
    {
        public override string ColumnName
        {
            get { return "Versao"; }
        }

        public override string TableName
        {
            get { return "MANU_VERSIONINFO"; }
        }

        public override string UniqueIndexName
        {
            get { return "MANU_VERSIONINFO_IDX"; }
        }

        public override string AppliedOnColumnName
        {
            get { return "Data_Hora"; }
        }

        public override string DescriptionColumnName
        {
            get { return "Descricao"; }
        }
    }
}
