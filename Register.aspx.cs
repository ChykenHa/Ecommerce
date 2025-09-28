using System;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;

namespace OnlineShop
{
    public partial class Register : System.Web.UI.Page
    {
        // Sửa tên database
        string connect = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\DataBase.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Xử lý khi trang được tải lần đầu
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            try
            {
                // Kiểm tra controls tồn tại
                if (!CheckControlsExist())
                {
                    ShowMessage("Lỗi: Không tìm thấy các controls cần thiết!");
                    return;
                }

                // Validate input fields
                if (!ValidateInput())
                {
                    return;
                }

                string fullName = txtFullName.Text.Trim();
                string email = txtEmail.Text.Trim();
                string username = txtRegUsername.Text.Trim();
                string phone = txtPhone.Text.Trim();
                string password = txtRegPassword.Text.Trim();
                string confirmPassword = txtConfirmPassword.Text.Trim();

                // Check if passwords match
                if (password != confirmPassword)
                {
                    ShowMessage("Mật khẩu xác nhận không khớp!");
                    return;
                }

                // Kiểm tra tên đăng nhập hoặc email đã tồn tại chưa
                if (CheckIfUserOrEmailExists(username, email))
                {
                    ShowMessage("Tên đăng nhập hoặc email đã tồn tại!");
                    return;
                }

                // Hash the password before storing
                string hashedPassword = HashPassword(password);

                if (RegisterUser(username, hashedPassword, fullName, email, phone))
                {
                    ShowMessage("Tạo tài khoản thành công!");
                    ClearRegistrationFields();
                    // Redirect after successful registration
                    Response.Redirect("Login.aspx");
                }
                else
                {
                    ShowMessage("Lỗi khi tạo tài khoản!");
                }
            }
            catch (Exception ex)
            {
                ShowMessage($"Lỗi đăng ký: {ex.Message}");
                System.Diagnostics.Debug.WriteLine("Lỗi đăng ký: " + ex.ToString());
            }
        }

        private bool CheckControlsExist()
        {
            return txtFullName != null && txtEmail != null && txtRegUsername != null &&
                   txtPhone != null && txtRegPassword != null && txtConfirmPassword != null;
        }

        private bool ValidateInput()
        {
            if (string.IsNullOrWhiteSpace(txtFullName.Text))
            {
                ShowMessage("Vui lòng nhập họ tên!");
                txtFullName.Focus();
                return false;
            }

            if (string.IsNullOrWhiteSpace(txtEmail.Text))
            {
                ShowMessage("Vui lòng nhập email!");
                txtEmail.Focus();
                return false;
            }

            if (!IsValidEmail(txtEmail.Text.Trim()))
            {
                ShowMessage("Email không hợp lệ!");
                txtEmail.Focus();
                return false;
            }

            if (string.IsNullOrWhiteSpace(txtRegUsername.Text))
            {
                ShowMessage("Vui lòng nhập tên đăng nhập!");
                txtRegUsername.Focus();
                return false;
            }

            if (txtRegUsername.Text.Trim().Length < 3)
            {
                ShowMessage("Tên đăng nhập phải có ít nhất 3 ký tự!");
                txtRegUsername.Focus();
                return false;
            }

            if (string.IsNullOrWhiteSpace(txtPhone.Text))
            {
                ShowMessage("Vui lòng nhập số điện thoại!");
                txtPhone.Focus();
                return false;
            }

            if (!IsValidPhone(txtPhone.Text.Trim()))
            {
                ShowMessage("Số điện thoại không hợp lệ!");
                txtPhone.Focus();
                return false;
            }

            if (string.IsNullOrWhiteSpace(txtRegPassword.Text))
            {
                ShowMessage("Vui lòng nhập mật khẩu!");
                txtRegPassword.Focus();
                return false;
            }

            if (txtRegPassword.Text.Length < 6)
            {
                ShowMessage("Mật khẩu phải có ít nhất 6 ký tự!");
                txtRegPassword.Focus();
                return false;
            }

            if (string.IsNullOrWhiteSpace(txtConfirmPassword.Text))
            {
                ShowMessage("Vui lòng xác nhận mật khẩu!");
                txtConfirmPassword.Focus();
                return false;
            }

            return true;
        }

