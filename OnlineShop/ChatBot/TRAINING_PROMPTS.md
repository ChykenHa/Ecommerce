# 🤖 Chatbot AI - Training Prompts & Logic

## 📋 Overview
SimpleChatHandler sử dụng keyword matching thông minh với nhiều variations để trả lời câu hỏi của khách hàng.

---

## 🎯 Trained Categories

### 1. **Greetings (Chào hỏi)**
**Keywords:**
- `xin chào`, `chào`, `hi`, `hello`, `hey`, `hê lô`, `helo`, `alo`, `hí`, `hì`

**Response:**
- Giới thiệu về Radian Shop
- Liệt kê các tính năng chatbot
- Hỏi nhu cầu khách hàng

---

### 2. **Điện thoại / Smartphones**
**Keywords:**
- `điện thoại`, `phone`, `smartphone`, `iphone`, `samsung`, `xiaomi`, `oppo`, `vivo`, `realme`

**Response:**
- iPhone 15 Pro Max - 29.990.000 ₫
- Samsung Galaxy S24 Ultra - 27.990.000 ₫
- Xiaomi 14 - 14.990.000 ₫
- Specs chi tiết từng dòng

---

### 3. **Laptop / Máy tính**
**Keywords:**
- `laptop`, `macbook`, `dell`, `asus`, `hp`, `lenovo`, `acer`, `msi`, `máy tính`, `máy tính xách tay`

**Response:**
- MacBook Air M3 - 31.990.000 ₫
- Dell XPS 15 - 45.990.000 ₫
- ASUS ROG Zephyrus - 42.990.000 ₫
- Use cases (văn phòng/gaming/đồ họa)

---

### 4. **Tablet / Máy tính bảng**
**Keywords:**
- `tablet`, `ipad`, `máy tính bảng`, `tab`

**Response:**
- iPad Pro 12.9 M2 - 24.990.000 ₫
- iPad Air 5 - 14.990.000 ₫
- Samsung Galaxy Tab S9+ - 19.990.000 ₫

---

### 5. **Tai nghe / Headphones**
**Keywords:**
- `tai nghe`, `headphone`, `earphone`, `airpods`, `earpod`, `sony`

**Response:**
- AirPods Pro Gen 2 - 6.490.000 ₫
- Sony WH-1000XM5 - 8.990.000 ₫
- AirPods Max - 13.990.000 ₫

---

### 6. **Phụ kiện**
**Keywords:**
- `phụ kiện`, `sạc`, `cáp`, `ốp`, `case`, `bao da`, `chuột`, `bàn phím`, `keyboard`, `mouse`

**Response:**
- Sạc nhanh, cáp, ốp lưng
- Bàn phím, chuột
- Balo, túi xách

---

### 7. **Giá cả / Price**
**Keywords:**
- `giá`, `bao nhiêu`, `price`, `cost`, `rẻ`, `mắc`, `tầm`, `ngân sách`, `budget`

**Response:**
- Dưới 10 triệu
- 10-20 triệu
- 20-30 triệu
- Trên 30 triệu
- Gợi ý sản phẩm theo từng tầm giá

---

### 8. **Khuyến mãi / Promotions**
**Keywords:**
- `khuyến mãi`, `giảm giá`, `sale`, `ưu đãi`, `promotion`, `voucher`, `coupon`, `mã giảm`

**Response:**
- iPhone 15: Giảm 15%, tặng AirPods
- MacBook: Tặng AirPods, giảm 10% phụ kiện
- Gaming Laptop: Giảm 20% chuột + bàn phím
- Event sinh nhật shop

---

### 9. **So sánh sản phẩm**
**Keywords:**
- `so sánh`, `compare`, `khác`, `difference`, `tốt hơn`, `better`, `nên mua`

**Response:**
- Hướng dẫn so sánh
- Ví dụ: iPhone vs Samsung, MacBook vs Dell
- Yêu cầu khách hàng cung cấp 2 sản phẩm cần so sánh

---

