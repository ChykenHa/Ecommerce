<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="OnlineShop.Login" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập/Đăng ký - Radian Shop</title>
    
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
    <form id="form2" runat="server">
        <div class="container">
            <header>
                <h1>Radian Shop</h1>
            </header>
            
            <div class="auth-container">
                <div class="auth-card">
                    <div class="tab-content active">
                        <div class="card-header">
                            <h2>Đăng nhập</h2>
                            <p>Đăng nhập để tiếp tục mua sắm</p>
                        </div>
                        
                        <div class="form-group">
                            <asp:Label ID="lblUsername" runat="server" CssClass="form-label" Text="Tên đăng nhập hoặc Email"></asp:Label>
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Nhập tên đăng nhập hoặc email"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="CheckUserName" runat="server" ControlToValidate="txtUsername" ErrorMessage="Bắt buộc" ForeColor="#DC3545" CssClass="validator-error"></asp:RequiredFieldValidator>
                        </div>
                        
                        <div class="form-group">
                            <asp:Label ID="lblPassword" runat="server" CssClass="form-label" Text="Mật khẩu"></asp:Label>
                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Nhập mật khẩu"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="CheckPassword" runat="server" ErrorMessage="Không được để trống" ControlToValidate="txtPassword" CssClass="validator-error"></asp:RequiredFieldValidator>
                        </div>
                        
                        <div class="form-check">
                            <asp:CheckBox ID="chkRemember" runat="server" CssClass="form-check-input" />
                            <asp:Label ID="lblRemember" runat="server" CssClass="form-check-label" Text="Ghi nhớ đăng nhập" AssociatedControlID="chkRemember"></asp:Label>
                        </div>
                        
                        <div class="forgot-password">
                            <a href="#">Quên mật khẩu?</a>
                        </div>
                        
                        <asp:Button ID="btnLogin" runat="server" Text="Đăng nhập" CssClass="button primary-button" OnClick="btnLogin_Click" />
                        
                        <div class="social-login">
                            <p>Hoặc đăng nhập với</p>
                            <div class="social-buttons">
                                <asp:LinkButton ID="btnFacebook" runat="server" CssClass="social-button facebook">F</asp:LinkButton>
                                <asp:LinkButton ID="btnGoogle" runat="server" CssClass="social-button google">G</asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
                
            <div class="auth-footer">
                <a href="Home.aspx" class="home-button">Quay lại Trang chủ</a>
            </div>
            
            <footer>
                <p>© 2025 Radian Shop. Tất cả các quyền được bảo lưu.</p>
            </footer>
        </div>
    </form>
</body>
</html>