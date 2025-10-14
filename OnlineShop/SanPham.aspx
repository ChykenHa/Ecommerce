<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.master" AutoEventWireup="true" CodeBehind="SanPham.aspx.cs" Inherits="OnlineShop.SanPham" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderContent" runat="server">
    <title>Sản Phẩm - Radian Shop</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="NewsContent" runat="server">
    <asp:HyperLink ID="new1" runat="server">Giảm giá đến 50% cho các sản phẩm công nghệ!</asp:HyperLink>
    <asp:HyperLink ID="new2" runat="server">Mua 1 tặng 1 phụ kiện điện thoại</asp:HyperLink>
    <asp:HyperLink ID="new3" runat="server">Freeship cho đơn hàng trên 500K</asp:HyperLink>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="BreadcrumbContent" runat="server">
    Trang chủ > Sản Phẩm       
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="SidebarContent" runat="server">
    <asp:Button ID="btnAll" runat="server" Text="Tất cả sản phẩm" CssClass="menu-item" OnClick="btnAll_Click" />
    <asp:Button ID="btnSmartphone" runat="server" Text="Điện thoại" CssClass="menu-item" OnClick="btnSmartphone_Click" />
    <asp:Button ID="btnLaptop" runat="server" Text="Laptop" CssClass="menu-item" OnClick="btnLaptop_Click" />
    <asp:Button ID="btnTablet" runat="server" Text="Máy tính bảng" CssClass="menu-item" OnClick="btnTablet_Click" />
    <asp:Button ID="btnHeadphone" runat="server" Text="Tai nghe" CssClass="menu-item" OnClick="btnHeadphone_Click" />
    <asp:Button ID="btnAccessories" runat="server" Text="Phụ kiện" CssClass="menu-item" OnClick="btnAccessories_Click" />
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="BannerContent" runat="server">
    <div class="banner">
        <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
            <!-- Indicators -->
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
            </div>

            <!-- Slides -->
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <asp:Image ID="Image1" runat="server" ImageUrl="~/Assets/Images/Banner1.png" CssClass="d-block w-100"/>
                </div>
                <div class="carousel-item">
                    <asp:Image ID="Image2" runat="server" ImageUrl="~/Assets/Images/Banner2.png" CssClass="d-block w-100"/>
                </div>
                <div class="carousel-item">
                    <asp:Image ID="Image3" runat="server" ImageUrl="~/Assets/Images/Banner3.png" CssClass="d-block w-100"/>
                </div>
            </div>

            <!-- Controls -->
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content6" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        /* Pagination Styles */
        .pagination-container {
            margin-top: 40px;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 20px;
        }

        .pagination {
            display: flex;
            align-items: center;
            gap: 8px;
            background: #fff;
            padding: 12px 20px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            border: 1px solid #e0e0e0;
        }

        .page-nav {
            display: flex;
            align-items: center;
            gap: 6px;
            padding: 10px 16px;
            background: #f8f9fa;
            color: #495057;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
            border: 1px solid #dee2e6;
        }

        .page-nav:hover {
            background: #007bff;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 123, 255, 0.3);
        }

        .page-nav:disabled,
        .page-nav[disabled] {
            background: #e9ecef;
            color: #6c757d;
            cursor: not-allowed;
            opacity: 0.6;
        }

        .page-nav:disabled:hover,
        .page-nav[disabled]:hover {
            background: #e9ecef;
            color: #6c757d;
            transform: none;
            box-shadow: none;
        }

        .page-numbers {
            display: flex;
            gap: 4px;
        }

        .page-number {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            background: #fff;
            color: #495057;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
            border: 1px solid #dee2e6;
        }

        .page-number:hover {
            background: #007bff;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 123, 255, 0.3);
        }

        .page-number.active {
            background: #007bff;
            color: white;
            font-weight: 600;
            box-shadow: 0 4px 8px rgba(0, 123, 255, 0.3);
        }

        .page-number.active:hover {
            background: #0056b3;
        }

        .pagination-info {
            text-align: center;
        }

        .total-pages {
            color: #6c757d;
            font-size: 14px;
            font-weight: 500;
            background: #f8f9fa;
            padding: 8px 16px;
            border-radius: 20px;
            border: 1px solid #dee2e6;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .pagination {
                padding: 8px 12px;
                gap: 4px;
            }
            
            .page-nav {
                padding: 8px 12px;
                font-size: 14px;
            }
            
            .page-number {
                width: 36px;
                height: 36px;
                font-size: 14px;
            }
        }

        /* Product Grid Improvements */
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 24px;
            margin-bottom: 40px;
        }

        .product-item {
            background: #fff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            border: 1px solid #e0e0e0;
        }

        .product-item:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
        }

        .product-image {
            position: relative;
            overflow: hidden;
            height: 200px;
        }

        .product-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .product-item:hover .product-image img {
            transform: scale(1.05);
        }

        .product-info {
            padding: 20px;
        }

        .product-title {
            margin: 0 0 12px 0;
            font-size: 16px;
            font-weight: 600;
            line-height: 1.4;
        }

        .product-title a {
            color: #333;
            text-decoration: none;
        }

        .product-title a:hover {
            color: #007bff;
        }

        .product-description {
            color: #666;
            font-size: 14px;
            line-height: 1.5;
            margin: 0 0 16px 0;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .product-price {
            font-size: 18px;
            font-weight: 700;
            color: #e74c3c;
            margin: 0 0 16px 0;
        }

        .product-actions {
            display: flex;
            gap: 8px;
        }

        .btn-buy-now {
            flex: 1;
            background: #007bff;
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-buy-now:hover {
            background: #0056b3;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 123, 255, 0.3);
        }

        /* Sort Dropdown */
        .dropdown-sort {
            padding: 10px 16px;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            background: #fff;
            font-size: 14px;
            color: #495057;
            min-width: 200px;
        }

        .dropdown-sort:focus {
            outline: none;
            border-color: #007bff;
            box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.1);
        }
    </style>
    <div class="product-container">
        <h2 class="section-title">
            <asp:Label ID="lblCategoryTitle" runat="server" Text="Tất Cả Sản Phẩm"></asp:Label>
        </h2>
        
        <div style="display: flex; justify-content: flex-end; margin-bottom: 20px;">
            <asp:DropDownList ID="ddlSort" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlSort_SelectedIndexChanged"
                CssClass="dropdown-sort">
                <asp:ListItem Value="default">Sắp xếp theo</asp:ListItem>
                <asp:ListItem Value="price_asc">Giá: Thấp đến cao</asp:ListItem>
                <asp:ListItem Value="price_desc">Giá: Cao đến thấp</asp:ListItem>
                <asp:ListItem Value="name_asc">Tên: A-Z</asp:ListItem>
                <asp:ListItem Value="name_desc">Tên: Z-A</asp:ListItem>
            </asp:DropDownList>
        </div>

        <div class="product-grid">
            <asp:Repeater ID="rptProducts" runat="server" OnItemCommand="rptProducts_ItemCommand">
                <ItemTemplate>
                    <div class="product-item">
                        <div class="product-image">
                            <asp:HyperLink ID="lnkProductImage" runat="server" NavigateUrl='<%# "Details.aspx?id=" + Eval("ProductId") %>'>
                                <asp:Image ID="imgProduct" runat="server" ImageUrl='<%# Eval("ImageUrl") %>' />
                            </asp:HyperLink>
                        </div>
                        <div class="product-info">
                            <h3 class="product-title">
                                <asp:HyperLink ID="lnkProductTitle" runat="server" NavigateUrl='<%# "Details.aspx?id=" + Eval("ProductId") %>'>
                                    <%# Eval("Name") %>
                                </asp:HyperLink>
                            </h3>
                            <p class="product-description"><%# Eval("Description") %></p>
                            <p class="product-price"><%# Eval("Price", "{0:N0} ₫") %></p>
                            <div class="product-actions">
                                <asp:Button ID="btnBuyNow" runat="server" Text="Mua ngay" CssClass="btn-buy-now" CommandArgument='<%# Eval("ProductId") %>' OnClick="btnBuyNow_Click" />
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        
        <!-- Pagination -->
        <div class="pagination-container">
            <div class="pagination">
                <asp:LinkButton ID="btnPrevious" runat="server" CssClass="page-nav" OnClick="btnPrevious_Click">
                    <i class="fas fa-chevron-left"></i> Trước
                </asp:LinkButton>
                
                <div class="page-numbers">
                    <asp:LinkButton ID="LinkButton1" runat="server" CssClass="page-number" OnClick="LinkButton1_Click">1</asp:LinkButton>
                    <asp:LinkButton ID="LinkButton2" runat="server" CssClass="page-number" OnClick="LinkButton2_Click">2</asp:LinkButton>
                    <asp:LinkButton ID="LinkButton3" runat="server" CssClass="page-number" OnClick="LinkButton3_Click">3</asp:LinkButton>
                    <asp:LinkButton ID="LinkButton4" runat="server" CssClass="page-number" OnClick="LinkButton4_Click">4</asp:LinkButton>
                    <asp:LinkButton ID="LinkButton5" runat="server" CssClass="page-number" OnClick="LinkButton5_Click">5</asp:LinkButton>
                </div>
                
                <asp:LinkButton ID="btnNext" runat="server" CssClass="page-nav" OnClick="btnNext_Click">
                    Sau <i class="fas fa-chevron-right"></i>
                </asp:LinkButton>
            </div>
            
            <div class="pagination-info">
                <asp:Label ID="lblTotalPages" runat="server" CssClass="total-pages"></asp:Label>
            </div>
        </div>
    </div>
</asp:Content>