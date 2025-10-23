<%@ WebHandler Language="C#" Class="SimpleChatHandler" %>

using System;
using System.Web;
using System.Text;
using System.IO;
using System.Net;

public class SimpleChatHandler : IHttpHandler
{
    private static readonly string GeminiApiKey = "AIzaSyAjkscAxtvhwMy6pRMYZ-LMe1C7zXwHX-A";
    private static readonly string GeminiApiUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-exp:generateContent";
    
    public void ProcessRequest(HttpContext context)
    {
        try
        {
            context.Response.ContentType = "application/json; charset=utf-8";
            context.Response.Headers.Add("Access-Control-Allow-Origin", "*");
            
            if (context.Request.HttpMethod == "OPTIONS")
            {
                context.Response.StatusCode = 200;
                return;
            }

            if (context.Request.HttpMethod != "POST")
            {
                WriteJsonResponse(context, null, "Method not supported");
                return;
            }

            string requestBody = "";
            using (var reader = new StreamReader(context.Request.InputStream, Encoding.UTF8))
            {
                requestBody = reader.ReadToEnd();
            }

            if (string.IsNullOrEmpty(requestBody))
            {
                WriteJsonResponse(context, null, "Empty request");
                return;
            }

            string userMessage = ExtractMessage(requestBody);
            
            if (string.IsNullOrEmpty(userMessage))
            {
                WriteJsonResponse(context, null, "No message found");
                return;
            }

            // Try keyword matching first (fast)
            string keywordResponse = TryKeywordMatch(userMessage);
            
            if (!string.IsNullOrEmpty(keywordResponse))
            {
                // Matched a keyword - return pre-made response
                WriteJsonResponse(context, keywordResponse, null);
            }
            else
            {
                // No keyword match - call Gemini API (intelligent)
                string geminiResponse = CallGeminiAPI(userMessage);
                WriteJsonResponse(context, geminiResponse, null);
            }
        }
        catch (Exception ex)
        {
            WriteJsonResponse(context, null, "Lỗi server: " + ex.Message);
        }
    }

    private string ExtractMessage(string json)
    {
        try
        {
            int startIndex = json.IndexOf("\"message\"");
            if (startIndex == -1) return null;
            
            startIndex = json.IndexOf(":", startIndex) + 1;
            startIndex = json.IndexOf("\"", startIndex) + 1;
            
            int endIndex = json.IndexOf("\"", startIndex);
            
            if (startIndex > 0 && endIndex > startIndex)
            {
                return json.Substring(startIndex, endIndex - startIndex);
            }
        }
        catch { }
        
        return null;
    }

    private string TryKeywordMatch(string message)
    {
        string lower = message.ToLower().Trim();
        
        // Greetings
        if (ContainsAny(lower, new[] { "xin chào", "chào", "hi", "hello", "hey" }))
        {
            return "👋 <b>Xin chào! Tôi là trợ lý AI của Radian Shop.</b><br><br>" +
                   "Tôi có thể giúp bạn:<br>" +
                   "• 📱 Tìm điện thoại, laptop, tablet<br>" +
                   "• 💰 Tư vấn giá cả phù hợp<br>" +
                   "• 🎁 Thông tin khuyến mãi<br>" +
                   "• ⚖️ So sánh sản phẩm<br><br>" +
                   "Bạn muốn tìm hiểu về sản phẩm nào? 😊";
        }
        
        // Điện thoại
        if (ContainsAny(lower, new[] { "điện thoại", "phone", "iphone", "samsung" }))
        {
            return "📱 <b>Điện thoại hot:</b><br><br>" +
                   "🔥 iPhone 15 Pro Max - 29.990.000 ₫<br>" +
                   "⚡ Samsung S24 Ultra - 27.990.000 ₫<br>" +
                   "💎 Xiaomi 14 - 14.990.000 ₫<br><br>" +
                   "Bạn muốn tìm hiểu thêm về dòng nào?";
        }
        
        // Laptop
        if (ContainsAny(lower, new[] { "laptop", "macbook", "dell", "asus" }))
        {
            return "💻 <b>Laptop bán chạy:</b><br><br>" +
                   "🍎 MacBook Air M3 - 31.990.000 ₫<br>" +
                   "⚡ Dell XPS 15 - 45.990.000 ₫<br>" +
                   "🎮 ASUS ROG - 42.990.000 ₫<br><br>" +
                   "Bạn cần laptop để làm gì?";
        }
        
        // Giá
        if (ContainsAny(lower, new[] { "giá", "bao nhiêu", "rẻ", "ngân sách" }))
        {
            return "💰 <b>Phân khúc giá:</b><br><br>" +
                   "💚 Dưới 10 triệu<br>" +
                   "💙 10-20 triệu<br>" +
                   "💜 20-30 triệu<br>" +
                   "❤️ Trên 30 triệu<br><br>" +
                   "Bạn muốn tìm trong khoảng nào?";
        }
        
        // Khuyến mãi
        if (ContainsAny(lower, new[] { "khuyến mãi", "giảm giá", "sale", "ưu đãi" }))
        {
            return "🎁 <b>Khuyến mãi HOT:</b><br><br>" +
                   "🔥 iPhone 15: Giảm 15%<br>" +
                   "⚡ MacBook: Tặng AirPods<br>" +
                   "💎 Gaming: Giảm 20% phụ kiện<br><br>" +
                   "Ghé shop để nhận ưu đãi!";
        }
        
        // Liên hệ
        if (ContainsAny(lower, new[] { "liên hệ", "địa chỉ", "shop", "cửa hàng" }))
        {
            return "📍 <b>Thông tin shop:</b><br><br>" +
                   "📍 01 Nguyễn Thị Cận, Đà Nẵng<br>" +
                   "📞 Hotline: 0364972519<br>" +
                   "⏰ T2-T6: 8h-21h, T7-CN: 9h-20h<br><br>" +
                   "Ghé shop trải nghiệm nhé! 🏪";
        }
        
        // No match
        return null;
    }

