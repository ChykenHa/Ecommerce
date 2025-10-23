# Admin Dashboard - Radian Shop

## 🎯 Tổng quan
Admin Dashboard là hệ thống quản lý hoàn chỉnh cho website bán hàng điện tử Radian Shop, được xây dựng bằng ASP.NET Web Forms với giao diện hiện đại và responsive.

## 🚀 Tính năng chính

### 📊 Dashboard Tổng quan
- **Thống kê real-time**: Tổng đơn hàng, sản phẩm, người dùng, doanh thu
- **Quick Actions**: Các nút thao tác nhanh đến các chức năng chính
- **Recent Products**: Hiển thị sản phẩm mới thêm gần đây
- **Responsive Design**: Tương thích mọi thiết bị

### 📦 Quản lý sản phẩm
- **CRUD Operations**: Thêm, sửa, xóa sản phẩm
- **Search & Filter**: Tìm kiếm và lọc theo danh mục
- **Bulk Operations**: Xóa hàng loạt, xuất Excel
- **Image Upload**: Upload hình ảnh sản phẩm
- **Pagination**: Phân trang cho danh sách lớn

### 🔐 Bảo mật
- **Session Authentication**: Kiểm tra đăng nhập admin
- **Input Validation**: Validate dữ liệu đầu vào
- **SQL Parameter Binding**: Tránh SQL injection
- **File Upload Security**: Validate file types

## 📁 Cấu trúc thư mục

```
Admin/
├── AdminLogin.aspx          # Trang đăng nhập admin
├── AdminLogin.aspx.cs       # Code-behind đăng nhập
├── AdminLogin.aspx.designer.cs
├── AdminDashboard.aspx      # Trang dashboard chính
├── AdminDashboard.aspx.cs   # Code-behind dashboard
├── AdminDashboard.aspx.designer.cs
├── AdminMaster.master       # Master page cho admin
├── AdminMaster.master.cs    # Code-behind master page
├── AdminMaster.master.designer.cs
├── ProductManagement.aspx   # Trang quản lý sản phẩm
├── ProductManagement.aspx.cs # Code-behind quản lý sản phẩm
└── ProductManagement.aspx.designer.cs

Assets/
├── CSS/
│   └── admin-styles.css     # CSS cho admin dashboard
└── JS/
    └── admin-scripts.js     # JavaScript cho admin dashboard
```

## 🛠️ Cài đặt và sử dụng

### 1. Truy cập Admin Dashboard
```
URL: /Admin/AdminLogin.aspx
```

### 2. Đăng nhập
```
Username: admin
Password: admin123
```

### 3. Sử dụng các tính năng
- **Dashboard**: Xem tổng quan hệ thống
- **Quản lý sản phẩm**: Thêm, sửa, xóa sản phẩm
- **Quản lý đơn hàng**: Xem và xử lý đơn hàng (đang phát triển)
- **Quản lý người dùng**: Quản lý tài khoản khách hàng (đang phát triển)

## 🎨 Giao diện

### Màu sắc chủ đạo
- **Primary**: #2563EB (Blue)
- **Secondary**: #64748B (Gray)
- **Success**: #10B981 (Green)
- **Warning**: #F59E0B (Orange)
- **Danger**: #EF4444 (Red)

### Responsive Breakpoints
- **Desktop**: > 1024px
- **Tablet**: 768px - 1024px
- **Mobile**: < 768px

## 🔧 Cấu hình

### Database Connection
```csharp
string connect = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\DataBase.mdf;Integrated Security=True;Connect Timeout=30;Application Name=OnlineShop";
```

### Session Variables
```csharp
Session["AdminLoggedIn"] = "true";
Session["AdminUsername"] = username;
Session["AdminLoginTime"] = DateTime.Now;
```

## 📱 Responsive Features

### Desktop
- Sidebar cố định bên trái
- Layout đầy đủ với tất cả tính năng
- Hover effects và animations

### Tablet
- Sidebar có thể thu gọn
- Layout tối ưu cho màn hình vừa
- Touch-friendly interface

### Mobile
- Sidebar overlay
- Hamburger menu
- Tối ưu cho touch interaction

## 🚀 Tính năng nâng cao

### JavaScript Features
- **Auto-refresh**: Cập nhật dữ liệu mỗi 30 giây
- **Modal Management**: Quản lý popup forms
- **Data Tables**: Tìm kiếm, sắp xếp, phân trang
- **Notifications**: Thông báo real-time
- **Keyboard Shortcuts**: Ctrl+M để toggle sidebar

### CSS Features
- **Modern Design**: Gradient backgrounds, shadows
- **Smooth Animations**: Transitions và hover effects
- **Flexbox/Grid**: Layout hiện đại
- **Custom Properties**: CSS variables cho dễ maintain

## 🔒 Bảo mật

### Authentication
- Session-based authentication
- Automatic redirect nếu chưa đăng nhập
- Logout functionality

### Data Protection
- SQL parameter binding
- Input validation
- File upload restrictions
- XSS protection

## 📊 Performance

### Optimizations
- **Lazy Loading**: Load data khi cần
- **Pagination**: Giới hạn số records hiển thị
- **Caching**: Cache static resources
- **Minification**: CSS/JS được optimize

### Database
- **Connection Pooling**: Tái sử dụng connections
- **Query Optimization**: Indexed queries
- **Timeout Settings**: Tránh timeout

## 🐛 Troubleshooting

### Lỗi thường gặp

1. **Parser Error**: Kiểm tra namespace trong .aspx files
2. **Control not found**: Đảm bảo designer files được tạo đúng
3. **Database connection**: Kiểm tra connection string
4. **File upload**: Kiểm tra permissions và file size limits

### Debug Mode
```csharp
System.Diagnostics.Debug.WriteLine($"Debug message: {variable}");
```

## 🔄 Updates và Maintenance

### Version History
- **v1.0.0**: Initial release với basic features
- **v1.1.0**: Thêm responsive design
- **v1.2.0**: Thêm bulk operations
- **v1.3.0**: Thêm notifications system

### Future Features
- [ ] Order Management
- [ ] User Management  
- [ ] Reports & Analytics
- [ ] Email Notifications
- [ ] Multi-language Support
- [ ] API Integration

## 📞 Support

Nếu gặp vấn đề, vui lòng:
1. Kiểm tra Error List trong Visual Studio
2. Xem Debug Output
3. Kiểm tra Browser Console
4. Verify database connection

---

**© 2025 Radian Shop. Tất cả quyền được bảo lưu.**
