<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.master" AutoEventWireup="true" CodeBehind="TaiKhoan.aspx.cs" Inherits="OnlineShop.TaiKhoan" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeaderContent" runat="server">
    <title>Thông Tin Tài Khoản - Radian Shop</title>
    <meta name="description" content="Quản lý thông tin tài khoản, theo dõi đơn hàng và cập nhật thông tin cá nhân của bạn." />
    <style>
        /* Styles dành riêng cho trang Tài Khoản */
        .account-container {
            background-color: rgba(255, 255, 255, 0.95);
            border-radius: var(--radius-md);
            padding: var(--space-lg);
            margin-bottom: var(--space-lg);
            box-shadow: var(--shadow-sm);
        }
        
        .account-header {
            display: flex;
            align-items: center;
            margin-bottom: var(--space-lg);
            padding-bottom: var(--space-md);
            border-bottom: 2px solid var(--primary-light);
        }
        
        .account-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background-color: var(--primary);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 2.5rem;
            font-weight: bold;
            margin-right: var(--space-lg);
            box-shadow: var(--shadow-md);
            overflow: hidden;
        }
        
        .account-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .account-welcome {
            flex-grow: 1;
        }
        
        .account-welcome h1 {
            font-size: var(--font-size-xl);
            color: var(--primary-dark);
            margin-bottom: var(--space-xs);
        }
        
        .account-welcome p {
            color: var(--text-medium);
            font-size: var(--font-size-md);
        }
        
        .account-tabs {
            display: flex;
            margin-bottom: var(--space-lg);
            background: var(--bg-light);
            border-radius: var(--radius-md);
            overflow: hidden;
        }
        
        .account-tab {
            border-style: none;
            border-color: inherit;
            border-width: medium;
            background: ;
            color: var(--text-medium);
            font-weight: 600;
            cursor: pointer;
            transition: all var(--transition-normal);
            position: relative;
            top: 0px;
            left: 0px;
        }
        
        .account-tab:hover {
            color: var(--primary);
        }
        
        .account-tab.active {
            background: linear-gradient(to right, var(--primary), var(--primary-dark));
            color: white;
        }
        
        .tab-content {
            display: none;
        }
        
        .tab-content.active {
            display: block;
        }
        
        /* Form styling */
        .form-group {
            margin-bottom: var(--space-md);
        }
        
        .form-group label {
            display: block;
            margin-bottom: var(--space-xs);
            font-weight: 600;
            color: var(--text-dark);
        }
        
        .form-control {
            width: 100%;
            padding: var(--space-sm);
            border: 1px solid var(--border-light);
            border-radius: var(--radius-sm);
            font-size: var(--font-size-md);
            transition: all var(--transition-fast);
        }
        
        .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 2px rgba(0, 119, 182, 0.2);
            outline: none;
        }
        
        .btn-save {
            background: linear-gradient(to right, var(--primary), var(--primary-dark));
            color: white;
            border: none;
            padding: var(--space-sm) var(--space-xl);
            border-radius: var(--radius-md);
            font-weight: 600;
            cursor: pointer;
            transition: all var(--transition-normal);
            display: inline-block;
            text-align: center;
        }
        
        .btn-save:hover {
            background: linear-gradient(to right, var(--primary-light), var(--primary));
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }
        
        /* Order history styling */
        .order-list {
            margin-top: var(--space-lg);
        }
        
        .order-item {
            background-color: white;
            border-radius: var(--radius-md);
            margin-bottom: var(--space-md);
            box-shadow: var(--shadow-sm);
            transition: all var(--transition-normal);
            overflow: hidden;
        }
        
        .order-item:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-md);
        }
        
        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: var(--space-md);
            background-color: var(--bg-light);
            border-bottom: 1px solid var(--border-light);
        }
        
        .order-number {
            font-weight: 600;
            color: var(--primary-dark);
        }
        
        .order-status {
            padding: var(--space-xs) var(--space-sm);
            border-radius: var(--radius-sm);
            font-size: var(--font-size-xs);
            font-weight: bold;
        }
        
        .status-completed {
            background-color: rgba(75, 181, 67, 0.2);
            color: #2e7d32;
        }
        
        .status-processing {
            background-color: rgba(255, 193, 7, 0.2);
            color: #ff8f00;
        }
        
        .status-cancelled {
            background-color: rgba(244, 67, 54, 0.2);
            color: #d32f2f;
        }
        
        .order-date {
            font-size: var(--font-size-sm);
            color: var(--text-medium);
        }
        
        .order-content {
            padding: var(--space-md);
        }
        
        .order-products {
            margin-bottom: var(--space-md);
        }
        
        .order-product {
            display: flex;
            align-items: center;
            padding: var(--space-sm) 0;
            border-bottom: 1px solid var(--border-light);
        }
        
        .order-product:last-child {
            border-bottom: none;
        }
        
        .product-thumb {
            width: 60px;
            height: 60px;
            margin-right: var(--space-md);
            border-radius: var(--radius-sm);
            overflow: hidden;
        }
        
        .product-thumb img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .product-details {
            flex-grow: 1;
        }
        
        .product-name {
            font-weight: 600;
            margin-bottom: var(--space-xs);
        }
        
        .product-quantity {
            font-size: var(--font-size-sm);
            color: var(--text-medium);
        }
        
        .product-price {
            font-weight: 600;
            color: var(--primary);
        }
        
        .order-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: var(--space-md);
            border-top: 1px solid var(--border-light);
        }
        
        .order-total {
            font-weight: 700;
            font-size: var(--font-size-lg);
            color: var(--primary-dark);
        }
        
        .btn-view-details {
            background-color: white;
            border: 2px solid var(--primary);
            color: var(--primary);
            padding: var(--space-xs) var(--space-md);
            border-radius: var(--radius-md);
            font-weight: 600;
            cursor: pointer;
            transition: all var(--transition-normal);
        }
        
        .btn-view-details:hover {
            background-color: var(--primary);
            color: white;
        }
        
        /* Security tab styling */
        .security-option {
            padding: var(--space-md);
            background-color: white;
            border-radius: var(--radius-md);
            margin-bottom: var(--space-md);
            box-shadow: var(--shadow-sm);
            display: flex;
            align-items: center;
        }
        
        .security-icon {
            margin-right: var(--space-md);
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            background: linear-gradient(to right, var(--primary), var(--primary-dark));
            color: white;
            font-size: 1.2rem;
        }
        
        .security-details {
            flex-grow: 1;
        }
        
        .security-title {
            font-weight: 600;
            margin-bottom: var(--space-xs);
            color: var(--text-dark);
        }
        
        .security-description {
            font-size: var(--font-size-sm);
            color: var(--text-medium);
        }
        
        .btn-security {
            background-color: var(--bg-light);
            border: none;
            color: var(--primary);
            padding: var(--space-xs) var(--space-md);
            border-radius: var(--radius-md);
            font-weight: 600;
            cursor: pointer;
            transition: all var(--transition-normal);
        }
        
        .btn-security:hover {
            background-color: var(--bg-highlight);
            color: var(--primary-dark);
        }
        
        /* Addresses tab styling */
        .address-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: var(--space-md);
            margin-top: var(--space-lg);
        }
        
        .address-card {
            background-color: white;
            border-radius: var(--radius-md);
            padding: var(--space-md);
            box-shadow: var(--shadow-sm);
            position: relative;
            border: 1px solid var(--border-light);
        }
        
        .address-default {
            position: absolute;
            top: var(--space-sm);
            right: var(--space-sm);
            background-color: var(--primary);
            color: white;
            font-size: var(--font-size-xs);
            padding: 2px var(--space-xs);
            border-radius: var(--radius-sm);
        }
        
        .address-name {
            font-weight: 700;
            margin-bottom: var(--space-xs);
            color: var(--text-dark);
        }
        
        .address-content {
            margin-bottom: var(--space-md);
            color: var(--text-medium);
            font-size: var(--font-size-sm);
            line-height: 1.5;
        }
        
        .address-actions {
            display: flex;
            gap: var(--space-sm);
        }
        
        .btn-edit-address {
            flex: 1;
            text-align: center;
            padding: var(--space-xs) 0;
            background-color: white;
            border: 1px solid var(--primary);
            color: var(--primary);
            border-radius: var(--radius-sm);
            font-size: var(--font-size-sm);
            font-weight: 600;
            cursor: pointer;
            transition: all var(--transition-normal);
        }
        
        .btn-edit-address:hover {
            background-color: var(--primary);
            color: white;
        }
        
        .btn-remove-address {
            flex: 1;
            text-align: center;
            padding: var(--space-xs) 0;
            background-color: white;
            border: 1px solid #f44336;
            color: #f44336;
            border-radius: var(--radius-sm);
            font-size: var(--font-size-sm);
            font-weight: 600;
            cursor: pointer;
            transition: all var(--transition-normal);
        }
        
        .btn-remove-address:hover {
            background-color: #f44336;
            color: white;
        }
        
        .btn-add-address {
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: white;
            border: 2px dashed var(--border-light);
            border-radius: var(--radius-md);
            padding: var(--space-md);
            color: var(--text-medium);
            font-weight: 600;
            cursor: pointer;
            transition: all var(--transition-normal);
            height: 100%;
            min-height: 160px;
        }
        
        .btn-add-address:hover {
            border-color: var(--primary);
            color: var(--primary);
        }
        
        .add-icon {
            font-size: 1.5rem;
            margin-right: var(--space-xs);
        }
        
        /* Responsive design */
        @media (max-width: 768px) {
            .account-header {
                flex-direction: column;
                text-align: center;
            }
            
            .account-avatar {
                margin: 0 0 var(--space-md);
            }
            
            .account-tabs {
                flex-wrap: wrap;
            }
            
            .account-tab {
                flex: 1 0 50%;
                text-align: center;
                padding: var(--space-sm);
                font-size: var(--font-size-sm);
            }
            
            .order-header {
                flex-direction: column;
                gap: var(--space-xs);
                align-items: flex-start;
            }
            
            .order-product {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .product-thumb {
                margin-bottom: var(--space-xs);
            }
            
            .address-list {
                grid-template-columns: 1fr;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="NewsContent" runat="server">
    <marquee behavior="scroll" direction="left">
        Chào mừng quý khách đến với trang quản lý tài khoản! Tận hưởng ưu đãi đặc biệt dành riêng cho thành viên - Giảm 10% cho mọi đơn hàng trong tháng 5!
    </marquee>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="SidebarContent" runat="server">
    <h2 class="sidebar-section-title">TÀI KHOẢN</h2>
    <asp:Button ID="BtnInfo" runat="server" Text="Thông Tin Tài Khoản" CssClass="menu-item active" OnClientClick="activateTab('info'); return false;" OnClick="BtnInfo_Click" />
    <asp:Button ID="BtnOrders" runat="server" Text="Đơn Hàng Của Tôi" CssClass="menu-item" OnClientClick="activateTab('orders'); return false;" OnClick="BtnOrders_Click" />
    <asp:Button ID="BtnAddresses" runat="server" Text="Sổ Địa Chỉ" CssClass="menu-item" OnClientClick="activateTab('addresses'); return false;" OnClick="BtnAddresses_Click" />
    <asp:Button ID="BtnSecurity" runat="server" Text="Bảo Mật" CssClass="menu-item" OnClientClick="activateTab('security'); return false;" OnClick="BtnSecurity_Click" />
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="BreadcrumbContent" runat="server">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="Default.aspx">Trang Chủ</a></li>
            <li class="breadcrumb-item active" aria-current="page">Tài Khoản</li>
        </ol>
    </nav>
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="MainContent" runat="server">
    <div class="account-container">
        <div class="account-header">
            <div class="account-avatar">
                <asp:Image ID="UserAvatar" runat="server" ImageUrl="~/Img/user-placeholder.jpg" AlternateText="Avatar" />
            </div>
            <div class="account-welcome">
                <h1>Xin chào, 
                <asp:Label ID="txtUserName" runat="server" Text="Khách hàng"></asp:Label>
                <p>Quản lý thông tin cá nhân và theo dõi đơn hàng của bạn tại đây.</p>
            </div>
        </div>
        
        <div class="account-tabs">
            <button class="account-tab active" data-tab="info">Thông Tin Tài Khoản</button>
            <button class="account-tab" data-tab="orders">Đơn Hàng Của Tôi</button>
            <button class="account-tab" data-tab="addresses">Sổ Địa Chỉ</button>
            <button class="account-tab" data-tab="security">Bảo Mật</button>
        </div>
        
        <!-- Tab Thông Tin Tài Khoản -->
        <div id="info" class="tab-content active">
            <h2>Thông Tin Cá Nhân</h2>
            <p>Cập nhật thông tin cá nhân của bạn để chúng tôi có thể phục vụ bạn tốt hơn.</p>
            
            <div class="form-group">
                <label for="txtFullName">Họ và tên</label>
                <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="Nhập họ và tên" OnTextChanged="txtFullName_TextChanged"></asp:TextBox>
            </div>
            
            <div class="form-group">
                <label for="txtEmail">Email</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="example@email.com"></asp:TextBox>
            </div>
            
            <div class="form-group">
                <label for="txtPhone">Số điện thoại</label>
                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="Nhập số điện thoại" OnTextChanged="txtPhone_TextChanged"></asp:TextBox>
            </div>
            
            <div class="form-group">
                <label for="txtBirthdate">Ngày sinh</label>
                <asp:TextBox ID="txtBirthdate" runat="server" CssClass="form-control" placeholder="DD/MM/YYYY" TextMode="Date" OnTextChanged="txtBirthdate_TextChanged"></asp:TextBox>
            </div>
            

            
            <div class="form-group">
                <label for="ddlGender">Giới tính</label>
                <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlGender_SelectedIndexChanged">
                    <asp:ListItem Text="Nam" Value="male"></asp:ListItem>
                    <asp:ListItem Text="Nữ" Value="female"></asp:ListItem>
                    <asp:ListItem Text="Khác" Value="other"></asp:ListItem>
                </asp:DropDownList>
            </div>
            
            <asp:Button ID="btnSaveInfo" runat="server" Text="Lưu Thông Tin" CssClass="btn-save" OnClick="SaveInfo_Click" />
        </div>
        
        <!-- Tab Đơn Hàng -->
        <div id="orders" class="tab-content">
            <h2>Đơn Hàng Của Tôi</h2>
            <p>Theo dõi trạng thái và xem chi tiết các đơn hàng của bạn.</p>
            
            <div class="order-list">
                <!-- Đơn hàng 1 -->
                <div class="order-item">
                    <div class="order-header">
                        <div class="order-number">Đơn hàng #ORD12345</div>
                        <div class="order-status status-completed">Đã giao hàng</div>
                        <div class="order-date">15/05/2025</div>
                    </div>
                    <div class="order-content">
                        <div class="order-products">
                            <div class="order-product">
                                <div class="product-thumb">
                                    <img src="Img/product1.jpg" alt="Product 1" />
                                </div>
                                <div class="product-details">
                                    <div class="product-name">Laptop Dell XPS 13</div>
                                    <div class="product-quantity">Số lượng: 1</div>
                                </div>
                                <div class="product-price">28.990.000₫</div>
                            </div>
                            <div class="order-product">
                                <div class="product-thumb">
                                    <img src="Img/product2.jpg" alt="Product 2" />
                                </div>
                                <div class="product-details">
                                    <div class="product-name">Chuột không dây Logitech</div>
                                    <div class="product-quantity">Số lượng: 1</div>
                                </div>
                                <div class="product-price">890.000₫</div>
                            </div>
                        </div>
                        <div class="order-footer">
                            <div class="order-total">Tổng tiền: 29.880.000₫</div>
                            <asp:Button ID="btnViewDetails1" runat="server" Text="Xem Chi Tiết" CssClass="btn-view-details" OnClick="ViewOrderDetails_Click" CommandArgument="ORD12345" />
                        </div>
                    </div>
                </div>
                
                <!-- Đơn hàng 2 -->
                <div class="order-item">
                    <div class="order-header">
                        <div class="order-number">Đơn hàng #ORD12346</div>
                        <div class="order-status status-processing">Đang giao hàng</div>
                        <div class="order-date">12/05/2025</div>
                    </div>
                    <div class="order-content">
                        <div class="order-products">
                            <div class="order-product">
                                <div class="product-thumb">
                                    <img src="Img/product3.jpg" alt="Product 3" />
                                </div>
                                <div class="product-details">
                                    <div class="product-name">Tai nghe Apple AirPods Pro</div>
                                    <div class="product-quantity">Số lượng: 1</div>
                                </div>
                                <div class="product-price">5.990.000₫</div>
                            </div>
                        </div>
                        <div class="order-footer">
                            <div class="order-total">Tổng tiền: 5.990.000₫</div>
                            <asp:Button ID="btnViewDetails2" runat="server" Text="Xem Chi Tiết" CssClass="btn-view-details" OnClick="ViewOrderDetails_Click" CommandArgument="ORD12346" />
                        </div>
                    </div>
                </div>
                
                <!-- Đơn hàng 3 -->
                <div class="order-item">
                    <div class="order-header">
                        <div class="order-number">Đơn hàng #ORD12347</div>
                        <div class="order-status status-cancelled">Đã hủy</div>
                        <div class="order-date">01/05/2025</div>
                    </div>
                    <div class="order-content">
                        <div class="order-products">
                            <div class="order-product">
                                <div class="product-thumb">
                                    <img src="Img/product4.jpg" alt="Product 4" />
                                </div>
                                <div class="product-details">
                                    <div class="product-name">Màn hình LG UltraWide</div>
                                    <div class="product-quantity">Số lượng: 1</div>
                                </div>
                                <div class="product-price">7.590.000₫</div>
                            </div>
                        </div>
                        <div class="order-footer">
                            <div class="order-total">Tổng tiền: 7.590.000₫</div>
                            <asp:Button ID="btnViewDetails3" runat="server" Text="Xem Chi Tiết" CssClass="btn-view-details" OnClick="ViewOrderDetails_Click" CommandArgument="ORD12347" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Tab Địa Chỉ -->
        <div id="addresses" class="tab-content">
            <h2>Sổ Địa Chỉ</h2>
            <p>Quản lý địa chỉ giao hàng và thanh toán của bạn.</p>
            
            <div class="address-list">
                <!-- Địa chỉ 1 -->
                <div class="address-card">
                    <div class="address-default">Mặc định</div>
                    <div class="address-name">Nguyễn Văn A</div>
                    <div class="address-content">
                        123 Đường Lê Lợi, Phường Bến Nghé<br>
                        Quận 1, TP. Hồ Chí Minh<br>
                        Điện thoại: 0912 345 678
                    </div>
                    <div class="address-actions">
                        <asp:Button ID="btnEditAddress1" runat="server" Text="Sửa" CssClass="btn-edit-address" OnClick="EditAddress_Click" CommandArgument="1" />
                        <asp:Button ID="btnRemoveAddress1" runat="server" Text="Xóa" CssClass="btn-remove-address" OnClick="RemoveAddress_Click" CommandArgument="1" />
                    </div>
                </div>
                
                <!-- Địa chỉ 2 -->
                <div class="address-card">
                    <div class="address-name">Nguyễn Văn A</div>
                    <div class="address-content">
                        45 Đường Trần Hưng Đạo, Phường 5<br>
                        Quận 10, TP. Hồ Chí Minh<br>
                        Điện thoại: 0987 654 321
                    </div>
                    <div class="address-actions">
                        <asp:Button ID="btnEditAddress2" runat="server" Text="Sửa" CssClass="btn-edit-address" OnClick="EditAddress_Click" CommandArgument="2" />
                        <asp:Button ID="btnRemoveAddress2" runat="server" Text="Xóa" CssClass="btn-remove-address" OnClick="RemoveAddress_Click" CommandArgument="2" />
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Tab Bảo Mật -->
        <div id="security" class="tab-content">
            <h2>Bảo Mật Tài Khoản</h2>
            <p>Quản lý mật khẩu và thiết lập bảo mật cho tài khoản của bạn.</p>
            
            <div class="security-option">
                <div class="security-icon">
                    <i class="fas fa-lock"></i>
                </div>
                <div class="security-details">
                    <div class="security-title">Đổi mật khẩu</div>
                    <div class="security-description">Thay đổi mật khẩu của bạn để tăng cường bảo mật tài khoản</div>
                </div>
                <asp:Button ID="btnChangePassword" runat="server" Text="Thay Đổi" CssClass="btn-security" OnClick="ChangePassword_Click" />
            </div>
            
            <div class="security-option">
                <div class="security-icon">
                    <i class="fas fa-mobile-alt"></i>
                </div>
                <div class="security-details">
                    <div class="security-title">Xác thực hai lớp</div>
                    <div class="security-description">Bật xác thực hai lớp để bảo vệ tài khoản của bạn tốt hơn</div>
                </div>
                <asp:Button ID="btn2FA" runat="server" Text="Thiết Lập" CssClass="btn-security" OnClick="Setup2FA_Click" />
            </div>
            
            <div class="security-option">
                <div class="security-icon">
                    <i class="fas fa-history"></i>
                </div>
                <div class="security-details">
                    <div class="security-title">Lịch sử đăng nhập</div>
                    <div class="security-description">Xem lịch sử đăng nhập gần đây vào tài khoản của bạn</div>
                </div>
                <asp:Button ID="btnLoginHistory" runat="server" Text="Xem" CssClass="btn-security" OnClick="ViewLoginHistory_Click" />
            </div>
            
            <div class="security-option">
                <div class="security-icon">
                    <i class="fas fa-bell"></i>
                </div>
                <div class="security-details">
                    <div class="security-title">Thông báo bảo mật</div>
                    <div class="security-description">Nhận thông báo khi có hoạt động đáng ngờ trên tài khoản của bạn</div>
                </div>
                <asp:Button ID="btnSecurityAlerts" runat="server" Text="Cài Đặt" CssClass="btn-security" OnClick="SetupSecurityAlerts_Click" />
            </div>
        </div>
    </div>
    
    <script type="text/javascript">
        // Chức năng chuyển đổi tab
        function activateTab(tabId) {
            // Ẩn tất cả nội dung tab
            var tabContents = document.getElementsByClassName('tab-content');
            for (var i = 0; i < tabContents.length; i++) {
                tabContents[i].classList.remove('active');
            }

            // Bỏ active khỏi tất cả các tab
            var tabs = document.getElementsByClassName('account-tab');
            for (var i = 0; i < tabs.length; i++) {
                tabs[i].classList.remove('active');
            }

            // Kích hoạt tab được chọn
            document.getElementById(tabId).classList.add('active');
            document.querySelector('[data-tab="' + tabId + '"]').classList.add('active');

            // Đánh dấu menu item tương ứng ở sidebar
            var menuItems = document.getElementsByClassName('menu-item');
            for (var i = 0; i < menuItems.length; i++) {
                menuItems[i].classList.remove('active');
            }

            switch (tabId) {
                case 'info':
                    document.getElementById('BtnInfo').classList.add('active');
                    break;
                case 'orders':
                    document.getElementById('BtnOrders').classList.add('active');
                    break;
                case 'addresses':
                    document.getElementById('BtnAddresses').classList.add('active');
                    break;
                case 'security':
                    document.getElementById('BtnSecurity').classList.add('active');
                    break;
            }
        }

        // Đăng ký sự kiện cho các tab
        document.addEventListener('DOMContentLoaded', function () {
            var tabs = document.getElementsByClassName('account-tab');
            for (var i = 0; i < tabs.length; i++) {
                tabs[i].addEventListener('click', function () {
                    var tabId = this.getAttribute('data-tab');
                    activateTab(tabId);
                });
            }
        });
    </script>
</asp:Content>
