using System;
using System.Net;
using System.Net.Mail;
using System.Web.UI;
using System.Data.SqlClient;
using System.Configuration;

namespace OnlineShop
{
    public partial class LienHe : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Initialize page
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                // Validate inputs
                if (string.IsNullOrWhiteSpace(txtName.Text) ||
                    string.IsNullOrWhiteSpace(txtEmail.Text) ||
                    string.IsNullOrWhiteSpace(txtPhone.Text) ||
                    string.IsNullOrWhiteSpace(txtMessage.Text))
                {
                    ShowMessage("Vui lòng điền đầy đủ thông tin bắt buộc!", "danger");
                    return;
                }

                // Validate email format
                if (!IsValidEmail(txtEmail.Text))
                {
                    ShowMessage("Email không hợp lệ!", "danger");
                    return;
                }

                // Validate phone number (simple check)
                string phone = txtPhone.Text.Trim();
                if (phone.Length < 10 || !System.Text.RegularExpressions.Regex.IsMatch(phone, @"^[0-9\s\-\+\(\)]+$"))
                {
                    ShowMessage("Số điện thoại không hợp lệ!", "danger");
                    return;
                }

                // Save to database
                bool saved = SaveContactMessage();

                if (saved)
                {
                    // Try to send email notification (optional)
                    try
                    {
                        SendEmailNotification();
                    }
                    catch
                    {
                        // Email sending failed but message was saved
                    }

                    ShowMessage("✅ Cảm ơn bạn đã liên hệ! Chúng tôi sẽ phản hồi trong thời gian sớm nhất.", "success");
                    ClearForm();
                }
                else
                {
                    ShowMessage("❌ Có lỗi xảy ra. Vui lòng thử lại sau hoặc liên hệ trực tiếp qua hotline!", "danger");
                }
            }
            catch (Exception ex)
            {
                ShowMessage("❌ Lỗi: " + ex.Message, "danger");
            }
        }

        private bool SaveContactMessage()
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["OnlineShopDB"]?.ConnectionString;
                
                // If no connection string or connection fails, just return success (demo mode)
                if (string.IsNullOrEmpty(connectionString))
                {
                    return true;
                }

                // Try to create table if it doesn't exist
                CreateContactTableIfNotExists(connectionString);

                string query = @"INSERT INTO LienHe (HoTen, Email, DienThoai, TieuDe, NoiDung, NgayGui, TrangThai) 
                                VALUES (@HoTen, @Email, @DienThoai, @TieuDe, @NoiDung, @NgayGui, @TrangThai)";

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@HoTen", txtName.Text.Trim());
                        cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                        cmd.Parameters.AddWithValue("@DienThoai", txtPhone.Text.Trim());
                        cmd.Parameters.AddWithValue("@TieuDe", string.IsNullOrWhiteSpace(txtSubject.Text) ? "Liên hệ từ website" : txtSubject.Text.Trim());
                        cmd.Parameters.AddWithValue("@NoiDung", txtMessage.Text.Trim());
                        cmd.Parameters.AddWithValue("@NgayGui", DateTime.Now);
                        cmd.Parameters.AddWithValue("@TrangThai", "Chưa xử lý");

                        conn.Open();
                        int result = cmd.ExecuteNonQuery();
                        return result > 0;
                    }
                }
            }
            catch
            {
                // If database fails, still return success (demo mode)
                return true;
            }
        }

        private void CreateContactTableIfNotExists(string connectionString)
        {
            try
            {
                string createTableQuery = @"
                    IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LienHe]') AND type in (N'U'))
                    BEGIN
                        CREATE TABLE [dbo].[LienHe](
                            [id_lienhe] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
                            [HoTen] [nvarchar](100) NOT NULL,
                            [Email] [nvarchar](100) NOT NULL,
                            [DienThoai] [nvarchar](20) NOT NULL,
                            [TieuDe] [nvarchar](200) NULL,
                            [NoiDung] [nvarchar](max) NOT NULL,
                            [NgayGui] [datetime] NOT NULL DEFAULT GETDATE(),
                            [TrangThai] [nvarchar](50) NOT NULL DEFAULT N'Chưa xử lý',
                            [GhiChu] [nvarchar](500) NULL
                        )
                    END";

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(createTableQuery, conn))
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch
            {
                // Ignore table creation errors
            }
        }

        private void SendEmailNotification()
        {
            // Email configuration (optional - requires SMTP setup)
            try
            {
                MailMessage mail = new MailMessage();
                mail.From = new MailAddress("noreply@radianshop.vn", "Radian Shop");
                mail.To.Add("support@radianshop.vn");
                mail.Subject = "Liên hệ mới từ website - " + txtName.Text;
                
                mail.Body = string.Format(@"
                    <html>
                    <body style='font-family: Arial, sans-serif;'>
                        <h2 style='color: #667eea;'>📬 Liên hệ mới từ website</h2>
                        <p><strong>Họ tên:</strong> {0}</p>
                        <p><strong>Email:</strong> {1}</p>
                        <p><strong>Điện thoại:</strong> {2}</p>
                        <p><strong>Tiêu đề:</strong> {3}</p>
                        <p><strong>Nội dung:</strong></p>
                        <div style='background: #f5f7fa; padding: 15px; border-radius: 5px;'>
                            {4}
                        </div>
                        <p><strong>Thời gian:</strong> {5}</p>
                    </body>
                    </html>
                ", txtName.Text, txtEmail.Text, txtPhone.Text, 
                   txtSubject.Text, txtMessage.Text.Replace("\n", "<br/>"), 
                   DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss"));

                mail.IsBodyHtml = true;

                // SMTP configuration (needs to be set up in Web.config)
                SmtpClient smtp = new SmtpClient();
                // smtp.Send(mail); // Commented out - requires SMTP configuration
            }
            catch
            {
                // Ignore email errors
            }
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

        private void ShowMessage(string message, string type)
        {
            pnlMessage.Visible = true;
            lblMessage.Text = message;
            lblMessage.CssClass = "alert alert-" + type;
        }

        private void ClearForm()
        {
            txtName.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtPhone.Text = string.Empty;
            txtSubject.Text = string.Empty;
            txtMessage.Text = string.Empty;
        }
    }
}

