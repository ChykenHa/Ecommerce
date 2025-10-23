using System;
using System.Web.UI;
using System.Web.UI.HtmlControls;

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

            if (!IsPostBack)
            {
                LoadAdminInfo();
                HighlightActiveMenu();
            }
        }

        private void LoadAdminInfo()
        {
            // Load admin information from session
            if (Session["AdminUsername"] != null)
            {
                string username = Session["AdminUsername"].ToString();
                string fullName = Session["AdminFullName"] != null ? Session["AdminFullName"].ToString() : username;
                string role = Session["AdminRole"] != null ? Session["AdminRole"].ToString() : "Admin";

                // Update admin info display using JavaScript
                string script = string.Format(@"
                    document.addEventListener('DOMContentLoaded', function() {{
                        var adminName = document.querySelector('.admin-name');
                        var adminRole = document.querySelector('.admin-role');
                        if (adminName) adminName.textContent = '{0}';
                        if (adminRole) adminRole.textContent = '{1}';
                    }});
                ", fullName, role);

                ScriptManager.RegisterStartupScript(this, GetType(), "LoadAdminInfo", script, true);
            }
        }

        private void HighlightActiveMenu()
        {
            // Get current page name
            string currentPage = System.IO.Path.GetFileName(Request.PhysicalPath);

            // Add active class to current menu item
            string script = string.Format(@"
                document.addEventListener('DOMContentLoaded', function() {{
                    var currentPage = '{0}';
                    var links = document.querySelectorAll('.sidebar-nav .nav-link');
                    
                    links.forEach(function(link) {{
                        var href = link.getAttribute('href');
                        if (href && href.indexOf(currentPage) !== -1) {{
                            link.classList.add('active');
                            link.parentElement.classList.add('active');
                        }}
                    }});
                }});
            ", currentPage);

            ScriptManager.RegisterStartupScript(this, GetType(), "HighlightMenu", script, true);
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Clear all admin session data
            Session["AdminLoggedIn"] = null;
            Session["AdminUsername"] = null;
            Session["AdminFullName"] = null;
            Session["AdminEmail"] = null;
            Session["AdminRole"] = null;
            Session["AdminLoginTime"] = null;
            
            // Abandon session
            Session.Abandon();
            
            // Redirect to login page
            Response.Redirect("AdminLogin.aspx");
        }
    }
}
