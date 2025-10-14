using System;
using System.Collections.Generic;

namespace OnlineShop
{
    [Serializable]
    public class CartItem
    {
        public int ProductId { get; set; }
        public string ProductName { get; set; }
        public string ImageUrl { get; set; }
        public decimal Price { get; set; }
        public int Quantity { get; set; }
        public decimal Total => Price * Quantity;
        public List<Gift> Gifts { get; set; }
    }

    [Serializable]
    public class Gift
    {
        public string GiftName { get; set; }
        public decimal GiftValue { get; set; }
    }
}

