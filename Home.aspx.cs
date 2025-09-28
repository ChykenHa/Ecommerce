using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace OnlineShop
{
    public partial class Home : System.Web.UI.Page
    {
        string connect = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=""C:\Users\stark\Documents\Zalo Received Files\đồ án\OnlineShop-20250411T150225Z-001\OnlineShop\OnlineShop\App_Data\DataBase.mdf"";Integrated Security=True";

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
                    string query = "SELECT TOP 21 id_hang AS ProductId, tenhang AS Name, mota AS Description, dongia AS Price, hinhanh AS ImageUrl FROM MatHang ORDER BY NEWID()";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        rptRandomProducts.DataSource = dt;
                        rptRandomProducts.DataBind();
                    }
                    else
                    {
                        Response.Write("<div class='alert alert-warning'>Không tìm thấy sản phẩm nào.</div>");
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("<div class='alert alert-danger'>Lỗi khi tải sản phẩm: " + ex.Message + "</div>");
                }
            }
        }

        // FIXED: Helper method to get or create cart from session
        private List<CartItem> GetCartFromSession()
        {
            try
            {
                if (Session["Cart"] == null)
                {
                    Session["Cart"] = new List<CartItem>();
                }

                var cartSession = Session["Cart"];

                // Safe casting - if it's the old List<int> format, convert it
                if (cartSession is List<int> oldCart)
                {
                    // Convert old format to new format
                    var newCart = new List<CartItem>();
                    foreach (int productId in oldCart)
                    {
                        var product = GetProductDetails(productId);
                        if (product != null)
                        {
                            var existingItem = newCart.Find(c => c.ProductId == productId);
                            if (existingItem != null)
                            {
                                existingItem.Quantity++;
                            }
                            else
                            {
                                newCart.Add(product);
                            }
                        }
                    }
                    Session["Cart"] = newCart;
                    return newCart;
                }
                else if (cartSession is List<CartItem> cart)
                {
                    return cart;
                }
                else
                {
                    // Reset if unknown format
                    var newCart = new List<CartItem>();
                    Session["Cart"] = newCart;
                    return newCart;
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error in GetCartFromSession: " + ex.Message);
                var newCart = new List<CartItem>();
                Session["Cart"] = newCart;
                return newCart;
            }
        }

        // Method to get product details from database
        private CartItem GetProductDetails(int productId)
        {
            using (SqlConnection conn = new SqlConnection(connect))
            {
                try
                {
                    conn.Open();
                    string query = "SELECT id_hang AS ProductId, tenhang AS Name, dongia AS Price, hinhanh AS ImageUrl FROM MatHang WHERE id_hang = @ProductId";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@ProductId", productId);

                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        return new CartItem
                        {
                            ProductId = Convert.ToInt32(reader["ProductId"]),
                            ProductName = reader["Name"].ToString(),
                            Price = Convert.ToDecimal(reader["Price"]),
                            ImageUrl = reader["ImageUrl"].ToString(),
                            Quantity = 1,
                            Gifts = new List<Gift>()
                        };
                    }
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine("Error getting product details: " + ex.Message);
                }
            }
            return null;
        }

        // Event handlers for the sidebar buttons
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

        // FIXED: Use CartItem consistently
        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int productId = Convert.ToInt32(btn.CommandArgument);

            using (SqlConnection conn = new SqlConnection(connect))
            {
                conn.Open();
                string query = "SELECT id_hang, tenhang, dongia, hinhanh FROM MatHang WHERE id_hang = @id";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@id", productId);

                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    var cart = Session["Cart"] as List<CartItem>;
                    if (cart == null) cart = new List<CartItem>();

                    var existingItem = cart.Find(c => c.ProductId == productId);
                    if (existingItem != null)
                    {
                        existingItem.Quantity += 1;
                    }
                    else
                    {
                        cart.Add(new CartItem
                        {
                            ProductId = productId,
                            ProductName = reader["tenhang"].ToString(),
                            Price = Convert.ToDecimal(reader["dongia"]),
                            ImageUrl = reader["hinhanh"].ToString(),
                            Quantity = 1
                        });
                    }
                    Session["Cart"] = cart;
                }
            }
            Response.Write("<script>alert('Sản phẩm đã được thêm vào giỏ hàng!');</script>");
        }

        protected void btnBuyNow_Click(object sender, EventArgs e)
        {
            btnAddToCart_Click(sender, e);
            Response.Redirect("GioHang.aspx");
        }
        protected void rptRandomProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            try
            {
                if (!int.TryParse(e.CommandArgument?.ToString(), out int productId))
                {
                    return;
                }

                if (e.CommandName == "AddToCart")
                {
                    List<CartItem> cart = GetCartFromSession();

                    // Check if item already exists in cart
                    var existingItem = cart.Find(c => c.ProductId == productId);
                    if (existingItem != null)
                    {
                        existingItem.Quantity++;
                    }
                    else
                    {
                        // Get product details and add to cart
                        var product = GetProductDetails(productId);
                        if (product != null)
                        {
                            cart.Add(product);
                        }
                        else
                        {
                            return;
                        }
                    }

                    Session["Cart"] = cart;
                    Response.Write("<script>alert('Sản phẩm đã được thêm vào giỏ hàng!');</script>");
                }
                else if (e.CommandName == "BuyNow")
                {
                    List<CartItem> cart = GetCartFromSession();

                    // Check if item already exists in cart
                    var existingItem = cart.Find(c => c.ProductId == productId);
                    if (existingItem != null)
                    {
                        existingItem.Quantity++;
                    }
                    else
                    {
                        // Get product details and add to cart
                        var product = GetProductDetails(productId);
                        if (product != null)
                        {
                            cart.Add(product);
                        }
                        else
                        {
                            return;
                        }
                    }

                    Session["Cart"] = cart;
                    Response.Redirect("GioHang.aspx");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error in rptRandomProducts_ItemCommand: " + ex.Message);
            }
        }
    }
}