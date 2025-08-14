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
    <asp:Button ID="btnLaptop" runat="server" Text="Máy tính" CssClass="menu-item" OnClick="btnLaptop_Click" />
    <asp:Button ID="btnManhinh" runat="server" Text="Màn hình" CssClass="menu-item" OnClick="btnManhhinh_Click" />
    <asp:Button ID="btnHeadphone" runat="server" Text="Tai nghe" CssClass="menu-item" OnClick="btnHeadphone_Click" />
    <asp:Button ID="btnCamera" runat="server" Text="Máy ảnh" CssClass="menu-item" OnClick="btnCamera_Click" />
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
                    <asp:Image ID="Image1" runat="server" ImageUrl="~/Img/Banner1.png" CssClass="d-block w-100"/>
                </div>
                <div class="carousel-item">
                    <asp:Image ID="Image2" runat="server" ImageUrl="~/Img/Banner2.png" CssClass="d-block w-100"/>
                </div>
                <div class="carousel-item">
                    <asp:Image ID="Image3" runat="server" ImageUrl="~/Img/Banner3.png" CssClass="d-block w-100"/>
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
        <div class="pagination">
            <asp:LinkButton ID="btnPrevious" runat="server" CssClass="page-nav" OnClick="btnPrevious_Click">&lt;</asp:LinkButton>
            <asp:LinkButton ID="LinkButton1" runat="server" CssClass="page-number" OnClick="LinkButton1_Click">1</asp:LinkButton>
            <asp:LinkButton ID="LinkButton2" runat="server" CssClass="page-number" OnClick="LinkButton2_Click">2</asp:LinkButton>
            <asp:LinkButton ID="LinkButton3" runat="server" CssClass="page-number" OnClick="LinkButton3_Click">3</asp:LinkButton>
            <asp:LinkButton ID="LinkButton4" runat="server" CssClass="page-number" OnClick="LinkButton4_Click">4</asp:LinkButton>
            <asp:LinkButton ID="LinkButton5" runat="server" CssClass="page-number" OnClick="LinkButton5_Click">5</asp:LinkButton>
            <asp:LinkButton ID="btnNext" runat="server" CssClass="page-nav" OnClick="btnNext_Click">&gt;</asp:LinkButton>
            <asp:Label ID="lblTotalPages" runat="server" CssClass="total-pages"></asp:Label>
        </div>
    </div>
</asp:Content>