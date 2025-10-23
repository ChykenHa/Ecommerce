using System;
using System.Data;
using System.Web.UI;

namespace OnlineShop
{
    public partial class Reports : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["AdminLoggedIn"] == null || Session["AdminLoggedIn"].ToString() != "true")
                {
                    Response.Redirect("AdminLogin.aspx");
                    return;
                }

                LoadReportData();
            }
        }

        private void LoadReportData()
        {
            // Hardcoded demo data for monthly stats
            lblMonthlyRevenue.Text = "42,500,000 ₫";
            lblMonthlyOrders.Text = "186";
            lblNewCustomers.Text = "127";
            lblProductsSold.Text = "423";

            // Load top 10 products
            DataTable dt = new DataTable();
            dt.Columns.Add("Rank", typeof(int));
            dt.Columns.Add("ProductName", typeof(string));
            dt.Columns.Add("CategoryName", typeof(string));
            dt.Columns.Add("QuantitySold", typeof(int));
            dt.Columns.Add("Revenue", typeof(decimal));

            // Add top selling products
            dt.Rows.Add(1, "iPhone 15 Pro Max 256GB", "Điện thoại", 87, 2609130000);
            dt.Rows.Add(2, "MacBook Air M3 13 inch", "Laptop", 65, 2079350000);
            dt.Rows.Add(3, "AirPods Pro Gen 2", "Phụ kiện", 142, 921580000);
            dt.Rows.Add(4, "Samsung Galaxy S24 Ultra", "Điện thoại", 54, 1511460000);
            dt.Rows.Add(5, "iPad Pro 12.9 M2", "Tablet", 48, 1199520000);
            dt.Rows.Add(6, "Apple Watch Ultra 2", "Phụ kiện", 42, 923580000);
            dt.Rows.Add(7, "MacBook Pro 14 M3 Pro", "Laptop", 28, 1539720000);
            dt.Rows.Add(8, "Dell XPS 15 9530", "Laptop", 31, 1425690000);
            dt.Rows.Add(9, "Sony WH-1000XM5", "Phụ kiện", 76, 683240000);
            dt.Rows.Add(10, "iPad Air 5 64GB", "Tablet", 51, 764490000);

            gvTopProducts.DataSource = dt;
            gvTopProducts.DataBind();
        }
    }
}

