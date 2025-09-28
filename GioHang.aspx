    <%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GioHang.aspx.cs" Inherits="OnlineShop.GioHang" MasterPageFile="~/Site1.master" %>
    <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <div class="cart-page">
            <div class="cart-header">
                <h2><i class="fas fa-shopping-cart"></i> Giỏ Hàng Của Bạn</h2>
                <p class="cart-subtitle">Xem lại các sản phẩm bạn đã chọn</p>
            </div>

            <div class="cart-container">
              <asp:Repeater ID="rptCart" runat="server" OnItemCommand="rptCart_ItemCommand">
    <ItemTemplate>
        <div class="cart-item">
            <div class="product-image-container">
                <asp:Image ID="imgProduct" runat="server" ImageUrl='<%# Eval("ImageUrl") %>' CssClass="product-image" AlternateText='<%# Eval("ProductName") %>' />
                <div class="image-overlay">
                    <i class="fas fa-eye"></i>
                </div>
            </div>

            <div class="product-details">
                <div class="product-header">
                    <h4 class="product-name"><%# Eval("ProductName") %></h4>
                    <div class="product-badge">
                        <span class="badge-text">Còn hàng</span>
                    </div>
                </div>

                <div class="price-section">
                    <span class="price-label">Đơn giá:</span>
                    <span class="price"><%# Eval("Price", "{0:N0}") %>₫</span>
                </div>

                <div class="quantity-section">
                    <label class="quantity-label">Số lượng:</label>
                    <div class="quantity-controls">
                        <asp:Button ID="btnDecrease" runat="server" Text="-" CssClass="qty-btn" 
                            CommandName="Decrease" CommandArgument='<%# Eval("ProductId") %>' />
                        <asp:TextBox ID="txtQuantity" runat="server" Text='<%# Eval("Quantity") %>' CssClass="quantity-input" />
                        <asp:Button ID="btnIncrease" runat="server" Text="+" CssClass="qty-btn" 
                            CommandName="Increase" CommandArgument='<%# Eval("ProductId") %>' />
                        <asp:Button ID="btnUpdateQuantity" runat="server" Text="Cập nhật" 
                            CommandName="UpdateQuantity" CommandArgument='<%# Eval("ProductId") %>' CssClass="btn-update" />
                    </div>
                </div>

                <div class="total-section">
                    <span class="total-label">Thành tiền:</span>
                    <span class="total-price">
                        <%# string.Format("{0:N0}", (decimal)Eval("Price") * (int)Eval("Quantity")) %>₫
                    </span>
                </div>

                <div class="action-section">
                    <asp:Button ID="btnRemove" runat="server" Text="Xóa khỏi giỏ" 
                        CommandName="Remove" CommandArgument='<%# Eval("ProductId") %>' CssClass="btn-remove" 
                        OnClientClick="return confirm('Bạn có chắc muốn xóa sản phẩm này?');" />
                    <button type="button" class="btn-favorite" title="Thêm vào yêu thích">
                        <i class="far fa-heart"></i>
                    </button>
                </div>
            </div>

            <div class="gift-section">
                <div class="gift-header">
                    <i class="fas fa-gift"></i>
                    <h5>Quà tặng khuyến mãi</h5>
                </div>
                <div class="gift-list">
                    <asp:Repeater ID="rptGifts" runat="server" DataSource='<%# Eval("Gifts") %>'>
                        <ItemTemplate>
                            <div class="gift-item">
                                <i class="fas fa-check-circle"></i>
                                <span class="gift-name"><%# Eval("GiftName") %></span>
                                <span class="gift-value">(Trị giá: <%# Eval("GiftValue", "{0:N0}") %>₫)</span>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
    </ItemTemplate>
</asp:Repeater>


                <div class="empty-cart" style="display: none;">
                    <i class="fas fa-shopping-cart"></i>
                    <h3>Giỏ hàng của bạn đang trống</h3>
                    <p>Hãy thêm sản phẩm vào giỏ hàng để tiếp tục mua sắm</p>
                    <a href="Products.aspx" class="btn-continue-shopping">Tiếp tục mua sắm</a>
                </div>
            </div>

            <div class="cart-summary">
                <div class="summary-content">
                    <div class="summary-row">
                        <span class="summary-label">Tạm tính:</span>
                        <span class="summary-value"><asp:Label ID="lblSubtotal" runat="server" Text="0"></asp:Label>₫</span>
                    </div>
                    <div class="summary-row">
                        <span class="summary-label">Phí vận chuyển:</span>
                        <span class="summary-value">Miễn phí</span>
                    </div>
                    <div class="summary-row discount-row">
                        <span class="summary-label">Giảm giá:</span>
                        <span class="summary-value discount">-<asp:Label ID="lblDiscount" runat="server" Text="0"></asp:Label>₫</span>
                    </div>
                    <div class="summary-divider"></div>
                    <div class="summary-row total-row">
                        <span class="summary-label">Tổng cộng:</span>
                        <span class="summary-value total"><asp:Label ID="lblTotal" runat="server" Text="0"></asp:Label>₫</span>
                    </div>
                
                    <div class="checkout-section">
                        <asp:Button ID="btnCheckout" runat="server" Text="Đặt Hàng Ngay" CssClass="btn-checkout" OnClick="btnCheckout_Click" />
                        <a href="Home.aspx" class="btn-continue">Tiếp tục mua sắm</a>
                    </div>
                
                    <div class="security-info">
                        <i class="fas fa-shield-alt"></i>
                        <span>Thanh toán an toàn & bảo mật</span>
                    </div>
                </div>
            </div>
        </div>

        <style>
            .cart-page {
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .cart-header {
                text-align: center;
                margin-bottom: 30px;
                padding: 20px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border-radius: 15px;
            }

            .cart-header h2 {
                margin: 0;
                font-size: 2.5em;
                font-weight: 700;
            }

            .cart-header i {
                margin-right: 10px;
            }

            .cart-subtitle {
                margin: 10px 0 0 0;
                opacity: 0.9;
                font-size: 1.1em;
            }

            .cart-container {
                display: flex;
                flex-direction: column;
                gap: 20px;
                margin-bottom: 30px;
            }

            .cart-item {
                display: grid;
                grid-template-columns: 200px 1fr 300px;
                gap: 20px;
                background: white;
                border-radius: 15px;
                padding: 25px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .cart-item:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(0,0,0,0.15);
            }

            .product-image-container {
                position: relative;
                overflow: hidden;
                border-radius: 12px;
            }

            .product-image {
                width: 100%;
                height: 200px;
                object-fit: cover;
                border-radius: 12px;
                transition: transform 0.3s ease;
            }

            .product-image:hover {
                transform: scale(1.05);
            }

            .image-overlay {
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: rgba(0,0,0,0.7);
                display: flex;
                align-items: center;
                justify-content: center;
                opacity: 0;
                transition: opacity 0.3s ease;
                border-radius: 12px;
            }

            .image-overlay:hover {
                opacity: 1;
            }

            .image-overlay i {
                color: white;
                font-size: 2em;
            }

            .product-details {
                display: flex;
                flex-direction: column;
                gap: 15px;
            }

            .product-header {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
            }

            .product-name {
                margin: 0;
                font-size: 1.4em;
                font-weight: 600;
                color: #333;
                line-height: 1.3;
            }

            .product-badge {
                background: #4CAF50;
                color: white;
                padding: 4px 12px;
                border-radius: 20px;
                font-size: 0.8em;
                font-weight: 500;
            }

            .price-section, .total-section {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .price-label, .quantity-label, .total-label {
                font-weight: 500;
                color: #666;
            }

            .price, .total-price {
                font-size: 1.3em;
                font-weight: 700;
                color: #e74c3c;
            }

            .quantity-section {
                display: flex;
                flex-direction: column;
                gap: 8px;
            }

            .quantity-controls {
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .qty-btn {
                width: 35px;
                height: 35px;
                border: 2px solid #ddd;
                background: white;
                border-radius: 50%;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: bold;
                transition: all 0.3s ease;
            }

            .qty-btn:hover {
                border-color: #667eea;
                background: #667eea;
                color: white;
            }

            .quantity-input {
                width: 60px;
                padding: 8px;
                border: 2px solid #ddd;
                border-radius: 6px;
                text-align: center;
                font-weight: 600;
            }

            .btn-update {
                background: #3498db;
                color: white;
                border: none;
                padding: 8px 16px;
                border-radius: 6px;
                cursor: pointer;
                font-weight: 500;
                transition: background 0.3s ease;
            }

            .btn-update:hover {
                background: #2980b9;
            }

            .action-section {
                display: flex;
                gap: 10px;
                align-items: center;
                margin-top: auto;
            }

            .btn-remove {
                background: #e74c3c;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 6px;
                cursor: pointer;
                font-weight: 500;
                transition: background 0.3s ease;
                flex-grow: 1;
            }

            .btn-remove:hover {
                background: #c0392b;
            }

            .btn-favorite {
                width: 40px;
                height: 40px;
                border: 2px solid #ddd;
                background: white;
                border-radius: 6px;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: all 0.3s ease;
            }

            .btn-favorite:hover {
                border-color: #e74c3c;
                color: #e74c3c;
            }

            .gift-section {
                background: #f8f9fa;
                padding: 20px;
                border-radius: 10px;
                border-left: 4px solid #ff6b6b;
            }

            .gift-header {
                display: flex;
                align-items: center;
                gap: 8px;
                margin-bottom: 15px;
            }

            .gift-header h5 {
                margin: 0;
                color: #333;
                font-weight: 600;
            }

            .gift-header i {
                color: #ff6b6b;
                font-size: 1.2em;
            }

            .gift-list {
                display: flex;
                flex-direction: column;
                gap: 8px;
            }

            .gift-item {
                display: flex;
                align-items: center;
                gap: 8px;
                padding: 8px 0;
            }

            .gift-item i {
                color: #4CAF50;
                font-size: 0.9em;
            }

            .gift-name {
                font-weight: 500;
                color: #333;
            }

            .gift-value {
                color: #666;
                font-size: 0.9em;
            }

            .cart-summary {
                background: white;
                border-radius: 15px;
                padding: 30px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                position: sticky;
                top: 20px;
            }

            .summary-content {
                max-width: 400px;
                margin: 0 auto;
            }

            .summary-row {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 12px 0;
            }

            .summary-label {
                font-weight: 500;
                color: #666;
            }

            .summary-value {
                font-weight: 600;
                color: #333;
            }

            .discount {
                color: #4CAF50;
            }

            .total-row {
                font-size: 1.3em;
            }

            .total-row .summary-value {
                color: #e74c3c;
                font-weight: 700;
            }

            .summary-divider {
                height: 1px;
                background: #ddd;
                margin: 15px 0;
            }

            .checkout-section {
                margin-top: 25px;
                display: flex;
                flex-direction: column;
                gap: 15px;
            }

            .btn-checkout {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border: none;
                padding: 15px 30px;
                border-radius: 8px;
                cursor: pointer;
                font-size: 1.1em;
                font-weight: 600;
                transition: transform 0.3s ease;
            }

            .btn-checkout:hover {
                transform: translateY(-2px);
            }

            .btn-continue {
                text-align: center;
                color: #667eea;
                text-decoration: none;
                font-weight: 500;
                padding: 12px;
                border: 2px solid #667eea;
                border-radius: 8px;
                transition: all 0.3s ease;
            }

            .btn-continue:hover {
                background: #667eea;
                color: white;
            }

            .security-info {
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 8px;
                margin-top: 20px;
                color: #666;
                font-size: 0.9em;
            }

            .security-info i {
                color: #4CAF50;
            }

            .empty-cart {
                text-align: center;
                padding: 60px 20px;
                color: #666;
            }

            .empty-cart i {
                font-size: 4em;
                margin-bottom: 20px;
                opacity: 0.3;
            }

            .btn-continue-shopping {
                background: #667eea;
                color: white;
                padding: 12px 30px;
                border-radius: 8px;
                text-decoration: none;
                display: inline-block;
                margin-top: 20px;
                transition: background 0.3s ease;
            }

            .btn-continue-shopping:hover {
                background: #5a6fd8;
            }

            @media (max-width: 768px) {
                .cart-item {
                    grid-template-columns: 1fr;
                    gap: 15px;
                }
            
                .product-image-container {
                    max-width: 200px;
                    margin: 0 auto;
                }
            
                .cart-header h2 {
                    font-size: 2em;
                }
            }
        </style>

        <script>
            function increaseQuantity(btn) {
                const input = btn.previousElementSibling;
                input.value = parseInt(input.value) + 1;
            }

            function decreaseQuantity(btn) {
                const input = btn.nextElementSibling;
                if (parseInt(input.value) > 1) {
                    input.value = parseInt(input.value) - 1;
                }
            }
        </script>
    </asp:Content>