### 10. **Trả góp / Installment**
**Keywords:**
- `trả góp`, `góp`, `installment`, `lãi suất`, `credit`

**Response:**
- Trả góp 0% (6-12 tháng)
- Công ty tài chính (Home Credit, FE Credit)
- Thẻ tín dụng (Visa, MasterCard, JCB)

---

### 11. **Bảo hành / Warranty**
**Keywords:**
- `bảo hành`, `warranty`, `bảo trì`, `sửa chữa`, `đổi trả`

**Response:**
- Bảo hành chính hãng 12 tháng
- Đổi trả trong 15 ngày
- Hỗ trợ kỹ thuật 24/7
- Hotline: 0364972519

---

### 12. **Liên hệ / Contact**
**Keywords:**
- `liên hệ`, `contact`, `địa chỉ`, `shop`, `cửa hàng`, `store`, `ở đâu`, `where`

**Response:**
- Địa chỉ: 01 Nguyễn Thị Cận, Liên Chiểu, Đà Nẵng
- Hotline: 0364972519
- Email: support@radianshop.vn
- Giờ mở cửa: T2-T6 (8h-21h), T7-CN (9h-20h)

---

### 13. **Thank you**
**Keywords:**
- `cảm ơn`, `thanks`, `thank you`, `ok`, `được`, `good`

**Response:**
- Cảm ơn và chúc mua sắm vui vẻ

---

## 🔧 Technical Implementation

### **Logic Flow:**
```
1. User sends message
2. Convert to lowercase
3. Check keywords for each category
4. Return matched response
5. If no match → Default response (menu)
```

### **Helper Methods:**
```csharp
IsGreeting(string) → bool
IsProductQuery(string, string[]) → bool
GetSmartResponse(string) → string
```

### **Response Format:**
- HTML with `<br>` for line breaks
- `<b>` for bold text
- Emojis for visual appeal
- Bullet points (•) for lists
- Price with ₫ symbol

---

## 📊 Response Statistics

| Category | Keywords | Response Length |
|----------|----------|-----------------|
| Greetings | 11 | ~200 chars |
| Products | 40+ | ~400-600 chars |
| Price | 10 | ~350 chars |
| Promotions | 8 | ~500 chars |
| Contact | 8 | ~300 chars |

---

## 🎨 Formatting Features

### **Emojis:**
- 📱 Điện thoại
- 💻 Laptop
- 🎧 Tai nghe
- 💰 Giá cả
- 🎁 Khuyến mãi
- 🛡️ Bảo hành
- 📍 Liên hệ

### **HTML Tags:**
- `<br>` - Line break
- `<b>` - Bold text
- Price highlighting (₫)
- Bullet styling (•)

---

## 🚀 Future Enhancements

### **Phase 2:**
- [ ] Database integration for real-time product data
- [ ] Product comparison logic
- [ ] Order tracking
- [ ] Multi-language support

### **Phase 3:**
- [ ] Machine Learning integration
- [ ] Natural Language Processing
- [ ] Sentiment analysis
- [ ] Personalized recommendations

---

## 📝 Adding New Prompts

### **Step 1: Add Keywords**
```csharp
if (IsProductQuery(lower, new[] { "keyword1", "keyword2", ... }))
```

### **Step 2: Create Response**
```csharp
return "🎯 <b>Title</b><br><br>" +
       "• Point 1<br>" +
       "• Point 2<br><br>" +
       "Question? 😊";
```

### **Step 3: Test**
- Rebuild solution
- Hard refresh browser (Ctrl + Shift + R)
- Test with various keywords

---

## ⚡ Performance

- **Response Time:** < 50ms
- **No External API:** 100% offline
- **No Database:** Static responses
- **Memory:** < 1MB

---

## 🔒 Security

- ✅ No SQL injection (no database)
- ✅ No XSS (HTML is server-generated)
- ✅ No API keys exposed
- ✅ Input validation

---

**Last Updated:** 2025-01-24
**Version:** 2.0
**Author:** Radian Shop AI Team

