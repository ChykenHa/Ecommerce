<%@ WebHandler Language="C#" Class="GeminiChatHandler" %>

using System;
using System.Web;
using System.Text;
using Newtonsoft.Json;

public class GeminiChatHandler : IHttpHandler
{
    private static readonly string GeminiApiKey = System.Web.Configuration.WebConfigurationManager.AppSettings["GeminiApiKey"];
    private static readonly string GeminiApiUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent";

    public void ProcessRequest(HttpContext context)
    {
        try
        {
            context.Response.ContentType = "application/json";
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
                string requestBody = new System.IO.StreamReader(context.Request.InputStream).ReadToEnd();
                
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

                var response = ProcessChatMessageSync(requestData.Message);
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

    private string ProcessChatMessageSync(string userMessage)
    {
        try
        {
            // Check API key
            if (string.IsNullOrEmpty(GeminiApiKey))
            {
                return "API key không được cấu hình. Vui lòng liên hệ quản trị viên.";
            }

            var prompt = $@"Bạn là một trợ lý AI chuyên về thiết bị điện tử và công nghệ cho cửa hàng Radian Shop. 
Hãy trả lời câu hỏi của khách hàng một cách thân thiện và hữu ích về các sản phẩm điện tử như điện thoại, laptop, máy tính bảng, tai nghe và phụ kiện.

Câu hỏi của khách hàng: {userMessage}

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
            
            // Sử dụng WebClient synchronous method
            using (var client = new System.Net.WebClient())
            {
                client.Headers.Add("Content-Type", "application/json");
                
                var apiUrl = $"{GeminiApiUrl}?key={GeminiApiKey}";
                var responseContent = client.UploadString(apiUrl, "POST", json);

                var geminiResponse = JsonConvert.DeserializeObject<GeminiResponse>(responseContent);
                if (geminiResponse?.candidates?.Length > 0 && geminiResponse.candidates[0].content?.parts?.Length > 0)
                {
                    return geminiResponse.candidates[0].content.parts[0].text;
                }
            }

            return "Xin lỗi, tôi không thể xử lý yêu cầu của bạn lúc này. Vui lòng thử lại sau.";
        }
        catch (Exception ex)
        {
            return $"Đã xảy ra lỗi khi xử lý yêu cầu của bạn: {ex.Message}";
        }
    }

    public bool IsReusable => false;

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
}
