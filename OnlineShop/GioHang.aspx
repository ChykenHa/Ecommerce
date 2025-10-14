    <%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GioHang.aspx.cs" Inherits="OnlineShop.GioHang" MasterPageFile="~/Site1.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SidebarContent" runat="server">
    <div class="voucher-section">
        <h3 class="voucher-header">
            <i class="fas fa-tag"></i> Mã Giảm Giá Hôm Nay
        </h3>
        
        <div class="voucher-container">
            <asp:LinkButton ID="lnkVoucher1" runat="server" CssClass="voucher-link" OnClick="ApplyVoucher" CommandArgument="SAVE30K">
                <div class="voucher-box">
                    <div class="voucher-icon bg-blue">30K</div>
                    <div class="voucher-text">
                        <div class="voucher-title">Tiết Kiệm 30K</div>
                        <div class="voucher-desc">Đơn từ 200K</div>
                    </div>
                </div>
            </asp:LinkButton>

            <asp:LinkButton ID="lnkVoucher2" runat="server" CssClass="voucher-link" OnClick="ApplyVoucher" CommandArgument="SAVE70K">
                <div class="voucher-box">
                    <div class="voucher-icon bg-green">70K</div>
                    <div class="voucher-text">
                        <div class="voucher-title">Giảm 70K</div>
                        <div class="voucher-desc">Đơn từ 600K</div>
                    </div>
                </div>
            </asp:LinkButton>

            <asp:LinkButton ID="lnkVoucher3" runat="server" CssClass="voucher-link" OnClick="ApplyVoucher" CommandArgument="MEGA120K">
                <div class="voucher-box">
                    <div class="voucher-icon bg-orange">120K</div>
                    <div class="voucher-text">
                        <div class="voucher-title">Mega Sale</div>
                        <div class="voucher-desc">Đơn từ 1tr</div>
                    </div>
                </div>
            </asp:LinkButton>

            <asp:LinkButton ID="lnkVoucher4" runat="server" CssClass="voucher-link" OnClick="ApplyVoucher" CommandArgument="VIP250K">
                <div class="voucher-box">
                    <div class="voucher-icon bg-purple">250K</div>
                    <div class="voucher-text">
                        <div class="voucher-title">VIP Member</div>
                        <div class="voucher-desc">Đơn từ 2.5tr</div>
                    </div>
                </div>
            </asp:LinkButton>

            <asp:LinkButton ID="lnkVoucher5" runat="server" CssClass="voucher-link" OnClick="ApplyVoucher" CommandArgument="DISCOUNT8">
                <div class="voucher-box">
                    <div class="voucher-icon bg-teal">8%</div>
                    <div class="voucher-text">
                        <div class="voucher-title">Giảm 8%</div>
                        <div class="voucher-desc">Đơn từ 300K</div>
                    </div>
                </div>
            </asp:LinkButton>

            <asp:LinkButton ID="lnkVoucher6" runat="server" CssClass="voucher-link" OnClick="ApplyVoucher" CommandArgument="SALE12">
                <div class="voucher-box">
                    <div class="voucher-icon bg-red">12%</div>
                    <div class="voucher-text">
                        <div class="voucher-title">Hot Sale</div>
                        <div class="voucher-desc">Đơn từ 500K</div>
                    </div>
                </div>
            </asp:LinkButton>

            <asp:LinkButton ID="lnkVoucher7" runat="server" CssClass="voucher-link" OnClick="ApplyVoucher" CommandArgument="SUPER18">
                <div class="voucher-box">
                    <div class="voucher-icon bg-indigo">18%</div>
                    <div class="voucher-text">
                        <div class="voucher-title">Super Deal</div>
                        <div class="voucher-desc">Đơn từ 800K</div>
                    </div>
                </div>
            </asp:LinkButton>

            <asp:LinkButton ID="lnkVoucher8" runat="server" CssClass="voucher-link" OnClick="ApplyVoucher" CommandArgument="ULTRA25">
                <div class="voucher-box voucher-special">
                    <div class="voucher-icon bg-gold">25%</div>
                    <div class="voucher-text">
                        <div class="voucher-title">Ultra Sale</div>
                        <div class="voucher-desc">Max 400K</div>
                    </div>
                </div>
            </asp:LinkButton>

            <asp:LinkButton ID="lnkVoucher9" runat="server" CssClass="voucher-link" OnClick="ApplyVoucher" CommandArgument="NEWBIE">
                <div class="voucher-box">
                    <div class="voucher-icon bg-cyan">90K</div>
                    <div class="voucher-text">
                        <div class="voucher-title">Khách Mới</div>
                        <div class="voucher-desc">Giảm 90K</div>
                    </div>
                </div>
            </asp:LinkButton>

            <asp:LinkButton ID="lnkVoucher10" runat="server" CssClass="voucher-link" OnClick="ApplyVoucher" CommandArgument="FREESHIP">
                <div class="voucher-box">
                    <div class="voucher-icon bg-lime">🚚</div>
                    <div class="voucher-text">
                        <div class="voucher-title">Free Ship</div>
                        <div class="voucher-desc">Giảm 35K</div>
                    </div>
                </div>
            </asp:LinkButton>

            <asp:LinkButton ID="lnkVoucher11" runat="server" CssClass="voucher-link" OnClick="ApplyVoucher" CommandArgument="WEEKEND">
                <div class="voucher-box">
                    <div class="voucher-icon bg-pink">15%</div>
                    <div class="voucher-text">
                        <div class="voucher-title">Weekend</div>
                        <div class="voucher-desc">Max 180K</div>
                    </div>
                </div>
            </asp:LinkButton>

            <asp:LinkButton ID="lnkVoucher12" runat="server" CssClass="voucher-link" OnClick="ApplyVoucher" CommandArgument="FLASH40">
                <div class="voucher-box voucher-special">
                    <div class="voucher-icon bg-fire">40%</div>
                    <div class="voucher-text">
                        <div class="voucher-title">🔥 Flash Sale</div>
                        <div class="voucher-desc">Max 600K</div>
                    </div>
                </div>
            </asp:LinkButton>
        </div>
    </div>

    <style>
        /* Override sidebar pseudo-elements */
        .sidebar::before,
        .sidebar::after {
            display: none !important;
        }

        .voucher-section {
            width: 100%;
            position: relative;
            z-index: 10;
        }

        .voucher-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 14px;
            border-radius: 10px;
            text-align: center;
            font-size: 1em;
            margin: 0 0 12px 0;
            font-weight: 700;
            box-shadow: 0 3px 10px rgba(102, 126, 234, 0.3);
            position: relative;
            z-index: 11;
        }

        .voucher-header i {
            margin-right: 6px;
        }

        .voucher-container {
            display: flex;
            flex-direction: column;
            gap: 10px;
            position: relative;
            z-index: 10;
        }

        .voucher-link {
            text-decoration: none !important;
            display: block;
            position: relative;
            z-index: 15;
        }

        .voucher-box {
            background: white !important;
            border-radius: 10px;
            padding: 12px;
            display: flex;
            align-items: center;
            gap: 12px;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            border: 2px solid transparent;
            position: relative;
            z-index: 20;
        }

        .voucher-link:hover .voucher-box {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.25);
            border-color: #667eea;
        }

        .voucher-link:active .voucher-box {
            transform: scale(0.98);
        }

        .voucher-icon {
            width: 55px;
            height: 55px;
            min-width: 55px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 800;
            font-size: 1em;
            color: white;
            box-shadow: 0 3px 10px rgba(0,0,0,0.15);
        }

        .voucher-text {
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 3px;
        }

        .voucher-title {
            font-weight: 700;
            font-size: 0.95em;
            color: #2d3436;
            line-height: 1.3;
        }

        .voucher-desc {
            font-size: 0.8em;
            color: #636e72;
            line-height: 1.2;
        }

        /* Special Vouchers with Border */
        .voucher-special {
            border: 2px solid #ffd700 !important;
            animation: pulse-glow 2s ease-in-out infinite;
        }

        @keyframes pulse-glow {
            0%, 100% { 
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            }
            50% { 
                box-shadow: 0 0 20px rgba(255, 215, 0, 0.5);
            }
        }

        /* Icon Background Colors */
        .bg-blue { background: linear-gradient(135deg, #4A90E2, #357ABD); }
        .bg-green { background: linear-gradient(135deg, #27ae60, #1e8449); }
        .bg-orange { background: linear-gradient(135deg, #f39c12, #e67e22); }
        .bg-purple { background: linear-gradient(135deg, #9b59b6, #8e44ad); }
        .bg-teal { background: linear-gradient(135deg, #1abc9c, #16a085); }
        .bg-red { background: linear-gradient(135deg, #e74c3c, #c0392b); }
        .bg-indigo { background: linear-gradient(135deg, #5f5fc4, #4527a0); }
        .bg-gold { background: linear-gradient(135deg, #f39c12, #d4af37); }
        .bg-cyan { background: linear-gradient(135deg, #00d2ff, #00a8cc); }
        .bg-lime { background: linear-gradient(135deg, #52c234, #3ea822); }
        .bg-pink { background: linear-gradient(135deg, #ff6b9d, #c44569); }
        .bg-fire { background: linear-gradient(135deg, #ff4757, #ee5a6f); }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <div class="cart-page">
            <div class="cart-header">
                <h2><i class="fas fa-shopping-cart"></i> Giỏ Hàng Của Bạn</h2>
            <p>Chọn mã giảm giá từ sidebar để nhận ưu đãi tốt nhất</p>
            </div>

        <!-- Applied Voucher Display -->
        <asp:Panel ID="pnlAppliedVoucher" runat="server" Visible="false" CssClass="voucher-applied">
            <div class="applied-icon">
                <i class="fas fa-check-circle"></i>
            </div>
            <div class="applied-info">
                <span class="applied-label">Đã áp dụng mã:</span>
                <span class="applied-code"><asp:Label ID="lblAppliedCode" runat="server"></asp:Label></span>
                <span class="applied-discount">Tiết kiệm: <strong><asp:Label ID="lblAppliedDiscount" runat="server"></asp:Label>₫</strong></span>
            </div>
            <asp:LinkButton ID="btnRemoveVoucher" runat="server" CssClass="remove-voucher" OnClick="RemoveVoucher_Click">
                <i class="fas fa-times"></i>
            </asp:LinkButton>
        </asp:Panel>

        <!-- Cart Items -->
        <div class="cart-items-wrapper">
              <asp:Repeater ID="rptCart" runat="server" OnItemCommand="rptCart_ItemCommand">
    <ItemTemplate>
                    <div class="product-card">
                        <div class="product-image-section">
                            <asp:Image ID="imgProduct" runat="server" ImageUrl='<%# Eval("ImageUrl") %>' CssClass="product-img" />
                            <div class="product-badge">Còn hàng</div>
            </div>

                        <div class="product-info-section">
                <div class="product-header">
                                <h3 class="product-name"><%# Eval("ProductName") %></h3>
                                <asp:Button ID="btnDel" runat="server" Text="🗑️" CssClass="btn-remove" 
                                    CommandName="Remove" CommandArgument='<%# Eval("ProductId") %>' 
                                    OnClientClick="return confirm('Bạn có chắc muốn xóa?');" />
                </div>

                            <div class="product-pricing">
                                <div class="price-label">Đơn giá</div>
                                <div class="price-value"><%# Eval("Price", "{0:N0}") %>₫</div>
                </div>

                            <div class="product-quantity-section">
                                <div class="qty-label">Số lượng</div>
                                <div class="qty-controls">
                                    <asp:Button ID="btnDec" runat="server" Text="−" CssClass="qty-control-btn" 
                            CommandName="Decrease" CommandArgument='<%# Eval("ProductId") %>' />
                                    <asp:TextBox ID="txtQty" runat="server" Text='<%# Eval("Quantity") %>' 
                                        CssClass="qty-display" ReadOnly="true" />
                                    <asp:Button ID="btnInc" runat="server" Text="+" CssClass="qty-control-btn" 
                            CommandName="Increase" CommandArgument='<%# Eval("ProductId") %>' />
                    </div>
                </div>

                            <div class="product-total-section">
                                <div class="total-label">Thành tiền</div>
                                <div class="total-value"><%# string.Format("{0:N0}", (decimal)Eval("Price") * (int)Eval("Quantity")) %>₫</div>
                </div>
            </div>
        </div>
    </ItemTemplate>
</asp:Repeater>
        </div>

        <asp:Panel ID="pnlEmptyCart" runat="server" Visible="false" CssClass="empty-cart">
                    <i class="fas fa-shopping-cart"></i>
            <h3>Giỏ hàng trống</h3>
                    <p>Hãy thêm sản phẩm vào giỏ hàng để tiếp tục mua sắm</p>
            <a href="SanPham.aspx" class="btn-shop">
                <i class="fas fa-shopping-bag"></i> Khám Phá Sản Phẩm
            </a>
        </asp:Panel>

        <!-- Summary -->
            <div class="cart-summary">
            <h3><i class="fas fa-receipt"></i> Tổng Đơn Hàng</h3>
            <div class="sum-row">
                <span>Tạm tính:</span>
                <span class="sum-value"><asp:Label ID="lblSubtotal" runat="server">0</asp:Label>₫</span>
                    </div>
            <div class="sum-row">
                <span>Phí vận chuyển:</span>
                <span class="sum-value shipping-free">Miễn phí</span>
                    </div>
            <div class="sum-row discount-row">
                <span><i class="fas fa-tag"></i> Giảm giá:</span>
                <span class="sum-value discount-value">-<asp:Label ID="lblDiscount" runat="server">0</asp:Label>₫</span>
                    </div>
            <hr class="divider" />
            <div class="sum-row total-row">
                <span>Tổng thanh toán:</span>
                <span class="total-amount"><asp:Label ID="lblTotal" runat="server">0</asp:Label>₫</span>
                    </div>
                        <asp:Button ID="btnCheckout" runat="server" Text="Đặt Hàng Ngay" CssClass="btn-checkout" OnClick="btnCheckout_Click" />
            <a href="SanPham.aspx" class="btn-back">
                <i class="fas fa-arrow-left"></i> Tiếp Tục Mua Sắm
            </a>
            </div>
        </div>

        <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

            .cart-page {
            max-width: 1100px;
                margin: 0 auto;
            padding: 25px;
            background: #f8f9fa;
            min-height: 100vh;
            }

            .cart-header {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
            padding: 30px;
                border-radius: 15px;
            text-align: center;
            margin-bottom: 25px;
            box-shadow: 0 8px 24px rgba(102, 126, 234, 0.25);
            }

            .cart-header h2 {
            margin: 0 0 8px 0;
            font-size: 2em;
                font-weight: 700;
            }

        .cart-header h2 i {
                margin-right: 10px;
            }

        .cart-header p {
            margin: 0;
            opacity: 0.95;
            font-size: 1.05em;
        }

        /* Applied Voucher */
        .voucher-applied {
            background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
            color: #155724;
            padding: 18px 22px;
            border-radius: 12px;
            margin-bottom: 25px;
                display: flex;
            align-items: center;
            gap: 15px;
            border: 2px solid #28a745;
            box-shadow: 0 4px 12px rgba(40, 167, 69, 0.15);
            animation: slideDown 0.4s ease;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .applied-icon i {
            font-size: 2em;
            color: #28a745;
            animation: checkmark 0.5s ease;
        }

        @keyframes checkmark {
            0% { transform: scale(0); }
            50% { transform: scale(1.2); }
            100% { transform: scale(1); }
        }

        .applied-info {
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

        .applied-label {
            font-size: 0.9em;
            opacity: 0.9;
        }

        .applied-code {
            font-size: 1.15em;
            font-weight: 700;
            color: #0c5c20;
        }

        .applied-discount {
            font-size: 0.95em;
        }

        .applied-discount strong {
            color: #28a745;
            font-size: 1.1em;
        }

        .remove-voucher {
            background: #dc3545;
            color: white;
            width: 36px;
            height: 36px;
            border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
            text-decoration: none;
            font-size: 1.2em;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
        }

        .remove-voucher:hover {
            background: #c82333;
            transform: rotate(90deg) scale(1.1);
        }

        /* Cart Items Wrapper */
        .cart-items-wrapper {
            margin-bottom: 25px;
        }

        /* Product Card - Modern Design */
        .product-card {
            background: white;
            border-radius: 16px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
            display: flex;
            gap: 25px;
            border: 2px solid transparent;
        }

        .product-card:hover {
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.15);
            transform: translateY(-3px);
            border-color: #667eea;
        }

        /* Image Section */
        .product-image-section {
            position: relative;
            flex-shrink: 0;
        }

        .product-img {
            width: 150px;
            height: 150px;
            object-fit: cover;
            border-radius: 12px;
            border: 3px solid #f0f3ff;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .product-badge {
            position: absolute;
            top: -8px;
            right: -8px;
            background: linear-gradient(135deg, #27ae60, #229954);
                color: white;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.75em;
            font-weight: 700;
            box-shadow: 0 2px 8px rgba(39, 174, 96, 0.3);
        }

        /* Product Info Section */
        .product-info-section {
            flex: 1;
                display: flex;
                flex-direction: column;
                gap: 15px;
            }

            .product-header {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
            gap: 15px;
            }

            .product-name {
                margin: 0;
            color: #2d3436;
            font-size: 1.3em;
            font-weight: 700;
            line-height: 1.4;
            flex: 1;
        }

        .btn-remove {
            background: #fff5f5;
            color: #e74c3c;
            border: 2px solid #ffe5e5;
            width: 40px;
            height: 40px;
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .btn-remove:hover {
            background: #e74c3c;
                color: white;
            border-color: #e74c3c;
            transform: rotate(90deg) scale(1.1);
        }

        .btn-remove {
            font-size: 1.4em;
        }

        /* Pricing Section */
        .product-pricing {
            background: #f8f9fa;
            padding: 12px 18px;
            border-radius: 10px;
            border-left: 4px solid #667eea;
        }

        .price-label {
            font-size: 0.85em;
            color: #636e72;
            font-weight: 600;
            margin-bottom: 5px;
        }

        .price-value {
                color: #e74c3c;
            font-size: 1.5em;
            font-weight: 800;
        }

        /* Quantity Section */
        .product-quantity-section {
            background: #f8f9fa;
            padding: 12px 18px;
            border-radius: 10px;
            border-left: 4px solid #27ae60;
        }

        .qty-label {
            font-size: 0.85em;
            color: #636e72;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .qty-controls {
                display: flex;
                align-items: center;
            gap: 12px;
        }

        .qty-control-btn {
            width: 38px;
            height: 38px;
                background: white;
            border: 2px solid #dfe6e9;
            border-radius: 10px;
                cursor: pointer;
            transition: all 0.3s ease;
                display: flex;
                align-items: center;
                justify-content: center;
            color: #2d3436;
            font-size: 1.3em;
            font-weight: 700;
            }

        .qty-control-btn:hover {
            background: #667eea;
                border-color: #667eea;
                color: white;
            transform: scale(1.1);
        }

        .qty-display {
            width: 70px;
            padding: 10px;
                text-align: center;
            border: 2px solid #dfe6e9;
            border-radius: 10px;
            font-weight: 800;
            font-size: 1.2em;
            background: white;
            color: #2d3436;
        }

        /* Total Section */
        .product-total-section {
            background: linear-gradient(135deg, #fff5f5, #ffe5e5);
            padding: 15px 18px;
            border-radius: 10px;
            border-left: 4px solid #e74c3c;
        }

        .total-label {
            font-size: 0.9em;
            color: #636e72;
            font-weight: 600;
            margin-bottom: 5px;
        }

        .total-value {
            color: #e74c3c;
            font-size: 1.8em;
            font-weight: 800;
        }

        /* Empty Cart */
        .empty-cart {
            background: white;
            padding: 60px 40px;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 3px 12px rgba(0,0,0,0.08);
        }

        .empty-cart i {
            font-size: 4em;
            color: #dfe6e9;
            margin-bottom: 20px;
        }

        .empty-cart h3 {
            color: #636e72;
            margin-bottom: 10px;
            font-size: 1.5em;
        }

        .empty-cart p {
            color: #b2bec3;
            margin-bottom: 25px;
            font-size: 1.05em;
        }

        .btn-shop {
            display: inline-block;
            padding: 14px 35px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            text-decoration: none;
                border-radius: 10px;
            font-weight: 600;
            font-size: 1.05em;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
        }

        .btn-shop:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
        }

        .btn-shop i {
            margin-right: 8px;
        }

        /* Summary */
        .cart-summary {
            background: white;
            padding: 28px;
            border-radius: 15px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.08);
            margin-top: 20px;
        }

        .cart-summary h3 {
            margin: 0 0 22px 0;
            padding-bottom: 18px;
            border-bottom: 2px solid #f0f0f0;
            color: #2d3436;
            font-size: 1.3em;
        }

        .cart-summary h3 i {
            margin-right: 10px;
            color: #667eea;
        }

        .sum-row {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            color: #636e72;
            font-size: 1.05em;
        }

        .sum-value {
            font-weight: 600;
            color: #2d3436;
        }

        .shipping-free {
            color: #27ae60;
            font-weight: 700;
        }

        .discount-row {
            background: #f0fff4;
            padding: 12px 15px;
            border-radius: 8px;
            margin: 8px 0;
            border: 1px solid #c6f6d5;
        }

        .discount-row span:first-child {
            color: #27ae60;
            font-weight: 600;
        }

        .discount-row i {
            margin-right: 6px;
        }

        .discount-value {
            color: #27ae60 !important;
            font-weight: 700 !important;
            font-size: 1.1em;
        }

        .divider {
            border: none;
            border-top: 2px solid #e9ecef;
            margin: 18px 0;
            }

            .total-row {
            font-size: 1.35em;
            font-weight: 700;
            color: #2d3436;
            padding: 15px 0;
            }

        .total-amount {
                color: #e74c3c;
            font-size: 1.15em;
            }

            .btn-checkout {
            width: 100%;
            padding: 16px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border: none;
            border-radius: 12px;
            font-size: 1.15em;
            font-weight: 700;
                cursor: pointer;
            margin: 22px 0 12px 0;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            }

            .btn-checkout:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
        }

        .btn-checkout:active {
            transform: translateY(-1px);
        }

        .btn-back {
            display: block;
                text-align: center;
            padding: 14px;
                color: #667eea;
                text-decoration: none;
                border: 2px solid #667eea;
            border-radius: 12px;
            font-weight: 600;
                transition: all 0.3s ease;
            }

        .btn-back i {
            margin-right: 8px;
        }

        .btn-back:hover {
                background: #667eea;
                color: white;
            transform: translateX(-5px);
        }

        @media (max-width: 768px) {
            .cart-page {
                padding: 15px;
            }

            .cart-header {
                padding: 20px;
            }

            .cart-header h2 {
                font-size: 1.5em;
            }

            .product-card {
                flex-direction: column;
                padding: 20px;
                gap: 20px;
            }

            .product-image-section {
                width: 100%;
            }

            .product-img {
                width: 100%;
                height: 200px;
            }

            .product-badge {
                top: 10px;
                right: 10px;
            }

            .product-header {
                flex-direction: column-reverse;
                align-items: stretch;
            }

            .btn-remove {
                align-self: flex-end;
            }

            .voucher-applied {
                flex-direction: column;
                text-align: center;
                gap: 10px;
            }

            .applied-info {
                align-items: center;
            }

            .cart-summary {
                padding: 20px;
            }

            .voucher-box {
                padding: 12px;
            }

            .voucher-icon {
                width: 50px;
                height: 50px;
            }
        }
    </style>
    </asp:Content>