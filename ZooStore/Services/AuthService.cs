using Npgsql;
using ZooStore.Infrastructure;
using ZooStore.Models;

namespace ZooStore.Services
{
    internal static class AuthService
    {
        public static AppUser Authenticate(string login, string password)
        {
            return Db.Execute(connection =>
            {
                const string sql = @"
                    select id, role_fk, full_name, login
                    from public.users
                    where login = @login and password = @password
                    limit 1;";

                using (var command = new NpgsqlCommand(sql, connection))
                {
                    command.Parameters.AddWithValue("@login", login);
                    command.Parameters.AddWithValue("@password", password);

                    using (var reader = command.ExecuteReader())
                    {
                        if (!reader.Read())
                        {
                            return null;
                        }

                        return new AppUser
                        {
                            Id = reader.GetInt32(0),
                            RoleId = reader.IsDBNull(1) ? 0 : reader.GetInt32(1),
                            FullName = reader.IsDBNull(2) ? string.Empty : reader.GetString(2),
                            Login = reader.IsDBNull(3) ? string.Empty : reader.GetString(3)
                        };
                    }
                }
            });
        }
    }
}
