namespace ZooStore.Models
{
    internal sealed class ProductListItem
    {
        public string Article { get; set; }

        public string Name { get; set; }

        public string Category { get; set; }

        public string Description { get; set; }

        public string Manufacturer { get; set; }

        public string Provider { get; set; }

        public string Measurement { get; set; }

        public int Cost { get; set; }

        public int Discount { get; set; }

        public int Quantity { get; set; }

        public string PicturePath { get; set; }

        public decimal FinalPrice
        {
            get { return Cost * (100 - Discount) / 100m; }
        }

        public bool HasDiscount
        {
            get { return Discount > 0; }
        }
    }
}
