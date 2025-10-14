<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.master" AutoEventWireup="true" CodeBehind="ThanhToan.aspx.cs" Inherits="OnlineShop.ThanhToan" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeaderContent" runat="server">
    <title>Thanh Toán - Radian Shop</title>
</asp:Content>

<asp:Content ID="ContentSidebar" ContentPlaceHolderID="SidebarContent" runat="server">
    <div class="info-form-section">
        <h3 class="info-header">
            <i class="fas fa-map-marker-alt"></i> Thông Tin Giao Hàng
        </h3>
        
        <div class="form-list">
            <div class="form-field">
                <label>Họ và tên <span class="req">*</span></label>
                <asp:TextBox ID="txtFullName" runat="server" CssClass="input-box" placeholder="Nguyễn Văn A" />
                <asp:RequiredFieldValidator ID="rfvFullName" runat="server" 
                    ControlToValidate="txtFullName" 
                    ErrorMessage="*Bắt buộc" 
                    CssClass="err-msg" 
                    Display="Dynamic" />
            </div>

            <div class="form-field">
                <label>Số điện thoại <span class="req">*</span></label>
                <asp:TextBox ID="txtPhone" runat="server" CssClass="input-box" placeholder="0123456789" />
                <asp:RequiredFieldValidator ID="rfvPhone" runat="server" 
                    ControlToValidate="txtPhone" 
                    ErrorMessage="*Bắt buộc" 
                    CssClass="err-msg" 
                    Display="Dynamic" />
            </div>

            <div class="form-field">
                <label>Email</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="input-box" placeholder="email@example.com" />
            </div>

            <div class="form-field">
                <label>Địa chỉ <span class="req">*</span></label>
                <asp:TextBox ID="txtAddress" runat="server" CssClass="input-box" placeholder="Số nhà, tên đường" />
                <asp:RequiredFieldValidator ID="rfvAddress" runat="server" 
                    ControlToValidate="txtAddress" 
                    ErrorMessage="*Bắt buộc" 
                    CssClass="err-msg" 
                    Display="Dynamic" />
            </div>

            <div class="form-field">
                <label>Tỉnh/Thành phố <span class="req">*</span></label>
                <asp:DropDownList ID="ddlCity" runat="server" CssClass="input-box">
                    <asp:ListItem Value="">-- Chọn --</asp:ListItem>
                    <asp:ListItem Value="HN">Hà Nội</asp:ListItem>
                    <asp:ListItem Value="HCM">TP. Hồ Chí Minh</asp:ListItem>
                    <asp:ListItem Value="DN">Đà Nẵng</asp:ListItem>
                    <asp:ListItem Value="HP">Hải Phòng</asp:ListItem>
                    <asp:ListItem Value="CT">Cần Thơ</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvCity" runat="server" 
                    ControlToValidate="ddlCity" 
                    InitialValue=""
                    ErrorMessage="*Bắt buộc" 
                    CssClass="err-msg" 
                    Display="Dynamic" />
            </div>

            <div class="form-field">
                <label>Quận/Huyện <span class="req">*</span></label>
                <asp:DropDownList ID="ddlDistrict" runat="server" CssClass="input-box">
                    <asp:ListItem Value="">-- Chọn --</asp:ListItem>
                    <asp:ListItem Value="1">Quận 1</asp:ListItem>
                    <asp:ListItem Value="2">Quận 2</asp:ListItem>
                    <asp:ListItem Value="3">Quận 3</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvDistrict" runat="server" 
                    ControlToValidate="ddlDistrict" 
                    InitialValue=""
                    ErrorMessage="*Bắt buộc" 
                    CssClass="err-msg" 
                    Display="Dynamic" />
            </div>

            <div class="form-field">
                <label>Ghi chú</label>
                <asp:TextBox ID="txtNote" runat="server" TextMode="MultiLine" Rows="3" 
                    CssClass="input-box" placeholder="Ghi chú (tùy chọn)" />
            </div>
        </div>
    </div>

    <style>
        /* Override sidebar pseudo-elements */
        .sidebar::before,
        .sidebar::after {
            display: none !important;
        }

        .info-form-section {
            width: 100%;
            position: relative;
            z-index: 10;
        }

        .info-header {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 14px;
            border-radius: 10px;
            text-align: center;
            font-size: 1em;
            margin: 0 0 12px 0;
            font-weight: 700;
            box-shadow: 0 3px 10px rgba(102, 126, 234, 0.3);
        }

        .info-header i {
            margin-right: 6px;
        }

        .form-list {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .form-field {
            background: white;
            padding: 12px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .form-field label {
            display: block;
            font-weight: 600;
            font-size: 0.9em;
            color: #2d3436;
            margin-bottom: 6px;
        }

        .req {
            color: #e74c3c;
        }

        .input-box {
            width: 100%;
            padding: 10px 12px;
            border: 2px solid #dfe6e9;
            border-radius: 8px;
            font-size: 0.95em;
            transition: all 0.3s;
        }

        .input-box:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .err-msg {
            color: #e74c3c;
            font-size: 0.8em;
            margin-top: 4px;
            display: block;
        }
    </style>
 </asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="checkout-page">
        <div class="checkout-header">
            <h2><i class="fas fa-credit-card"></i> Thanh Toán</h2>
            <div class="checkout-steps">
                <div class="step active">
                    <i class="fas fa-shopping-cart"></i>
                    <span>Giỏ hàng</span>
                </div>
                <div class="step active">
                    <i class="fas fa-shipping-fast"></i>
                    <span>Thông tin</span>
                    </div>
                <div class="step">
                    <i class="fas fa-check-circle"></i>
                    <span>Hoàn thành</span>
            </div>
        </div>
    </div>

        <!-- Payment Method -->
        <div class="payment-section">
            <h3><i class="fas fa-wallet"></i> Phương Thức Thanh Toán</h3>
            <asp:RadioButtonList ID="rblPaymentMethod" runat="server" CssClass="payment-methods">
                <asp:ListItem Value="COD" Selected="True">💵 Thanh toán khi nhận hàng (COD)</asp:ListItem>
                <asp:ListItem Value="BANK">🏦 Chuyển khoản ngân hàng</asp:ListItem>
                <asp:ListItem Value="MOMO">📱 Ví MoMo</asp:ListItem>
                <asp:ListItem Value="CARD">💳 Thẻ tín dụng/Ghi nợ</asp:ListItem>
            </asp:RadioButtonList>
        </div>

        <!-- Applied Voucher Info -->
        <asp:Panel ID="pnlVoucherInfo" runat="server" Visible="false" CssClass="voucher-info-box">
            <i class="fas fa-tag"></i>
            <div class="voucher-info-text">
                <strong>Mã giảm giá:</strong> 
                <asp:Label ID="lblVoucherCode" runat="server"></asp:Label>
            </div>
        </asp:Panel>

        <!-- Order Summary -->
        <div class="order-summary-box">
            <h3><i class="fas fa-receipt"></i> Đơn Hàng</h3>
            
            <div class="order-items-list">
                <asp:Repeater ID="rptOrderItems" runat="server">
                    <ItemTemplate>
                        <div class="order-product">
                            <asp:Image ID="img" runat="server" ImageUrl='<%# Eval("ImageUrl") %>' CssClass="order-img" />
                            <div class="order-info">
                                <div class="order-name"><%# Eval("ProductName") %></div>
                                <div class="order-qty">SL: <%# Eval("Quantity") %></div>
                            </div>
                            <div class="order-price"><%# string.Format("{0:N0}", (decimal)Eval("Price") * (int)Eval("Quantity")) %>₫</div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <div class="order-calc">
                <div class="calc-row">
                    <span>Tạm tính:</span>
                    <span><asp:Label ID="lblSubtotal" runat="server">0</asp:Label>₫</span>
                </div>
                <div class="calc-row">
                    <span>Phí ship:</span>
                    <span class="free"><asp:Label ID="lblShipping" runat="server">0</asp:Label>₫</span>
                </div>
                <div class="calc-row discount-calc">
                    <span>Giảm giá:</span>
                    <span class="discount-amt">-<asp:Label ID="lblDiscount" runat="server">0</asp:Label>₫</span>
                </div>
                <hr />
                <div class="calc-row final">
                    <span>Tổng thanh toán:</span>
                    <span class="final-amt"><asp:Label ID="lblTotal" runat="server">0</asp:Label>₫</span>
                </div>
            </div>

            <div class="terms-section">
                <asp:CheckBox ID="chkAgree" runat="server" />
                <label for="chkAgree" style="margin-left: 8px; font-size: 0.9em;">
                    Tôi đồng ý với điều khoản
                </label>
                <asp:CustomValidator ID="cvAgree" runat="server" 
                    ErrorMessage="*Vui lòng đồng ý điều khoản" 
                    CssClass="err-msg" 
                    Display="Dynamic"
                    ClientValidationFunction="ValidateAgree" />
            </div>

            <asp:Button ID="btnPlaceOrder" runat="server" Text="Đặt Hàng Ngay" 
                CssClass="btn-place-order" OnClick="btnPlaceOrder_Click" />          
            
            <a href="GioHang.aspx" class="btn-back-cart">
                <i class="fas fa-arrow-left"></i> Quay lại giỏ hàng
            </a>
        </div>
    </div>

    <style>
        .checkout-page {
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
        }

        .checkout-header {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 25px;
            border-radius: 12px;
            text-align: center;
            margin-bottom: 25px;
        }

        .checkout-header h2 {
            margin: 0 0 20px 0;
            font-size: 2em;
        }

        .checkout-steps {
            display: flex;
            justify-content: center;
            gap: 40px;
        }

        .step {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 8px;
            opacity: 0.5;
        }

        .step.active {
            opacity: 1;
        }

        .step i {
            font-size: 2em;
        }

        .step span {
            font-size: 0.9em;
        }

        /* Payment Section */
        .payment-section {
            background: white;
            padding: 25px;
            border-radius: 12px;
            margin-bottom: 20px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }

        .payment-section h3 {
            margin: 0 0 20px 0;
            color: #2d3436;
            font-size: 1.3em;
        }

        .payment-section h3 i {
            margin-right: 8px;
            color: #667eea;
        }

        .payment-methods {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .payment-methods input[type="radio"] {
            display: none;
        }

        .payment-methods label {
            display: block;
            padding: 15px 20px;
            background: #f8f9fa;
            border: 2px solid #dfe6e9;
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.3s;
            font-weight: 600;
            color: #2d3436;
        }

        .payment-methods input[type="radio"]:checked + label {
            background: #f0f3ff;
            border-color: #667eea;
            color: #667eea;
        }

        .payment-methods label:hover {
            border-color: #667eea;
        }

        /* Voucher Info Box */
        .voucher-info-box {
            background: linear-gradient(135deg, #d4edda, #c3e6cb);
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            border: 2px solid #28a745;
            display: flex;
            align-items: center;
            gap: 12px;
            box-shadow: 0 3px 10px rgba(40, 167, 69, 0.15);
        }

        .voucher-info-box i {
            font-size: 1.5em;
            color: #28a745;
        }

        .voucher-info-text {
            flex: 1;
            color: #155724;
            font-size: 1em;
        }

        .voucher-info-text strong {
            font-weight: 700;
        }

        /* Order Summary */
        .order-summary-box {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }

        .order-summary-box h3 {
            margin: 0 0 20px 0;
            color: #2d3436;
            font-size: 1.3em;
            padding-bottom: 15px;
            border-bottom: 2px solid #f0f0f0;
        }

        .order-summary-box h3 i {
            margin-right: 8px;
            color: #667eea;
        }

        .order-items-list {
            max-height: 300px;
            overflow-y: auto;
            margin-bottom: 20px;
        }

        .order-items-list::-webkit-scrollbar {
            width: 6px;
        }

        .order-items-list::-webkit-scrollbar-thumb {
            background: #667eea;
            border-radius: 3px;
        }

        .order-product {
            display: flex;
            gap: 12px;
            padding: 12px 0;
            border-bottom: 1px solid #f0f0f0;
        }

        .order-product:last-child {
            border-bottom: none;
        }

        .order-img {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 8px;
        }

        .order-info {
            flex: 1;
        }

        .order-name {
            font-weight: 600;
            font-size: 0.95em;
            color: #2d3436;
            margin-bottom: 4px;
        }

        .order-qty {
            font-size: 0.85em;
            color: #636e72;
        }

        .order-price {
            font-weight: 700;
            color: #e74c3c;
        }

        .order-calc {
            margin: 20px 0;
        }

        .calc-row {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            color: #636e72;
        }

        .free {
            color: #27ae60;
            font-weight: 600;
        }

        .discount-calc {
            background: #f0fff4;
            padding: 12px 15px;
            border-radius: 8px;
            margin: 8px 0;
        }

        .discount-amt {
            color: #27ae60;
            font-weight: 700;
        }

        .order-calc hr {
            border: none;
            border-top: 2px solid #f0f0f0;
            margin: 15px 0;
        }

        .final {
            font-size: 1.3em;
            font-weight: 700;
            color: #2d3436;
        }

        .final-amt {
            color: #e74c3c;
        }

        .terms-section {
            margin: 20px 0;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 8px;
        }

        .btn-place-order {
            width: 100%;
            padding: 16px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1.15em;
            font-weight: 700;
            cursor: pointer;
            margin-bottom: 12px;
            transition: all 0.3s;
        }

        .btn-place-order:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        .btn-back-cart {
            display: block;
            text-align: center;
            padding: 12px;
            color: #667eea;
            text-decoration: none;
            border: 2px solid #667eea;
            border-radius: 10px;
            font-weight: 600;
            transition: all 0.3s;
        }

        .btn-back-cart:hover {
            background: #667eea;
            color: white;
        }

        .btn-back-cart i {
            margin-right: 6px;
        }

        @media (max-width: 768px) {
            .checkout-steps {
                gap: 20px;
            }
            .step span {
                font-size: 0.75em;
            }
        }
    </style>

    <script>
        function ValidateAgree(source, args) {
            var checkbox = document.getElementById('<%= chkAgree.ClientID %>');
            args.IsValid = checkbox.checked;
        }
    </script>
</asp:Content>
