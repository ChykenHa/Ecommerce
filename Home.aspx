<%@ Page Language="C#" MasterPageFile="~/Site1.master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="OnlineShop.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderContent" runat="server">
    <title>Trang Chủ - Radian Shop</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="NewsContent" runat="server">
    <asp:HyperLink ID="new1" runat="server">Giảm giá đến 50% cho các sản phẩm công nghệ!</asp:HyperLink>
    <asp:HyperLink ID="new2" runat="server">Mua 1 tặng 1 phụ kiện điện thoại</asp:HyperLink>
    <asp:HyperLink ID="new3" runat="server">Freeship cho đơn hàng trên 500K</asp:HyperLink>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="BreadcrumbContent" runat="server">
    Trang chủ
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
                    <asp:Image ID="Image1" runat="server" ImageUrl="~/Img/Banner1.png" CssClass="carousel-inner"/>
                </div>
                <div class="carousel-item">
                    <asp:Image ID="Image2" runat="server" ImageUrl="~/Img/Banner2.png" CssClass="carousel-inner"/>
                </div>
                <div class="carousel-item">
                    <asp:Image ID="Image3" runat="server" ImageUrl="~/Img/Banner3.png" CssClass="carousel-inner"/>
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
    <!-- Main content for the homepage goes here -->
    <div class="featured-products">
        <h2 class="section-title">Sản Phẩm Nổi Bật</h2>
        <div class="product-grid">
            <asp:Repeater ID="rptRandomProducts" runat="server" OnItemCommand="rptRandomProducts_ItemCommand">
                <ItemTemplate>
                    <div class="product-item">
                        <div class="product-image">
                            <asp:Image ID="imgProduct" runat="server" ImageUrl='<%# Eval("ImageUrl") %>' CssClass="product-image" />
                        </div>
                        <div class="product-info">
                            <h3 class="product-title"><%# Eval("Name") %></h3>
                            <p class="product-price"><%# Eval("Price", "{0:N0} ₫") %></p>
                            <asp:Button ID="btnBuyNow" runat="server" Text="Mua ngay" CssClass="btn-buy-now" CommandArgument='<%# Eval("ProductId") %>' OnClick="btnBuyNow_Click" />
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content7" ContentPlaceHolderID="FooterContent" runat="server">
</asp:Content>