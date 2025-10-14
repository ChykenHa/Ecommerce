using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using Newtonsoft.Json;

namespace OnlineShop
{
    public partial class Home : System.Web.UI.Page
    {
        string connect = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\DataBase.mdf;Integrated Security=True";

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
                    // Thay đổi từ Products sang MatHang và đảm bảo tên cột tương thích - sử dụng ảnh webp từ Images_DB
                    string query = "SELECT TOP 20 id_hang AS ProductId, tenhang AS Name, mota AS Description, dongia AS Price, " +
                                 "'~/Images_DB/Loai_' + CAST(id_loai AS VARCHAR) + '/' + CAST(id_hang AS VARCHAR) + '.webp' AS ImageUrl " +
                                 "FROM MatHang ORDER BY NEWID()";

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
            Response.Redirect("SanPham.aspx?category=1"); // Điện thoại
        }

        protected void btnLaptop_Click(object sender, EventArgs e)
        {
            Response.Redirect("SanPham.aspx?category=2"); // Laptop
        }

        protected void btnTablet_Click(object sender, EventArgs e)
        {
            Response.Redirect("SanPham.aspx?category=3"); // Máy tính bảng
        }

        protected void btnHeadphone_Click(object sender, EventArgs e)
        {
            Response.Redirect("SanPham.aspx?category=4"); // Tai nghe
        }

        protected void btnAccessories_Click(object sender, EventArgs e)
        {
            Response.Redirect("SanPham.aspx?category=5"); // Phụ kiện
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int productId = Convert.ToInt32(btn.CommandArgument);

            // Add to cart using CartItem
            AddProductToCart(productId, 1);

            // Notify user
            Response.Write("<script>alert('Sản phẩm đã được thêm vào giỏ hàng!');</script>");
        }

        protected void btnBuyNow_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int productId = Convert.ToInt32(btn.CommandArgument);

            // Add to cart and redirect
            AddProductToCart(productId, 1);
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

                            List<CartItem> cartItems;
                            if (Session["Cart"] == null)
                            {
                                cartItems = new List<CartItem>();
                            }
                            else
                            {
                                cartItems = (List<CartItem>)Session["Cart"];
                            }

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
                System.Diagnostics.Debug.WriteLine("Error adding to cart: " + ex.Message);
            }
        }

        protected void rptRandomProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {

        }

        [WebMethod]
        public static string TestChat()
        {
            return "Test thành công! Page Method hoạt động.";
        }

        [WebMethod]
        public static string ProcessChatMessage(string message)
        {
            try
            {
                System.Diagnostics.Debug.WriteLine($"ProcessChatMessage called with: {message}");
                
                // Hardcode API key to avoid config issues
                var apiKey = "AIzaSyB3PKtuXrV9lyghgIZha12OuSCyyNLUlQ8";
                
                if (string.IsNullOrEmpty(apiKey))
                {
                    System.Diagnostics.Debug.WriteLine("API key is empty");
                    return "API key không được cấu hình. Vui lòng liên hệ quản trị viên.";
                }
                
                System.Diagnostics.Debug.WriteLine("API key found, proceeding with Gemini API call");

                var prompt = $@"Bạn là một trợ lý AI chuyên về thiết bị điện tử và công nghệ cho cửa hàng Radian Shop. 
Hãy trả lời câu hỏi của khách hàng một cách thân thiện và hữu ích về các sản phẩm điện tử như điện thoại, laptop, máy tính bảng, tai nghe và phụ kiện.

Câu hỏi của khách hàng: {message}

Hãy trả lời bằng tiếng Việt, ngắn gọn và hữu ích. Nếu khách hàng hỏi về sản phẩm cụ thể, hãy đưa ra lời khuyên và thông tin hữu ích.";

                var requestBody = new
                {
                    contents = new[]
                    {
                        new
                        {
                            parts = new[]
                            {
                                new { text = prompt }
                            }
                        }
                    },
                    generationConfig = new
                    {
                        temperature = 0.7,
                        topK = 40,
                        topP = 0.95,
                        maxOutputTokens = 1024
                    }
                };

                var json = JsonConvert.SerializeObject(requestBody);
                
                using (var client = new System.Net.WebClient())
                {
                    client.Headers.Add("Content-Type", "application/json");
                    
                    var apiUrl = $"https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key={apiKey}";
                    System.Diagnostics.Debug.WriteLine($"Calling Gemini API: {apiUrl}");
                    
                    var responseContent = client.UploadString(apiUrl, "POST", json);
                    System.Diagnostics.Debug.WriteLine($"Gemini API response: {responseContent}");

                    var geminiResponse = JsonConvert.DeserializeObject<dynamic>(responseContent);
                    if (geminiResponse?.candidates?.Count > 0 && geminiResponse.candidates[0].content?.parts?.Count > 0)
                    {
                        var aiResponse = geminiResponse.candidates[0].content.parts[0].text;
                        System.Diagnostics.Debug.WriteLine($"AI response: {aiResponse}");
                        return aiResponse;
                    }
                }

                System.Diagnostics.Debug.WriteLine("No valid response from Gemini API");
                return "Xin lỗi, tôi không thể xử lý yêu cầu của bạn lúc này. Vui lòng thử lại sau.";
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Exception in ProcessChatMessage: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"Stack trace: {ex.StackTrace}");
                return $"Đã xảy ra lỗi khi xử lý yêu cầu của bạn: {ex.Message}";
            }
        }
    }
} 