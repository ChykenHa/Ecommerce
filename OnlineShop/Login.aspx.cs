using System;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web.Security;
using static System.Net.Mime.MediaTypeNames;

namespace OnlineShop
{
    public partial class Login : System.Web.UI.Page
    {
        string connect = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\DataBase.mdf;Integrated Security=True;Connect Timeout=30;Application Name=OnlineShop";

        protected void Page_Load(object sender, EventArgs e)
        {
            // Page initialization
        }

        private string HashPassword(string password)
        {
            using (SHA256 sha256Hash = SHA256.Create())
            {
                byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder builder = new StringBuilder();
                for (int i = 0; i < bytes.Length; i++)
                {
                    builder.Append(bytes[i].ToString("x2"));
                }
                return builder.ToString();
            }
        }

        private bool ValidateLogin(string username, string password)
        {
            using (SqlConnection conn = new SqlConnection(connect))
            {
                string hashedPassword = HashPassword(password);
                string query = "SELECT COUNT(*) FROM KhachHang WHERE (tendangnhap = @username OR email = @username) AND matkhau = @password";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@username", username);
                cmd.Parameters.AddWithValue("@password", hashedPassword);

                try
                {
                    conn.Open();
                    int count = (int)cmd.ExecuteScalar();
                    return count > 0;
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine($"Login validation error: {ex.Message}");
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

                if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
                {
                    Response.Write("<script>alert('Vui lòng nhập tên đăng nhập và mật khẩu!');</script>");
                    return;
                }

                if (!CheckIfUserExists(username))
                {
                    Response.Write("<script>alert('Tài khoản chưa tồn tại trong hệ thống!');</script>");
                    Response.Redirect("Register.aspx");
                    return;
                }

                if (ValidateLogin(username, password))
                {
                    SaveUserInfoToSession(username);
                    FormsAuthentication.SetAuthCookie(username, true);
                    Response.Write("<script>alert('Đăng nhập thành công!');</script>");
                    Response.Redirect("Home.aspx");
                }
                else
                {
                    Response.Write("<script>alert('Mật khẩu không đúng!');</script>");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Login error: {ex.Message}");
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
                    System.Diagnostics.Debug.WriteLine($"User existence check error: {ex.Message}");
                    return false;
                }
            }
        }

        private void SaveUserInfoToSession(string username)
        {
            using (SqlConnection conn = new SqlConnection(connect))
            {
                string query = "SELECT id_khachhang, tendangnhap, hoten, email, dienthoai FROM KhachHang WHERE tendangnhap = @username OR email = @username";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@username", username);

                try
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        Session["id_khachhang"] = Convert.ToInt32(reader["id_khachhang"]);
                        Session["Username"] = reader["tendangnhap"].ToString();
                        Session["FullName"] = reader["hoten"].ToString();
                        Session["Email"] = reader["email"].ToString();
                        Session["Phone"] = reader["dienthoai"] != DBNull.Value ? reader["dienthoai"].ToString() : "";
                        Session["IsLoggedIn"] = true;
                    }
                    reader.Close();
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine($"Save user info error: {ex.Message}");
                }
            }
        }
    }
}