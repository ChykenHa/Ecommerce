using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineShop
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Xử lý khi trang được tải lần đầu
            }
        }
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string connect = @"Data Source=DARLING\SQLEXPRESS;Initial Catalog=OnlineShopDB;Integrated Security=True";
            try
            {
                string fullName = txtFullName.Text.Trim();
                string email = txtEmail.Text.Trim();
                string username = txtRegUsername.Text.Trim();
                string phone = txtPhone.Text.Trim();
                string password = txtRegPassword.Text.Trim();

                // Kiểm tra tên đăng nhập hoặc email đã tồn tại chưa
                if (CheckIfUserOrEmailExists(username, email))
                {
                    Response.Write("<script>alert('Tên đăng nhập hoặc email đã tồn tại!');</script>");
                    Response.Redirect("Login.aspx");
                    return;
                }

                if (RegisterUser(username, password, fullName, email, phone))
                {
                    Response.Write("<script>alert('Tạo tài khoản thành công!');</script>");
                    Response.Redirect("Home.aspx");
                    ClearRegistrationFields();
                }
                else
                {
                    Response.Write("<script>alert('Lỗi lưu ');</script>");
                }
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('Lỗi đăng ký: {ex.Message}');</script>");
                Console.Error.WriteLine("Lỗi đăng ký: " + ex.Message);
            }
        }
        private bool RegisterUser(string username, string password, string fullName, string email, string phone)
        {
            string connect = @"Data Source=DARLING\SQLEXPRESS;Initial Catalog=OnlineShopDB;Integrated Security=True";
            using (SqlConnection conn = new SqlConnection(connect))
            {
                string query = "INSERT INTO KhachHang (tendangnhap, matkhau, hoten, email, dienthoai) VALUES (@username, @password, @fullName, @email, @phone)";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@username", username);
                cmd.Parameters.AddWithValue("@password", password);
                cmd.Parameters.AddWithValue("@fullName", fullName);
                cmd.Parameters.AddWithValue("@email", email);
                cmd.Parameters.AddWithValue("@phone", phone);

                try
                {
                    conn.Open();
                    Console.WriteLine("Kết nối cơ sở dữ liệu thành công.");
                    int rowsAffected = cmd.ExecuteNonQuery();
                    Console.WriteLine($"Số dòng bị ảnh hưởng: {rowsAffected}");
                    return rowsAffected > 0;
                }
                catch (Exception ex)
                {
                    Console.Error.WriteLine("Lỗi khi tạo tài khoản: " + ex.Message);
                    Response.Write($"<script>alert('Lỗi chi tiết: {ex.Message}');</script>");
                    return false;
                }
            }
        }
        private bool CheckIfUserOrEmailExists(string username, string email)
        {
            string connect = @"Data Source=DARLING\SQLEXPRESS;Initial Catalog=OnlineShopDB;Integrated Security=True";
            using (SqlConnection conn = new SqlConnection(connect))
            {
                string query = "SELECT COUNT(*) FROM KhachHang WHERE tendangnhap = @username OR email = @email";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@username", username);
                cmd.Parameters.AddWithValue("@email", email);

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
        private void ClearRegistrationFields()
        {
            txtFullName.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtRegUsername.Text = string.Empty;
            txtPhone.Text = string.Empty;
            txtRegPassword.Text = string.Empty;
            txtConfirmPassword.Text = string.Empty;
        }
    }
}