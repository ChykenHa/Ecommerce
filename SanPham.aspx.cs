using System;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineShop
{
    public partial class SanPham : System.Web.UI.Page
    {
        string connect = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\DataBase.mdf;Integrated Security=True";

        // Biến phân trang
        private int currentPage = 1;
        private int pageSize = 12;
        private int totalPages = 0;

        // Thêm biến để lưu trữ trạng thái lọc và sắp xếp
        private int? currentCategoryId = null;
        private string currentSortOrder = null;

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
            else
            {
                // Khôi phục trạng thái từ ViewState
                if (ViewState["CurrentCategoryId"] != null)
                    currentCategoryId = (int?)ViewState["CurrentCategoryId"];
                if (ViewState["CurrentSortOrder"] != null)
                    currentSortOrder = ViewState["CurrentSortOrder"].ToString();
                if (ViewState["CurrentPage"] != null)
                    currentPage = (int)ViewState["CurrentPage"];
            }
        }

        private void LoadProducts(string orderBy = null, int? categoryId = null)
        {
            // Lưu trạng thái hiện tại
            currentSortOrder = orderBy;
            currentCategoryId = categoryId;
            ViewState["CurrentSortOrder"] = currentSortOrder;
            ViewState["CurrentCategoryId"] = currentCategoryId;
            ViewState["CurrentPage"] = currentPage;

            using (SqlConnection conn = new SqlConnection(connect))
            {
                try
                {
                    conn.Open();

                    // Tạo câu truy vấn cơ bản
                    string baseQuery = "SELECT id_hang AS ProductId, tenhang AS Name, mota AS Description, dongia AS Price, hinhanh AS ImageUrl FROM MatHang";
                    string whereClause = "";
                    string countQuery = "SELECT COUNT(*) FROM MatHang";

                    // Thêm điều kiện WHERE nếu có category
                    if (categoryId.HasValue)
                    {
                        whereClause = " WHERE id_loai = @CategoryId";
                        baseQuery += whereClause;
                        countQuery += whereClause;
                    }

                    // Đếm tổng số sản phẩm cho phân trang
                    SqlCommand countCmd = new SqlCommand(countQuery, conn);
                    if (categoryId.HasValue)
                        countCmd.Parameters.AddWithValue("@CategoryId", categoryId.Value);

                    int totalCount = (int)countCmd.ExecuteScalar();
                    totalPages = (int)Math.Ceiling((double)totalCount / pageSize);

                    // Thêm ORDER BY
                    if (!string.IsNullOrEmpty(orderBy))
                    {
                        string columnName = orderBy.Split(' ')[0].ToLower();
                        string[] validColumns = { "id_hang", "tenhang", "mota", "dongia", "hinhanh" };

                        if (validColumns.Contains(columnName))
                        {
                            baseQuery += " ORDER BY " + orderBy;
                        }
                        else
                        {
                            // Sắp xếp mặc định nếu cột không hợp lệ
                            baseQuery += " ORDER BY id_hang";
                        }
                    }
                    else
                    {
                        // Sắp xếp mặc định
                        baseQuery += " ORDER BY id_hang";
                    }

                    // Thêm phân trang
                    baseQuery += " OFFSET @Offset ROWS FETCH NEXT @PageSize ROWS ONLY";

                    SqlCommand cmd = new SqlCommand(baseQuery, conn);
                    if (categoryId.HasValue)
                        cmd.Parameters.AddWithValue("@CategoryId", categoryId.Value);
                    cmd.Parameters.AddWithValue("@Offset", (currentPage - 1) * pageSize);
                    cmd.Parameters.AddWithValue("@PageSize", pageSize);

                    SqlDataReader reader = cmd.ExecuteReader();
                    if (rptProducts != null)
                    {
                        rptProducts.DataSource = reader;
                        rptProducts.DataBind();
                    }

                    reader.Close();

                    // Hiển thị thông tin trang hiện tại
                    if (lblTotalPages != null)
                    {
                        lblTotalPages.Text = $"Trang {currentPage} / {totalPages}";
                    }
                }
                catch (Exception ex)
                {
                    string message = "Lỗi khi tải sản phẩm: " + ex.Message;
                    ScriptManager.RegisterStartupScript(this, GetType(), "ErrorMessage",
                        $"alert('{message.Replace("'", "\\'")}');", true);
                    System.Diagnostics.Debug.WriteLine(message);
                }
            }
        }

        // Loại bỏ method LoadProductsByCategory vì đã tích hợp vào LoadProducts

        private void UpdatePaginationControls()
        {
            if (totalPages == 0) return;

            // Cập nhật hiển thị và trạng thái các điều khiển phân trang
            btnPrevious.Visible = (currentPage > 1);
            btnNext.Visible = (currentPage < totalPages);

            // Hiển thị các nút số trang
            if (totalPages <= 5)
            {
                // Hiển thị tất cả các trang có sẵn
                LinkButton1.Visible = totalPages >= 1;
                LinkButton2.Visible = totalPages >= 2;
                LinkButton3.Visible = totalPages >= 3;
                LinkButton4.Visible = totalPages >= 4;
                LinkButton5.Visible = totalPages >= 5;

                for (int i = 1; i <= Math.Min(5, totalPages); i++)
                {
                    LinkButton btn = GetLinkButton(i);
                    btn.Text = i.ToString();
                    btn.CommandArgument = i.ToString();
                    btn.CssClass = currentPage == i ? "page-number active" : "page-number";
                }
            }
            else
            {
                // Phân trang phức tạp hơn
                int[] pageNumbers = new int[5];

                if (currentPage <= 3)
                {
                    // Đầu phân trang: 1, 2, 3, 4, 5
                    for (int i = 0; i < 5; i++)
                        pageNumbers[i] = i + 1;
                }
                else if (currentPage >= totalPages - 2)
                {
                    // Cuối phân trang: (n-4), (n-3), (n-2), (n-1), n
                    for (int i = 0; i < 5; i++)
                        pageNumbers[i] = totalPages - 4 + i;
                }
                else
                {
                    // Giữa phân trang: (current-2), (current-1), current, (current+1), (current+2)
                    for (int i = 0; i < 5; i++)
                        pageNumbers[i] = currentPage - 2 + i;
                }

                // Cập nhật các LinkButton
                for (int i = 1; i <= 5; i++)
                {
                    LinkButton btn = GetLinkButton(i);
                    btn.Text = pageNumbers[i - 1].ToString();
                    btn.CommandArgument = pageNumbers[i - 1].ToString();
                    btn.CssClass = currentPage == pageNumbers[i - 1] ? "page-number active" : "page-number";
                }
            }
        }

        private LinkButton GetLinkButton(int index)
        {
            switch (index)
            {
                case 1: return LinkButton1;
                case 2: return LinkButton2;
                case 3: return LinkButton3;
                case 4: return LinkButton4;
                case 5: return LinkButton5;
                default: return LinkButton1;
            }
        }

        protected void btnBuyNow_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string productId = btn.CommandArgument;
            Response.Redirect("GioHang.aspx?productId=" + productId);
        }

        protected void btnAll_Click(object sender, EventArgs e)
        {
            currentPage = 1;
            LoadProducts();
            UpdatePaginationControls();
        }

        protected void btnSmartphone_Click(object sender, EventArgs e)
        {
            currentPage = 1;
            LoadProducts(currentSortOrder, 1); // Giữ nguyên sort order hiện tại
            UpdatePaginationControls();
        }

        protected void btnLaptop_Click(object sender, EventArgs e)
        {
            currentPage = 1;
            LoadProducts(currentSortOrder, 2);
            UpdatePaginationControls();
        }

        protected void btnManhhinh_Click(object sender, EventArgs e)
        {
            currentPage = 1;
            LoadProducts(currentSortOrder, 4);
            UpdatePaginationControls();
        }

        protected void btnHeadphone_Click(object sender, EventArgs e)
        {
            currentPage = 1;
            LoadProducts(currentSortOrder, 5);
            UpdatePaginationControls();
        }

        protected void btnCamera_Click(object sender, EventArgs e)
        {
            currentPage = 1;
            LoadProducts(currentSortOrder, 3);
            UpdatePaginationControls();
        }

        protected void ddlSort_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedValue = ddlSort.SelectedValue;
            string orderBy = null;

            switch (selectedValue)
            {
                case "price_asc":
                    orderBy = "dongia ASC";
                    break;
                case "price_desc":
                    orderBy = "dongia DESC";
                    break;
                case "name_asc":
                    orderBy = "tenhang ASC";
                    break;
                case "name_desc":
                    orderBy = "tenhang DESC";
                    break;
                default:
                    orderBy = null;
                    break;
            }

            currentPage = 1; // Reset về trang đầu khi sort
            LoadProducts(orderBy, currentCategoryId); // Giữ nguyên category filter
            UpdatePaginationControls();
        }

        // Xử lý phân trang
        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            if (currentPage > 1)
            {
                currentPage--;
                LoadProducts(currentSortOrder, currentCategoryId);
                UpdatePaginationControls();
            }
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            if (currentPage < totalPages)
            {
                currentPage++;
                LoadProducts(currentSortOrder, currentCategoryId);
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
            LoadProducts(currentSortOrder, currentCategoryId);
            UpdatePaginationControls();
        }

        protected void rptProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            // Xử lý các lệnh repeater nếu cần
        }
    }
}