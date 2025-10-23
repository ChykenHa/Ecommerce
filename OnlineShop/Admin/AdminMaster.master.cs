using System;
using System.Web.UI;

namespace OnlineShop
{
    public partial class AdminMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check admin authentication
            if (Session["AdminLoggedIn"] == null || Session["AdminLoggedIn"].ToString() != "true")
            {
                Response.Redirect("AdminLogin.aspx");
                return;
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Clear admin session
            Session["AdminLoggedIn"] = null;
            Session["AdminUsername"] = null;
            
            // Redirect to login page
            Response.Redirect("AdminLogin.aspx");
        }
    }
}
