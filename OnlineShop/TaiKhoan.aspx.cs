using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineShop
{
    public partial class TaiKhoan : System.Web.UI.Page
    {
        string connect = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\DataBase.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Load user info
                LoadUserInfo();
                
                // Load orders
                LoadAllOrders();
                BindOrders();

                // Check requested tab
                string tab = Request.QueryString["tab"];
                if (!string.IsNullOrEmpty(tab))
                {
                    // Force reload orders if coming from checkout
                    if (tab == "orders")
                    {
                        LoadAllOrders();
                        BindOrders();
                    }
                    
                    ClientScript.RegisterStartupScript(this.GetType(), "ActivateTab",
                        "activateTab('" + tab + "');", true);
                }
            }
        }

        private void LoadAllOrders()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connect))
                {
                    conn.Open();
                    
                    // First check if table exists
                    string checkTableQuery = @"
                        IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='DonHang' AND xtype='U')
                        BEGIN
                            CREATE TABLE DonHang (
                                id_donhang INT PRIMARY KEY IDENTITY(1,1),
                                hoten NVARCHAR(100),
                                sodienthoai VARCHAR(15),
                                email VARCHAR(100),
                                diachi NVARCHAR(200),
                                thanhpho VARCHAR(50),
                                quan VARCHAR(50),
                                ghichu NVARCHAR(500),
                                phuongthucthanhtoan VARCHAR(20),
                                tongtien DECIMAL(18,2),
                                ngaydat DATETIME,
                                trangthai NVARCHAR(50)
                            )
                        END";
                    
                    SqlCommand cmdCreate = new SqlCommand(checkTableQuery, conn);
                    cmdCreate.ExecuteNonQuery();
                    
                    string query = @"SELECT TOP 20
                                        id_donhang,
                                        hoten,
                                        sodienthoai,
                                        diachi,
                                        tongtien,
                                        ngaydat,
                                        trangthai,
                                        phuongthucthanhtoan
                                    FROM DonHang 
                                    ORDER BY ngaydat DESC";
                    
                    SqlCommand cmd = new SqlCommand(query, conn);
                    SqlDataReader reader = cmd.ExecuteReader();
                    System.Data.DataTable dt = new System.Data.DataTable();
                    dt.Load(reader);
                    
                    ViewState["Orders"] = dt;
                }
            }
            catch (Exception ex)
            {
                ViewState["Orders"] = null;
            }
        }

        private void BindOrders()
        {
            System.Data.DataTable dt = ViewState["Orders"] as System.Data.DataTable;
            
            if (dt != null && dt.Rows.Count > 0)
            {
                rptOrders.DataSource = dt;
                rptOrders.DataBind();
                pnlNoOrders.Visible = false;
            }
            else
            {
                rptOrders.DataSource = null;
                rptOrders.DataBind();
                pnlNoOrders.Visible = true;
            }
        }

        protected void rptOrders_ItemDataBound(object sender, System.Web.UI.WebControls.RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == System.Web.UI.WebControls.ListItemType.Item || 
                e.Item.ItemType == System.Web.UI.WebControls.ListItemType.AlternatingItem)
            {
                // Format order status
                System.Web.UI.WebControls.Literal litOrderStatus = (System.Web.UI.WebControls.Literal)e.Item.FindControl("litOrderStatus");
                System.Web.UI.WebControls.Literal litPaymentMethod = (System.Web.UI.WebControls.Literal)e.Item.FindControl("litPaymentMethod");
                
                string status = DataBinder.Eval(e.Item.DataItem, "trangthai").ToString();
                string paymentMethod = DataBinder.Eval(e.Item.DataItem, "phuongthucthanhtoan").ToString();
                
                // Format status
                string statusClass = "";
                string statusText = "";
                switch (status.ToLower())
                {
                    case "đang xử lý":
                        statusClass = "status-processing";
                        statusText = "Đang xử lý";
                        break;
                    case "đã giao":
                        statusClass = "status-completed";
                        statusText = "Đã giao";
                        break;
                    case "đã hủy":
                        statusClass = "status-cancelled";
                        statusText = "Đã hủy";
                        break;
                    default:
                        statusClass = "status-processing";
                        statusText = status;
                        break;
                }
                
                litOrderStatus.Text = $"<span class=\"order-status {statusClass}\">{statusText}</span>";
                
                // Format payment method
                string paymentText = "";
                switch (paymentMethod.ToUpper())
                {
                    case "COD":
                        paymentText = "Thanh toán khi nhận hàng";
                        break;
                    case "BANK":
                        paymentText = "Chuyển khoản ngân hàng";
                        break;
                    case "CARD":
                        paymentText = "Thanh toán bằng thẻ";
                        break;
                    default:
                        paymentText = paymentMethod;
                        break;
                }
                
                litPaymentMethod.Text = paymentText;
            }
        }

        private void LoadUserInfo()
        {
            if (Session["id_khachhang"] != null)
            {
                int UserId = Convert.ToInt32(Session["id_khachhang"]);

                using (SqlConnection conn = new SqlConnection(connect))
                {
                    SqlCommand cmd = new SqlCommand("SELECT * FROM KhachHang WHERE id_khachhang = @UserId", conn);
                    cmd.Parameters.AddWithValue("@UserId", UserId);

                    try
                    {
                        conn.Open();
                        SqlDataReader reader = cmd.ExecuteReader();

                        if (reader.Read())
                        {
                            // Hiển thị thông tin người dùng
                            txtUserName.Text = Session["Username"] != null ? Session["Username"].ToString() : reader["hoten"].ToString();
                            txtFullName.Text = reader["hoten"].ToString();
                            txtEmail.Text = reader["email"].ToString();
                            txtPhone.Text = reader["dienthoai"].ToString();
                            
                            // Set gender if available
                            if (reader["gioitinh"] != DBNull.Value)
                            {
                                string gender = reader["gioitinh"].ToString();
                                if (gender == "Nam" || gender == "male")
                                    ddlGender.SelectedValue = "male";
                                else if (gender == "Nữ" || gender == "female")
                                    ddlGender.SelectedValue = "female";
                                else
                                    ddlGender.SelectedValue = "other";
                            }
                            
                            // Set birthdate if available
                            if (reader["ngaysinh"] != DBNull.Value)
                            {
                                DateTime birthdate = Convert.ToDateTime(reader["ngaysinh"]);
                                txtBirthdate.Text = birthdate.ToString("yyyy-MM-dd");
                            }
                        }
                        reader.Close();
                    }
                    catch (Exception ex)
                    {
                        // Handle error silently
                    }
                }
            }
            else
            {
                txtUserName.Text = "Khách hàng";
                txtFullName.Text = "";
                txtEmail.Text = "";
                txtPhone.Text = "";
            }
        }

        // Tab button handlers
        protected void BtnInfo_Click(object sender, EventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "ActivateTab", "activateTab('info');", true);
        }

        protected void BtnOrders_Click(object sender, EventArgs e)
        {
            LoadAllOrders();
            BindOrders();
            ClientScript.RegisterStartupScript(this.GetType(), "ActivateTab", "activateTab('orders');", true);
        }

        protected void BtnAddresses_Click(object sender, EventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "ActivateTab", "activateTab('addresses');", true);
        }

        protected void BtnSecurity_Click(object sender, EventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "ActivateTab", "activateTab('security');", true);
        }

        // Form field change handlers
        protected void txtFullName_TextChanged(object sender, EventArgs e)
        {
            // Handle full name change
        }

        protected void txtPhone_TextChanged(object sender, EventArgs e)
        {
            // Handle phone change
        }

        protected void txtBirthdate_TextChanged(object sender, EventArgs e)
        {
            // Handle birthdate change
        }

        protected void ddlGender_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Handle gender change
        }

        // Save user info
        protected void SaveInfo_Click(object sender, EventArgs e)
        {
            if (Session["id_khachhang"] != null)
            {
                try
                {
                    int UserId = Convert.ToInt32(Session["id_khachhang"]);
                    
                    using (SqlConnection conn = new SqlConnection(connect))
                    {
                        conn.Open();
                        string query = @"UPDATE KhachHang 
                                       SET hoten = @HoTen, email = @Email, dienthoai = @DienThoai, 
                                           gioitinh = @GioiTinh, ngaysinh = @NgaySinh
                                       WHERE id_khachhang = @UserId";
                        
                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@HoTen", txtFullName.Text.Trim());
                        cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                        cmd.Parameters.AddWithValue("@DienThoai", txtPhone.Text.Trim());
                        cmd.Parameters.AddWithValue("@GioiTinh", ddlGender.SelectedValue);
                        cmd.Parameters.AddWithValue("@NgaySinh", string.IsNullOrEmpty(txtBirthdate.Text) ? (object)DBNull.Value : DateTime.Parse(txtBirthdate.Text));
                        cmd.Parameters.AddWithValue("@UserId", UserId);
                        
                        cmd.ExecuteNonQuery();
                        
                        ScriptManager.RegisterStartupScript(this, GetType(), "SaveSuccess", 
                            "alert('✓ Đã lưu thông tin thành công!');", true);
                    }
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "SaveError", 
                        $"alert('✕ Lỗi khi lưu thông tin: {ex.Message}');", true);
                }
            }
        }

        // Address handlers
        protected void EditAddress_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string addressId = btn.CommandArgument;
            ScriptManager.RegisterStartupScript(this, GetType(), "EditAddress", 
                $"alert('Chỉnh sửa địa chỉ ID: {addressId}');", true);
        }

        protected void RemoveAddress_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string addressId = btn.CommandArgument;
            ScriptManager.RegisterStartupScript(this, GetType(), "RemoveAddress", 
                $"alert('Xóa địa chỉ ID: {addressId}');", true);
        }

        // Security handlers
        protected void ChangePassword_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "ChangePassword", 
                "alert('Chức năng đổi mật khẩu sẽ được phát triển!');", true);
        }

        protected void Setup2FA_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "Setup2FA", 
                "alert('Chức năng xác thực hai lớp sẽ được phát triển!');", true);
        }

        protected void ViewLoginHistory_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "ViewLoginHistory", 
                "alert('Chức năng xem lịch sử đăng nhập sẽ được phát triển!');", true);
        }

        protected void SetupSecurityAlerts_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "SetupSecurityAlerts", 
                "alert('Chức năng thiết lập cảnh báo bảo mật sẽ được phát triển!');", true);
        }

        // Order handlers
        protected void ViewOrderDetails_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string orderId = btn.CommandArgument;
            ScriptManager.RegisterStartupScript(this, GetType(), "ViewOrderDetails", 
                $"alert('Xem chi tiết đơn hàng ID: {orderId}');", true);
        }
    }
}