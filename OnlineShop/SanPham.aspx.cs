using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineShop
{
    public partial class SanPham : System.Web.UI.Page
    {
        string connect = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\DataBase.mdf;Integrated Security=True;Connect Timeout=30;Application Name=OnlineShop";

        // Pagination variables - optimized for better performance
        private int currentPage = 1;
        private int pageSize = 8; // Reduced from 10 for faster loading
        private int totalPages = 0;

        // Filter and sort state
        private int? currentCategoryId = null;
        private string currentSortOrder = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Get page number from query string
                if (Request.QueryString["page"] != null)
                {
                    int.TryParse(Request.QueryString["page"], out currentPage);
                    if (currentPage < 1) currentPage = 1;
                }

                // Get category from query string
                if (Request.QueryString["category"] != null)
                {
                    int categoryId;
                    if (int.TryParse(Request.QueryString["category"], out categoryId))
                    {
                        currentCategoryId = categoryId;
                    }
                }
                
                LoadProducts();
                UpdatePaginationControls();
                UpdateCategoryTitle();
            }
            else
            {
                // Restore state from ViewState
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
            // Save current state
            currentSortOrder = orderBy;
            currentCategoryId = categoryId ?? currentCategoryId;
            ViewState["CurrentSortOrder"] = currentSortOrder;
            ViewState["CurrentCategoryId"] = currentCategoryId;
            ViewState["CurrentPage"] = currentPage;

            using (SqlConnection conn = new SqlConnection(connect))
            {
                try
                {
                    conn.Open();

                    // Optimized query with pagination for faster loading
                    string baseQuery = "SELECT id_hang AS ProductId, tenhang AS Name, mota AS Description, dongia AS Price, " +
                                     "'~/Images_DB/Loai_' + CAST(id_loai AS VARCHAR) + '/' + CAST(id_hang AS VARCHAR) + '.webp' AS ImageUrl " +
                                     "FROM MatHang";
                    string whereClause = "";
                    string countQuery = "SELECT COUNT(*) FROM MatHang";

                    // Add WHERE condition if category is specified
                    if (categoryId.HasValue)
                    {
                        whereClause = " WHERE id_loai = @CategoryId";
                        baseQuery += whereClause;
                        countQuery += whereClause;
                    }

                    // Count total products for pagination - optimized
                    SqlCommand countCmd = new SqlCommand(countQuery, conn);
                    if (categoryId.HasValue)
                        countCmd.Parameters.AddWithValue("@CategoryId", categoryId.Value);

                    int totalCount = (int)countCmd.ExecuteScalar();
                    totalPages = (int)Math.Ceiling((double)totalCount / pageSize);

                    // Add ORDER BY with index-friendly sorting
                    if (!string.IsNullOrEmpty(orderBy))
                    {
                        string columnName = orderBy.Split(' ')[0].ToLower();
                        string[] validColumns = { "id_hang", "tenhang", "dongia" }; // Removed mota for better performance

                        if (validColumns.Contains(columnName))
                        {
                            baseQuery += " ORDER BY " + orderBy;
                        }
                        else
                        {
                            baseQuery += " ORDER BY id_hang";
                        }
                    }
                    else
                    {
                        baseQuery += " ORDER BY id_hang";
                    }

                    // Simplified pagination for better compatibility
                    int offset = (currentPage - 1) * pageSize;
                    baseQuery += $" OFFSET {offset} ROWS FETCH NEXT {pageSize} ROWS ONLY";

                    SqlCommand cmd = new SqlCommand(baseQuery, conn);
                    if (categoryId.HasValue)
                        cmd.Parameters.AddWithValue("@CategoryId", categoryId.Value);

                    SqlDataReader reader = cmd.ExecuteReader();
                    if (rptProducts != null)
                    {
                        rptProducts.DataSource = reader;
                        rptProducts.DataBind();
                    }

                    reader.Close();

                    // Display current page info
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

        private void UpdateCategoryTitle()
        {
            if (lblCategoryTitle != null)
            {
                if (currentCategoryId.HasValue)
                {
                    string categoryName = GetCategoryName(currentCategoryId.Value);
                    lblCategoryTitle.Text = categoryName;
                }
                else
                {
                    lblCategoryTitle.Text = "Tất Cả Sản Phẩm";
                }
            }
        }

        private string GetCategoryName(int categoryId)
        {
            switch (categoryId)
            {
                case 1: return "Điện Thoại";
                case 2: return "Laptop";
                case 3: return "Máy Tính Bảng";
                case 4: return "Tai Nghe";
                case 5: return "Phụ Kiện";
                default: return "Sản Phẩm";
            }
        }

        private void UpdatePaginationControls()
        {
            if (totalPages == 0) 
            {
                System.Diagnostics.Debug.WriteLine("UpdatePaginationControls - No pages to display");
                return;
            }

            System.Diagnostics.Debug.WriteLine($"UpdatePaginationControls - Current page: {currentPage}, Total pages: {totalPages}");
            
            // Cập nhật hiển thị và trạng thái các điều khiển phân trang
            btnPrevious.Visible = (currentPage > 1);
            btnNext.Visible = (currentPage < totalPages);
            
            System.Diagnostics.Debug.WriteLine($"UpdatePaginationControls - Previous visible: {btnPrevious.Visible}, Next visible: {btnNext.Visible}");

            // Hiển thị các nút số trang (chỉ 3 nút)
            if (totalPages <= 3)
            {
                // Hiển thị tất cả các trang có sẵn
                LinkButton1.Visible = totalPages >= 1;
                LinkButton2.Visible = totalPages >= 2;
                LinkButton3.Visible = totalPages >= 3;

                for (int i = 1; i <= Math.Min(3, totalPages); i++)
                {
                    LinkButton btn = GetLinkButton(i);
                    if (btn != null)
                    {
                        btn.Text = i.ToString();
                        btn.CommandArgument = i.ToString();
                        btn.CssClass = currentPage == i ? "page-number active" : "page-number";
                    }
                }
            }
            else
            {
                // Phân trang phức tạp hơn với 3 nút
                int[] pageNumbers = new int[3];

                if (currentPage <= 2)
                {
                    // Đầu phân trang: 1, 2, 3
                    for (int i = 0; i < 3; i++)
                        pageNumbers[i] = i + 1;
                }
                else if (currentPage >= totalPages - 1)
                {
                    // Cuối phân trang: (n-2), (n-1), n
                    for (int i = 0; i < 3; i++)
                        pageNumbers[i] = totalPages - 2 + i;
                }
                else
                {
                    // Giữa phân trang: (current-1), current, (current+1)
                    for (int i = 0; i < 3; i++)
                        pageNumbers[i] = currentPage - 1 + i;
                }

                // Hiển thị tất cả 3 nút
                LinkButton1.Visible = true;
                LinkButton2.Visible = true;
                LinkButton3.Visible = true;

                // Cập nhật các LinkButton
                for (int i = 1; i <= 3; i++)
                {
                    LinkButton btn = GetLinkButton(i);
                    if (btn != null)
                    {
                        btn.Text = pageNumbers[i - 1].ToString();
                        btn.CommandArgument = pageNumbers[i - 1].ToString();
                        btn.CssClass = currentPage == pageNumbers[i - 1] ? "page-number active" : "page-number";
                    }
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
                default: return LinkButton1;
            }
        }

        protected void btnBuyNow_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int productId = int.Parse(btn.CommandArgument);
            
            // Add product to cart first
            AddProductToCart(productId, 1);
            
            // Then redirect to cart page
            Response.Redirect("GioHang.aspx");
        }
        
        private void AddProductToCart(int productId, int quantity)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connect))
                {
                    using (SqlCommand cmd = new SqlCommand("SELECT id_hang AS ProductId, tenhang AS ProductName, dongia AS Price, " +
                        "'~/Images_DB/Loai_' + CAST(id_loai AS VARCHAR) + '/' + CAST(id_hang AS VARCHAR) + '.webp' AS ImageUrl " +
                        "FROM MatHang WHERE id_hang = @ProductId", conn))
                    {
                        cmd.Parameters.AddWithValue("@ProductId", productId);
                        conn.Open();

                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.Read())
                        {
                            int pId = reader.GetInt32(reader.GetOrdinal("ProductId"));
                            string pName = reader.GetString(reader.GetOrdinal("ProductName"));
                            decimal pPrice = reader.GetDecimal(reader.GetOrdinal("Price"));
                            string pImage = reader["ImageUrl"].ToString();

                            List<CartItem> cartItems = Session["Cart"] as List<CartItem> ?? new List<CartItem>();

                            CartItem existingItem = cartItems.Find(c => c.ProductId == pId);
                            if (existingItem != null)
                            {
                                existingItem.Quantity += quantity;
                            }
                            else
                            {
                                CartItem newItem = new CartItem
                                {
                                    ProductId = pId,
                                    ProductName = pName,
                                    Price = pPrice,
                                    Quantity = quantity,
                                    ImageUrl = pImage
                                };
                                cartItems.Add(newItem);
                            }

                            Session["Cart"] = cartItems;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                string errorMessage = "Lỗi khi thêm sản phẩm vào giỏ hàng: " + ex.Message;
                ScriptManager.RegisterStartupScript(this, GetType(), "ErrorMessage", $"alert('{errorMessage.Replace("'", "\\'")}');", true);
                System.Diagnostics.Debug.WriteLine(errorMessage);
            }
        }

        protected void btnAll_Click(object sender, EventArgs e)
        {
            currentPage = 1;
            currentCategoryId = null;
            LoadProducts();
            UpdatePaginationControls();
            UpdateCategoryTitle();
        }

        protected void btnSmartphone_Click(object sender, EventArgs e)
        {
            currentPage = 1;
            LoadProducts(currentSortOrder, 1);
            UpdatePaginationControls();
            UpdateCategoryTitle();
        }

        protected void btnLaptop_Click(object sender, EventArgs e)
        {
            currentPage = 1;
            LoadProducts(currentSortOrder, 2);
            UpdatePaginationControls();
            UpdateCategoryTitle();
        }

        protected void btnTablet_Click(object sender, EventArgs e)
        {
            currentPage = 1;
            LoadProducts(currentSortOrder, 3);
            UpdatePaginationControls();
            UpdateCategoryTitle();
        }

        protected void btnHeadphone_Click(object sender, EventArgs e)
        {
            currentPage = 1;
            LoadProducts(currentSortOrder, 4);
            UpdatePaginationControls();
            UpdateCategoryTitle();
        }

        protected void btnAccessories_Click(object sender, EventArgs e)
        {
            currentPage = 1;
            LoadProducts(currentSortOrder, 5);
            UpdatePaginationControls();
            UpdateCategoryTitle();
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
            if (currentPage < 10)
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