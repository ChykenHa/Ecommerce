# Hướng Dẫn Hệ Thống Quản Trị (Admin Panel)

## Thông Tin Đăng Nhập

### Tài khoản Admin mặc định:
- **Username**: `admin`  
- **Password**: `admin123`  
- **URL đăng nhập**: `http://localhost:62512/Admin/AdminLogin.aspx`

### Tài khoản phụ:
- **Username**: `radianadmin`  
- **Password**: `Radian@2025`

## Cấu Trúc Hệ Thống

### 1. Dashboard (`AdminDashboard.aspx`)
- **Chức năng**:
  - Thống kê tổng quan: đơn hàng, sản phẩm, người dùng, doanh thu
  - Hiển thị 10 sản phẩm gần đây nhất
  - Charts và biểu đồ thống kê
  
- **Dữ liệu hiển thị**:
  - Query từ bảng `MatHang`, `LoaiHang`
  - Tính toán tổng doanh thu từ giá sản phẩm

### 2. Quản Lý Sản Phẩm (`ProductManagement.aspx`)
- **Chức năng**:
  - Xem danh sách sản phẩm (GridView với pagination)
  - Tìm kiếm theo tên, mô tả
  - Lọc theo danh mục
  - Sắp xếp theo tên, giá
  - Thêm, sửa, xóa sản phẩm
  - Upload hình ảnh sản phẩm
  
- **Database**:
  - Bảng `MatHang`: id_hang, tenhang, mota, dongia, id_loai, soluong
  - Bảng `LoaiHang`: id_loai, tenloai, mota

### 3. Quản Lý Đơn Hàng (`OrderManagement.aspx`)
- **Chức năng**:
  - Xem danh sách đơn hàng
  - Lọc theo trạng thái (Chờ xử lý, Đang xử lý, Đang giao, Hoàn thành, Đã hủy)
  - Lọc theo khoảng ngày
  - Cập nhật trạng thái đơn hàng
  - Xem chi tiết đơn hàng
  - Xuất báo cáo Excel
  
- **Trạng thái đơn hàng**:
  - `Pending`: Chờ xử lý (màu cam)
  - `Processing`: Đang xử lý (màu xanh dương)
  - `Shipping`: Đang giao (màu tím)
  - `Completed`: Hoàn thành (màu xanh lá)
  - `Cancelled`: Đã hủy (màu đỏ)

### 4. Quản Lý Người Dùng (`UserManagement.aspx`)
- **Chức năng**:
  - Xem danh sách khách hàng
  - Tìm kiếm theo tên, email, số điện thoại
  - Lọc theo trạng thái (Hoạt động / Bị khóa)
  - Khóa/Mở khóa tài khoản
  - Thêm người dùng mới
  - Chỉnh sửa thông tin người dùng

### 5. Quản Lý Danh Mục (`CategoryManagement.aspx`)
- **Chức năng**:
  - Xem danh sách danh mục sản phẩm
  - Thêm danh mục mới
  - Chỉnh sửa trực tiếp (inline editing)
  - Xóa danh mục (nếu không có sản phẩm)
  - Hiển thị số lượng sản phẩm theo danh mục
  
- **Lưu ý**: Không thể xóa danh mục đang có sản phẩm (Foreign Key constraint)

### 6. Báo Cáo (`Reports.aspx`)
- **Chức năng**:
  - Báo cáo doanh thu theo tháng (Line Chart)
  - Báo cáo đơn hàng theo trạng thái (Doughnut Chart)
  - Top 10 sản phẩm bán chạy
  - Thống kê tổng hợp: doanh thu, đơn hàng, khách hàng mới, sản phẩm đã bán
  - Lọc báo cáo theo khoảng ngày
  - Xuất PDF
  
- **Công nghệ**: Chart.js để vẽ biểu đồ

## Cơ Sở Dữ Liệu

### Bảng `QuanTriVien`
```sql
id_quantrivien INT PRIMARY KEY
tendangnhap VARCHAR(50)
matkhau VARCHAR(100)
hoten NVARCHAR(100)
email VARCHAR(100)
id_quyen VARCHAR(20) FK -> Quyen(id_quyen)
```

### Bảng `Quyen`
```sql
id_quyen VARCHAR(20) PRIMARY KEY
tenquyen NVARCHAR(100)
mota NVARCHAR(255)
```

**Các quyền có sẵn**:
- `ADMIN`: Quản trị viên - Toàn quyền
- `MANAGER`: Quản lý - Quản lý sản phẩm và đơn hàng
- `STAFF`: Nhân viên - Xem và cập nhật đơn hàng

## Tính Năng Bảo Mật

### 1. Authentication
- Session-based authentication
- Kiểm tra `Session["AdminLoggedIn"]` trên mỗi trang
- Auto-redirect về trang login nếu chưa đăng nhập
- Remember Me (lưu trạng thái đăng nhập)

### 2. Session Management
```csharp
Session["AdminLoggedIn"] = "true"
Session["AdminUsername"] = username
Session["AdminFullName"] = fullname
Session["AdminEmail"] = email
Session["AdminRole"] = role
Session["AdminLoginTime"] = DateTime.Now
```

### 3. Logout
- Clear toàn bộ session
- Redirect về trang login
- Button logout có sẵn ở sidebar

## UI/UX Design

### Color Scheme
- Primary: `#667eea` (Purple-Blue)
- Secondary: `#764ba2` (Purple)
- Success: `#2ecc71` (Green)
- Danger: `#e74c3c` (Red)
- Warning: `#f39c12` (Orange)
- Info: `#3498db` (Blue)

