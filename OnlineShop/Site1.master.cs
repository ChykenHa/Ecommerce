using System;
using System.Web;
using System.Web.Security;
namespace OnlineShop
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Disable caching for dynamic content
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));
            Response.Cache.SetNoStore();
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
            // TODO: Implement sales page navigation
        }

        protected void Contact_Click(object sender, EventArgs e)
        {
            Response.Redirect("LienHe.aspx");
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            // TODO: Implement search functionality
        }

        protected void Login_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }
        protected void Logout_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Session.Abandon();
            Response.Redirect("~/Home.aspx", true);
        }

        protected void Cart_Click(object sender, EventArgs e)
        {
            Response.Redirect("GioHang.aspx");
        }

        protected void btnAll_Click(object sender, EventArgs e)
        {
            // TODO: Implement all products filter
        }

        protected void btnSmartphone_Click(object sender, EventArgs e)
        {
            // TODO: Implement smartphone filter
        }

        protected void btnLaptop_Click(object sender, EventArgs e)
        {
            // TODO: Implement laptop filter
        }

        protected void btnTablet_Click(object sender, EventArgs e)
        {
            // TODO: Implement tablet filter
        }

        protected void btnHeadphone_Click(object sender, EventArgs e)
        {
            // TODO: Implement headphone filter
        }

        protected void btnAccessories_Click(object sender, EventArgs e)
        {
            // TODO: Implement accessories filter
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