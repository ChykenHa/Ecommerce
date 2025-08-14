using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace OnlineShop
{
    public partial class Login : System.Web.UI.Page
    {
        string connect = @"Data Source=DARLING\SQLEXPRESS;Initial Catalog=OnlineShopDB;Integrated Security=True";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Xử lý khi trang được tải lần đầu
            }
        }

        private bool ValidateLogin(string username, string password)
        {
            using (SqlConnection conn = new SqlConnection(connect))
            {
                string query = "SELECT COUNT(*) FROM KhachHang WHERE (tendangnhap = @username OR email = @username) AND matkhau = @password";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@username", username);
                cmd.Parameters.AddWithValue("@password", password);

                try
                {
                    conn.Open();
                    int count = (int)cmd.ExecuteScalar();
                    return count > 0;
                }
                catch (Exception ex)
                {
                    Console.Error.WriteLine("Lỗi khi kiểm tra đăng nhập: " + ex.Message);
                    return false;
                }
            }
        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                string username = txtUsername.Text.Trim();
                string password = txtPassword.Text.Trim();

                // Kiểm tra đầu vào
                if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
                {
                    Response.Write("<script>alert('Vui lòng nhập tên đăng nhập và mật khẩu!');</script>");
                    return;
                }

                if (!CheckIfUserExists(username))
                {
                    // Tài khoản không tồn tại
                    Response.Write("<script>alert('Tài khoản chưa tồn tại trong hệ thống!');</script>");
                    Response.Redirect("Register.aspx");
                    return;
                }

                if (ValidateLogin(username, password))
                {
                    // Lưu thông tin người dùng vào Session
                    SaveUserInfoToSession(username);

                    // Đăng nhập thành công
                    Response.Write("<script>alert('Đăng nhập thành công!');</script>");
                    Response.Redirect("Home.aspx");
                }
                else
                {
                    // Đăng nhập thất bại (sai mật khẩu)
                    Response.Write("<script>alert('Mật khẩu không đúng!');</script>");
                }
            }
            catch (Exception exx)
            {
                Console.Error.WriteLine("Lỗi khi đăng nhập: " + exx.Message);
                Response.Write("<script>alert('Có lỗi xảy ra khi đăng nhập!');</script>");
            }
        }
        private bool CheckIfUserExists(string username)
        {
            using (SqlConnection conn = new SqlConnection(connect))
            {
                string query = "SELECT COUNT(*) FROM KhachHang WHERE tendangnhap = @username OR email = @username";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@username", username);

                try
                {
                    conn.Open();
                    int count = (int)cmd.ExecuteScalar();
                    return count > 0;
                }
                catch (Exception ex)
                {
                    Console.Error.WriteLine("Lỗi khi kiểm tra tài khoản: " + ex.Message);
                    return false;
                }
            }
        }

        private void SaveUserInfoToSession(string username)
        {
            using (SqlConnection conn = new SqlConnection(connect))
            {
                string query = "SELECT makhachhang, tendangnhap, hoten, email FROM KhachHang WHERE tendangnhap = @username OR email = @username";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@username", username);

                try
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        // Lưu thông tin người dùng vào Session
                        Session["UserID"] = reader["makhachhang"].ToString();
                        Session["Username"] = reader["tendangnhap"].ToString();
                        Session["FullName"] = reader["hoten"].ToString();
                        Session["Email"] = reader["email"].ToString();
                        Session["IsLoggedIn"] = true;
                    }
                    reader.Close();
                }
                catch (Exception ex)
                {
                    Console.Error.WriteLine("Lỗi khi lưu thông tin người dùng: " + ex.Message);
                }
            }
        }
    }
}