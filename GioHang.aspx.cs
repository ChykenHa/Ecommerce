using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;

namespace OnlineShop
{
    public partial class GioHang : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCart();
            }
        }

        private void LoadCart()
        {
            var cart = Session["Cart"] as List<CartItem>;
            if (cart == null)
            {
                cart = new List<CartItem>();
                Session["Cart"] = cart;
            }

            rptCart.DataSource = cart;
            rptCart.DataBind();

            lblTotal.Text = CalculateTotal(cart).ToString("C");
        }

        private decimal CalculateTotal(List<CartItem> cart)
        {
            decimal total = 0;
            foreach (var item in cart)
            {
                total += item.Price * item.Quantity;
            }
            return total;
        }

        protected void rptCart_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            var cart = Session["Cart"] as List<CartItem>;
            int productId = int.Parse(e.CommandArgument.ToString());

            if (e.CommandName == "Remove")
            {
                cart.RemoveAll(c => c.ProductId == productId);
            }
            else if (e.CommandName == "UpdateQuantity")
            {
                var txtQuantity = e.Item.FindControl("txtQuantity") as TextBox;
                var item = cart.Find(c => c.ProductId == productId);
                if (item != null)
                {
                    item.Quantity = int.Parse(txtQuantity.Text);
                }
            }

            Session["Cart"] = cart;
            LoadCart();
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            // Xử lý thanh toán
            Response.Redirect("Checkout.aspx");
        }
    }

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

    public class Gift
    {
        public string GiftName { get; set; }
        public decimal GiftValue { get; set; }
    }
}
