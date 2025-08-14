using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace OnlineShop
{
    public partial class Home : System.Web.UI.Page
    {
        string connect = @"Data Source=DARLING\SQLEXPRESS;Initial Catalog=OnlineShopDB;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadRandomProducts();
            }
        }
        private void LoadRandomProducts()
        {
            using (SqlConnection conn = new SqlConnection(connect))
            {
                try
                {
                    conn.Open();
                    // Thay đổi từ Products sang MatHang và đảm bảo tên cột tương thích
                    string query = "SELECT TOP 20 id_hang AS ProductId, tenhang AS Name, mota AS Description, dongia AS Price, hinhanh AS ImageUrl FROM MatHang ORDER BY NEWID()";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        rptRandomProducts.DataSource = dt;
                        rptRandomProducts.DataBind();
                        // Thêm log để debug
                        Response.Write($"<script>console.log('Số sản phẩm: {dt.Rows.Count}');</script>");
                    }
                    else
                    {
                        // Hiển thị thông báo không có sản phẩm
                        Response.Write("<script>console.log('Không tìm thấy sản phẩm nào.');</script>");
                        Response.Write("<div class='alert alert-warning'>Không tìm thấy sản phẩm nào.</div>");
                    }
                }
                catch (Exception ex)
                {
                    // Hiển thị thông báo lỗi và ghi log
                    Response.Write("<script>console.error('Lỗi khi tải sản phẩm: " + ex.Message + "');</script>");
                    Response.Write("<div class='alert alert-danger'>Lỗi khi tải sản phẩm. Vui lòng thử lại sau.</div>");
                }
            }
        }


        // Event handlers for the sidebar buttons - redirects handled in master page
        protected void btnAll_Click(object sender, EventArgs e)
        {
            Response.Redirect("SanPham.aspx");
        }

        protected void btnSmartphone_Click(object sender, EventArgs e)
        {
            Response.Redirect("SanPham.aspx?category=smartphone");
        }

        protected void btnLaptop_Click(object sender, EventArgs e)
        {
            Response.Redirect("SanPham.aspx?category=laptop");
        }

        protected void btnTablet_Click(object sender, EventArgs e)
        {
            Response.Redirect("SanPham.aspx?category=tablet");
        }

        protected void btnHeadphone_Click(object sender, EventArgs e)
        {
            Response.Redirect("SanPham.aspx?category=headphone");
        }

        protected void btnAccessories_Click(object sender, EventArgs e)
        {
            Response.Redirect("SanPham.aspx?category=accessories");
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int productId = Convert.ToInt32(btn.CommandArgument);

            // Add to cart logic
            // For example:
            if (Session["Cart"] == null)
            {
                Session["Cart"] = new List<int>();
            }

            List<int> cart = (List<int>)Session["Cart"];
            cart.Add(productId);
            Session["Cart"] = cart;

            // Notify user
            Response.Write("<script>alert('Sản phẩm đã được thêm vào giỏ hàng!');</script>");
        }

        protected void btnBuyNow_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int productId = Convert.ToInt32(btn.CommandArgument);

            // Add to cart and redirect to checkout
            if (Session["Cart"] == null)
            {
                Session["Cart"] = new List<int>();
            }

            List<int> cart = (List<int>)Session["Cart"];
            cart.Add(productId);
            Session["Cart"] = cart;

            Response.Redirect("Checkout.aspx");
        }

        protected void rptRandomProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {

        }
    }
}