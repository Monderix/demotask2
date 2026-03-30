using System;
using System.Collections.Generic;

namespace ZooStore.Models
{
    internal sealed class OrderEditItem
    {
        public int Id { get; set; }

        public DateTime OrderDate { get; set; }

        public DateTime DeliveryDate { get; set; }

        public int PickupPointId { get; set; }

        public int ClientId { get; set; }

        public int PickupCode { get; set; }

        public int StatusId { get; set; }

        public List<OrderItemEditItem> Items { get; set; }
    }
}