    private string CallGeminiAPI(string userMessage)
    {
        try
        {
            // System prompt for shop context
            string systemPrompt = "Bạn là trợ lý AI của Radian Shop - cửa hàng bán điện thoại, laptop, tablet, tai nghe tại Đà Nẵng. " +
                "Địa chỉ: 01 Nguyễn Thị Cận, Liên Chiểu, Đà Nẵng. Hotline: 0364972519. " +
                "Hãy trả lời thân thiện, nhiệt tình, ngắn gọn (2-4 câu). " +
                "Luôn gợi ý sản phẩm phù hợp và khuyến khích khách ghé shop.";
            
            string fullPrompt = systemPrompt + "\n\nKhách hỏi: " + userMessage + "\n\nTrả lời:";
            
            // Build JSON request manually
            string requestJson = "{\"contents\":[{\"parts\":[{\"text\":\"" + 
                EscapeJsonString(fullPrompt) + "\"}]}]}";
            
            // Make HTTP request
            string url = GeminiApiUrl + "?key=" + GeminiApiKey;
            
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
            request.Method = "POST";
            request.ContentType = "application/json";
            request.Timeout = 10000; // 10 seconds
            
            byte[] bytes = Encoding.UTF8.GetBytes(requestJson);
            request.ContentLength = bytes.Length;
            
            using (Stream requestStream = request.GetRequestStream())
            {
                requestStream.Write(bytes, 0, bytes.Length);
            }
            
            using (HttpWebResponse response = (HttpWebResponse)request.GetResponse())
            using (Stream responseStream = response.GetResponseStream())
            using (StreamReader reader = new StreamReader(responseStream))
            {
                string responseJson = reader.ReadToEnd();
                
                // Parse response manually
                string text = ExtractGeminiText(responseJson);
                
                if (!string.IsNullOrEmpty(text))
                {
                    // Format response with line breaks
                    return text.Replace("\n", "<br>");
                }
            }
        }
        catch (WebException we)
        {
            // API error - return friendly fallback
            return "🤖 Xin lỗi, tôi đang gặp chút vấn đề kỹ thuật.<br><br>" +
                   "Bạn có thể:<br>" +
                   "• Gọi hotline: 0364972519<br>" +
                   "• Hoặc hỏi về: Điện thoại, Laptop, Giá cả, Khuyến mãi<br><br>" +
                   "Tôi sẽ cố gắng trả lời tốt hơn! 😊";
        }
        catch
        {
            // General error
        }
        
        // Fallback response
        return "🤖 <b>Tôi có thể giúp bạn:</b><br><br>" +
               "📱 Điện thoại, Laptop, Tablet<br>" +
               "💰 Tư vấn giá cả<br>" +
               "🎁 Khuyến mãi hot<br>" +
               "📍 Địa chỉ & liên hệ<br><br>" +
               "Bạn muốn hỏi về gì? 😊";
    }

    private string ExtractGeminiText(string json)
    {
        try
        {
            // Find "text": "..." in JSON
            int textIndex = json.IndexOf("\"text\"");
            if (textIndex == -1) return null;
            
            int startQuote = json.IndexOf("\"", textIndex + 6);
            if (startQuote == -1) return null;
            
            int endQuote = startQuote + 1;
            bool escaping = false;
            
            while (endQuote < json.Length)
            {
                if (json[endQuote] == '\\' && !escaping)
                {
                    escaping = true;
                }
                else if (json[endQuote] == '"' && !escaping)
                {
                    break;
                }
                else
                {
                    escaping = false;
                }
                endQuote++;
            }
            
            if (endQuote < json.Length)
            {
                string text = json.Substring(startQuote + 1, endQuote - startQuote - 1);
                // Unescape JSON
                return text.Replace("\\n", "\n").Replace("\\\"", "\"").Replace("\\\\", "\\");
            }
        }
        catch { }
        
        return null;
    }

    private bool ContainsAny(string text, string[] keywords)
    {
        foreach (string keyword in keywords)
        {
            if (text.Contains(keyword)) return true;
        }
        return false;
    }

    private string EscapeJsonString(string text)
    {
        if (string.IsNullOrEmpty(text)) return "";
        
        return text
            .Replace("\\", "\\\\")
            .Replace("\"", "\\\"")
            .Replace("\n", "\\n")
            .Replace("\r", "\\r")
            .Replace("\t", "\\t");
    }

    private void WriteJsonResponse(HttpContext context, string response, string error)
    {
        StringBuilder json = new StringBuilder();
        json.Append("{");
        
        if (!string.IsNullOrEmpty(response))
        {
            json.Append("\"response\":\"");
            string escaped = response
                .Replace("\\", "\\\\")
                .Replace("\"", "\\\"");
            json.Append(escaped);
            json.Append("\"");
        }
        
        if (!string.IsNullOrEmpty(error))
        {
            if (json.Length > 1) json.Append(",");
            json.Append("\"error\":\"");
            json.Append(error.Replace("\\", "\\\\").Replace("\"", "\\\""));
            json.Append("\"");
        }
        
        json.Append("}");
        
        context.Response.Write(json.ToString());
    }

    public bool IsReusable
    {
        get { return false; }
    }
}
