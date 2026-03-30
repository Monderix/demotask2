using System;
using System.Configuration;
using System.IO;
using System.Windows.Forms;
using Npgsql;

namespace ZooStore.Services
{
    internal static class DialogService
    {
        public static void ShowInfo(string text, string title = "Информация")
        {
            MessageBox.Show(text, title, MessageBoxButtons.OK, MessageBoxIcon.Information);
        }

        public static void ShowWarning(string text, string title = "Предупреждение")
        {
            MessageBox.Show(text, title, MessageBoxButtons.OK, MessageBoxIcon.Warning);
        }

        public static void ShowError(string text, string title = "Ошибка")
        {
            MessageBox.Show(text, title, MessageBoxButtons.OK, MessageBoxIcon.Error);
        }

        public static bool Confirm(string text, string title = "Подтверждение")
        {
            return MessageBox.Show(text, title, MessageBoxButtons.YesNo, MessageBoxIcon.Question)
                == DialogResult.Yes;
        }

        public static void ShowException(Exception exception, string action)
        {
            ShowError(BuildFriendlyMessage(exception, action));
        }

        private static string BuildFriendlyMessage(Exception exception, string action)
        {
            if (exception is ConfigurationErrorsException)
            {
                return "Ошибка конфигурации приложения.\nПроверьте строку подключения к базе данных в App.config.";
            }

            if (exception is NpgsqlException)
            {
                return string.Format(
                    "Не удалось {0}.\nПроверьте, что PostgreSQL запущен, строка подключения заполнена верно, и база доступна.\n\nТехническая причина: {1}",
                    action,
                    exception.Message);
            }

            if (exception is IOException)
            {
                return string.Format(
                    "Не удалось {0} из-за проблемы с файлами.\nПроверьте доступ к папке приложения и повторите попытку.",
                    action);
            }

            return string.Format(
                "Не удалось {0}.\nПовторите попытку. Если ошибка сохранится, проверьте введенные данные и настройки приложения.",
                action);
        }
    }
}
