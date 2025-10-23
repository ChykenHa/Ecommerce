<%@ WebHandler Language="C#" Class="GeminiChatHandler" %>

using System;
using System.Web;
using System.Text;
using System.Net;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json;
using System.Web.Caching;

public class GeminiChatHandler : IHttpHandler
{
    private static readonly string GeminiApiKey = System.Web.Configuration.WebConfigurationManager.AppSettings["GeminiApiKey"];
    private static readonly string GeminiApiUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent";
    
    public void ProcessRequest(HttpContext context)
    {
        try
        {
            ProcessRequestInternal(context);
        }
        catch (Exception ex)
        {
            context.Response.ContentType = "application/json";
            context.Response.Write(JsonConvert.SerializeObject(new { error = "Lỗi server: " + ex.Message }));
        }
    }

    private void ProcessRequestInternal(HttpContext context)
    {
        try
        {
            context.Response.ContentType = "application/json";
            context.Response.ContentEncoding = Encoding.UTF8;
            context.Response.Headers.Add("Access-Control-Allow-Origin", "*");
            context.Response.Headers.Add("Access-Control-Allow-Methods", "POST, GET, OPTIONS");
            context.Response.Headers.Add("Access-Control-Allow-Headers", "Content-Type");

            if (context.Request.HttpMethod == "OPTIONS")
            {
                context.Response.StatusCode = 200;
                return;
            }

            if (context.Request.HttpMethod == "POST")
            {
                string requestBody = new System.IO.StreamReader(context.Request.InputStream, Encoding.UTF8).ReadToEnd();

                if (string.IsNullOrEmpty(requestBody))
                {
                    context.Response.Write(JsonConvert.SerializeObject(new { error = "Request body is empty" }));
                    return;
                }

                var requestData = JsonConvert.DeserializeObject<ChatRequest>(requestBody);

                if (string.IsNullOrEmpty(requestData?.Message))
                {
                    context.Response.Write(JsonConvert.SerializeObject(new { error = "Tin nhắn không được để trống" }));
                    return;
                }

                var response = ProcessChatMessage(requestData.Message);
                context.Response.Write(JsonConvert.SerializeObject(new { response = response }));
            }
            else
            {
                context.Response.Write(JsonConvert.SerializeObject(new { error = "Method không được hỗ trợ" }));
            }
        }
        catch (Exception ex)
        {
            context.Response.Write(JsonConvert.SerializeObject(new { error = "Lỗi server: " + ex.Message }));
        }
    }

    private string ProcessChatMessage(string userMessage)
    {
        try
        {
            if (string.IsNullOrEmpty(GeminiApiKey))
            {
                return "API key không được cấu hình. Vui lòng liên hệ quản trị viên.";
            }
            
            // Validate API key format
            if (!GeminiApiKey.StartsWith("AIza") || GeminiApiKey.Length < 30)
            {
                return "API key không hợp lệ. Vui lòng kiểm tra lại cấu hình.";
            }

            // Check if user is asking for product recommendations
            if (IsProductQuery(userMessage))
            {
                var products = GetProductsFromDatabase(userMessage);
                if (products.Any())
                {
                    return FormatProductRecommendations(products, userMessage);
                }
            }

            // Check cache first
            string cacheKey = $"gemini_response_{userMessage.GetHashCode()}";
            var cachedResponse = HttpContext.Current.Cache[cacheKey] as string;
            if (cachedResponse != null)
            {
                return cachedResponse;
            }

            var prompt = $@"Bạn là trợ lý AI cho Radian Shop. Trả lời ngắn gọn, thân thiện bằng tiếng Việt về điện thoại, laptop, tablet, tai nghe.
Câu hỏi: {userMessage}";

            var requestBody = new
            {
                contents = new[]
                {
                    new { parts = new[] { new { text = prompt } } }
                },
                generationConfig = new
                {
                    temperature = 0.7,
                    topK = 20,
                    topP = 0.9,
                    maxOutputTokens = 512
                }
            };

            var json = JsonConvert.SerializeObject(requestBody);
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
            var apiUrl = $"{GeminiApiUrl}?key={GeminiApiKey}";

            using (var client = new WebClientWithTimeout { Timeout = 8000 })
            {
                client.Encoding = Encoding.UTF8;
                client.Headers.Add("Content-Type", "application/json");

                try
                {
                    var responseContent = client.UploadString(apiUrl, "POST", json);
                    var geminiResponse = JsonConvert.DeserializeObject<GeminiResponse>(responseContent);
                        
                    if (geminiResponse?.candidates?.Length > 0 && geminiResponse.candidates[0].content?.parts?.Length > 0)
                    {
                        var responseText = geminiResponse.candidates[0].content.parts[0].text;
                        // Cache response for 5 minutes
                        HttpContext.Current.Cache.Insert(cacheKey, responseText, null, DateTime.Now.AddMinutes(5), System.Web.Caching.Cache.NoSlidingExpiration);
                        return responseText;
                    }

                    return "Xin lỗi, không thể xử lý yêu cầu. Vui lòng thử lại.";
                }
                catch (WebException webEx)
                {
                    if (webEx.Response != null)
                    {
                        using (var stream = webEx.Response.GetResponseStream())
                        using (var reader = new System.IO.StreamReader(stream))
                        {
                            var body = reader.ReadToEnd();
                            return $"Lỗi API: {webEx.Message}";
                        }
                    }
                    return $"Lỗi kết nối: {webEx.Message}";
                }
            }
        }
        catch (Exception ex)
        {
            return $"Lỗi: {ex.Message}";
        }
    }

