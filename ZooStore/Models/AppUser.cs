namespace ZooStore.Models
{
    internal sealed class AppUser
    {
        public int Id { get; set; }

        public int RoleId { get; set; }

        public UserRole Role
        {
            get { return (UserRole)RoleId; }
        }

        public string FullName { get; set; }

        public string Login { get; set; }

        public bool IsGuest
        {
            get { return Role == UserRole.Guest; }
        }
    }
}
