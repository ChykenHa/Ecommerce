<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="OnlineShop.Login" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập/Đăng ký - Radian Shop</title>
    <style>
        /* CSS Variables and Base Styles */
        :root {
            /* Color scheme based on blue gradient */
            --primary: #0077B6;            
            --primary-light: #00B4D8;      
            --primary-dark: #03045E;       
            --secondary: #90E0EF;          
            --secondary-light: #CAF0F8;    
            --accent: #48CAE4;             
            --text-dark: #03045E;          
            --text-medium: #0077B6;        
            --text-light: #ffffff;
            --bg-light: #F0FAFF;           
            --bg-highlight: #E1F5FE;       
            --border-light: #CAF0F8;       
            
            /* Shadows */
            --shadow-sm: 0 1px 3px rgba(0, 0, 0, 0.1);
            --shadow-md: 0 4px 6px rgba(0, 0, 0, 0.1);
            --shadow-lg: 0 10px 15px rgba(0, 0, 0, 0.1);
            --shadow-xl: 0 20px 25px rgba(0, 0, 0, 0.15);
            
            /* Font and measurements */
            --font-primary: 'Segoe UI', 'Helvetica Neue', Arial, sans-serif;
            --radius-sm: 4px;
            --radius-md: 8px;
            --radius-lg: 12px;
            --radius-xl: 20px;
            --radius-circle: 50%;
            
            --transition-fast: 0.15s ease;
            --transition-normal: 0.3s ease;
            --transition-slow: 0.5s ease;
        }
        
        * {
            box-sizing: border-box;
            font-family: var(--font-primary);
        }
        
        body {
            margin: 0;
            padding: 0;
            background-image: url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNjI2IiBoZWlnaHQ9IjYyNiIgdmlld0JveD0iMCAwIDYyNiA2MjYiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CjxyZWN0IHdpZHRoPSI2MjYiIGhlaWdodD0iNjI2IiBmaWxsPSJ1cmwoI3BhaW50MF9saW5lYXJfMTAzXzE0KSIvPgo8ZGVmcz4KPGxpbmVhckdyYWRpZW50IGlkPSJwYWludDBfbGluZWFyXzEwM18xNCIgeDE9IjMxMyIgeTE9IjAiIHgyPSIzMTMiIHkyPSI2MjYiIGdyYWRpZW50VW5pdHM9InVzZXJTcGFjZU9uVXNlIj4KPHN0b3Agc3RvcC1jb2xvcj0iIzkzQzVGRCIvPgo8c3RvcCBvZmZzZXQ9IjEiIHN0b3AtY29sb3I9IiM2Nzk2RkYiLz4KPC9saW5lYXJHcmFkaWVudD4KPC9kZWZzPgo8L3N2Zz4K');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            color: var(--text-dark);
            line-height: 1.6;
            -webkit-font-smoothing: antialiased;
            min-height: 100vh;
            position: relative;
        }

        /* Background overlay with the shopping illustration */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-image: url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iODAwIiBoZWlnaHQ9IjYwMCIgdmlld0JveD0iMCAwIDgwMCA2MDAiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CjxyZWN0IHdpZHRoPSI4MDAiIGhlaWdodD0iNjAwIiBmaWxsPSIjOTNCNUZEIi8+CjxjaXJjbGUgY3g9IjQwMCIgY3k9IjMwMCIgcj0iMjAwIiBmaWxsPSIjNjc5NkZGIiBvcGFjaXR5PSIwLjMiLz4KPGNpcmNsZSBjeD0iNjAwIiBjeT0iMTAwIiByPSIxMDAiIGZpbGw9IiM5M0M1RkQiIG9wYWNpdHk9IjAuNSIvPgo8Y2lyY2xlIGN4PSIyMDAiIGN5PSI1MDAiIHI9IjgwIiBmaWxsPSIjNjc5NkZGIiBvcGFjaXR5PSIwLjQiLz4KPCEtLSBTaG9wcGluZyBjYXJ0IGljb24gLS0+CjxyZWN0IHg9IjM1MCIgeT0iMjcwIiB3aWR0aD0iMTAwIiBoZWlnaHQ9IjYwIiBmaWxsPSIjRkY3QTAwIiByeD0iMTAiIC8+CjxjaXJjbGUgY3g9IjM2NSIgY3k9IjM0NSIgcj0iMTAiIGZpbGw9IiMzMzMiLz4KPGNpcmNsZSBjeD0iNDM1IiBjeT0iMzQ1IiByPSIxMCIgZmlsbD0iIzMzMyIvPgo8IS0tIE1vYmlsZSBwaG9uZSAtLT4KPHJlY3QgeD0iNTAwIiB5PSIyMDAiIHdpZHRoPSI4MCIgaGVpZ2h0PSIxNDAiIGZpbGw9IiMyNTYwRkYiIHJ4PSIxNSIgLz4KPHJlY3QgeD0iNTEwIiB5PSIyMjAiIHdpZHRoPSI2MCIgaGVpZ2h0PSI4MCIgZmlsbD0iIzY3OTZGRiIgcng9IjUiIC8+CjwhLS0gQ3JlZGl0IGNhcmQgLS0+CjxyZWN0IHg9IjI1MCIgeT0iMTUwIiB3aWR0aD0iMTAwIiBoZWlnaHQ9IjYwIiBmaWxsPSIjRkY3QTAwIiByeD0iOCIgLz4KPHJlY3QgeD0iMjYwIiB5PSIxNjAiIHdpZHRoPSI4MCIgaGVpZ2h0PSI0MCIgZmlsbD0iIzIxNDNGRiIgcng9IjQiIC8+CjwhLS0gR2lmdCBib3hlcyAtLT4KPHJlY3QgeD0iMTUwIiB5PSIzNTAiIHdpZHRoPSI2MCIgaGVpZ2h0PSI2MCIgZmlsbD0iI0ZGN0EwMCIgcng9IjUiIC8+CjxyZWN0IHg9IjIzMCIgeT0iMzgwIiB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIGZpbGw9IiM2Nzk2RkYiIHJ4PSI1IiAvPgo8IS0tIFNob3BwaW5nIGJhZyAtLT4KPHJlY3QgeD0iNjAwIiB5PSIzNTAiIHdpZHRoPSI2MCIgaGVpZ2h0PSI4MCIgZmlsbD0iIzIxNDNGRiIgcng9IjEwIiAvPgo8IS0tIERlY29yYXRpdmUgZWxlbWVudHMgLS0+CjxjaXJjbGUgY3g9IjE1MCIgY3k9IjE1MCIgcj0iMjAiIGZpbGw9IiNGRkZGRkYiIG9wYWNpdHk9IjAuNiIvPgo8Y2lyY2xlIGN4PSI2NTAiIGN5PSI0NTAiIHI9IjE1IiBmaWxsPSIjRkZGRkZGIiBvcGFjaXR5PSIwLjQiLz4KPC9zdmc+');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            z-index: -1;
            opacity: 0.9;
        }
        
        .container {
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            position: relative;
            z-index: 1;
        }
        
        header {
            background-color: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            color: white;
            padding: 25px 0;
            border-radius: var(--radius-xl);
            margin-bottom: 40px;
            box-shadow: var(--shadow-xl);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        h1 {
            text-align: center;
            margin: 0;
            font-size: 3rem;
            text-shadow: 2px 2px 10px rgba(0, 0, 0, 0.3);
            font-weight: 700;
            background: linear-gradient(135deg, #fff, #e0f0ff);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        
        .auth-container {
            display: flex;
            justify-content: center;
            gap: 40px;
            flex-wrap: wrap;
            margin: 60px 0;
        }
        
        .auth-card {
            background-color: rgba(255, 255, 255, 0.25);
            backdrop-filter: blur(25px);
            -webkit-backdrop-filter: blur(25px);
            border-radius: var(--radius-xl);
            overflow: hidden;
            box-shadow: var(--shadow-xl);
            width: 100%;
            max-width: 420px;
            padding: 40px;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            border: 1px solid rgba(255, 255, 255, 0.3);
            position: relative;
        }

        .auth-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, 
                rgba(255, 255, 255, 0.1) 0%, 
                rgba(255, 255, 255, 0.05) 50%, 
                rgba(255, 255, 255, 0.1) 100%);
            border-radius: var(--radius-xl);
            z-index: -1;
        }
        
        .auth-card:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.2);
            background-color: rgba(255, 255, 255, 0.3);
        }
        
        .card-header {
            margin-bottom: 30px;
            text-align: center;
        }
        
        .card-header h2 {
            color: var(--text-dark);
            margin-bottom: 12px;
            font-size: 2rem;
            font-weight: 700;
            text-shadow: 1px 1px 3px rgba(255, 255, 255, 0.8);
        }
        
        .card-header p {
            color: var(--text-medium);
            margin: 0;
            font-size: 1.1rem;
            font-weight: 500;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-label {
            display: block;
            margin-bottom: 10px;
            font-weight: 700;
            color: var(--text-dark);
            font-size: 1rem;
            text-shadow: 1px 1px 2px rgba(255, 255, 255, 0.7);
        }
        
        .form-control {
            width: 100%;
            padding: 15px 18px;
            border: 2px solid rgba(255, 255, 255, 0.4);
            border-radius: var(--radius-lg);
            font-size: 1rem;
            transition: all var(--transition-normal);
            background-color: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            color: var(--text-dark);
            font-weight: 500;
        }
        
        .form-control::placeholder {
            color: rgba(3, 4, 94, 0.6);
        }
        
        .form-control:focus {
            border-color: var(--primary);
            outline: none;
            box-shadow: 0 0 0 4px rgba(0, 119, 182, 0.2);
            background-color: rgba(255, 255, 255, 0.95);
            transform: translateY(-2px);
        }
        
        .form-check {
            display: flex;
            align-items: center;
            margin-bottom: 25px;
        }
        
        .form-check-input {
            margin-right: 10px;
            transform: scale(1.2);
        }
        
        .form-check-label {
            color: var(--text-medium);
            font-weight: 600;
            text-shadow: 1px 1px 2px rgba(255, 255, 255, 0.7);
        }
        
        .button {
            padding: 15px 25px;
            border: none;
            border-radius: var(--radius-lg);
            font-weight: bold;
            cursor: pointer;
            transition: all var(--transition-normal);
            font-size: 1.1rem;
            width: 100%;
            position: relative;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .button:active {
            transform: scale(0.98);
        }
        
        .primary-button {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white;
            box-shadow: var(--shadow-lg);
            border: 2px solid rgba(255, 255, 255, 0.2);
        }
        
        .primary-button:hover {
            background: linear-gradient(135deg, var(--primary-light), var(--primary));
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(0, 119, 182, 0.4);
        }
        
        .primary-button::before {
            content: '►';
            margin-right: 10px;
            display: inline-block;
            transition: transform var(--transition-normal);
            font-size: 0.9em;
        }
        
        .primary-button:hover::before {
            transform: translateX(5px);
        }
        
        .social-login {
            margin-top: 30px;
            text-align: center;
        }
        
        .social-login p {
            color: var(--text-medium);
            margin-bottom: 20px;
            position: relative;
            font-weight: 600;
            text-shadow: 1px 1px 2px rgba(255, 255, 255, 0.7);
        }
        
        .social-login p:before,
        .social-login p:after {
            content: "";
            display: inline-block;
            width: 35%;
            height: 2px;
            background: linear-gradient(to right, transparent, rgba(255, 255, 255, 0.6), transparent);
            vertical-align: middle;
            margin: 0 12px;
        }
        
        .social-buttons {
            display: flex;
            justify-content: center;
            gap: 20px;
        }
        
        .social-button {
            width: 50px;
            height: 50px;
            border-radius: var(--radius-circle);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.4rem;
            font-weight: bold;
            transition: all var(--transition-normal);
            box-shadow: var(--shadow-md);
            border: 2px solid rgba(255, 255, 255, 0.3);
        }
        
        .social-button:hover {
            transform: scale(1.15) translateY(-3px);
            box-shadow: var(--shadow-xl);
        }
        
        .facebook {
            background: linear-gradient(135deg, #4267B2, #3B5998);
        }
        
        .google {
            background: linear-gradient(135deg, #EA4335, #DB4437);
        }
        
        .auth-footer {
            text-align: center;
            margin-top: 30px;
        }
        
        .forgot-password {
            text-align: right;
            margin-bottom: 25px;
        }
        
        .forgot-password a {
            color: var(--text-medium);
            text-decoration: none;
            font-size: 0.95rem;
            font-weight: 600;
            transition: all var(--transition-fast);
            text-shadow: 1px 1px 2px rgba(255, 255, 255, 0.7);
        }
        
        .forgot-password a:hover {
            color: var(--primary);
            text-decoration: underline;
        }
        
        .home-button {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 15px 30px;
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.9), rgba(255, 255, 255, 0.7));
            color: var(--primary-dark);
            text-decoration: none;
            border-radius: var(--radius-lg);
            margin-top: 25px;
            transition: all var(--transition-normal);
            font-weight: 700;
            box-shadow: var(--shadow-lg);
            border: 2px solid rgba(255, 255, 255, 0.5);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
        }
        
        .home-button:hover {
            background: linear-gradient(135deg, rgba(255, 255, 255, 1), rgba(255, 255, 255, 0.9));
            transform: translateY(-3px);
            box-shadow: var(--shadow-xl);
        }
        
        .home-button::before {
            content: '◄';
            margin-right: 10px;
            display: inline-block;
            transition: transform var(--transition-normal);
            font-size: 0.9em;
        }
        
        .home-button:hover::before {
            transform: translateX(-5px);
        }
        
        footer {
            margin-top: 50px;
            text-align: center;
            color: white;
            font-size: 1rem;
            background-color: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            padding: 20px 0;
            border-radius: var(--radius-xl);
            border: 1px solid rgba(255, 255, 255, 0.2);
            font-weight: 600;
            text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.3);
        }
        
        @media (max-width: 768px) {
            .auth-container {
                gap: 30px;
                margin: 40px 0;
            }
            
            .auth-card {
                padding: 30px 25px;
            }
            
            h1 {
                font-size: 2.5rem;
            }
        }
        
        /* Validation styling */
        .validator-error {
            color: #DC3545;
            font-size: 0.85rem;
            margin-top: 8px;
            display: block;
            position: relative;
            padding-left: 1.8em;
            font-weight: 600;
            text-shadow: 1px 1px 2px rgba(255, 255, 255, 0.8);
        }
        
        .validator-error::before {
            content: "!";
            position: absolute;
            left: 0;
            width: 1.3em;
            height: 1.3em;
            background: #DC3545;
            color: white;
            border-radius: 50%;
            text-align: center;
            line-height: 1.3em;
            font-size: 0.8em;
            font-weight: bold;
        }

        /* Floating elements animation */
        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
        }

        .auth-card {
            animation: float 6s ease-in-out infinite;
        }

        /* Glassmorphism enhancement */
        .auth-card::after {
            content: '';
            position: absolute;
            top: 1px;
            left: 1px;
            right: 1px;
            height: 50%;
            background: linear-gradient(180deg, rgba(255, 255, 255, 0.15) 0%, transparent 100%);
            border-radius: var(--radius-xl) var(--radius-xl) 0 0;
            pointer-events: none;
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