    private bool IsProductQuery(string message)
    {
        var productKeywords = new[] { "điện thoại", "laptop", "máy tính bảng", "tablet", "tai nghe", "phụ kiện", "iphone", "samsung", "xiaomi", "oppo", "vivo", "realme", "asus", "dell", "hp", "lenovo", "macbook", "ipad", "airpods", "sản phẩm", "mua", "giá", "triệu", "nghìn", "đồng" };
        var lowerMessage = message.ToLower();
        return productKeywords.Any(keyword => lowerMessage.Contains(keyword));
    }

    private List<Product> GetProductsFromDatabase(string userMessage)
    {
        // Check cache first
        string cacheKey = $"products_{userMessage.GetHashCode()}";
        var cachedProducts = HttpContext.Current.Cache[cacheKey] as List<Product>;
        if (cachedProducts != null)
        {
            return cachedProducts;
        }

        var products = new List<Product>();
        var connectionString = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["OnlineShopDB"].ConnectionString;
        
        try
        {
            using (var conn = new SqlConnection(connectionString))
            {
                conn.Open();
                var filters = ParseUserFilters(userMessage);
                
                var query = @"SELECT TOP 5 mh.id_hang, mh.tenhang, mh.mota, mh.dongia, mh.id_loai, l.tenloai
                             FROM MatHang mh 
                             LEFT JOIN LoaiHang l ON mh.id_loai = l.id_loai";
                
                var whereConditions = new List<string>();
                var parameters = new List<SqlParameter>();
                
                if (filters.MaxPrice > 0)
                {
                    whereConditions.Add("mh.dongia <= @MaxPrice");
                    parameters.Add(new SqlParameter("@MaxPrice", filters.MaxPrice));
                }
                
                if (filters.MinPrice > 0)
                {
                    whereConditions.Add("mh.dongia >= @MinPrice");
                    parameters.Add(new SqlParameter("@MinPrice", filters.MinPrice));
                }
                
                if (filters.CategoryId > 0)
                {
                    whereConditions.Add("mh.id_loai = @CategoryId");
                    parameters.Add(new SqlParameter("@CategoryId", filters.CategoryId));
                }
                
                if (!string.IsNullOrEmpty(filters.Brand))
                {
                    whereConditions.Add("mh.tenhang LIKE @Brand");
                    parameters.Add(new SqlParameter("@Brand", "%" + filters.Brand + "%"));
                }
                
                if (whereConditions.Any())
                {
                    query += " WHERE " + string.Join(" AND ", whereConditions);
                }
                
                query += " ORDER BY mh.dongia ASC";
                
                using (var cmd = new SqlCommand(query, conn))
                {
                    cmd.CommandTimeout = 5;
                    foreach (var param in parameters)
                    {
                        cmd.Parameters.Add(param);
                    }
                    
                    using (var reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            products.Add(new Product
                            {
                                ProductId = reader.GetInt32(0),
                                Name = reader.GetString(1),
                                Description = reader.IsDBNull(2) ? "" : reader.GetString(2),
                                Price = reader.GetDecimal(3),
                                CategoryId = reader.GetInt32(4),
                                CategoryName = reader.IsDBNull(5) ? "" : reader.GetString(5)
                            });
                        }
                    }
                }
            }

            // Cache products for 10 minutes
            if (products.Any())
            {
                HttpContext.Current.Cache.Insert(cacheKey, products, null, DateTime.Now.AddMinutes(10), System.Web.Caching.Cache.NoSlidingExpiration);
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine($"DB Error: {ex.Message}");
        }
        
        return products;
    }

