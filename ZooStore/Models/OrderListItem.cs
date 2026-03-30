using System;

namespace ZooStore.Models
{
    internal sealed class OrderListItem
    {
        public int Id { get; set; }

        public DateTime? OrderDate { get; set; }

        public DateTime? DeliveryDate { get; set; }

        public string PickupPointAddress { get; set; }

        public string ClientFullName { get; set; }

        public int PickupCode { get; set; }

        public string StatusName { get; set; }

        public string ItemsSummary { get; set; }
    }
}