        private bool IsValidEmail(string email)
        {
            try
            {
                var addr = new System.Net.Mail.MailAddress(email);
                return addr.Address == email;
            }
            catch
            {
                return false;
            }
        }

        private bool IsValidPhone(string phone)
        {
            // Kiểm tra số điện thoại Việt Nam (10-11 số, bắt đầu bằng 0)
            string pattern = @"^0[0-9]{9,10}$";
            return Regex.IsMatch(phone, pattern);
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

        private bool RegisterUser(string username, string password, string fullName, string email, string phone)
        {
            using (SqlConnection conn = new SqlConnection(connect))
            {
                try
                {
                    // Kiểm tra kết nối database
                    conn.Open();

                    // Sử dụng parameterized query để tránh SQL injection
                    string query = @"INSERT INTO KhachHang (tendangnhap, matkhau, hoten, email, dienthoai) 
                                    VALUES (@username, @password, @fullName, @email, @phone)";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@username", username ?? "");
                        cmd.Parameters.AddWithValue("@password", password ?? "");
                        cmd.Parameters.AddWithValue("@fullName", fullName ?? "");
                        cmd.Parameters.AddWithValue("@email", email ?? "");
                        cmd.Parameters.AddWithValue("@phone", phone ?? "");

                        int rowsAffected = cmd.ExecuteNonQuery();
                        return rowsAffected > 0;
                    }
                }
                catch (SqlException ex)
                {
                    System.Diagnostics.Debug.WriteLine($"SQL Error Code: {ex.Number}");
                    System.Diagnostics.Debug.WriteLine($"SQL Error: {ex.Message}");

                    // Xử lý các lỗi SQL cụ thể
                    switch (ex.Number)
                    {
                        case 2: // Cannot open database
                            ShowMessage("Không thể kết nối đến cơ sở dữ liệu!");
                            break;
                        case 2627: // Duplicate key
                            ShowMessage("Tên đăng nhập hoặc email đã tồn tại!");
                            break;
                        default:
                            ShowMessage($"Lỗi cơ sở dữ liệu: {ex.Message}");
                            break;
                    }
                    return false;
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine($"General Error: {ex.Message}");
                    ShowMessage($"Lỗi: {ex.Message}");
                    return false;
                }
            }
        }

        private bool CheckIfUserOrEmailExists(string username, string email)
        {
            using (SqlConnection conn = new SqlConnection(connect))
            {
                try
                {
                    conn.Open();
                    string query = "SELECT COUNT(*) FROM KhachHang WHERE tendangnhap = @username OR email = @email";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@username", username);
                        cmd.Parameters.AddWithValue("@email", email);

                        int count = (int)cmd.ExecuteScalar();
                        return count > 0;
                    }
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine("Lỗi khi kiểm tra tài khoản: " + ex.Message);
                    ShowMessage("Lỗi khi kiểm tra tài khoản tồn tại!");
                    return true; // Trả về true để ngăn không cho đăng ký khi có lỗi
                }
            }
        }

        private void ClearRegistrationFields()
        {
            if (CheckControlsExist())
            {
                txtFullName.Text = string.Empty;
                txtEmail.Text = string.Empty;
                txtRegUsername.Text = string.Empty;
                txtPhone.Text = string.Empty;
                txtRegPassword.Text = string.Empty;
                txtConfirmPassword.Text = string.Empty;
            }
        }

        // Phương thức ShowMessage an toàn hơn
        private void ShowMessage(string message)
        {
            if (string.IsNullOrEmpty(message)) return;

            // Escape các ký tự đặc biệt để tránh lỗi JavaScript
            string escapedMessage = message.Replace("\\", "\\\\")
                                         .Replace("'", "\\'")
                                         .Replace("\"", "\\\"")
                                         .Replace("\n", "\\n")
                                         .Replace("\r", "\\r");

            string script = $"<script>alert('{escapedMessage}');</script>";
            Response.Write(script);
        }
    }
}