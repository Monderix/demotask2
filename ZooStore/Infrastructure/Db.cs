using System;
using System.Data;
using Npgsql;

namespace ZooStore.Infrastructure
{
    internal static class Db
    {
        public static NpgsqlConnection OpenConnection()
        {
            AppConfig.Validate();

            var connection = new NpgsqlConnection(AppConfig.ConnectionString);
            connection.Open();
            return connection;
        }

        public static T Execute<T>(Func<NpgsqlConnection, T> action)
        {
            using (var connection = OpenConnection())
            {
                return action(connection);
            }
        }

        public static void Execute(Action<NpgsqlConnection> action)
        {
            using (var connection = OpenConnection())
            {
                action(connection);
            }
        }

        public static object DbValue(string value)
        {
            return string.IsNullOrWhiteSpace(value) ? (object)DBNull.Value : value.Trim();
        }
    }
}
