namespace ZooStore.Models
{
    internal sealed class ProductEditItem
    {
        public string Article { get; set; }

        public string Name { get; set; }

        public int CategoryId { get; set; }

        public string Description { get; set; }

        public int ManufacturerId { get; set; }

        public int ProviderId { get; set; }

        public int Cost { get; set; }

        public int MeasurementId { get; set; }

        public int Quantity { get; set; }

        public int Discount { get; set; }

        public string PicturePath { get; set; }
    }
}
