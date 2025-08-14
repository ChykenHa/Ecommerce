<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.master" AutoEventWireup="true" CodeBehind="Details.aspx.cs" Inherits="OnlineShop.Details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderContent" runat="server">
    <title>Chi Tiết Sản Phẩm - Radian Shop</title>
    <style>
        /* Styles cho trang chi tiết sản phẩm */

.product-detail-container {
    padding: 20px;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0,0,0,0.05);
}

.product-detail-wrapper {
    display: flex;
    flex-wrap: wrap;
    gap: 30px;
    margin-bottom: 40px;
}

.product-detail-left {
    flex: 1;
    min-width: 300px;
}

.product-detail-right {
    flex: 1;
    min-width: 300px;
}

.product-detail-image {
    width: 100%;
    border: 1px solid #eee;
    border-radius: 8px;
    overflow: hidden;
    margin-bottom: 15px;
}

.detail-image {
    width: 100%;
    height: auto;
    object-fit: cover;
}

.product-thumbnails {
    display: flex;
    gap: 10px;
    overflow-x: auto;
}

.thumbnail-item {
    width: 80px;
    height: 80px;
    border: 1px solid #eee;
    border-radius: 4px;
    overflow: hidden;
    cursor: pointer;
}

.thumbnail-item:hover {
    border-color: #0066cc;
}

.thumbnail {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.product-detail-title {
    font-size: 24px;
    font-weight: 700;
    margin-bottom: 15px;
    color: #333;
}

.product-meta {
    margin-bottom: 20px;
    font-size: 14px;
    color: #666;
}

.product-meta > div {
    margin-bottom: 5px;
}

.product-price-wrapper {
    display: flex;
    align-items: center;
    margin-bottom: 20px;
}

.product-detail-price {
    font-size: 24px;
    font-weight: 700;
    color: #e53935;
    margin-right: 15px;
}

.product-original-price {
    font-size: 16px;
    color: #999;
    text-decoration: line-through;
}

.product-detail-description {
    margin-bottom: 30px;
    line-height: 1.6;
    color: #444;
}

.product-quantity {
    display: flex;
    align-items: center;
    margin-bottom: 30px;
}

.quantity-label {
    margin-right: 15px;
    font-weight: 500;
}

.quantity-controls {
    display: flex;
    align-items: center;
    border: 1px solid #ddd;
    border-radius: 4px;
    overflow: hidden;
}

.quantity-btn {
    width: 40px;
    height: 40px;
    background-color: #f5f5f5;
    border: none;
    font-size: 18px;
    cursor: pointer;
}

.quantity-btn:hover {
    background-color: #e0e0e0;
}

.quantity-input {
    width: 60px;
    height: 40px;
    border: none;
    border-left: 1px solid #ddd;
    border-right: 1px solid #ddd;
    text-align: center;
    font-size: 16px;
}

.product-actions {
    display: flex;
    gap: 15px;
    margin-bottom: 30px;
}

.btn-add-cart {
    padding: 12px 25px;
    background-color: #f5f5f5;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s;
}

.btn-add-cart:hover {
    background-color: #e0e0e0;
}

.btn-buy-now {
    padding: 12px 25px;
    background-color: #e53935;
    color: white;
    border: none;
    border-radius: 4px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s;
}

.btn-buy-now:hover {
    background-color: #c62828;
}

.product-guarantee {
    padding: 15px;
    border: 1px solid #e0e0e0;
    border-radius: 4px;
    background-color: #f9f9f9;
}

.guarantee-item {
    display: flex;
    align-items: center;
    margin-bottom: 10px;
}

.guarantee-item i {
    margin-right: 10px;
    color: #0066cc;
}

.product-tabs {
    margin-bottom: 40px;
}

.tab-header {
    display: flex;
    border-bottom: 1px solid #ddd;
    margin-bottom: 20px;
}

.tab-btn {
    padding: 12px 20px;
    background: none;
    border: none;
    border-bottom: 2px solid transparent;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s;
}

.tab-btn.active {
    color: #0066cc;
    border-bottom-color: #0066cc;
}

.tab-pane {
    display: none;
    padding: 20px 0;
}

.tab-pane.active {
    display: block;
}

.product-full-description {
    line-height: 1.8;
}

.product-specifications {
    width: 100%;
}

.spec-row {
    display: flex;
    border-bottom: 1px solid #eee;
    padding: 10px 0;
}

.spec-row:last-child {
    border-bottom: none;
}

.spec-name {
    flex: 1;
    font-weight: 500;
    color: #666;
}

.spec-value {
    flex: 2;
    color: #333;
}

.product-reviews {
    width: 100%;
}

.review-summary {
    display: flex;
    justify-content: center;
    margin-bottom: 30px;
    padding: 20px;
    background-color: #f9f9f9;
    border-radius: 8px;
}

.average-rating {
    text-align: center;
}

.average-rating .rating-stars {
    font-size: 24px;
    color: #ffb400;
    margin: 10px 0;
}

.average-rating .total-reviews {
    color: #666;
}

.review-list {
    margin-bottom: 40px;
}

.review-item {
    padding: 15px 0;
    border-bottom: 1px solid #eee;
}

.review-header {
    display: flex;
    justify-content: space-between;
    margin-bottom: 10px;
}

.reviewer-name {
    font-weight: 600;
}

.review-date {
    color: #999;
    font-size: 14px;
}

.reviewer-rating {
    color: #ffb400;
    margin-bottom: 10px;
}

.review-content {
    line-height: 1.6;
    color: #444;
}

.write-review {
    background-color: #f9f9f9;
    padding: 20px;
    border-radius: 8px;
}

.write-review h3 {
    margin-bottom: 20px;
    font-size: 18px;
}

.form-group {
    margin-bottom: 15px;
}

.form-group label {
    display: block;
    margin-bottom: 5px;
    font-weight: 500;
}

.form-control {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 14px;
}

.rating-options {
    display: flex;
    gap: 15px;
}

.btn-submit-review {
    padding: 10px 20px;
    background-color: #0066cc;
    color: white;
    border: none;
    border-radius: 4px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s;
}

.btn-submit-review:hover {
    background-color: #0052a3;
}

.related-products {
    margin-top: 50px;
}

.section-title {
    font-size: 24px;
    font-weight: 700;
    margin-bottom: 20px;
    color: #333;
    position: relative;
    padding-bottom: 10px;
}

.section-title:after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    width: 50px;
    height: 3px;
    background-color: #0066cc;
}

