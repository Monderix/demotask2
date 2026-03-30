using System.Configuration;

namespace ZooStore.Infrastructure
{
    internal static class AppConfig
    {
        private const string ConnectionStringName = "ZooStoreDb";

        public static string ConnectionString
        {
            get
            {
                var settings = ConfigurationManager.ConnectionStrings[ConnectionStringName];
                return settings == null ? string.Empty : settings.ConnectionString;
            }
        }

        public static void Validate()
        {
            if (string.IsNullOrWhiteSpace(ConnectionString))
            {
                throw new ConfigurationErrorsException(
                    "Не найдена строка подключения 'ZooStoreDb' в файле конфигурации.");
            }
        }
    }
}
