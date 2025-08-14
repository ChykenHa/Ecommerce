using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Data;
using System.Linq;
using System.Web.UI;

namespace OnlineShop
{
    public partial class SanPham : System.Web.UI.Page
    {
        // Biến phân trang
        private int currentPage = 1;
        private int pageSize = 12; // Số sản phẩm mỗi trang
        private int totalPages = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Lấy số trang từ query string nếu có
                if (Request.QueryString["page"] != null)
                {
                    int.TryParse(Request.QueryString["page"], out currentPage);
                    if (currentPage < 1) currentPage = 1;
                }

                LoadProducts();
                UpdatePaginationControls();
            }
        }

        private void LoadProducts(string orderBy = null)
        {
            string connect = @"Data Source=DARLING\SQLEXPRESS;Initial Catalog=OnlineShopDB;Integrated Security=True";
            using (SqlConnection conn = new SqlConnection(connect))
            {
                try
                {
                    conn.Open();

                    // Đếm tổng số sản phẩm cho phân trang
                    string countQuery = "SELECT COUNT(*) FROM MatHang";
                    SqlCommand countCmd = new SqlCommand(countQuery, conn);
                    int totalCount = (int)countCmd.ExecuteScalar();
                    totalPages = (int)Math.Ceiling((double)totalCount / pageSize);

                    // Truy vấn chính với phân trang
                    string query = @"SELECT id_hang AS ProductId, tenhang AS Name, mota AS Description, 
                                   dongia AS Price, hinhanh AS ImageUrl FROM MatHang";

                    // Thêm ORDER BY nếu có
                    if (!string.IsNullOrEmpty(orderBy))
                    {
                        string columnName = orderBy.Split(' ')[0];
                        string[] validColumns = { "id_hang", "tenhang", "mota", "dongia", "hinh" };
                        if (validColumns.Contains(columnName))
                            query += " ORDER BY " + orderBy;
                        else
                            throw new ArgumentException("Cột sắp xếp không hợp lệ.");
                    }
                    else
                    {
                        // Sắp xếp mặc định
                        query += " ORDER BY id_hang";
                    }

                    // Thêm phân trang
                    query += " OFFSET @Offset ROWS FETCH NEXT @PageSize ROWS ONLY";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Offset", (currentPage - 1) * pageSize);
                    cmd.Parameters.AddWithValue("@PageSize", pageSize);

                    SqlDataReader reader = cmd.ExecuteReader();
                    if (rptProducts != null)
                    {
                        rptProducts.DataSource = reader;
                        rptProducts.DataBind();
                    }

                    // Hiển thị thông tin trang hiện tại
                    if (lblTotalPages != null)
                    {
                        lblTotalPages.Text = $"Trang {currentPage} / {totalPages}";
                    }
                }
                catch (Exception ex)
                {
                    // Sử dụng ScriptManager để hiển thị lỗi
                    string message = "Lỗi khi tải sản phẩm: " + ex.Message;
                    ScriptManager.RegisterStartupScript(this, GetType(), "ErrorMessage",
                        $"alert('{message.Replace("'", "\\'")}');", true);

                    System.Diagnostics.Debug.WriteLine(message);
                }
            }
        }

        private void LoadProductsByCategory(int categoryId)
        {
            string connect = @"Data Source=DARLING\SQLEXPRESS;Initial Catalog=OnlineShopDB;Integrated Security=True";
            using (SqlConnection conn = new SqlConnection(connect))
            {
                try
                {
                    conn.Open();

                    // Đếm tổng số sản phẩm trong danh mục này cho phân trang
                    string countQuery = "SELECT COUNT(*) FROM MatHang WHERE id_loai = @CategoryId";
                    SqlCommand countCmd = new SqlCommand(countQuery, conn);
                    countCmd.Parameters.AddWithValue("@CategoryId", categoryId);
                    int totalCount = (int)countCmd.ExecuteScalar();
                    totalPages = (int)Math.Ceiling((double)totalCount / pageSize);

                    // Truy vấn chính với phân trang
                    string query = @"SELECT id_hang AS ProductId, tenhang AS Name, mota AS Description, 
                                   dongia AS Price, hinhanh AS ImageUrl 
                                   FROM MatHang WHERE id_loai = @CategoryId
                                   ORDER BY id_hang
                                   OFFSET @Offset ROWS FETCH NEXT @PageSize ROWS ONLY";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@CategoryId", categoryId);
                    cmd.Parameters.AddWithValue("@Offset", (currentPage - 1) * pageSize);
                    cmd.Parameters.AddWithValue("@PageSize", pageSize);

                    SqlDataReader reader = cmd.ExecuteReader();
                    if (rptProducts != null)
                    {
                        rptProducts.DataSource = reader;
                        rptProducts.DataBind();
                    }

                    // Hiển thị thông tin trang hiện tại
                    if (lblTotalPages != null)
                    {
                        lblTotalPages.Text = $"Trang {currentPage} / {totalPages}";
                    }
                }
                catch (Exception ex)
                {
                    // Sử dụng ScriptManager để hiển thị lỗi
                    string message = "Lỗi khi tải sản phẩm theo danh mục: " + ex.Message;
                    ScriptManager.RegisterStartupScript(this, GetType(), "ErrorMessage",
                        $"alert('{message.Replace("'", "\\'")}');", true);

                    System.Diagnostics.Debug.WriteLine(message);
                }
            }
        }

        private void UpdatePaginationControls()
        {
            // Cập nhật hiển thị và trạng thái các điều khiển phân trang
            btnPrevious.Visible = (currentPage > 1);
            btnNext.Visible = (currentPage < totalPages);

            // Hiển thị các nút số trang
            LinkButton1.Text = "1";
            LinkButton1.CommandArgument = "1";

            // Triển khai đơn giản - có thể cải thiện cho trải nghiệm người dùng tốt hơn
            if (totalPages <= 5)
            {
                // Hiển thị tất cả các trang có sẵn
                LinkButton1.Visible = totalPages >= 1;
                LinkButton2.Visible = totalPages >= 2;
                LinkButton3.Visible = totalPages >= 3;
                LinkButton4.Visible = totalPages >= 4;
                LinkButton5.Visible = totalPages >= 5;

                LinkButton2.Text = "2";
                LinkButton3.Text = "3";
                LinkButton4.Text = "4";
                LinkButton5.Text = "5";

                LinkButton2.CommandArgument = "2";
                LinkButton3.CommandArgument = "3";
                LinkButton4.CommandArgument = "4";
                LinkButton5.CommandArgument = "5";
            }
            else
            {
                // Phân trang phức tạp hơn với dấu chấm lửng
                if (currentPage <= 3)
                {
                    // Đầu phân trang
                    LinkButton1.Text = "1";
                    LinkButton2.Text = "2";
                    LinkButton3.Text = "3";
                    LinkButton4.Text = "4";
                    LinkButton5.Text = "5";

                    LinkButton1.CommandArgument = "1";
                    LinkButton2.CommandArgument = "2";
                    LinkButton3.CommandArgument = "3";
                    LinkButton4.CommandArgument = "4";
                    LinkButton5.CommandArgument = "5";
                }
                else if (currentPage >= totalPages - 2)
                {
                    // Cuối phân trang
                    LinkButton1.Text = (totalPages - 4).ToString();
                    LinkButton2.Text = (totalPages - 3).ToString();
                    LinkButton3.Text = (totalPages - 2).ToString();
                    LinkButton4.Text = (totalPages - 1).ToString();
                    LinkButton5.Text = totalPages.ToString();

                    LinkButton1.CommandArgument = (totalPages - 4).ToString();
                    LinkButton2.CommandArgument = (totalPages - 3).ToString();
                    LinkButton3.CommandArgument = (totalPages - 2).ToString();
                    LinkButton4.CommandArgument = (totalPages - 1).ToString();
                    LinkButton5.CommandArgument = totalPages.ToString();
                }
                else
                {
                    // Giữa phân trang
                    LinkButton1.Text = (currentPage - 2).ToString();
                    LinkButton2.Text = (currentPage - 1).ToString();
                    LinkButton3.Text = currentPage.ToString();
                    LinkButton4.Text = (currentPage + 1).ToString();
                    LinkButton5.Text = (currentPage + 2).ToString();

                    LinkButton1.CommandArgument = (currentPage - 2).ToString();
                    LinkButton2.CommandArgument = (currentPage - 1).ToString();
                    LinkButton3.CommandArgument = currentPage.ToString();
                    LinkButton4.CommandArgument = (currentPage + 1).ToString();
                    LinkButton5.CommandArgument = (currentPage + 2).ToString();
                }
            }

            // Đặt nút trang hiện tại
            LinkButton1.CssClass = currentPage.ToString() == LinkButton1.Text ? "page-number active" : "page-number";
            LinkButton2.CssClass = currentPage.ToString() == LinkButton2.Text ? "page-number active" : "page-number";
            LinkButton3.CssClass = currentPage.ToString() == LinkButton3.Text ? "page-number active" : "page-number";
            LinkButton4.CssClass = currentPage.ToString() == LinkButton4.Text ? "page-number active" : "page-number";
            LinkButton5.CssClass = currentPage.ToString() == LinkButton5.Text ? "page-number active" : "page-number";
        }

        protected void btnBuyNow_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string productId = btn.CommandArgument;
            Response.Redirect("Checkout.aspx?productId=" + productId);
        }

        protected void btnAll_Click(object sender, EventArgs e)
        {
            currentPage = 1; // Reset về trang đầu tiên
            LoadProducts();
            UpdatePaginationControls();
        }

        protected void btnSmartphone_Click(object sender, EventArgs e)
        {
            currentPage = 1; // Reset về trang đầu tiên
            LoadProductsByCategory(1);
            UpdatePaginationControls();
        }

        protected void btnLaptop_Click(object sender, EventArgs e)
        {
            currentPage = 1; // Reset về trang đầu tiên
            LoadProductsByCategory(2);
            UpdatePaginationControls();
        }

        protected void btnManhhinh_Click(object sender, EventArgs e)
        {
            currentPage = 1; // Reset về trang đầu tiên
            LoadProductsByCategory(4);
            UpdatePaginationControls();
        }

        protected void btnHeadphone_Click(object sender, EventArgs e)
        {
            currentPage = 1; // Reset về trang đầu tiên
            LoadProductsByCategory(5);
            UpdatePaginationControls();
        }

        protected void btnCamera_Click(object sender, EventArgs e)
        {
            currentPage = 1; // Reset về trang đầu tiên
            LoadProductsByCategory(3);
            UpdatePaginationControls();
        }

        protected void ddlSort_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedValue = ddlSort.SelectedValue;

            switch (selectedValue)
            {
                case "price_asc":
                    LoadProducts("dongia ASC");
                    break;
                case "price_desc":
                    LoadProducts("dongia DESC");
                    break;
                case "name_asc":
                    LoadProducts("tenhang ASC");
                    break;
                case "name_desc":
                    LoadProducts("tenhang DESC");
                    break;
                default:
                    LoadProducts();
                    break;
            }
            UpdatePaginationControls();
        }

        // Xử lý phân trang
        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            if (currentPage > 1)
            {
                currentPage--;
                LoadProducts();
                UpdatePaginationControls();
            }
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            if (currentPage < totalPages)
            {
                currentPage++;
                LoadProducts();
                UpdatePaginationControls();
            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            GoToPage(int.Parse(LinkButton1.CommandArgument));
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            GoToPage(int.Parse(LinkButton2.CommandArgument));
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            GoToPage(int.Parse(LinkButton3.CommandArgument));
        }

        protected void LinkButton4_Click(object sender, EventArgs e)
        {
            GoToPage(int.Parse(LinkButton4.CommandArgument));
        }

        protected void LinkButton5_Click(object sender, EventArgs e)
        {
            GoToPage(int.Parse(LinkButton5.CommandArgument));
        }

        private void GoToPage(int page)
        {
            currentPage = page;
            LoadProducts();
            UpdatePaginationControls();
        }

        protected void rptProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            // Xử lý các lệnh repeater nếu cần
        }
    }
}