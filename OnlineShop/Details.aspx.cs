using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineShop
{
    public partial class Details : System.Web.UI.Page
    {
        // Chuỗi kết nối đến cơ sở dữ liệu
        string connect = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\DataBase.mdf;Integrated Security=True";
        // Lưu trữ ID của sản phẩm đang xem
        int productId = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Kiểm tra xem có tham số ID được truyền qua URL không
            if (!string.IsNullOrEmpty(Request.QueryString["id"]))
            {
                // Phân tích ID sản phẩm từ URL - PHẢI làm điều này mỗi lần tải trang
                if (int.TryParse(Request.QueryString["id"], out productId))
                {
                    if (!IsPostBack)
                    {
                        // Tải thông tin sản phẩm nếu là lần đầu tiên tải trang
                        LoadProductDetails();
                        LoadProductThumbnails();
                        LoadProductSpecifications();
                        LoadProductReviews();
                        LoadRelatedProducts();
                    }
                    // productId is now set for both initial load and postbacks
                }
                else
                {
                    // Xử lý trường hợp ID không hợp lệ
                    Response.Write("<script>alert('ID sản phẩm không hợp lệ!');</script>");
                    Response.Redirect("SanPham.aspx");
                }
            }
            else
            {
                // Nếu không có ID, chuyển hướng về trang sản phẩm
                Response.Redirect("SanPham.aspx");
            }
        }

        private void LoadProductDetails()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connect))
                {
                    using (SqlCommand cmd = new SqlCommand("SELECT * FROM MatHang WHERE id_hang = @ProductId", conn))
                    {
                        cmd.Parameters.AddWithValue("@ProductId", productId);
                        conn.Open();

                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.Read())
                        {
                            // Hiển thị thông tin cơ bản của sản phẩm
                            lblName.Text = reader["tenhang"].ToString();
                            lblProductName.Text = reader["tenhang"].ToString();
                            lblProductId.Text = productId.ToString();
                            lblCategory.Text = GetCategoryName(Convert.ToInt32(reader["id_loai"]));
                            lblStatus.Text = Convert.ToInt32(reader["soluongton"]) > 0 ? "Còn hàng" : "Hết hàng";

                            decimal price = Convert.ToDecimal(reader["dongia"]);
                            decimal originalPrice = price * 1.2M; // Giả sử giá gốc cao hơn 20%

                            lblPrice.Text = string.Format("{0:N0} ₫", price);
                            lblOriginalPrice.Text = string.Format("{0:N0} ₫", originalPrice);

                            lblDescription.Text = reader["mota"].ToString();
                            litFullDescription.Text = reader["mota"].ToString(); // Sử dụng lại trường mô tả cho mô tả đầy đủ

                            // Hiển thị hình ảnh sản phẩm - sử dụng ảnh webp từ Images_DB
                            int categoryId = Convert.ToInt32(reader["id_loai"]);
                            imgProductDetail.ImageUrl = $"~/Images_DB/Loai_{categoryId}/{productId}.webp";
                        }
                        else
                        {
                            // Sản phẩm không tồn tại, chuyển hướng về trang sản phẩm
                            Response.Write("<script>alert('Không tìm thấy sản phẩm với ID: " + productId + "');</script>");
                            Response.Redirect("SanPham.aspx");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Xử lý ngoại lệ - hiển thị thông báo lỗi
                string errorMessage = "Lỗi khi tải thông tin sản phẩm: " + ex.Message;
                Response.Write("<script>console.error('" + errorMessage + "');</script>");
                Response.Write("<script>alert('" + errorMessage + "');</script>");
            }
        }

        private string GetCategoryName(int categoryId)
        {
            string categoryName = "Không xác định";

            try
            {
                using (SqlConnection conn = new SqlConnection(connect))
                {
                    using (SqlCommand cmd = new SqlCommand("SELECT tenloai FROM LoaiHang WHERE id_loai = @CategoryId", conn))
                    {
                        cmd.Parameters.AddWithValue("@CategoryId", categoryId);
                        conn.Open();

                        object result = cmd.ExecuteScalar();
                        if (result != null && result != DBNull.Value)
                        {
                            categoryName = result.ToString();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Xử lý ngoại lệ - ghi log hoặc hiển thị thông báo
                Response.Write("<script>console.error('Lỗi khi lấy tên danh mục: " + ex.Message + "');</script>");
            }

            return categoryName;
        }

        private void LoadProductThumbnails()
        {
            // Trong trường hợp này, chúng ta có thể không có bảng riêng cho hình ảnh sản phẩm
            // Nếu bạn có bảng hình ảnh riêng, hãy thay đổi truy vấn tương ứng
            try
            {
                using (SqlConnection conn = new SqlConnection(connect))
                {
                    using (SqlCommand cmd = new SqlCommand("SELECT id_loai FROM MatHang WHERE id_hang = @ProductId", conn))
                    {
                        cmd.Parameters.AddWithValue("@ProductId", productId);
                        conn.Open();

                        DataTable dt = new DataTable();
                        dt.Columns.Add("ImageUrl", typeof(string));

                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.Read())
                        {
                            // Lấy id_loai để tạo đường dẫn ảnh webp
                            int categoryId = Convert.ToInt32(reader["id_loai"]);
                            
                            DataRow row = dt.NewRow();
                            row["ImageUrl"] = $"~/Images_DB/Loai_{categoryId}/{productId}.webp";
                            dt.Rows.Add(row);
                        }

                        rptThumbnails.DataSource = dt;
                        rptThumbnails.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>console.error('Lỗi khi tải hình ảnh thu nhỏ: " + ex.Message + "');</script>");
            }
        }

        private void LoadProductSpecifications()
        {
            // Tạo một DataTable chứa các thông số kỹ thuật từ các cột trong bảng MatHang
            try
            {
                using (SqlConnection conn = new SqlConnection(connect))
                {
                    using (SqlCommand cmd = new SqlCommand("SELECT * FROM MatHang WHERE id_hang = @ProductId", conn))
                    {
                        cmd.Parameters.AddWithValue("@ProductId", productId);
                        conn.Open();

                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.Read())
                        {
                            DataTable dt = new DataTable();
                            dt.Columns.Add("Name", typeof(string));
                            dt.Columns.Add("Value", typeof(string));

                            // Thêm các hàng với các thông số kỹ thuật từ bảng MatHang
                            // Điều chỉnh theo các cột thực tế trong bảng MatHang của bạn
                            if (reader["id_loai"] != DBNull.Value)
                            {
                                DataRow row1 = dt.NewRow();
                                row1["Name"] = "Loại";
                                row1["Value"] = GetCategoryName(Convert.ToInt32(reader["id_loai"]));
                                dt.Rows.Add(row1);
                            }

                            if (reader["dongia"] != DBNull.Value)
                            {
                                DataRow row2 = dt.NewRow();
                                row2["Name"] = "Giá";
                                row2["Value"] = string.Format("{0:N0} ₫", Convert.ToDecimal(reader["dongia"]));
                                dt.Rows.Add(row2);
                            }

                            if (reader["soluongton"] != DBNull.Value)
                            {
                                DataRow row3 = dt.NewRow();
                                row3["Name"] = "Số lượng tồn";
                                row3["Value"] = reader["soluongton"].ToString();
                                dt.Rows.Add(row3);
                            }

                            if (reader["tinhtrang"] != DBNull.Value)
                            {
                                DataRow row4 = dt.NewRow();
                                row4["Name"] = "Tình trạng";
                                row4["Value"] = reader["tinhtrang"].ToString();
                                dt.Rows.Add(row4);
                            }

                            // Thêm các thông số khác nếu có

                            rptSpecifications.DataSource = dt;
                            rptSpecifications.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>console.error('Lỗi khi tải thông số kỹ thuật: " + ex.Message + "');</script>");
            }
        }

        private void LoadProductReviews()
        {
            // Nếu bạn có bảng đánh giá sản phẩm, hãy thay đổi truy vấn tương ứng
            // Ở đây tôi sẽ giả định là bạn không có bảng đánh giá riêng
            try
            {
                DataTable dt = new DataTable();
                dt.Columns.Add("ReviewId", typeof(int));
                dt.Columns.Add("Rating", typeof(int));
                dt.Columns.Add("ReviewText", typeof(string));
                dt.Columns.Add("ReviewDate", typeof(DateTime));
                dt.Columns.Add("ReviewerName", typeof(string));

                // Gán 0 đánh giá và hiển thị thông báo
                lblAverageRating.Text = "0.0";
                litRatingStars.Text = "☆☆☆☆☆";
                lblTotalReviews.Text = "0";

                rptProductReviews.DataSource = dt;
                rptProductReviews.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("<script>console.error('Lỗi khi tải đánh giá: " + ex.Message + "');</script>");
            }
        }

        private void LoadRelatedProducts()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connect))
                {
                    // Lấy CategoryId của sản phẩm hiện tại
                    int categoryId = 0;
                    using (SqlCommand cmd = new SqlCommand("SELECT id_loai FROM MatHang WHERE id_hang = @ProductId", conn))
                    {
                        cmd.Parameters.AddWithValue("@ProductId", productId);
                        conn.Open();

                        object result = cmd.ExecuteScalar();
                        if (result != null && result != DBNull.Value)
                        {
                            categoryId = Convert.ToInt32(result);
                        }
                        conn.Close();
                    }

                    // Lấy các sản phẩm cùng danh mục, ngoại trừ sản phẩm hiện tại - sử dụng ảnh webp
                    using (SqlCommand cmd = new SqlCommand("SELECT TOP 4 id_hang AS ProductId, tenhang AS Name, dongia AS Price, " +
                        "'~/Images_DB/Loai_' + CAST(id_loai AS VARCHAR) + '/' + CAST(id_hang AS VARCHAR) + '.webp' AS ImageUrl " +
                        "FROM MatHang WHERE id_loai = @CategoryId AND id_hang != @ProductId", conn))
                    {
                        cmd.Parameters.AddWithValue("@CategoryId", categoryId);
                        cmd.Parameters.AddWithValue("@ProductId", productId);
                        conn.Open();

                        DataTable dt = new DataTable();
                        SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                        adapter.Fill(dt);

                        rptRelatedProducts.DataSource = dt;
                        rptRelatedProducts.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>console.error('Lỗi khi tải sản phẩm liên quan: " + ex.Message + "');</script>");
            }
        }

        protected void btnDescTab_Click(object sender, EventArgs e)
        {
            // Hiển thị tab mô tả
            pnlDescContent.CssClass = "tab-pane active";
            pnlSpecContent.CssClass = "tab-pane";
            pnlReviewContent.CssClass = "tab-pane";

            btnDescTab.CssClass = "tab-btn active";
            btnSpecTab.CssClass = "tab-btn";
            btnReviewTab.CssClass = "tab-btn";
        }

        protected void btnSpecTab_Click(object sender, EventArgs e)
        {
            // Hiển thị tab thông số kỹ thuật
            pnlDescContent.CssClass = "tab-pane";
            pnlSpecContent.CssClass = "tab-pane active";
            pnlReviewContent.CssClass = "tab-pane";

            btnDescTab.CssClass = "tab-btn";
            btnSpecTab.CssClass = "tab-btn active";
            btnReviewTab.CssClass = "tab-btn";
        }

        protected void btnReviewTab_Click(object sender, EventArgs e)
        {
            // Hiển thị tab đánh giá
            pnlDescContent.CssClass = "tab-pane";
            pnlSpecContent.CssClass = "tab-pane";
            pnlReviewContent.CssClass = "tab-pane active";

            btnDescTab.CssClass = "tab-btn";
            btnSpecTab.CssClass = "tab-btn";
            btnReviewTab.CssClass = "tab-btn active";
        }

        protected void btnDecrease_Click(object sender, EventArgs e)
        {
            // Giảm số lượng, nhưng không nhỏ hơn 1
            int quantity = Convert.ToInt32(txtQuantity.Text);
            if (quantity > 1)
            {
                txtQuantity.Text = (quantity - 1).ToString();
            }
        }

        protected void btnIncrease_Click(object sender, EventArgs e)
        {
            // Tăng số lượng
            int quantity = Convert.ToInt32(txtQuantity.Text);
            txtQuantity.Text = (quantity + 1).ToString();
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            // Lấy số lượng từ TextBox
            int quantity = Convert.ToInt32(txtQuantity.Text);

            // Thêm sản phẩm vào giỏ hàng
            AddProductToCart(productId, quantity);

            // Hiển thị thông báo thành công
            ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", "alert('Đã thêm sản phẩm vào giỏ hàng!');", true);
        }

        protected void btnBuyNow_Click(object sender, EventArgs e)
        {
            // Lấy số lượng từ TextBox
            int quantity = Convert.ToInt32(txtQuantity.Text);

            // Thêm sản phẩm vào giỏ hàng
            AddProductToCart(productId, quantity);

            // Chuyển hướng đến trang giỏ hàng
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
                            // Lấy thông tin sản phẩm
                            int pId = reader.GetInt32(reader.GetOrdinal("ProductId"));
                            string pName = reader.GetString(reader.GetOrdinal("ProductName"));
                            decimal pPrice = reader.GetDecimal(reader.GetOrdinal("Price"));
                            string pImage = reader["ImageUrl"].ToString();

                            // Lấy giỏ hàng từ session
                            List<CartItem> cartItems;
                            if (Session["Cart"] == null)
                            {
                                cartItems = new List<CartItem>();
                            }
                            else
                            {
                                cartItems = (List<CartItem>)Session["Cart"];
                            }

                            // Kiểm tra sản phẩm đã có trong giỏ hàng chưa
                            CartItem existingItem = cartItems.Find(c => c.ProductId == pId);
                            if (existingItem != null)
                            {
                                // Nếu sản phẩm đã có trong giỏ hàng, tăng số lượng
                                existingItem.Quantity += quantity;
                            }
                            else
                            {
                                // Nếu sản phẩm chưa có trong giỏ hàng, thêm mới
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

                            // Lưu giỏ hàng vào session
                            Session["Cart"] = cartItems;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Hiển thị thông báo lỗi
                string errorMessage = "Lỗi khi thêm sản phẩm vào giỏ hàng: " + ex.Message;
                ScriptManager.RegisterStartupScript(this, GetType(), "ErrorMessage", $"alert('{errorMessage.Replace("'", "\\'")}');", true);
                System.Diagnostics.Debug.WriteLine(errorMessage);
            }
        }

        protected void btnAddToWishlist_Click(object sender, EventArgs e)
        {
            // Kiểm tra người dùng đã đăng nhập chưa
            if (Session["UserId"] == null)
            {
                // Nếu chưa đăng nhập, chuyển hướng đến trang đăng nhập
                Response.Redirect("DangNhap.aspx?returnUrl=" + Server.UrlEncode(Request.RawUrl));
                return;
            }

            // Giả sử bạn có bảng WishList, hãy điều chỉnh theo cấu trúc của bạn
            ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", "alert('Chức năng danh sách yêu thích hiện chưa được hỗ trợ.');", true);
        }

        protected void btnSubmitReview_Click(object sender, EventArgs e)
        {
            // Kiểm tra người dùng đã đăng nhập chưa
            if (Session["UserId"] == null)
            {
                // Nếu chưa đăng nhập, chuyển hướng đến trang đăng nhập
                Response.Redirect("DangNhap.aspx?returnUrl=" + Server.UrlEncode(Request.RawUrl));
                return;
            }

            // Giả sử bạn có bảng đánh giá sản phẩm, hãy điều chỉnh theo cấu trúc của bạn
            ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", "alert('Chức năng đánh giá sản phẩm hiện chưa được hỗ trợ.');", true);
        }

        protected void rptRelatedProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "ViewDetails")
            {
                // Chuyển hướng đến trang chi tiết sản phẩm được chọn
                int relatedProductId = Convert.ToInt32(e.CommandArgument);
                Response.Redirect("ChiTietSanPham.aspx?id=" + relatedProductId);
            }
            else if (e.CommandName == "AddToCart")
            {
                // Lấy ID sản phẩm từ CommandArgument
                int relatedProductId = Convert.ToInt32(e.CommandArgument);

                // Kiểm tra hoặc tạo giỏ hàng trong Session
                DataTable dtCart;
                if (Session["ShoppingCart"] == null)
                {
                    // Tạo giỏ hàng mới nếu chưa có
                    dtCart = new DataTable();
                    dtCart.Columns.Add("ProductId", typeof(int));
                    dtCart.Columns.Add("Name", typeof(string));
                    dtCart.Columns.Add("Price", typeof(decimal));
                    dtCart.Columns.Add("Quantity", typeof(int));
                    dtCart.Columns.Add("ImageUrl", typeof(string));
                }
                else
                {
                    // Sử dụng giỏ hàng hiện có
                    dtCart = (DataTable)Session["ShoppingCart"];
                }

                // Kiểm tra sản phẩm đã có trong giỏ hàng chưa
                bool productExists = false;
                foreach (DataRow row in dtCart.Rows)
                {
                    if (Convert.ToInt32(row["ProductId"]) == relatedProductId)
                    {
                        // Nếu sản phẩm đã có, tăng số lượng
                        row["Quantity"] = Convert.ToInt32(row["Quantity"]) + 1;
                        productExists = true;
                        break;
                    }
                }

                // Nếu sản phẩm chưa có trong giỏ hàng, thêm sản phẩm mới
                if (!productExists)
                {
                    // Lấy thông tin sản phẩm từ cơ sở dữ liệu
                    using (SqlConnection conn = new SqlConnection(connect))
                    {
                        using (SqlCommand cmd = new SqlCommand("SELECT tenhang AS Name, dongia AS Price, id_loai, " +
                            "'~/Images_DB/Loai_' + CAST(id_loai AS VARCHAR) + '/' + CAST(id_hang AS VARCHAR) + '.webp' AS ImageUrl " +
                            "FROM MatHang WHERE id_hang = @ProductId", conn))
                        {
                            cmd.Parameters.AddWithValue("@ProductId", relatedProductId);
                            conn.Open();

                            SqlDataReader reader = cmd.ExecuteReader();
                            if (reader.Read())
                            {
                                // Thêm sản phẩm vào giỏ hàng
                                DataRow newRow = dtCart.NewRow();
                                newRow["ProductId"] = relatedProductId;
                                newRow["Name"] = reader["Name"].ToString();
                                newRow["Price"] = Convert.ToDecimal(reader["Price"]);
                                newRow["Quantity"] = 1;
                                newRow["ImageUrl"] = reader["ImageUrl"].ToString();
                                dtCart.Rows.Add(newRow);
                            }
                        }
                    }
                }

                // Lưu giỏ hàng vào Session
                Session["ShoppingCart"] = dtCart;

                // Hiển thị thông báo thành công
                ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", "alert('Đã thêm sản phẩm vào giỏ hàng!');", true);
            }
        }

        protected void rptProductReviews_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                // Lấy đối tượng DataRowView từ item
                DataRowView rowView = (DataRowView)e.Item.DataItem;

                // Lấy control để hiển thị số sao
                Literal litReviewStars = (Literal)e.Item.FindControl("litReviewStars");

                // Lấy điểm đánh giá từ DataRowView
                int rating = Convert.ToInt32(rowView["Rating"]);

                // Tạo chuỗi hiển thị số sao
                string stars = "";
                for (int i = 1; i <= 5; i++)
                {
                    if (i <= rating)
                        stars += "★";
                    else
                        stars += "☆";
                }

                // Gán chuỗi sao vào Literal
                litReviewStars.Text = stars;
            }
        }

        protected void btnAll_Click(object sender, EventArgs e)
        {
            Response.Redirect("SanPham.aspx?category=0");
        }

        protected void btnSmartphone_Click(object sender, EventArgs e)
        {
            Response.Redirect("SanPham.aspx?category=1");
        }

        protected void btnLaptop_Click(object sender, EventArgs e)
        {
            Response.Redirect("SanPham.aspx?category=2");
        }

        protected void btnManhinh_Click(object sender, EventArgs e)
        {
            Response.Redirect("SanPham.aspx?category=3");
        }

        protected void btnHeadphone_Click(object sender, EventArgs e)
        {
            Response.Redirect("SanPham.aspx?category=4");
        }

        protected void btnCamera_Click(object sender, EventArgs e)
        {
            Response.Redirect("SanPham.aspx?category=5");
        }
    }
}