    private UserFilters ParseUserFilters(string message)
    {
        var filters = new UserFilters();
        var lowerMessage = message.ToLower();
        
        // Parse price
        if (lowerMessage.Contains("triệu"))
        {
            var priceMatch = System.Text.RegularExpressions.Regex.Match(message, @"(\d+)\s*triệu");
            if (priceMatch.Success)
            {
                filters.MaxPrice = decimal.Parse(priceMatch.Groups[1].Value) * 1000000;
            }
        }
        else if (lowerMessage.Contains("nghìn"))
        {
            var priceMatch = System.Text.RegularExpressions.Regex.Match(message, @"(\d+)\s*nghìn");
            if (priceMatch.Success)
            {
                filters.MaxPrice = decimal.Parse(priceMatch.Groups[1].Value) * 1000;
            }
        }
        
        // Parse category
        if (lowerMessage.Contains("điện thoại") || lowerMessage.Contains("phone"))
        {
            filters.CategoryId = 1; // Assuming category 1 is phones
        }
        else if (lowerMessage.Contains("laptop"))
        {
            filters.CategoryId = 2; // Assuming category 2 is laptops
        }
        else if (lowerMessage.Contains("máy tính bảng") || lowerMessage.Contains("tablet"))
        {
            filters.CategoryId = 3; // Assuming category 3 is tablets
        }
        else if (lowerMessage.Contains("tai nghe"))
        {
            filters.CategoryId = 4; // Assuming category 4 is headphones
        }
        
        // Parse brand
        var brands = new[] { "iphone", "samsung", "xiaomi", "oppo", "vivo", "realme", "asus", "dell", "hp", "lenovo", "macbook" };
        foreach (var brand in brands)
        {
            if (lowerMessage.Contains(brand))
            {
                filters.Brand = brand;
                break;
            }
        }
        
        return filters;
    }

    private string FormatProductRecommendations(List<Product> products, string userMessage)
    {
        var response = new StringBuilder();
        response.AppendLine("🎯 Sản phẩm phù hợp:\n");
        
        foreach (var product in products)
        {
            response.AppendLine($"📱 {product.Name}");
            response.AppendLine($"💰 {product.Price:N0} ₫");
            if (!string.IsNullOrEmpty(product.CategoryName))
            {
                response.AppendLine($"🏷️ {product.CategoryName}");
            }
            response.AppendLine();
        }
        
        response.AppendLine("💡 Bạn có thể xem chi tiết hoặc hỏi thêm về sản phẩm.");
        return response.ToString();
    }

    public bool IsReusable => false;

    internal class WebClientWithTimeout : System.Net.WebClient
    {
        public int Timeout { get; set; } = 8000; // ms

        protected override WebRequest GetWebRequest(Uri address)
        {
            var request = base.GetWebRequest(address);
            if (request != null)
            {
                request.Timeout = Timeout;
                var httpReq = request as HttpWebRequest;
                if (httpReq != null)
                {
                    httpReq.ReadWriteTimeout = Timeout;
                    httpReq.KeepAlive = false;
                }
            }
            return request;
        }
    }

    public class ChatRequest
    {
        public string Message { get; set; }
    }

    public class GeminiResponse
    {
        public Candidate[] candidates { get; set; }
    }

    public class Candidate
    {
        public Content content { get; set; }
    }

    public class Content
    {
        public Part[] parts { get; set; }
    }

    public class Part
    {
        public string text { get; set; }
    }

    public class UserFilters
    {
        public decimal MaxPrice { get; set; }
        public decimal MinPrice { get; set; }
        public int CategoryId { get; set; }
        public string Brand { get; set; }
    }

    public class Product
    {
        public int ProductId { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public decimal Price { get; set; }
        public string ImageUrl { get; set; }
        public int CategoryId { get; set; }
        public string CategoryName { get; set; }
    }

}
