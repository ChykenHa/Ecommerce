using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineShop
{
    public partial class Details : System.Web.UI.Page
    {
        // Chuỗi kết nối đến cơ sở dữ liệu
        string connect = @"Data Source=DARLING\SQLEXPRESS;Initial Catalog=OnlineShopDB;Integrated Security=True";
        // Lưu trữ ID của sản phẩm đang xem
        int productId = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Kiểm tra xem có tham số ID được truyền qua URL không
            if (!string.IsNullOrEmpty(Request.QueryString["id"]))
            {
                // Phân tích ID sản phẩm từ URL
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
                }
                else
                {
                    // Xử lý trường hợp ID không hợp lệ
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
                    using (SqlCommand cmd = new SqlCommand("SELECT * FROM Products WHERE ProductId = @ProductId", conn))
                    {
                        cmd.Parameters.AddWithValue("@ProductId", productId);
                        conn.Open();

                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.Read())
                        {
                            // Hiển thị thông tin cơ bản của sản phẩm
                            lblName.Text = reader["Name"].ToString();
                            lblProductName.Text = reader["Name"].ToString();
                            lblProductId.Text = productId.ToString();
                            lblCategory.Text = GetCategoryName(Convert.ToInt32(reader["CategoryId"]));
                            lblStatus.Text = Convert.ToBoolean(reader["InStock"]) ? "Còn hàng" : "Hết hàng";

                            decimal price = Convert.ToDecimal(reader["Price"]);
                            decimal originalPrice = price * 1.2M; // Giả sử giá gốc cao hơn 20%

                            lblPrice.Text = string.Format("{0:N0} ₫", price);
                            lblOriginalPrice.Text = string.Format("{0:N0} ₫", originalPrice);

                            lblDescription.Text = reader["Description"].ToString();
                            litFullDescription.Text = reader["FullDescription"].ToString();

                            // Hiển thị hình ảnh sản phẩm
                            imgProductDetail.ImageUrl = reader["ImageUrl"].ToString();
                        }
                        else
                        {
                            // Sản phẩm không tồn tại, chuyển hướng về trang sản phẩm
                            Response.Redirect("SanPham.aspx");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Xử lý ngoại lệ
                // Có thể ghi log lỗi hoặc hiển thị thông báo
                Response.Write("<script>alert('Có lỗi xảy ra: " + ex.Message + "');</script>");
            }
        }

        private string GetCategoryName(int categoryId)
        {
            string categoryName = string.Empty;

            try
            {
                using (SqlConnection conn = new SqlConnection(connect))
                {
                    using (SqlCommand cmd = new SqlCommand("SELECT CategoryName FROM Categories WHERE CategoryId = @CategoryId", conn))
                    {
                        cmd.Parameters.AddWithValue("@CategoryId", categoryId);
                        conn.Open();

                        object result = cmd.ExecuteScalar();
                        if (result != null)
                        {
                            categoryName = result.ToString();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Xử lý ngoại lệ
            }

            return categoryName;
        }

        private void LoadProductThumbnails()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connect))
                {
                    using (SqlCommand cmd = new SqlCommand("SELECT ImageUrl FROM ProductImages WHERE ProductId = @ProductId", conn))
                    {
                        cmd.Parameters.AddWithValue("@ProductId", productId);
                        conn.Open();

                        DataTable dt = new DataTable();
                        SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                        adapter.Fill(dt);

                        rptThumbnails.DataSource = dt;
                        rptThumbnails.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                // Xử lý ngoại lệ
            }
        }

        private void LoadProductSpecifications()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connect))
                {
                    using (SqlCommand cmd = new SqlCommand("SELECT SpecName AS Name, SpecValue AS Value FROM ProductSpecifications WHERE ProductId = @ProductId", conn))
                    {
                        cmd.Parameters.AddWithValue("@ProductId", productId);
                        conn.Open();

                        DataTable dt = new DataTable();
                        SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                        adapter.Fill(dt);

                        rptSpecifications.DataSource = dt;
                        rptSpecifications.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                // Xử lý ngoại lệ
            }
        }

        private void LoadProductReviews()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connect))
                {
                    // Tính điểm đánh giá trung bình
                    using (SqlCommand cmd = new SqlCommand("SELECT AVG(Rating) AS AverageRating, COUNT(*) AS TotalReviews FROM ProductReviews WHERE ProductId = @ProductId", conn))
                    {
                        cmd.Parameters.AddWithValue("@ProductId", productId);
                        conn.Open();

                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.Read())
                        {
                            object avgRating = reader["AverageRating"];
                            if (avgRating != DBNull.Value)
                            {
                                double averageRating = Convert.ToDouble(avgRating);
                                lblAverageRating.Text = averageRating.ToString("0.0");

                                // Hiển thị sao đánh giá
                                string stars = "";
                                for (int i = 1; i <= 5; i++)
                                {
                                    if (i <= Math.Round(averageRating))
                                        stars += "★";
                                    else
                                        stars += "☆";
                                }
                                litRatingStars.Text = stars;
                            }
                            else
                            {
                                lblAverageRating.Text = "0.0";
                                litRatingStars.Text = "☆☆☆☆☆";
                            }

                            lblTotalReviews.Text = reader["TotalReviews"].ToString();
                        }
                        reader.Close();
                    }

                    // Lấy danh sách đánh giá
                    using (SqlCommand cmd = new SqlCommand(
                        @"SELECT PR.ReviewId, PR.Rating, PR.ReviewText, PR.ReviewDate, 
                U.UserName as ReviewerName
                FROM ProductReviews PR
                JOIN Users U ON PR.UserId = U.UserId
                WHERE PR.ProductId = @ProductId
                ORDER BY PR.ReviewDate DESC", conn))
                    {
                        cmd.Parameters.AddWithValue("@ProductId", productId);

                        DataTable dt = new DataTable();
                        SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                        adapter.Fill(dt);

                        rptProductReviews.DataSource = dt;
                        rptProductReviews.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                // Xử lý ngoại lệ
                ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage",
                    "console.error('Lỗi khi tải đánh giá: " + ex.Message + "');", true);
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
                    using (SqlCommand cmd = new SqlCommand("SELECT CategoryId FROM Products WHERE ProductId = @ProductId", conn))
                    {
                        cmd.Parameters.AddWithValue("@ProductId", productId);
                        conn.Open();

                        object result = cmd.ExecuteScalar();
                        if (result != null)
                        {
                            categoryId = Convert.ToInt32(result);
                        }
                        conn.Close();
                    }

                    // Lấy các sản phẩm cùng danh mục, ngoại trừ sản phẩm hiện tại
                    using (SqlCommand cmd = new SqlCommand("SELECT TOP 4 ProductId, Name, Price, ImageUrl FROM Products WHERE CategoryId = @CategoryId AND ProductId != @ProductId", conn))
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
                // Xử lý ngoại lệ
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
                if (Convert.ToInt32(row["ProductId"]) == productId)
                {
                    // Nếu sản phẩm đã có, tăng số lượng
                    row["Quantity"] = Convert.ToInt32(row["Quantity"]) + quantity;
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
                    using (SqlCommand cmd = new SqlCommand("SELECT Name, Price, ImageUrl FROM Products WHERE ProductId = @ProductId", conn))
                    {
                        cmd.Parameters.AddWithValue("@ProductId", productId);
                        conn.Open();

                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.Read())
                        {
                            // Thêm sản phẩm vào giỏ hàng
                            DataRow newRow = dtCart.NewRow();
                            newRow["ProductId"] = productId;
                            newRow["Name"] = reader["Name"].ToString();
                            newRow["Price"] = Convert.ToDecimal(reader["Price"]);
                            newRow["Quantity"] = quantity;
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

        protected void btnBuyNow_Click(object sender, EventArgs e)
        {
            // Thêm sản phẩm vào giỏ hàng
            btnAddToCart_Click(sender, e);

            // Chuyển hướng đến trang giỏ hàng
            Response.Redirect("GioHang.aspx");
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

            int userId = Convert.ToInt32(Session["UserId"]);

            try
            {
                using (SqlConnection conn = new SqlConnection(connect))
                {
                    // Kiểm tra sản phẩm đã có trong danh sách yêu thích chưa
                    using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Wishlist WHERE UserId = @UserId AND ProductId = @ProductId", conn))
                    {
                        cmd.Parameters.AddWithValue("@UserId", userId);
                        cmd.Parameters.AddWithValue("@ProductId", productId);
                        conn.Open();

                        int count = Convert.ToInt32(cmd.ExecuteScalar());
                        if (count > 0)
                        {
                            // Sản phẩm đã có trong danh sách yêu thích
                            ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", "alert('Sản phẩm đã có trong danh sách yêu thích!');", true);
                        }
                        else
                        {
                            // Thêm sản phẩm vào danh sách yêu thích
                            using (SqlCommand insertCmd = new SqlCommand("INSERT INTO Wishlist (UserId, ProductId, DateAdded) VALUES (@UserId, @ProductId, @DateAdded)", conn))
                            {
                                insertCmd.Parameters.AddWithValue("@UserId", userId);
                                insertCmd.Parameters.AddWithValue("@ProductId", productId);
                                insertCmd.Parameters.AddWithValue("@DateAdded", DateTime.Now);

                                insertCmd.ExecuteNonQuery();

                                // Hiển thị thông báo thành công
                                ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", "alert('Đã thêm sản phẩm vào danh sách yêu thích!');", true);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Xử lý ngoại lệ
                ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", "alert('Có lỗi xảy ra: " + ex.Message + "');", true);
            }
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

            int userId = Convert.ToInt32(Session["UserId"]);
            string reviewText = txtComment.Text.Trim(); // Thay đổi txtReviewText thành txtComment
            int rating = Convert.ToInt32(rblRating.SelectedValue);

            // Kiểm tra nội dung đánh giá
            if (string.IsNullOrEmpty(reviewText))
            {
                lblReviewError.Text = "Vui lòng nhập nội dung đánh giá";
                lblReviewError.Visible = true;
                return;
            }

            // Kiểm tra điểm đánh giá
            if (rating < 1 || rating > 5)
            {
                lblReviewError.Text = "Vui lòng chọn số sao đánh giá";
                lblReviewError.Visible = true;
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connect))
                {
                    // Kiểm tra người dùng đã đánh giá sản phẩm này chưa
                    using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM ProductReviews WHERE UserId = @UserId AND ProductId = @ProductId", conn))
                    {
                        cmd.Parameters.AddWithValue("@UserId", userId);
                        cmd.Parameters.AddWithValue("@ProductId", productId);
                        conn.Open();

                        int count = Convert.ToInt32(cmd.ExecuteScalar());
                        if (count > 0)
                        {
                            // Cập nhật đánh giá cũ
                            using (SqlCommand updateCmd = new SqlCommand(
                                "UPDATE ProductReviews SET Rating = @Rating, ReviewText = @ReviewText, ReviewDate = @ReviewDate WHERE UserId = @UserId AND ProductId = @ProductId", conn))
                            {
                                updateCmd.Parameters.AddWithValue("@UserId", userId);
                                updateCmd.Parameters.AddWithValue("@ProductId", productId);
                                updateCmd.Parameters.AddWithValue("@Rating", rating);
                                updateCmd.Parameters.AddWithValue("@ReviewText", reviewText);
                                updateCmd.Parameters.AddWithValue("@ReviewDate", DateTime.Now);

                                updateCmd.ExecuteNonQuery();

                                // Hiển thị thông báo thành công
                                lblReviewSuccess.Text = "Đã cập nhật đánh giá của bạn!";
                                lblReviewSuccess.Visible = true;
                                lblReviewError.Visible = false;
                            }
                        }
                        else
                        {
                            // Thêm đánh giá mới
                            using (SqlCommand insertCmd = new SqlCommand(
                                "INSERT INTO ProductReviews (ProductId, UserId, Rating, ReviewText, ReviewDate) VALUES (@ProductId, @UserId, @Rating, @ReviewText, @ReviewDate)", conn))
                            {
                                insertCmd.Parameters.AddWithValue("@ProductId", productId);
                                insertCmd.Parameters.AddWithValue("@UserId", userId);
                                insertCmd.Parameters.AddWithValue("@Rating", rating);
                                insertCmd.Parameters.AddWithValue("@ReviewText", reviewText);
                                insertCmd.Parameters.AddWithValue("@ReviewDate", DateTime.Now);

                                insertCmd.ExecuteNonQuery();

                                // Hiển thị thông báo thành công
                                lblReviewSuccess.Text = "Cảm ơn bạn đã đánh giá sản phẩm!";
                                lblReviewSuccess.Visible = true;
                                lblReviewError.Visible = false;
                            }
                        }

                        // Làm mới dữ liệu đánh giá
                        LoadProductReviews();
                        // Xóa nội dung đánh giá
                        txtComment.Text = "";
                        rblRating.ClearSelection();
                    }
                }
            }
            catch (Exception ex)
            {
                // Xử lý ngoại lệ
                lblReviewError.Text = "Có lỗi xảy ra: " + ex.Message;
                lblReviewError.Visible = true;
                lblReviewSuccess.Visible = false;
            }
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
                        using (SqlCommand cmd = new SqlCommand("SELECT Name, Price, ImageUrl FROM Products WHERE ProductId = @ProductId", conn))
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