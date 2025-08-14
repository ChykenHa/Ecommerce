using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Security.Principal;
namespace OnlineShop
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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
            Response.Redirect("Account.aspx");
        }
        protected void Logout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }
}