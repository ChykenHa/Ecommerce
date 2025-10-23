using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace OnlineShop
{
    public partial class AdminLogin : System.Web.UI.Page
    {
        string connect = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\DataBase.mdf;Integrated Security=True;Connect Timeout=30;Application Name=OnlineShop";

        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if already logged in
            if (Session["AdminLoggedIn"] != null && Session["AdminLoggedIn"].ToString() == "true")
            {
                Response.Redirect("AdminDashboard.aspx");
                return;
            }

            // Focus on username field
            if (!IsPostBack)
            {
                txtUsername.Focus();
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                ShowError("Vui lòng nhập đầy đủ thông tin đăng nhập!");
                return;
            }

            // Simple admin authentication (in production, use proper authentication)
            if (AuthenticateAdmin(username, password))
            {
                // Set session variables
                Session["AdminLoggedIn"] = "true";
                Session["AdminUsername"] = username;
                Session["AdminLoginTime"] = DateTime.Now;

                // Redirect to dashboard
                Response.Redirect("AdminDashboard.aspx");
            }
            else
            {
                ShowError("Tên đăng nhập hoặc mật khẩu không đúng!");
            }
        }

        private bool AuthenticateAdmin(string username, string password)
        {
            // For demo purposes, using simple hardcoded credentials
            // In production, this should query the database and use proper password hashing
            
            if (username == "admin" && password == "admin123")
            {
                return true;
            }

            // You can also check against database
            using (SqlConnection conn = new SqlConnection(connect))
            {
                try
                {
                    conn.Open();
                    string query = "SELECT COUNT(*) FROM AdminUsers WHERE Username = @Username AND Password = @Password AND IsActive = 1";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Username", username);
                    cmd.Parameters.AddWithValue("@Password", password); // In production, use hashed password

                    int count = (int)cmd.ExecuteScalar();
                    return count > 0;
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine($"Error authenticating admin: {ex.Message}");
                    return false;
                }
            }
        }

        private void ShowError(string message)
        {
            lblError.Text = message;
            pnlError.Visible = true;
            
            // Hide error after 5 seconds
            ScriptManager.RegisterStartupScript(this, GetType(), "HideError", 
                "setTimeout(function() { document.getElementById('" + pnlError.ClientID + "').style.display = 'none'; }, 5000);", true);
        }
    }
}
