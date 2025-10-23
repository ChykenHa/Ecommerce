using System;
using System.Data;
using System.Web.UI;

namespace OnlineShop
{
    public partial class UserManagement : System.Web.UI.Page
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

                LoadUserStats();
            }
        }

        private void LoadUserStats()
        {
            // Hardcoded demo data
            lblTotalUsers.Text = "2,834";
            lblActiveUsers.Text = "2,756";
            lblNewUsers.Text = "127";
            
            // Load sample users
            LoadUsers();
        }
        
        private void LoadUsers()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("UserId", typeof(int));
            dt.Columns.Add("FullName", typeof(string));
            dt.Columns.Add("Email", typeof(string));
            dt.Columns.Add("Phone", typeof(string));
            dt.Columns.Add("RegisterDate", typeof(DateTime));
            dt.Columns.Add("Status", typeof(string));
            
            // Add sample users
            dt.Rows.Add(1, "Nguyễn Văn An", "nguyenvanan@gmail.com", "0901234567", DateTime.Now.AddDays(-180), "Hoạt động");
            dt.Rows.Add(2, "Trần Thị Bình", "tranthikinh@yahoo.com", "0912345678", DateTime.Now.AddDays(-150), "Hoạt động");
            dt.Rows.Add(3, "Lê Minh Châu", "leminhchau@outlook.com", "0923456789", DateTime.Now.AddDays(-120), "Hoạt động");
            dt.Rows.Add(4, "Phạm Thị Dung", "phamthidung@gmail.com", "0934567890", DateTime.Now.AddDays(-90), "Hoạt động");
            dt.Rows.Add(5, "Hoàng Văn Em", "hoangvanem@icloud.com", "0945678901", DateTime.Now.AddDays(-60), "Hoạt động");
            dt.Rows.Add(6, "Đặng Thị Phượng", "dangthiphuong@gmail.com", "0956789012", DateTime.Now.AddDays(-45), "Bị khóa");
            dt.Rows.Add(7, "Vũ Minh Giang", "vuminhgiang@yahoo.com", "0967890123", DateTime.Now.AddDays(-30), "Hoạt động");
            dt.Rows.Add(8, "Bùi Thị Hoa", "buithihoa@gmail.com", "0978901234", DateTime.Now.AddDays(-25), "Hoạt động");
            dt.Rows.Add(9, "Ngô Văn Hùng", "ngovanhung@outlook.com", "0989012345", DateTime.Now.AddDays(-20), "Hoạt động");
            dt.Rows.Add(10, "Lý Thị Lan", "lythilan@gmail.com", "0990123456", DateTime.Now.AddDays(-15), "Hoạt động");
            dt.Rows.Add(11, "Trương Minh Khang", "truongminhkhang@yahoo.com", "0901234568", DateTime.Now.AddDays(-10), "Hoạt động");
            dt.Rows.Add(12, "Phan Thị Mai", "phanthimai@gmail.com", "0912345679", DateTime.Now.AddDays(-8), "Hoạt động");
            dt.Rows.Add(13, "Võ Văn Nam", "vovannam@icloud.com", "0923456780", DateTime.Now.AddDays(-5), "Hoạt động");
            dt.Rows.Add(14, "Đỗ Thị Oanh", "dothioanh@gmail.com", "0934567891", DateTime.Now.AddDays(-3), "Hoạt động");
            dt.Rows.Add(15, "Mai Văn Phong", "maivanphong@yahoo.com", "0945678902", DateTime.Now.AddDays(-1), "Hoạt động");
            
            gvUsers.DataSource = dt;
            gvUsers.DataBind();
        }

        protected void btnAddUser_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "AddUser",
                "alert('Tính năng thêm người dùng đang phát triển!');", true);
        }
    }
}

