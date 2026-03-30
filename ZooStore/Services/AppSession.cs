using ZooStore.Models;

namespace ZooStore.Services
{
    internal static class AppSession
    {
        public static AppUser CurrentUser { get; private set; }

        public static bool IsAuthorized
        {
            get { return CurrentUser != null; }
        }

        public static void SignIn(AppUser user)
        {
            CurrentUser = user;
        }

        public static void SignOut()
        {
            CurrentUser = null;
        }

        public static AppUser CreateGuest()
        {
            return new AppUser
            {
                Id = 0,
                RoleId = (int)UserRole.Guest,
                FullName = "Гость",
                Login = "guest"
            };
        }
    }
}