### Layout
- **Sidebar**: Menu điều hướng (collapsible)
- **Top Bar**: Breadcrumb, notifications, admin profile
- **Main Content**: Nội dung chính của từng trang
- **Responsive**: Tự động điều chỉnh trên mobile/tablet

### Components
- Bootstrap 5.3.0
- Font Awesome 6.4.0 icons
- GridView với Bootstrap styling
- Modal dialogs
- Toast notifications
- Loading spinners

## Cách Sử Dụng

### Bước 1: Đăng nhập
1. Truy cập `http://localhost:62512/Admin/AdminLogin.aspx`
2. Nhập username: `admin`, password: `admin123`
3. Click "Đăng nhập"

### Bước 2: Quản lý sản phẩm
1. Click "Quản lý sản phẩm" trong sidebar
2. Xem danh sách sản phẩm hiện có
3. Click "Thêm sản phẩm" để thêm mới
4. Click "Sửa" để chỉnh sửa
5. Click "Xóa" để xóa (có confirm)

### Bước 3: Quản lý đơn hàng
1. Click "Quản lý đơn hàng"
2. Lọc theo trạng thái hoặc ngày
3. Click "Chi tiết" để xem chi tiết đơn
4. Click "Cập nhật" để thay đổi trạng thái

### Bước 4: Xem báo cáo
1. Click "Báo cáo"
2. Chọn loại báo cáo
3. Chọn khoảng thời gian
4. Click "Tạo báo cáo"
5. Click "Xuất PDF" nếu cần

## Xử Lý Lỗi

### Lỗi thường gặp:

**1. "Could not load type 'OnlineShop.Global'"**
- **Nguyên nhân**: Chưa rebuild sau khi thay đổi code
- **Giải pháp**: 
  ```
  1. Clean Solution (Build → Clean Solution)
  2. Rebuild Solution (Build → Rebuild Solution)
  3. Restart IIS Express
  ```

**2. "Parser Error - Could not load file or assembly"**
- **Nguyên nhân**: Thiếu NuGet packages
- **Giải pháp**:
  ```
  1. Right-click Solution → Restore NuGet Packages
  2. Rebuild Solution
  ```

**3. Lỗi Database Connection**
- **Nguyên nhân**: Chuỗi kết nối không đúng hoặc DB không tồn tại
- **Giải pháp**:
  ```csharp
  string connect = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\DataBase.mdf;Integrated Security=True;Connect Timeout=30;Application Name=OnlineShop";
  ```
  - Kiểm tra file `DataBase.mdf` trong `App_Data`
  - Rebuild database nếu cần

**4. Session timeout / Auto logout**
- **Nguyên nhân**: Session expire (mặc định 30 phút)
- **Giải pháp**: Tăng timeout trong `Web.config`:
  ```xml
  <sessionState mode="InProc" timeout="60" />
  ```

## Performance Tips

### 1. Caching
- Implement output caching cho báo cáo
- Cache danh mục sản phẩm (ít thay đổi)

### 2. Pagination
- Luôn dùng `AllowPaging="true"` cho GridView
- Set `PageSize` phù hợp (10-20 items)

### 3. Database
- Tạo index cho các cột thường query:
  ```sql
  CREATE INDEX IX_MatHang_id_loai ON MatHang(id_loai)
  CREATE INDEX IX_MatHang_tenhang ON MatHang(tenhang)
  ```

### 4. Images
- Compress ảnh sản phẩm trước khi upload
- Sử dụng WebP format (đã implement)
- Lazy loading cho gallery

## Mở Rộng Tương Lai

### Tính năng nên thêm:
1. ✅ Dashboard với charts
2. ✅ Quản lý danh mục inline editing
3. ✅ Báo cáo thống kê với Chart.js
4. ⬜ Export Excel/PDF cho tất cả danh sách
5. ⬜ Upload nhiều ảnh cho 1 sản phẩm
6. ⬜ Rich text editor cho mô tả sản phẩm
7. ⬜ Bulk operations (xóa/cập nhật hàng loạt)
8. ⬜ Email notifications cho đơn hàng mới
9. ⬜ Real-time dashboard updates (SignalR)
10. ⬜ Role-based access control (RBAC) nâng cao
11. ⬜ Audit logging (theo dõi thao tác admin)
12. ⬜ Inventory management (quản lý kho)
13. ⬜ Customer support chat
14. ⬜ Marketing campaigns management

## API Endpoints (Future)

Nếu muốn tách Admin thành SPA (Single Page Application):
```
GET    /api/products          - List products
POST   /api/products          - Create product
PUT    /api/products/{id}     - Update product
DELETE /api/products/{id}     - Delete product
GET    /api/orders            - List orders
PUT    /api/orders/{id}/status - Update order status
GET    /api/reports/revenue   - Revenue report
GET    /api/dashboard/stats   - Dashboard statistics
```

## Credits

- **Framework**: ASP.NET Web Forms 4.8
- **UI**: Bootstrap 5.3.0
- **Icons**: Font Awesome 6.4.0
- **Charts**: Chart.js
- **Database**: SQL Server LocalDB
- **IDE**: Visual Studio 2022

## Support

Nếu gặp vấn đề, kiểm tra:
1. Build Output window trong Visual Studio
2. Browser Console (F12)
3. IIS Express logs
4. SQL Server error logs

---

**Version**: 1.0.0  
**Last Updated**: October 2025  
**Developed by**: Radian Shop Team

