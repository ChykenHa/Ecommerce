using System;
using System.Web.UI;

namespace OnlineShop
{
    public partial class Settings : System.Web.UI.Page
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

                LoadAdminSettings();
            }
        }

        private void LoadAdminSettings()
        {
            if (Session["AdminUsername"] != null)
            {
                txtUsername.Text = Session["AdminUsername"].ToString();
            }

            if (Session["AdminFullName"] != null)
            {
                txtFullName.Text = Session["AdminFullName"].ToString();
            }

            if (Session["AdminEmail"] != null)
            {
                txtEmail.Text = Session["AdminEmail"].ToString();
            }

            if (Session["AdminRole"] != null)
            {
                txtRole.Text = Session["AdminRole"].ToString();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            // Validate inputs
            if (string.IsNullOrWhiteSpace(txtFullName.Text))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "ValidationError",
                    "alert('Vui lòng nhập họ tên!');", true);
                return;
            }

            if (string.IsNullOrWhiteSpace(txtEmail.Text))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "ValidationError",
                    "alert('Vui lòng nhập email!');", true);
                return;
            }

            // Check if changing password
            if (!string.IsNullOrWhiteSpace(txtCurrentPassword.Text))
            {
                if (string.IsNullOrWhiteSpace(txtNewPassword.Text))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "ValidationError",
                        "alert('Vui lòng nhập mật khẩu mới!');", true);
                    return;
                }

                if (txtNewPassword.Text != txtConfirmPassword.Text)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "ValidationError",
                        "alert('Mật khẩu xác nhận không khớp!');", true);
                    return;
                }

                // TODO: Update password in database
            }

            // Update session
            Session["AdminFullName"] = txtFullName.Text;
            Session["AdminEmail"] = txtEmail.Text;

            // TODO: Update database

            ScriptManager.RegisterStartupScript(this, GetType(), "Success",
                "alert('Cập nhật thông tin thành công!');", true);
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminDashboard.aspx");
        }
    }
}

