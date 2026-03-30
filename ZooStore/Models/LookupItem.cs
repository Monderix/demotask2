namespace ZooStore.Models
{
    internal sealed class LookupItem
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public override string ToString()
        {
            return Name;
        }
    }
}
