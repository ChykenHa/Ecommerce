using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineShop
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        string connect = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\DataBase.mdf;Integrated Security=True;Connect Timeout=30;Application Name=OnlineShop";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check admin authentication
                if (Session["AdminLoggedIn"] == null || Session["AdminLoggedIn"].ToString() != "true")
                {
                    Response.Redirect("AdminLogin.aspx");
                    return;
                }

                LoadDashboardStats();
                LoadRecentProducts();
            }
        }

        private void LoadDashboardStats()
        {
            // Hardcoded demo data
            Label lblOrders = (Label)FindControl("lblTotalOrders");
            Label lblProducts = (Label)FindControl("lblTotalProducts");
            Label lblUsers = (Label)FindControl("lblTotalUsers");
            Label lblRevenue = (Label)FindControl("lblTotalRevenue");

            if (lblOrders != null) lblOrders.Text = "1,247";
            if (lblProducts != null) lblProducts.Text = "156";
            if (lblUsers != null) lblUsers.Text = "2,834";
            if (lblRevenue != null) lblRevenue.Text = "125,450,000 ₫";
        }

        private void LoadRecentProducts()
        {
            // Create hardcoded demo data
            DataTable dt = new DataTable();
            dt.Columns.Add("ProductId", typeof(int));
            dt.Columns.Add("Name", typeof(string));
            dt.Columns.Add("Description", typeof(string));
            dt.Columns.Add("Price", typeof(decimal));
            dt.Columns.Add("CategoryName", typeof(string));
            dt.Columns.Add("ImageUrl", typeof(string));
            dt.Columns.Add("CreatedDate", typeof(DateTime));

            // Add sample products
            dt.Rows.Add(156, "iPhone 15 Pro Max 256GB", "Điện thoại cao cấp từ Apple", 29990000, "Điện thoại", "~/Assets/Images/product-placeholder.jpg", DateTime.Now.AddDays(-1));
            dt.Rows.Add(155, "Samsung Galaxy S24 Ultra", "Flagship Android mới nhất", 27990000, "Điện thoại", "~/Assets/Images/product-placeholder.jpg", DateTime.Now.AddDays(-2));
            dt.Rows.Add(154, "MacBook Air M3 13 inch", "Laptop siêu mỏng nhẹ", 31990000, "Laptop", "~/Assets/Images/product-placeholder.jpg", DateTime.Now.AddDays(-3));
            dt.Rows.Add(153, "iPad Pro 12.9 inch M2", "Máy tính bảng chuyên nghiệp", 24990000, "Tablet", "~/Assets/Images/product-placeholder.jpg", DateTime.Now.AddDays(-4));
            dt.Rows.Add(152, "Sony WH-1000XM5", "Tai nghe chống ồn cao cấp", 8990000, "Phụ kiện", "~/Assets/Images/product-placeholder.jpg", DateTime.Now.AddDays(-5));
            dt.Rows.Add(151, "Apple Watch Ultra 2", "Đồng hồ thông minh cao cấp", 21990000, "Phụ kiện", "~/Assets/Images/product-placeholder.jpg", DateTime.Now.AddDays(-6));
            dt.Rows.Add(150, "Dell XPS 15 9530", "Laptop workstation mạnh mẽ", 45990000, "Laptop", "~/Assets/Images/product-placeholder.jpg", DateTime.Now.AddDays(-7));
            dt.Rows.Add(149, "AirPods Pro Gen 2", "Tai nghe không dây Apple", 6490000, "Phụ kiện", "~/Assets/Images/product-placeholder.jpg", DateTime.Now.AddDays(-8));
            dt.Rows.Add(148, "Samsung Galaxy Tab S9+", "Tablet Android cao cấp", 19990000, "Tablet", "~/Assets/Images/product-placeholder.jpg", DateTime.Now.AddDays(-9));
            dt.Rows.Add(147, "Logitech MX Master 3S", "Chuột không dây cao cấp", 2490000, "Phụ kiện", "~/Assets/Images/product-placeholder.jpg", DateTime.Now.AddDays(-10));

            GridView gvProducts = (GridView)FindControl("gvRecentProducts");
            if (gvProducts != null)
            {
                gvProducts.DataSource = dt;
                gvProducts.DataBind();
            }
        }

        protected void btnViewOrder_Click(object sender, EventArgs e)
        {
            // Redirect to order detail page
            string orderId = ((Button)sender).CommandArgument;
            Response.Redirect(string.Format("OrderDetail.aspx?id={0}", orderId));
        }

        protected void btnEditProduct_Click(object sender, EventArgs e)
        {
            // Redirect to product edit page
            string productId = ((Button)sender).CommandArgument;
            Response.Redirect(string.Format("ProductEdit.aspx?id={0}", productId));
        }
    }
}

