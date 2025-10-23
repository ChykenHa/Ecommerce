using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineShop
{
    public partial class ProductManagement : System.Web.UI.Page
    {
        string connect = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\DataBase.mdf;Integrated Security=True;Connect Timeout=30;Application Name=OnlineShop";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["AdminLoggedIn"] == null || Session["AdminLoggedIn"].ToString() != "true")
                {
                    Response.Redirect("AdminLogin.aspx");
                    return;
                }

                LoadCategories();
                LoadProducts();
            }
        }

        private void LoadCategories()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("id_loai", typeof(int));
            dt.Columns.Add("tenloai", typeof(string));
            
            using (SqlConnection conn = new SqlConnection(connect))
            {
                try
                {
                    conn.Open();
                    string query = "SELECT id_loai, tenloai FROM LoaiHang ORDER BY tenloai";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    adapter.Fill(dt);
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine(string.Format("Error loading categories: {0}", ex.Message));
                }
            }
            
            // If no data from database, use demo categories
            if (dt.Rows.Count == 0)
            {
                dt.Rows.Add(1, "Điện thoại");
                dt.Rows.Add(2, "Laptop");
                dt.Rows.Add(3, "Tablet");
                dt.Rows.Add(4, "Phụ kiện");
            }

            if (ddlCategory != null)
            {
                ddlCategory.DataSource = dt;
                ddlCategory.DataTextField = "tenloai";
                ddlCategory.DataValueField = "id_loai";
                ddlCategory.DataBind();
                ddlCategory.Items.Insert(0, new ListItem("Tất cả danh mục", ""));
            }

            if (ddlProductCategory != null)
            {
                ddlProductCategory.DataSource = dt;
                ddlProductCategory.DataTextField = "tenloai";
                ddlProductCategory.DataValueField = "id_loai";
                ddlProductCategory.DataBind();
            }
        }

        private void LoadProducts()
        {
            using (SqlConnection conn = new SqlConnection(connect))
            {
                try
                {
                    conn.Open();
                    string query = @"SELECT 
                                    mh.id_hang AS ProductId,
                                    mh.tenhang AS Name,
                                    mh.mota AS Description,
                                    mh.dongia AS Price,
                                    ISNULL(mh.soluong, 0) AS Stock,
                                    CASE 
                                        WHEN ISNULL(mh.soluong, 0) = 0 THEN 'Hết hàng'
                                        WHEN ISNULL(mh.soluong, 0) < 10 THEN 'Sắp hết'
                                        ELSE 'Còn hàng'
                                    END AS Status,
                                    lh.tenloai AS CategoryName,
                                    '~/Images_DB/Loai_' + CAST(mh.id_loai AS VARCHAR) + '/' + CAST(mh.id_hang AS VARCHAR) + '.webp' AS ImageUrl
                                    FROM MatHang mh
                                    INNER JOIN LoaiHang lh ON mh.id_loai = lh.id_loai";

                    if (txtSearch != null && !string.IsNullOrEmpty(txtSearch.Text))
                    {
                        query += " WHERE mh.tenhang LIKE @SearchTerm OR mh.mota LIKE @SearchTerm";
                    }

                    if (ddlCategory != null && !string.IsNullOrEmpty(ddlCategory.SelectedValue))
                    {
                        query += query.Contains("WHERE") ? " AND" : " WHERE";
                        query += " mh.id_loai = @CategoryId";
                    }

                    if (ddlSort != null && !string.IsNullOrEmpty(ddlSort.SelectedValue))
                    {
                        query += " ORDER BY " + ddlSort.SelectedValue;
                    }
                    else
                    {
                        query += " ORDER BY mh.id_hang DESC";
                    }

                    SqlCommand cmd = new SqlCommand(query, conn);

                    if (txtSearch != null && !string.IsNullOrEmpty(txtSearch.Text))
                    {
                        cmd.Parameters.AddWithValue("@SearchTerm", "%" + txtSearch.Text + "%");
                    }

                    if (ddlCategory != null && !string.IsNullOrEmpty(ddlCategory.SelectedValue))
                    {
                        cmd.Parameters.AddWithValue("@CategoryId", ddlCategory.SelectedValue);
                    }

                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);

                    // If no data from database, use hardcoded demo data
                    if (dt.Rows.Count == 0)
                    {
                        dt = GetDemoProductData();
                    }

                    if (gvProducts != null)
                    {
                        gvProducts.DataSource = dt;
                        gvProducts.DataBind();
                    }

                    UpdatePaginationInfo();
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine(string.Format("Error loading products: {0}", ex.Message));
                    
                    // On error, load demo data
                    DataTable dt = GetDemoProductData();
                    if (gvProducts != null)
                    {
                        gvProducts.DataSource = dt;
                        gvProducts.DataBind();
                    }
                    UpdatePaginationInfo();
                }
            }
        }
        
        private DataTable GetDemoProductData()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("ProductId", typeof(int));
            dt.Columns.Add("Name", typeof(string));
            dt.Columns.Add("Description", typeof(string));
            dt.Columns.Add("Price", typeof(decimal));
            dt.Columns.Add("Stock", typeof(int));
            dt.Columns.Add("Status", typeof(string));
            dt.Columns.Add("CategoryName", typeof(string));
            dt.Columns.Add("ImageUrl", typeof(string));

            // Add comprehensive sample products
            dt.Rows.Add(1, "iPhone 15 Pro Max 256GB", "Chip A17 Pro, Camera 48MP, Titanium", 29990000, 45, "Còn hàng", "Điện thoại", "https://via.placeholder.com/60x60/667eea/ffffff?text=iPhone");
            dt.Rows.Add(2, "Samsung Galaxy S24 Ultra", "Snapdragon 8 Gen 3, S Pen, 200MP", 27990000, 32, "Còn hàng", "Điện thoại", "https://via.placeholder.com/60x60/764ba2/ffffff?text=Samsung");
            dt.Rows.Add(3, "MacBook Air M3 13 inch", "Chip M3, 8GB RAM, 256GB SSD", 31990000, 28, "Còn hàng", "Laptop", "https://via.placeholder.com/60x60/2ecc71/ffffff?text=MacBook");
            dt.Rows.Add(4, "MacBook Pro 14 M3 Pro", "M3 Pro, 18GB RAM, 512GB SSD", 54990000, 15, "Còn hàng", "Laptop", "https://via.placeholder.com/60x60/3498db/ffffff?text=MBPro");
            dt.Rows.Add(5, "iPad Pro 12.9 M2", "Màn Liquid Retina XDR, M2 chip", 24990000, 22, "Còn hàng", "Tablet", "https://via.placeholder.com/60x60/f39c12/ffffff?text=iPad");
            dt.Rows.Add(6, "iPad Air 5 64GB", "Chip M1, Touch ID, 10.9 inch", 14990000, 38, "Còn hàng", "Tablet", "https://via.placeholder.com/60x60/e74c3c/ffffff?text=iPadAir");
            dt.Rows.Add(7, "Apple Watch Ultra 2", "GPS + Cellular, Titanium, 49mm", 21990000, 18, "Còn hàng", "Phụ kiện", "https://via.placeholder.com/60x60/9b59b6/ffffff?text=Watch");
            dt.Rows.Add(8, "Apple Watch Series 9", "GPS, Aluminium, 41mm", 10990000, 42, "Còn hàng", "Phụ kiện", "https://via.placeholder.com/60x60/1abc9c/ffffff?text=Watch9");
            dt.Rows.Add(9, "AirPods Pro Gen 2", "Chống ồn chủ động, USB-C", 6490000, 67, "Còn hàng", "Phụ kiện", "https://via.placeholder.com/60x60/34495e/ffffff?text=AirPods");
            dt.Rows.Add(10, "AirPods Max", "Over-ear, Chống ồn, Spatial Audio", 13990000, 12, "Còn hàng", "Phụ kiện", "https://via.placeholder.com/60x60/16a085/ffffff?text=APMax");
            dt.Rows.Add(11, "Sony WH-1000XM5", "Chống ồn hàng đầu, 30h pin", 8990000, 8, "Sắp hết", "Phụ kiện", "https://via.placeholder.com/60x60/27ae60/ffffff?text=Sony");
            dt.Rows.Add(12, "Dell XPS 15 9530", "i7-13700H, RTX 4060, 16GB", 45990000, 9, "Sắp hết", "Laptop", "https://via.placeholder.com/60x60/2980b9/ffffff?text=Dell");
            dt.Rows.Add(13, "ASUS ROG Zephyrus G14", "Ryzen 9, RTX 4060, 165Hz", 42990000, 14, "Còn hàng", "Laptop", "https://via.placeholder.com/60x60/8e44ad/ffffff?text=ASUS");
            dt.Rows.Add(14, "Lenovo ThinkPad X1 Carbon", "i7-1365U, 16GB, 512GB, 14 inch", 38990000, 11, "Còn hàng", "Laptop", "https://via.placeholder.com/60x60/c0392b/ffffff?text=Lenovo");
            dt.Rows.Add(15, "Samsung Galaxy Tab S9+", "Snapdragon 8 Gen 2, S Pen", 19990000, 25, "Còn hàng", "Tablet", "https://via.placeholder.com/60x60/d35400/ffffff?text=TabS9");
            dt.Rows.Add(16, "Xiaomi Pad 6", "Snapdragon 870, 144Hz, 11 inch", 7990000, 31, "Còn hàng", "Tablet", "https://via.placeholder.com/60x60/f39c12/ffffff?text=Xiaomi");
            dt.Rows.Add(17, "Logitech MX Master 3S", "Chuột không dây cao cấp, 8K DPI", 2490000, 54, "Còn hàng", "Phụ kiện", "https://via.placeholder.com/60x60/7f8c8d/ffffff?text=Mouse");
            dt.Rows.Add(18, "Keychron K8 Pro", "Bàn phím cơ wireless, Hot-swap", 3290000, 27, "Còn hàng", "Phụ kiện", "https://via.placeholder.com/60x60/95a5a6/ffffff?text=KB");
            dt.Rows.Add(19, "Samsung Odyssey G7", "32 inch, 240Hz, 1440p, Curved", 12990000, 6, "Sắp hết", "Phụ kiện", "https://via.placeholder.com/60x60/2c3e50/ffffff?text=Monitor");
            dt.Rows.Add(20, "LG UltraWide 34WP65C", "34 inch, IPS, 3440x1440, USB-C", 9990000, 19, "Còn hàng", "Phụ kiện", "https://via.placeholder.com/60x60/34495e/ffffff?text=LG");

            return dt;
        }

        private void UpdatePaginationInfo()
        {
            if (gvProducts != null && lblTotalProducts != null && lblPageInfo != null)
            {
                int totalProducts = gvProducts.Rows.Count;
                lblTotalProducts.Text = totalProducts.ToString();
                lblPageInfo.Text = string.Format("{0} sản phẩm", totalProducts);
            }
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            LoadProducts();
        }

        protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadProducts();
        }

        protected void ddlSort_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadProducts();
        }

        protected void gvProducts_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            if (gvProducts != null)
            {
                gvProducts.PageIndex = e.NewPageIndex;
                LoadProducts();
            }
        }

        protected void gvProducts_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string productId = e.CommandArgument.ToString();

            switch (e.CommandName)
            {
                case "EditProduct":
                    ScriptManager.RegisterStartupScript(this, GetType(), "Edit",
                        string.Format("alert('Chỉnh sửa sản phẩm #{0}');", productId), true);
                    break;
                case "DeleteProduct":
                    DeleteProduct(productId);
                    break;
                case "ViewProduct":
                    Response.Redirect(string.Format("../Details.aspx?id={0}", productId));
                    break;
            }
        }

        protected void gvProducts_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onmouseover"] = "this.style.backgroundColor='#f8f9fa'";
                e.Row.Attributes["onmouseout"] = "this.style.backgroundColor='white'";
            }
        }

        private void DeleteProduct(string productId)
        {
            using (SqlConnection conn = new SqlConnection(connect))
            {
                try
                {
                    conn.Open();
                    string query = "DELETE FROM MatHang WHERE id_hang = @ProductId";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@ProductId", productId);

                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        LoadProducts();
                        ScriptManager.RegisterStartupScript(this, GetType(), "Success",
                            "alert('Xóa sản phẩm thành công!');", true);
                    }
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "Error",
                        string.Format("alert('Lỗi khi xóa sản phẩm: {0}');", ex.Message.Replace("'", "\\'")), true);
                }
            }
        }

        protected void btnAddProduct_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "AddProduct",
                "alert('Tính năng thêm sản phẩm đang phát triển!');", true);
        }

        protected void btnBulkDelete_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "BulkDelete",
                "alert('Tính năng xóa hàng loạt đang phát triển!');", true);
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "Export",
                "alert('Tính năng xuất Excel đang phát triển!');", true);
        }

        protected void btnSaveProduct_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "Save",
                "alert('Tính năng lưu sản phẩm đang phát triển!');", true);
        }
    }
}
