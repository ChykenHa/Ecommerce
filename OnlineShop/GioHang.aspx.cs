using System;
using System.Collections.Generic;
using System.Web.UI;
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
            // Clear old cart format if exists
            if (Session["Cart"] != null && Session["Cart"] is List<int>)
            {
                Session["Cart"] = null;
            }

            var cart = Session["Cart"] as List<CartItem>;

            if (cart == null || cart.Count == 0)
            {
                pnlEmptyCart.Visible = true;
                rptCart.Visible = false;
                lblSubtotal.Text = "0";
                lblDiscount.Text = "0";
                lblTotal.Text = "0";
            }
            else
            {
                pnlEmptyCart.Visible = false;
                rptCart.Visible = true;
                rptCart.DataSource = cart;
                rptCart.DataBind();
                UpdateTotals();
            }

            UpdateVoucherDisplay();
        }

        private void UpdateTotals()
        {
            var cart = Session["Cart"] as List<CartItem>;
            decimal subtotal = CalculateSubtotal(cart);
            decimal discount = GetDiscount(subtotal);
            decimal total = subtotal - discount;

            lblSubtotal.Text = subtotal.ToString("N0");
            lblDiscount.Text = discount.ToString("N0");
            lblTotal.Text = total.ToString("N0");
        }

        private decimal CalculateSubtotal(List<CartItem> cart)
        {
            decimal total = 0;
            if (cart != null)
            {
                foreach (var item in cart)
                    total += item.Price * item.Quantity;
            }
            return total;
        }

        private decimal GetDiscount(decimal subtotal)
        {
            if (Session["AppliedVoucherCode"] != null)
            {
                string code = Session["AppliedVoucherCode"].ToString();
                return CalculateDiscount(code, subtotal);
            }
            return 0;
        }

        private decimal CalculateDiscount(string code, decimal subtotal)
        {
            var cart = Session["Cart"] as List<CartItem>;
            decimal discount = 0;

            switch (code.ToUpper())
            {
                // Fixed Amount Vouchers
                case "SAVE30K":
                    if (subtotal >= 200000)
                        discount = 30000;
                    break;

                case "SAVE70K":
                    if (subtotal >= 600000)
                        discount = 70000;
                    break;

                case "MEGA120K":
                    if (subtotal >= 1000000)
                        discount = 120000;
                    break;

                case "VIP250K":
                    if (subtotal >= 2500000)
                        discount = 250000;
                    break;

                // Percentage Vouchers
                case "DISCOUNT8":
                    if (subtotal >= 300000)
                        discount = subtotal * 0.08m;
                    break;

                case "SALE12":
                    if (subtotal >= 500000)
                        discount = subtotal * 0.12m;
                    break;

                case "SUPER18":
                    if (subtotal >= 800000)
                        discount = subtotal * 0.18m;
                    break;

                case "ULTRA25":
                    if (subtotal >= 1500000)
                        discount = Math.Min(subtotal * 0.25m, 400000);
                    break;

                // Special Vouchers
                case "NEWBIE":
                    discount = 90000;
                    break;

                case "FREESHIP":
                    discount = 35000;
                    break;

                case "WEEKEND":
                    discount = Math.Min(subtotal * 0.15m, 180000);
                    break;

                case "FLASH40":
                    discount = Math.Min(subtotal * 0.40m, 600000);
                    break;
            }

            return discount;
        }

        protected void ApplyVoucher(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string code = btn.CommandArgument;

            // Check if cart is old format and convert
            if (Session["Cart"] != null && Session["Cart"] is List<int>)
            {
                Session["Cart"] = null;
                ShowAlert("Giỏ hàng đã được làm mới. Vui lòng thêm sản phẩm lại!", "warning");
                LoadCart();
                return;
            }

            var cart = Session["Cart"] as List<CartItem>;
            if (cart == null || cart.Count == 0)
            {
                ShowAlert("Giỏ hàng trống! Vui lòng thêm sản phẩm trước khi áp dụng mã.", "warning");
                return;
            }

            decimal subtotal = CalculateSubtotal(cart);
            decimal discount = CalculateDiscount(code, subtotal);

            if (discount > 0)
            {
                Session["AppliedVoucherCode"] = code;
                LoadCart();
                ShowAlert($"✓ Áp dụng mã {code} thành công!\\n💰 Tiết kiệm: {discount:N0}₫", "success");
            }
            else
            {
                ShowAlert(GetVoucherErrorMessage(code, subtotal), "error");
            }
        }

        private string GetVoucherErrorMessage(string code, decimal subtotal)
        {
            switch (code.ToUpper())
            {
                case "SAVE30K":
                    return $"Mã SAVE30K yêu cầu đơn hàng tối thiểu 200.000₫\\nĐơn hiện tại: {subtotal:N0}₫";
                case "SAVE70K":
                    return $"Mã SAVE70K yêu cầu đơn hàng tối thiểu 600.000₫\\nĐơn hiện tại: {subtotal:N0}₫";
                case "MEGA120K":
                    return $"Mã MEGA120K yêu cầu đơn hàng tối thiểu 1.000.000₫\\nĐơn hiện tại: {subtotal:N0}₫";
                case "VIP250K":
                    return $"Mã VIP250K yêu cầu đơn hàng tối thiểu 2.500.000₫\\nĐơn hiện tại: {subtotal:N0}₫";
                case "DISCOUNT8":
                    return $"Mã DISCOUNT8 yêu cầu đơn hàng tối thiểu 300.000₫\\nĐơn hiện tại: {subtotal:N0}₫";
                case "SALE12":
                    return $"Mã SALE12 yêu cầu đơn hàng tối thiểu 500.000₫\\nĐơn hiện tại: {subtotal:N0}₫";
                case "SUPER18":
                    return $"Mã SUPER18 yêu cầu đơn hàng tối thiểu 800.000₫\\nĐơn hiện tại: {subtotal:N0}₫";
                case "ULTRA25":
                    return $"Mã ULTRA25 yêu cầu đơn hàng tối thiểu 1.500.000₫\\nĐơn hiện tại: {subtotal:N0}₫";
                default:
                    return "Không thể áp dụng mã giảm giá này!";
            }
        }

        protected void RemoveVoucher_Click(object sender, EventArgs e)
        {
            Session["AppliedVoucherCode"] = null;
            LoadCart();
            ShowAlert("Đã xóa mã giảm giá!", "info");
        }

        private void UpdateVoucherDisplay()
        {
            if (Session["AppliedVoucherCode"] != null)
            {
                var cart = Session["Cart"] as List<CartItem>;
                decimal subtotal = CalculateSubtotal(cart);
                string code = Session["AppliedVoucherCode"].ToString();
                decimal discount = CalculateDiscount(code, subtotal);

                if (discount > 0)
                {
                    pnlAppliedVoucher.Visible = true;
                    lblAppliedCode.Text = code;
                    lblAppliedDiscount.Text = discount.ToString("N0");
                }
                else
                {
                    // Nếu không còn đủ điều kiện, tự động xóa voucher
                    pnlAppliedVoucher.Visible = false;
                    Session["AppliedVoucherCode"] = null;
                }
            }
            else
            {
                pnlAppliedVoucher.Visible = false;
            }
        }

        protected void rptCart_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            var cart = Session["Cart"] as List<CartItem>;
            int productId = int.Parse(e.CommandArgument.ToString());

            if (e.CommandName == "Remove")
            {
                cart.RemoveAll(c => c.ProductId == productId);
                ShowAlert("Đã xóa sản phẩm khỏi giỏ hàng!", "info");
            }
            else if (e.CommandName == "Increase")
            {
                var item = cart.Find(c => c.ProductId == productId);
                if (item != null)
                {
                    item.Quantity++;
                }
            }
            else if (e.CommandName == "Decrease")
            {
                var item = cart.Find(c => c.ProductId == productId);
                if (item != null && item.Quantity > 1)
                {
                    item.Quantity--;
                }
            }

            Session["Cart"] = cart;
            LoadCart();
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            var cart = Session["Cart"] as List<CartItem>;

            if (cart == null || cart.Count == 0)
            {
                ShowAlert("Giỏ hàng trống! Vui lòng thêm sản phẩm.", "warning");
                return;
            }

            // Lưu thông tin voucher để sử dụng ở trang thanh toán
            if (Session["AppliedVoucherCode"] != null)
            {
                decimal subtotal = CalculateSubtotal(cart);
                decimal discount = GetDiscount(subtotal);
                Session["CheckoutDiscount"] = discount;
                Session["CheckoutVoucherCode"] = Session["AppliedVoucherCode"];
            }

            Response.Redirect("ThanhToan.aspx");
        }

        private void ShowAlert(string message, string type)
        {
            string icon = "ℹ️";
            switch (type)
            {
                case "success": icon = "✓"; break;
                case "error": icon = "✕"; break;
                case "warning": icon = "⚠"; break;
            }

            ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                $"alert('{icon} {message}');", true);
        }
    }
}