.product-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
    gap: 20px;
}

.product-item {
    background-color: #fff;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 0 10px rgba(0,0,0,0.05);
    transition: transform 0.3s;
}

.product-item:hover {
    transform: translateY(-5px);
}

.product-image {
    position: relative;
    height: 200px;
    overflow: hidden;
}

.product-image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.3s;
}

.product-item:hover .product-image img {
    transform: scale(1.05);
}

.product-info {
    padding: 15px;
}

.product-title {
    font-size: 16px;
    font-weight: 600;
    margin-bottom: 8px;
    height: 40px;
    overflow: hidden;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
}

.product-title a {
    color: #333;
    text-decoration: none;
}

.product-title a:hover {
    color: #0066cc;
}

.product-price {
    font-size: 18px;
    font-weight: 700;
    color: #e53935;
    margin-bottom: 15px;
}

/* Responsive */
@media (max-width: 768px) {
    .product-detail-wrapper {
        flex-direction: column;
    }
    
    .product-grid {
        grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
    }
    
    .product-actions {
        flex-direction: column;
    }
}
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="NewsContent" runat="server">
    <asp:HyperLink ID="new1" runat="server">Giảm giá đến 50% cho các sản phẩm công nghệ!</asp:HyperLink>
    <asp:HyperLink ID="new2" runat="server">Mua 1 tặng 1 phụ kiện điện thoại</asp:HyperLink>
    <asp:HyperLink ID="new3" runat="server">Freeship cho đơn hàng trên 500K</asp:HyperLink>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="BreadcrumbContent" runat="server">
    <asp:HyperLink ID="lnkHome" runat="server" NavigateUrl="~/Default.aspx">Trang chủ</asp:HyperLink> > 
    <asp:HyperLink ID="lnkProducts" runat="server" NavigateUrl="~/SanPham.aspx">Sản Phẩm</asp:HyperLink> > 
    <asp:Label ID="lblProductName" runat="server"></asp:Label>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="SidebarContent" runat="server">
    <asp:Button ID="btnAll" runat="server" Text="Tất cả sản phẩm" CssClass="menu-item" OnClick="btnAll_Click" />
    <asp:Button ID="btnSmartphone" runat="server" Text="Điện thoại" CssClass="menu-item" OnClick="btnSmartphone_Click" />
    <asp:Button ID="btnLaptop" runat="server" Text="Máy tính" CssClass="menu-item" OnClick="btnLaptop_Click" />
    <asp:Button ID="btnManhinh" runat="server" Text="Màn hình" CssClass="menu-item" OnClick="btnManhinh_Click" />
    <asp:Button ID="btnHeadphone" runat="server" Text="Tai nghe" CssClass="menu-item" OnClick="btnHeadphone_Click" />
    <asp:Button ID="btnCamera" runat="server" Text="Máy ảnh" CssClass="menu-item" OnClick="btnCamera_Click" />
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="BannerContent" runat="server">
    <!-- Không hiển thị banner ở trang chi tiết sản phẩm -->
