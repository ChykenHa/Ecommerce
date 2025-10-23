using System;
using System.Data;
using System.Web.UI;

namespace OnlineShop
{
    public partial class OrderManagement : System.Web.UI.Page
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

                LoadOrderStats();
            }
        }

        private void LoadOrderStats()
        {
            // Hardcoded demo data
            lblPendingOrders.Text = "28";
            lblProcessingOrders.Text = "45";
            lblShippingOrders.Text = "67";
            lblCompletedOrders.Text = "1,156";
            
            // Load sample orders
            LoadOrders();
        }
        
        private void LoadOrders()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("OrderId", typeof(string));
            dt.Columns.Add("CustomerName", typeof(string));
            dt.Columns.Add("OrderDate", typeof(DateTime));
            dt.Columns.Add("TotalAmount", typeof(decimal));
            dt.Columns.Add("Status", typeof(string));
            
            // Add sample orders
            dt.Rows.Add("DH001247", "Nguyễn Văn An", DateTime.Now.AddHours(-2), 29990000, "Chờ xử lý");
            dt.Rows.Add("DH001246", "Trần Thị Bình", DateTime.Now.AddHours(-5), 54990000, "Đang xử lý");
            dt.Rows.Add("DH001245", "Lê Minh Châu", DateTime.Now.AddDays(-1), 24990000, "Đang giao");
            dt.Rows.Add("DH001244", "Phạm Thị Dung", DateTime.Now.AddDays(-1), 14990000, "Đang giao");
            dt.Rows.Add("DH001243", "Hoàng Văn Em", DateTime.Now.AddDays(-2), 31990000, "Hoàn thành");
            dt.Rows.Add("DH001242", "Đặng Thị Phượng", DateTime.Now.AddDays(-2), 6490000, "Hoàn thành");
            dt.Rows.Add("DH001241", "Vũ Minh Giang", DateTime.Now.AddDays(-3), 21990000, "Hoàn thành");
            dt.Rows.Add("DH001240", "Bùi Thị Hoa", DateTime.Now.AddDays(-3), 8990000, "Đã hủy");
            dt.Rows.Add("DH001239", "Ngô Văn Hùng", DateTime.Now.AddDays(-4), 45990000, "Hoàn thành");
            dt.Rows.Add("DH001238", "Lý Thị Lan", DateTime.Now.AddDays(-4), 13990000, "Hoàn thành");
            dt.Rows.Add("DH001237", "Trương Minh Khang", DateTime.Now.AddDays(-5), 27990000, "Hoàn thành");
            dt.Rows.Add("DH001236", "Phan Thị Mai", DateTime.Now.AddDays(-5), 10990000, "Hoàn thành");
            dt.Rows.Add("DH001235", "Võ Văn Nam", DateTime.Now.AddDays(-6), 19990000, "Hoàn thành");
            dt.Rows.Add("DH001234", "Đỗ Thị Oanh", DateTime.Now.AddDays(-6), 42990000, "Hoàn thành");
            dt.Rows.Add("DH001233", "Mai Văn Phong", DateTime.Now.AddDays(-7), 7990000, "Hoàn thành");
            
            gvOrders.DataSource = dt;
            gvOrders.DataBind();
        }
    }
}

