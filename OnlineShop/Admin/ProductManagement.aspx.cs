using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
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
                // Check admin authentication
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
            using (SqlConnection conn = new SqlConnection(connect))
            {
                try
                {
                    conn.Open();
                    string query = "SELECT id_loai, tenloai FROM LoaiHang ORDER BY tenloai";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);

                    DropDownList ddlCat = (DropDownList)FindControl("ddlCategory");
                    DropDownList ddlProdCat = (DropDownList)FindControl("ddlProductCategory");

                    if (ddlCat != null)
                    {
                        ddlCat.DataSource = dt;
                        ddlCat.DataTextField = "tenloai";
                        ddlCat.DataValueField = "id_loai";
                        ddlCat.DataBind();
                    }

                    if (ddlProdCat != null)
                    {
                        ddlProdCat.DataSource = dt;
                        ddlProdCat.DataTextField = "tenloai";
                        ddlProdCat.DataValueField = "id_loai";
                        ddlProdCat.DataBind();
                    }
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine($"Error loading categories: {ex.Message}");
                }
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
                                    '~/Images_DB/Loai_' + CAST(mh.id_loai AS VARCHAR) + '/' + CAST(mh.id_hang AS VARCHAR) + '.webp' AS ImageUrl,
                                    GETDATE() AS CreatedDate
                                    FROM MatHang mh
                                    INNER JOIN LoaiHang lh ON mh.id_loai = lh.id_loai";

                    // Add search filter
                    TextBox txtSearch = (TextBox)FindControl("txtSearch");
                    if (txtSearch != null && !string.IsNullOrEmpty(txtSearch.Text))
                    {
                        query += " WHERE mh.tenhang LIKE @SearchTerm OR mh.mota LIKE @SearchTerm";
                    }

                    // Add category filter
                    DropDownList ddlCat = (DropDownList)FindControl("ddlCategory");
                    if (ddlCat != null && !string.IsNullOrEmpty(ddlCat.SelectedValue))
                    {
                        if (query.Contains("WHERE"))
                            query += " AND mh.id_loai = @CategoryId";
                        else
                            query += " WHERE mh.id_loai = @CategoryId";
                    }

                    // Add sorting
                    DropDownList ddlSort = (DropDownList)FindControl("ddlSort");
                    if (ddlSort != null)
                    {
                        query += " ORDER BY " + ddlSort.SelectedValue;
                    }

                    SqlCommand cmd = new SqlCommand(query, conn);
                    
                    if (txtSearch != null && !string.IsNullOrEmpty(txtSearch.Text))
                    {
                        cmd.Parameters.AddWithValue("@SearchTerm", "%" + txtSearch.Text + "%");
                    }
                    
                    if (ddlCat != null && !string.IsNullOrEmpty(ddlCat.SelectedValue))
                    {
                        cmd.Parameters.AddWithValue("@CategoryId", ddlCat.SelectedValue);
                    }

                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);

                    GridView gvProducts = (GridView)FindControl("gvProducts");
                    if (gvProducts != null)
                    {
                        gvProducts.DataSource = dt;
                        gvProducts.DataBind();
                    }

                    // Update pagination info
                    UpdatePaginationInfo();
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine($"Error loading products: {ex.Message}");
                }
            }
        }

        private void UpdatePaginationInfo()
        {
            GridView gvProducts = (GridView)FindControl("gvProducts");
            Label lblTotal = (Label)FindControl("lblTotalProducts");
            Label lblPageInfo = (Label)FindControl("lblPageInfo");

            if (gvProducts != null && lblTotal != null && lblPageInfo != null)
            {
                int totalProducts = gvProducts.Rows.Count;
                int currentPage = gvProducts.PageIndex + 1;
                int pageSize = gvProducts.PageSize;
                int startIndex = (currentPage - 1) * pageSize + 1;
                int endIndex = Math.Min(currentPage * pageSize, totalProducts);

                lblTotal.Text = totalProducts.ToString();
                lblPageInfo.Text = $"{startIndex} - {endIndex}";
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
            GridView gvProducts = (GridView)FindControl("gvProducts");
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
                case "Edit":
                    LoadProductForEdit(productId);
                    break;
                case "Delete":
                    DeleteProduct(productId);
                    break;
                case "View":
                    Response.Redirect($"../Details.aspx?id={productId}");
                    break;
            }
        }

        protected void gvProducts_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Add hover effects
                e.Row.Attributes["onmouseover"] = "this.style.backgroundColor='#f8f9fa'";
                e.Row.Attributes["onmouseout"] = "this.style.backgroundColor='white'";
            }
        }

        private void LoadProductForEdit(string productId)
        {
            using (SqlConnection conn = new SqlConnection(connect))
            {
                try
                {
                    conn.Open();
                    string query = "SELECT * FROM MatHang WHERE id_hang = @ProductId";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@ProductId", productId);

                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        TextBox txtName = (TextBox)FindControl("txtProductName");
                        DropDownList ddlCat = (DropDownList)FindControl("ddlProductCategory");
                        TextBox txtPrice = (TextBox)FindControl("txtPrice");
                        TextBox txtStock = (TextBox)FindControl("txtStock");
                        TextBox txtDesc = (TextBox)FindControl("txtDescription");

                        if (txtName != null) txtName.Text = reader["tenhang"].ToString();
                        if (ddlCat != null) ddlCat.SelectedValue = reader["id_loai"].ToString();
                        if (txtPrice != null) txtPrice.Text = reader["dongia"].ToString();
                        if (txtStock != null) txtStock.Text = reader["soluong"].ToString();
                        if (txtDesc != null) txtDesc.Text = reader["mota"].ToString();
                        
                        // Store product ID for update
                        ViewState["EditProductId"] = productId;
                    }
                    reader.Close();

                    // Show modal
                    ScriptManager.RegisterStartupScript(this, GetType(), "ShowModal", "openModal('Sửa sản phẩm');", true);
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine($"Error loading product for edit: {ex.Message}");
                }
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
                        ScriptManager.RegisterStartupScript(this, GetType(), "Success", "showAlert('Xóa sản phẩm thành công!', 'success');", true);
                    }
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine($"Error deleting product: {ex.Message}");
                    ScriptManager.RegisterStartupScript(this, GetType(), "Error", "showAlert('Lỗi khi xóa sản phẩm!', 'danger');", true);
                }
            }
        }

        protected void btnAddProduct_Click(object sender, EventArgs e)
        {
            // Clear form
            ClearProductForm();
            ViewState["EditProductId"] = null;
            
            // Show modal
            ScriptManager.RegisterStartupScript(this, GetType(), "ShowModal", "openModal('Thêm sản phẩm mới');", true);
        }

        protected void btnSaveProduct_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string productId = ViewState["EditProductId"]?.ToString();
                
                if (string.IsNullOrEmpty(productId))
                {
                    // Add new product
                    AddNewProduct();
                }
                else
                {
                    // Update existing product
                    UpdateProduct(productId);
                }
            }
        }

        private void AddNewProduct()
        {
            using (SqlConnection conn = new SqlConnection(connect))
            {
                try
                {
                    conn.Open();
                    string query = @"INSERT INTO MatHang (tenhang, id_loai, dongia, soluong, mota) 
                                    VALUES (@Name, @CategoryId, @Price, @Stock, @Description)";
                    
                    SqlCommand cmd = new SqlCommand(query, conn);
                    
                    TextBox txtName = (TextBox)FindControl("txtProductName");
                    DropDownList ddlCat = (DropDownList)FindControl("ddlProductCategory");
                    TextBox txtPrice = (TextBox)FindControl("txtPrice");
                    TextBox txtStock = (TextBox)FindControl("txtStock");
                    TextBox txtDesc = (TextBox)FindControl("txtDescription");

                    cmd.Parameters.AddWithValue("@Name", txtName?.Text ?? "");
                    cmd.Parameters.AddWithValue("@CategoryId", ddlCat?.SelectedValue ?? "1");
                    cmd.Parameters.AddWithValue("@Price", decimal.Parse(txtPrice?.Text ?? "0"));
                    cmd.Parameters.AddWithValue("@Stock", int.Parse(txtStock?.Text ?? "0"));
                    cmd.Parameters.AddWithValue("@Description", txtDesc?.Text ?? "");

                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        LoadProducts();
                        ClearProductForm();
                        ScriptManager.RegisterStartupScript(this, GetType(), "Success", "showAlert('Thêm sản phẩm thành công!', 'success'); closeModal();", true);
                    }
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine($"Error adding product: {ex.Message}");
                    ScriptManager.RegisterStartupScript(this, GetType(), "Error", "showAlert('Lỗi khi thêm sản phẩm!', 'danger');", true);
                }
            }
        }

        private void UpdateProduct(string productId)
        {
            using (SqlConnection conn = new SqlConnection(connect))
            {
                try
                {
                    conn.Open();
                    string query = @"UPDATE MatHang 
                                    SET tenhang = @Name, 
                                        id_loai = @CategoryId, 
                                        dongia = @Price, 
                                        soluong = @Stock, 
                                        mota = @Description 
                                    WHERE id_hang = @ProductId";
                    
                    SqlCommand cmd = new SqlCommand(query, conn);
                    
                    TextBox txtName = (TextBox)FindControl("txtProductName");
                    DropDownList ddlCat = (DropDownList)FindControl("ddlProductCategory");
                    TextBox txtPrice = (TextBox)FindControl("txtPrice");
                    TextBox txtStock = (TextBox)FindControl("txtStock");
                    TextBox txtDesc = (TextBox)FindControl("txtDescription");

                    cmd.Parameters.AddWithValue("@Name", txtName?.Text ?? "");
                    cmd.Parameters.AddWithValue("@CategoryId", ddlCat?.SelectedValue ?? "1");
                    cmd.Parameters.AddWithValue("@Price", decimal.Parse(txtPrice?.Text ?? "0"));
                    cmd.Parameters.AddWithValue("@Stock", int.Parse(txtStock?.Text ?? "0"));
                    cmd.Parameters.AddWithValue("@Description", txtDesc?.Text ?? "");
                    cmd.Parameters.AddWithValue("@ProductId", productId);

                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        LoadProducts();
                        ClearProductForm();
                        ScriptManager.RegisterStartupScript(this, GetType(), "Success", "showAlert('Cập nhật sản phẩm thành công!', 'success'); closeModal();", true);
                    }
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine($"Error updating product: {ex.Message}");
                    ScriptManager.RegisterStartupScript(this, GetType(), "Error", "showAlert('Lỗi khi cập nhật sản phẩm!', 'danger');", true);
                }
            }
        }

        private void ClearProductForm()
        {
            TextBox txtName = (TextBox)FindControl("txtProductName");
            TextBox txtPrice = (TextBox)FindControl("txtPrice");
            TextBox txtStock = (TextBox)FindControl("txtStock");
            TextBox txtDesc = (TextBox)FindControl("txtDescription");
            DropDownList ddlCat = (DropDownList)FindControl("ddlProductCategory");
            DropDownList ddlStatus = (DropDownList)FindControl("ddlStatus");

            if (txtName != null) txtName.Text = "";
            if (txtPrice != null) txtPrice.Text = "";
            if (txtStock != null) txtStock.Text = "0";
            if (txtDesc != null) txtDesc.Text = "";
            if (ddlCat != null) ddlCat.SelectedIndex = 0;
            if (ddlStatus != null) ddlStatus.SelectedIndex = 0;
        }

        protected void btnBulkDelete_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "Info", "showAlert('Tính năng xóa hàng loạt đang được phát triển!', 'info');", true);
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "Info", "showAlert('Tính năng xuất Excel đang được phát triển!', 'info');", true);
        }
    }
}