</asp:Content>

<asp:Content ID="Content6" ContentPlaceHolderID="MainContent" runat="server">

    <div class="product-detail-container">
        <div class="product-detail-wrapper">
            <div class="product-detail-left">
                <div class="product-detail-image">
                    <asp:Image ID="imgProductDetail" runat="server" CssClass="detail-image" />
                </div>
                <div class="product-thumbnails">
                    <asp:Repeater ID="rptThumbnails" runat="server">
                        <ItemTemplate>
                            <div class="thumbnail-item">
                                <asp:Image ID="imgThumbnail" runat="server" ImageUrl='<%# Eval("ImageUrl") %>' CssClass="thumbnail" />
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
            
            <div class="product-detail-right">
                <h1 class="product-detail-title">
                    <asp:Label ID="lblName" runat="server"></asp:Label>
                </h1>
                
                <div class="product-meta">
                    <div class="product-id">
                        Mã sản phẩm: <asp:Label ID="lblProductId" runat="server"></asp:Label>
                    </div>
                    <div class="product-category">
                        Danh mục: <asp:Label ID="lblCategory" runat="server"></asp:Label>
                    </div>
                    <div class="product-status">
                        Tình trạng: <asp:Label ID="lblStatus" runat="server"></asp:Label>
                    </div>
                </div>
                
                <div class="product-price-wrapper">
                    <div class="product-detail-price">
                        <asp:Label ID="lblPrice" runat="server"></asp:Label>
                    </div>
                    <div class="product-original-price">
                        <asp:Label ID="lblOriginalPrice" runat="server"></asp:Label>
                    </div>
                </div>
                
                <div class="product-detail-description">
                    <asp:Label ID="lblDescription" runat="server"></asp:Label>
                </div>
                
                <div class="product-quantity">
                    <span class="quantity-label">Số lượng:</span>
                    <div class="quantity-controls">
                        <asp:Button ID="btnDecrease" runat="server" Text="-" CssClass="quantity-btn" OnClick="btnDecrease_Click" />
                        <asp:TextBox ID="txtQuantity" runat="server" Text="1" CssClass="quantity-input"></asp:TextBox>
                        <asp:Button ID="btnIncrease" runat="server" Text="+" CssClass="quantity-btn" OnClick="btnIncrease_Click" />
                    </div>
                </div>
                
                <div class="product-actions">
                    <asp:Button ID="btnAddToCart" runat="server" Text="Thêm vào giỏ hàng" CssClass="btn-add-cart" OnClick="btnAddToCart_Click" />
                    <asp:Button ID="btnBuyNow" runat="server" Text="Mua ngay" CssClass="btn-buy-now" OnClick="btnBuyNow_Click" />
                </div>
                
                <div class="product-guarantee">
                    <div class="guarantee-item">
                        <i class="fas fa-shield-alt"></i>
                        <span>Bảo hành chính hãng 12 tháng</span>
                    </div>
                    <div class="guarantee-item">
                        <i class="fas fa-exchange-alt"></i>
                        <span>Đổi trả miễn phí trong 30 ngày</span>
                    </div>
                    <div class="guarantee-item">
                        <i class="fas fa-truck"></i>
                        <span>Giao hàng toàn quốc</span>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="product-tabs">
            <div class="tab-header">
                <asp:Button ID="btnDescTab" runat="server" Text="Mô tả chi tiết" CssClass="tab-btn active" OnClick="btnDescTab_Click" />
                <asp:Button ID="btnSpecTab" runat="server" Text="Thông số kỹ thuật" CssClass="tab-btn" OnClick="btnSpecTab_Click" />
                <asp:Button ID="btnReviewTab" runat="server" Text="Đánh giá" CssClass="tab-btn" OnClick="btnReviewTab_Click" />
            </div>
            
            <div class="tab-content">
                <asp:Panel ID="pnlDescContent" runat="server" CssClass="tab-pane active">
                    <div class="product-full-description">
                        <asp:Literal ID="litFullDescription" runat="server"></asp:Literal>
                    </div>
                </asp:Panel>
                
                <asp:Panel ID="pnlSpecContent" runat="server" CssClass="tab-pane">
                    <div class="product-specifications">
                        <asp:Repeater ID="rptSpecifications" runat="server">
                            <ItemTemplate>
                                <div class="spec-row">
                                    <div class="spec-name"><%# Eval("Name") %></div>
                                    <div class="spec-value"><%# Eval("Value") %></div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </asp:Panel>

                <div class="review-list">
                    <asp:Repeater ID="rptProductReviews" runat="server" OnItemDataBound="rptProductReviews_ItemDataBound">
                        <ItemTemplate>
                            <div class="review-item">
                                <div class="review-header">
                                    <div class="reviewer-name"><%# Eval("ReviewerName") %></div>
                                    <div class="review-date"><%# Eval("ReviewDate", "{0:dd/MM/yyyy}") %></div>
                                </div>
                                <div class="reviewer-rating">
                                    <asp:Literal ID="litReviewStars" runat="server"></asp:Literal>
                                </div>
                                <div class="review-content"><%# Eval("ReviewText") %></div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                
                <asp:Panel ID="pnlReviewContent" runat="server" CssClass="tab-pane">
                    <div class="product-reviews">
                        <div class="review-summary">
                            <div class="average-rating">
                                <asp:Label ID="lblAverageRating" runat="server"></asp:Label>
                                <div class="rating-stars">
                                    <asp:Literal ID="litRatingStars" runat="server"></asp:Literal>
                                </div>
                                <div class="total-reviews">
                                    <asp:Label ID="lblTotalReviews" runat="server"></asp:Label> đánh giá
                                </div>
                            </div>
                        </div>
                       
                        
                        <asp:Panel ID="pnlWriteReview" runat="server" CssClass="write-review">
                            <h3>Viết đánh giá của bạn</h3>
                            <div class="form-group">
                                <label for="txtReviewerName">Họ tên:</label>
                                <asp:TextBox ID="txtReviewerName" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label for="rblRating">Đánh giá:</label>
                                <asp:RadioButtonList ID="rblRating" runat="server" RepeatDirection="Horizontal" CssClass="rating-options">
                                    <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                    <asp:ListItem Text="5" Value="5" Selected="True"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                            <div class="form-group">
                                <label for="txtComment">Nhận xét:</label>
                                <asp:TextBox ID="txtComment" runat="server" TextMode="MultiLine" Rows="5" CssClass="form-control"></asp:TextBox>
                            </div>
                            <asp:Button ID="btnSubmitReview" runat="server" Text="Gửi đánh giá" CssClass="btn-submit-review" OnClick="btnSubmitReview_Click" />
                        </asp:Panel>
                    </div>
                </asp:Panel>
            </div>
        </div>
        
        <div class="related-products">
            <h2 class="section-title">Sản phẩm liên quan</h2>
            <div class="product-grid">
                <asp:Repeater ID="rptRelatedProducts" runat="server">
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
                                <p class="product-price"><%# Eval("Price", "{0:N0} ₫") %></p>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>
    <asp:Label ID="lblReviewError" runat="server" CssClass="text-danger" Visible="false"></asp:Label>
<asp:Label ID="lblReviewSuccess" runat="server" CssClass="text-success" Visible="false"></asp:Label>

// Đảm bảo có btnAddToWishlist trong form
<asp:Button ID="btnAddToWishlist" runat="server" Text="Thêm vào yêu thích" CssClass="btn-add-wishlist" OnClick="btnAddToWishlist_Click" />
</asp:Content>