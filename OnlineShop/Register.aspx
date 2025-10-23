<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="OnlineShop.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Ký - Radian Shop</title>
    
    <!-- Login/Register Styles with cache busting -->
    <link href="~/Assets/CSS/login-register-styles.css?v=2025" rel="stylesheet" />
    
    <!-- Force custom gradient background immediately -->
    <style>
        body {
            background: linear-gradient(135deg, 
                #213448 0%,     /* Dark blue from image */
                #547792 35%,    /* Medium blue from image */
                #94B4C1 70%,    /* Light blue from image */
                #ECEFCA 100%    /* Cream from image */
            ) !important;
            background-attachment: fixed !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
        <div class="auth-container">
            <div class="auth-card">
                <div class="tab-content active">
                    <div class="card-header">
                 <h2>Đăng ký</h2>
                 <p>Tạo tài khoản mới để mua sắm</p> 
                        </div>
            <div class="form-group">
                <asp:Label ID="lblFullName" runat="server" CssClass="form-label" Text="Họ và tên"></asp:Label>
                <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="Nhập họ và tên"></asp:TextBox>
                <asp:RequiredFieldValidator ID="CheckFullName" runat="server" 
                    ErrorMessage="Không được để trống" 
                    Display="Dynamic" 
                    ControlToValidate="txtFullName" 
                    ForeColor="Red"
                    CssClass="validator-error">
                </asp:RequiredFieldValidator>
            </div>
            <div class="form-group">
                <asp:Label ID="lblEmail" runat="server" CssClass="form-label" Text="Email"></asp:Label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Nhập email"></asp:TextBox>
                <asp:RegularExpressionValidator ID="revEmail" runat="server" 
                    ControlToValidate="txtEmail"
                    ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
                    ErrorMessage="Email không hợp lệ (VD: example@gmail.com)"
                    ForeColor="Red"
                    Display="Dynamic"
                    CssClass="validator-error">
                </asp:RegularExpressionValidator>
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                    ControlToValidate="txtEmail"
                    ErrorMessage="Vui lòng nhập email"
                    Display="Dynamic"
                    ForeColor="Red"
                    CssClass="validator-error">
                </asp:RequiredFieldValidator>
            </div>
            <div class="form-group">
                <asp:Label ID="lblRegUsername" runat="server" CssClass="form-label" Text="Tên đăng nhập"></asp:Label>
                <asp:TextBox ID="txtRegUsername" runat="server" CssClass="form-control" placeholder="Nhập tên đăng nhập"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvUsername" runat="server"
                    ControlToValidate="txtRegUsername"
                    ErrorMessage="Vui lòng nhập tên đăng nhập"
                    Display="Dynamic"
                    ForeColor="Red"
                    CssClass="validator-error">
                </asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revUsername" runat="server"
                    ControlToValidate="txtRegUsername"
                    ValidationExpression="^[a-zA-Z0-9_]{4,20}$"
                    ErrorMessage="Tên đăng nhập phải từ 4-20 ký tự và chỉ chứa chữ cái, số hoặc dấu gạch dưới"
                    ForeColor="Red"
                    Display="Dynamic"
                    CssClass="validator-error">
                </asp:RegularExpressionValidator>
            </div>
            <div class="form-group">
                <asp:Label ID="lblPhone" runat="server" CssClass="form-label" Text="Số điện thoại"></asp:Label>
                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="Nhập số điện thoại"></asp:TextBox>
                <asp:RegularExpressionValidator ID="revPhone" runat="server"
                    ControlToValidate="txtPhone"
                    ValidationExpression="^(0|\+84)\d{9}$"
                    ErrorMessage="Số điện thoại phải bắt đầu bằng 0 hoặc +84 và có tổng cộng 10 chữ số"
                    ForeColor="Red"
                    Display="Dynamic"
                    CssClass="validator-error">
                </asp:RegularExpressionValidator>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"
                    ControlToValidate="txtPhone"
                    ErrorMessage="Vui lòng nhập SĐT"
                    ForeColor="Red"
                    Display="Dynamic"
                    CssClass="validator-error">
                </asp:RequiredFieldValidator>
            </div>
            
            <div class="form-group">
                <asp:Label ID="lblRegPassword" runat="server" CssClass="form-label" Text="Mật khẩu"></asp:Label>
                <asp:TextBox ID="txtRegPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Nhập mật khẩu"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                    ErrorMessage="Không được để trống" 
                    ControlToValidate="txtRegPassword" 
                    Display="Dynamic"
                    ForeColor="Red"
                    CssClass="validator-error">
                 </asp:RequiredFieldValidator>
            </div>
            
            <div class="form-group">
                <asp:Label ID="lblConfirmPassword" runat="server" CssClass="form-label" Text="Xác nhận mật khẩu"></asp:Label>
                <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Nhập lại mật khẩu" ></asp:TextBox>
                <asp:CompareValidator ID="CompareValidator1" runat="server" 
                    ErrorMessage="Mật khẩu không khớp" 
                    ControlToCompare="txtRegPassword" 
                    ControlToValidate="txtConfirmPassword"
                    ForeColor="Red"
                    Display="Dynamic"
                    CssClass="validator-error">
                </asp:CompareValidator>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                    ErrorMessage="Không được để trống" 
                    ControlToValidate="txtConfirmPassword" 
                    Display="Dynamic"
                    ForeColor="Red"
                    CssClass="validator-error">
                </asp:RequiredFieldValidator>
            </div>
            
            <asp:Button ID="btnRegister" runat="server" Text="Đăng ký" CssClass="button primary-button" OnClick="btnRegister_Click" />
        </div>
      </div>
     </div>
    </div>
   </form>
</body>
</html>
