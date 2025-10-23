using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineShop
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        string connect = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\DataBase.mdf;Integrated Security=True;Connect Timeout=30;Application Name=OnlineShop";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check admin authentication
                if (Session["AdminLoggedIn"] == null || Session["AdminLoggedIn"].ToString() != "true")
                {
                    Response.Redirect("AdminLogin.aspx");
                    return;
                }

                LoadDashboardStats();
                LoadRecentProducts();
            }
        }

        private void LoadDashboardStats()
        {
            using (SqlConnection conn = new SqlConnection(connect))
            {
                try
                {
                    conn.Open();

                    // Load total orders - using simplified query for demo
                    string orderQuery = "SELECT COUNT(*) FROM MatHang"; // Using MatHang as demo
                    SqlCommand orderCmd = new SqlCommand(orderQuery, conn);
                    string totalOrders = orderCmd.ExecuteScalar().ToString();

                    // Load total products
                    string productQuery = "SELECT COUNT(*) FROM MatHang";
                    SqlCommand productCmd = new SqlCommand(productQuery, conn);
                    string totalProducts = productCmd.ExecuteScalar().ToString();

                    // Load total users - using MatHang as demo since TaiKhoan might not exist
                    string userQuery = "SELECT COUNT(*) FROM MatHang";
                    SqlCommand userCmd = new SqlCommand(userQuery, conn);
                    string totalUsers = userCmd.ExecuteScalar().ToString();

                    // Load total revenue - simplified
                    string revenueQuery = "SELECT ISNULL(SUM(dongia), 0) FROM MatHang";
                    SqlCommand revenueCmd = new SqlCommand(revenueQuery, conn);
                    decimal totalRevenue = Convert.ToDecimal(revenueCmd.ExecuteScalar());

                    // Update labels using FindControl
                    Label lblOrders = (Label)FindControl("lblTotalOrders");
                    Label lblProducts = (Label)FindControl("lblTotalProducts");
                    Label lblUsers = (Label)FindControl("lblTotalUsers");
                    Label lblRevenue = (Label)FindControl("lblTotalRevenue");

                    if (lblOrders != null) lblOrders.Text = totalOrders;
                    if (lblProducts != null) lblProducts.Text = totalProducts;
                    if (lblUsers != null) lblUsers.Text = totalUsers;
                    if (lblRevenue != null) lblRevenue.Text = totalRevenue.ToString("N0") + " ₫";
                }
                catch (Exception ex)
                {
                    // Handle error
                    System.Diagnostics.Debug.WriteLine($"Error loading dashboard stats: {ex.Message}");
                }
            }
        }

        private void LoadRecentProducts()
        {
            using (SqlConnection conn = new SqlConnection(connect))
            {
                try
                {
                    conn.Open();
                    string query = @"SELECT TOP 10 
                                    mh.id_hang AS ProductId,
                                    mh.tenhang AS Name,
                                    mh.mota AS Description,
                                    mh.dongia AS Price,
                                    lh.tenloai AS CategoryName,
                                    '~/Images_DB/Loai_' + CAST(mh.id_loai AS VARCHAR) + '/' + CAST(mh.id_hang AS VARCHAR) + '.webp' AS ImageUrl,
                                    GETDATE() AS CreatedDate
                                    FROM MatHang mh
                                    INNER JOIN LoaiHang lh ON mh.id_loai = lh.id_loai
                                    ORDER BY mh.id_hang DESC";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);

                    GridView gvProducts = (GridView)FindControl("gvRecentProducts");
                    if (gvProducts != null)
                    {
                        gvProducts.DataSource = dt;
                        gvProducts.DataBind();
                    }
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine($"Error loading recent products: {ex.Message}");
                }
            }
        }

        protected void btnViewOrder_Click(object sender, EventArgs e)
        {
            // Redirect to order detail page
            string orderId = ((Button)sender).CommandArgument;
            Response.Redirect($"OrderDetail.aspx?id={orderId}");
        }

        protected void btnEditProduct_Click(object sender, EventArgs e)
        {
            // Redirect to product edit page
            string productId = ((Button)sender).CommandArgument;
            Response.Redirect($"ProductEdit.aspx?id={productId}");
        }
    }
}