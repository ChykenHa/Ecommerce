using System;
using System.Web;
using System.Web.Security;
namespace OnlineShop
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));
            Response.Cache.SetNoStore();
            if (IsPostBack)
            {

            }
        }

        protected void ButtonHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }

        protected void Services_Click(object sender, EventArgs e)
        {
            Response.Redirect("Dichvu.aspx");
        }

        protected void SanPham_Click(object sender, EventArgs e)
        {
            Response.Redirect("SanPham.aspx");
        }

        protected void Sales_Click(object sender, EventArgs e)
        {

        }

        protected void Contact_Click(object sender, EventArgs e)
        {

        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {

        }

        protected void Login_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }
        protected void Logout_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Session.Abandon(); // Hủy tất cả session nếu có dùng
            Response.Redirect("~/Home.aspx", true); // Điều này rất quan trọng
        }

        protected void Cart_Click(object sender, EventArgs e)
        {
            Response.Redirect("GioHang.aspx");
        }

        protected void btnAll_Click(object sender, EventArgs e)
        {

        }

        protected void btnSmartphone_Click(object sender, EventArgs e)
        {

        }

        protected void btnLaptop_Click(object sender, EventArgs e)
        {

        }

        protected void btnTablet_Click(object sender, EventArgs e)
        {

        }

        protected void btnHeadphone_Click(object sender, EventArgs e)
        {

        }

        protected void btnAccessories_Click(object sender, EventArgs e)
        {

        }

        protected void Register_Click(object sender, EventArgs e)
        {
            Response.Redirect("Register.aspx");
        }

        protected void Account_Click(object sender, EventArgs e)
        {
            Response.Redirect("TaiKhoan.aspx");
        }
    }
}