using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.UI;

namespace OnlineShop
{
    public partial class ThanhToan : System.Web.UI.Page
    {
        string connect = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\DataBase.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Test database connection
                TestDatabaseConnection();
                
                LoadOrderSummary();
            }
        }

        private void TestDatabaseConnection()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connect))
                {
                    conn.Open();
                    System.Diagnostics.Debug.WriteLine("Database connection test: SUCCESS");
                    
                    // Test if DonHang table exists
                    string checkTableQuery = "SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'DonHang'";
                    SqlCommand cmd = new SqlCommand(checkTableQuery, conn);
                    int tableExists = Convert.ToInt32(cmd.ExecuteScalar());
                    
                    System.Diagnostics.Debug.WriteLine($"DonHang table exists: {tableExists > 0}");
                    
                    if (tableExists > 0)
                    {
                        // Get actual column names
                        string getColumnsQuery = @"
                            SELECT COLUMN_NAME 
                            FROM INFORMATION_SCHEMA.COLUMNS 
                            WHERE TABLE_NAME = 'DonHang' 
                            ORDER BY ORDINAL_POSITION";
                        SqlCommand cmdColumns = new SqlCommand(getColumnsQuery, conn);
                        SqlDataReader reader = cmdColumns.ExecuteReader();
                        
                        System.Diagnostics.Debug.WriteLine("Actual DonHang columns:");
                        while (reader.Read())
                        {
                            System.Diagnostics.Debug.WriteLine($"- {reader["COLUMN_NAME"]}");
                        }
                        reader.Close();
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Database connection test FAILED: {ex.Message}");
            }
        }

        private void LoadOrderSummary()
        {
            var cart = Session["Cart"] as List<CartItem>;
            
            if (cart == null || cart.Count == 0)
            {
                Response.Redirect("GioHang.aspx");
                return;
            }

            // Bind cart items to repeater
            rptOrderItems.DataSource = cart;
            rptOrderItems.DataBind();

            // Calculate totals
            decimal subtotal = CalculateSubtotal(cart);
            decimal shipping = CalculateShipping(subtotal);
            decimal discount = GetDiscount();
            decimal total = subtotal + shipping - discount;

            lblSubtotal.Text = subtotal.ToString("N0");
            lblShipping.Text = shipping.ToString("N0");
            lblDiscount.Text = discount.ToString("N0");
            lblTotal.Text = total.ToString("N0");

            // Display applied voucher if any
            if (Session["AppliedVoucherCode"] != null && discount > 0)
            {
                pnlVoucherInfo.Visible = true;
                lblVoucherCode.Text = Session["AppliedVoucherCode"].ToString();
            }
            else if (Session["CheckoutVoucherCode"] != null && discount > 0)
            {
                pnlVoucherInfo.Visible = true;
                lblVoucherCode.Text = Session["CheckoutVoucherCode"].ToString();
            }
            else
            {
                pnlVoucherInfo.Visible = false;
            }
        }

        private decimal CalculateSubtotal(List<CartItem> cart)
        {
            decimal subtotal = 0;
            foreach (var item in cart)
            {
                subtotal += item.Price * item.Quantity;
            }
            return subtotal;
        }

        private decimal CalculateShipping(decimal subtotal)
        {
            // Free shipping for orders over 500,000 VND
            if (subtotal >= 500000)
                return 0;
            return 30000; // 30,000 VND shipping fee
        }

        private decimal GetDiscount()
        {
            // Try multiple session keys for voucher
            string voucherCode = Session["AppliedVoucherCode"] as string;
            if (string.IsNullOrEmpty(voucherCode))
            {
                voucherCode = Session["CheckoutVoucherCode"] as string;
            }
            
            if (string.IsNullOrEmpty(voucherCode))
                return 0;

            var cart = Session["Cart"] as List<CartItem>;
            if (cart == null || cart.Count == 0)
                return 0;

            decimal subtotal = CalculateSubtotal(cart);
            decimal discount = CalculateDiscount(voucherCode, subtotal);
            
            return discount;
        }

        private decimal CalculateDiscount(string code, decimal subtotal)
        {
            decimal discount = 0;

            switch (code.ToUpper())
            {
                // Fixed Amount Vouchers
                case "SAVE30K":
                    if (subtotal >= 200000)
                        discount = 30000;
                    break;

                case "SAVE70K":
                    if (subtotal >= 600000)
                        discount = 70000;
                    break;

                case "MEGA120K":
                    if (subtotal >= 1000000)
                        discount = 120000;
                    break;

                case "VIP250K":
                    if (subtotal >= 2500000)
                        discount = 250000;
                    break;

                // Percentage Vouchers
                case "DISCOUNT8":
                    if (subtotal >= 300000)
                        discount = subtotal * 0.08m;
                    break;

                case "SALE12":
                    if (subtotal >= 500000)
                        discount = subtotal * 0.12m;
                    break;

                case "SUPER18":
                    if (subtotal >= 800000)
                        discount = subtotal * 0.18m;
                    break;

                case "ULTRA25":
                    if (subtotal >= 1500000)
                        discount = Math.Min(subtotal * 0.25m, 400000);
                    break;

                // Special Vouchers
                case "NEWBIE":
                    discount = 90000;
                    break;

                case "FREESHIP":
                    discount = 35000;
                    break;

                case "WEEKEND":
                    discount = Math.Min(subtotal * 0.15m, 180000);
                    break;

                case "FLASH40":
                    discount = Math.Min(subtotal * 0.40m, 600000);
                    break;
            }

            return discount;
        }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            try
            {
                System.Diagnostics.Debug.WriteLine("btnPlaceOrder_Click - Starting order placement");
                
                // Check required fields manually
                if (string.IsNullOrEmpty(txtFullName.Text.Trim()))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "ValidationError", 
                        "alert('⚠ Vui lòng nhập họ và tên!');", true);
                    return;
                }

                if (string.IsNullOrEmpty(txtPhone.Text.Trim()))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "ValidationError", 
                        "alert('⚠ Vui lòng nhập số điện thoại!');", true);
                    return;
                }

                if (string.IsNullOrEmpty(txtAddress.Text.Trim()))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "ValidationError", 
                        "alert('⚠ Vui lòng nhập địa chỉ!');", true);
                    return;
                }

                if (ddlCity.SelectedValue == "")
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "ValidationError", 
                        "alert('⚠ Vui lòng chọn tỉnh/thành phố!');", true);
                    return;
                }

                if (ddlDistrict.SelectedValue == "")
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "ValidationError", 
                        "alert('⚠ Vui lòng chọn quận/huyện!');", true);
                    return;
                }

                if (!chkAgree.Checked)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "Alert", 
                        "alert('⚠ Vui lòng đồng ý với điều khoản và điều kiện!');", true);
                    return;
                }

                // Check cart
                var cart = Session["Cart"] as List<CartItem>;
                if (cart == null || cart.Count == 0)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "EmptyCart", 
                        "alert('⚠ Giỏ hàng trống!'); window.location='GioHang.aspx';", true);
                    return;
                }

                System.Diagnostics.Debug.WriteLine($"btnPlaceOrder_Click - Cart has {cart.Count} items");
                
                // Calculate final totals
                decimal subtotal = CalculateSubtotal(cart);
                decimal shipping = CalculateShipping(subtotal);
                decimal discount = GetDiscount();
                decimal total = subtotal + shipping - discount;

                System.Diagnostics.Debug.WriteLine($"btnPlaceOrder_Click - Subtotal: {subtotal:N0}, Shipping: {shipping:N0}, Discount: {discount:N0}, Total: {total:N0}");

                // Insert order into database
                int orderId = InsertOrder(total);
                
                // Debug: Log order creation
                System.Diagnostics.Debug.WriteLine($"Order creation result: {orderId}");
                
                if (orderId > 0)
                {
                    // Insert order details
                    InsertOrderDetails(orderId, cart);

                    // Clear cart and voucher
                    Session["Cart"] = null;
                    Session["AppliedVoucherCode"] = null;
                    Session["CheckoutDiscount"] = null;
                    Session["CheckoutVoucherCode"] = null;

                    // Redirect to TaiKhoan page with orders tab
                    string successScript = $@"
                        alert('✓ Đặt hàng thành công!\n\nMã đơn hàng: #{orderId}\nTổng tiền: {total:N0}₫\n\nBạn có thể xem đơn hàng trong mục Tài Khoản.');
                        window.location='TaiKhoan.aspx?tab=orders';
                    ";
                    ScriptManager.RegisterStartupScript(this, GetType(), "Success", successScript, true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "Error", 
                        "alert('✕ Không thể tạo đơn hàng. Vui lòng thử lại sau!');", true);
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"btnPlaceOrder_Click - Error: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"btnPlaceOrder_Click - StackTrace: {ex.StackTrace}");
                
                ScriptManager.RegisterStartupScript(this, GetType(), "Error", 
                    $"alert('✕ Lỗi: {ex.Message.Replace("'", "\\'")}\\n\\nVui lòng thử lại hoặc liên hệ hỗ trợ.');", true);
            }
        }

        private int InsertOrder(decimal total)
        {
            int orderId = 0;

            try
            {
                System.Diagnostics.Debug.WriteLine($"InsertOrder - Starting with total: {total:N0}");
                
                using (SqlConnection conn = new SqlConnection(connect))
                {
                    conn.Open();
                    System.Diagnostics.Debug.WriteLine("InsertOrder - Database connection opened");

                    // Check if table exists and has correct structure
                    try
                    {
                        // Check if table exists
                        string checkTableQuery = "SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'DonHang'";
                        SqlCommand cmdCheck = new SqlCommand(checkTableQuery, conn);
                        int tableExists = Convert.ToInt32(cmdCheck.ExecuteScalar());
                        
                        if (tableExists == 0)
                        {
                            // Create table if not exists
                            string createTableQuery = @"
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
                            )";
                            SqlCommand cmdCreate = new SqlCommand(createTableQuery, conn);
                            cmdCreate.ExecuteNonQuery();
                            System.Diagnostics.Debug.WriteLine("InsertOrder - Created DonHang table");
                        }
                        else
                        {
                            // Check if table has correct columns
                            string checkColumnsQuery = @"
                                SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS 
                                WHERE TABLE_NAME = 'DonHang' AND COLUMN_NAME IN ('hoten', 'sodienthoai', 'email', 'diachi', 'thanhpho', 'quan', 'ghichu', 'phuongthucthanhtoan', 'tongtien', 'ngaydat', 'trangthai')";
                            SqlCommand cmdColumns = new SqlCommand(checkColumnsQuery, conn);
                            int correctColumns = Convert.ToInt32(cmdColumns.ExecuteScalar());
                            
                            if (correctColumns < 11) // Should have 11 columns
                            {
                                System.Diagnostics.Debug.WriteLine("InsertOrder - Table structure incorrect, but keeping existing data");
                                // Don't drop table, just continue with insert
                            }
                            else
                            {
                                System.Diagnostics.Debug.WriteLine("InsertOrder - Table structure is correct");
                            }
                        }
                    }
                    catch (Exception exCreate)
                    {
                        System.Diagnostics.Debug.WriteLine($"InsertOrder - Table check error: {exCreate.Message}");
                        // Continue anyway
                    }

                    string query = @"INSERT INTO DonHang (hoten, sodienthoai, email, diachi, thanhpho, quan, ghichu, phuongthucthanhtoan, tongtien, ngaydat, trangthai) 
                                   VALUES (@HoTen, @SoDienThoai, @Email, @DiaChi, @ThanhPho, @Quan, @GhiChu, @PhuongThucThanhToan, @TongTien, @NgayDat, @TrangThai);
                                   SELECT CAST(SCOPE_IDENTITY() AS INT);";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@HoTen", txtFullName.Text.Trim());
                        cmd.Parameters.AddWithValue("@SoDienThoai", txtPhone.Text.Trim());
                        cmd.Parameters.AddWithValue("@Email", string.IsNullOrEmpty(txtEmail.Text) ? (object)DBNull.Value : txtEmail.Text.Trim());
                        cmd.Parameters.AddWithValue("@DiaChi", txtAddress.Text.Trim());
                        cmd.Parameters.AddWithValue("@ThanhPho", ddlCity.SelectedValue);
                        cmd.Parameters.AddWithValue("@Quan", ddlDistrict.SelectedValue);
                        cmd.Parameters.AddWithValue("@GhiChu", string.IsNullOrEmpty(txtNote.Text) ? (object)DBNull.Value : txtNote.Text.Trim());
                        cmd.Parameters.AddWithValue("@PhuongThucThanhToan", rblPaymentMethod.SelectedValue);
                        cmd.Parameters.AddWithValue("@TongTien", total);
                        cmd.Parameters.AddWithValue("@NgayDat", DateTime.Now);
                        cmd.Parameters.AddWithValue("@TrangThai", "Đang xử lý");

                        System.Diagnostics.Debug.WriteLine($"InsertOrder - Executing insert with total: {total:N0}");
                        
                        object result = cmd.ExecuteScalar();
                        if (result != null && result != DBNull.Value)
                        {
                            orderId = Convert.ToInt32(result);
                            System.Diagnostics.Debug.WriteLine($"InsertOrder - Order created successfully with ID: {orderId}");
                        }
                        else
                        {
                            System.Diagnostics.Debug.WriteLine("InsertOrder - No ID returned from insert");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Debug: Log detailed error
                System.Diagnostics.Debug.WriteLine($"InsertOrder - Error: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"InsertOrder - StackTrace: {ex.StackTrace}");
                
                // Re-throw to show user the exact error
                throw new Exception($"Lỗi khi lưu đơn hàng: {ex.Message}", ex);
            }

            return orderId;
        }

        private void InsertOrderDetails(int orderId, List<CartItem> cart)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connect))
                {
                    // Check if table exists and has correct structure
                    conn.Open();
                    try
                    {
                        // Check if table exists
                        string checkTableQuery = "SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'ChiTietDonHang'";
                        SqlCommand cmdCheck = new SqlCommand(checkTableQuery, conn);
                        int tableExists = Convert.ToInt32(cmdCheck.ExecuteScalar());
                        
                        if (tableExists == 0)
                        {
                            // Create table if not exists
                            string createTableQuery = @"
                            CREATE TABLE ChiTietDonHang (
                                id_chitiet INT PRIMARY KEY IDENTITY(1,1),
                                id_donhang INT,
                                id_sanpham INT,
                                tensanpham NVARCHAR(200),
                                soluong INT,
                                dongia DECIMAL(18,2),
                                thanhtien DECIMAL(18,2)
                            )";
                            SqlCommand cmdCreate = new SqlCommand(createTableQuery, conn);
                            cmdCreate.ExecuteNonQuery();
                            System.Diagnostics.Debug.WriteLine("InsertOrderDetails - Created ChiTietDonHang table");
                        }
                        else
                        {
                            // Check if table has correct columns
                            string checkColumnsQuery = @"
                                SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS 
                                WHERE TABLE_NAME = 'ChiTietDonHang' AND COLUMN_NAME IN ('id_donhang', 'id_sanpham', 'tensanpham', 'soluong', 'dongia', 'thanhtien')";
                            SqlCommand cmdColumns = new SqlCommand(checkColumnsQuery, conn);
                            int correctColumns = Convert.ToInt32(cmdColumns.ExecuteScalar());
                            
                            if (correctColumns < 6) // Should have 6 columns
                            {
                                System.Diagnostics.Debug.WriteLine("InsertOrderDetails - Table structure incorrect, but keeping existing data");
                                // Don't drop table, just continue with insert
                            }
                            else
                            {
                                System.Diagnostics.Debug.WriteLine("InsertOrderDetails - Table structure is correct");
                            }
                        }
                    }
                    catch (Exception exCreate)
                    {
                        System.Diagnostics.Debug.WriteLine($"InsertOrderDetails - Table check error: {exCreate.Message}");
                        // Continue anyway
                    }

                    string query = @"INSERT INTO ChiTietDonHang (id_donhang, id_sanpham, tensanpham, soluong, dongia, thanhtien) 
                                   VALUES (@OrderId, @ProductId, @ProductName, @Quantity, @Price, @Total)";

                    foreach (var item in cart)
                    {
                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@OrderId", orderId);
                            cmd.Parameters.AddWithValue("@ProductId", item.ProductId);
                            cmd.Parameters.AddWithValue("@ProductName", item.ProductName);
                            cmd.Parameters.AddWithValue("@Quantity", item.Quantity);
                            cmd.Parameters.AddWithValue("@Price", item.Price);
                            cmd.Parameters.AddWithValue("@Total", item.Price * item.Quantity);

                            cmd.ExecuteNonQuery();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Log error
                throw new Exception($"Lỗi khi lưu chi tiết đơn hàng: {ex.Message}", ex);
            }
        }
    }
}