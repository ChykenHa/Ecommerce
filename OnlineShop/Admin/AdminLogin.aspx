<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="OnlineShop.AdminLogin" %>

<!DOCTYPE html>
<html lang="vi">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Admin Login - Radian Shop</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .login-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            padding: 3rem;
            width: 100%;
            max-width: 400px;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .login-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .login-logo {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
            color: white;
            font-size: 2rem;
        }

        .login-title {
            font-size: 1.8rem;
            font-weight: 700;
            color: #333;
            margin-bottom: 0.5rem;
        }

        .login-subtitle {
            color: #666;
            font-size: 0.9rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            font-weight: 600;
            color: #333;
            margin-bottom: 0.5rem;
        }

        .form-control {
            border: 2px solid #e1e5e9;
            border-radius: 10px;
            padding: 0.75rem 1rem;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.8);
        }

        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
            background: white;
        }

        .input-group {
            position: relative;
        }

        .input-group .form-control {
            padding-left: 3rem;
        }

        .input-group-icon {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: #999;
            z-index: 10;
        }

        .btn-login {
            background: linear-gradient(135deg, #667eea, #764ba2);
            border: none;
            border-radius: 10px;
            padding: 0.75rem 2rem;
            font-size: 1rem;
            font-weight: 600;
            color: white;
            width: 100%;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }

        .btn-login:active {
            transform: translateY(0);
        }

        .alert {
            border-radius: 10px;
            border: none;
            margin-bottom: 1rem;
        }

        .alert-danger {
            background: rgba(220, 53, 69, 0.1);
            color: #721c24;
            border-left: 4px solid #dc3545;
        }

        .login-footer {
            text-align: center;
            margin-top: 2rem;
            padding-top: 1rem;
            border-top: 1px solid #e1e5e9;
        }

        .login-footer a {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
        }

        .login-footer a:hover {
            text-decoration: underline;
        }

        .floating-shapes {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: -1;
        }

        .shape {
            position: absolute;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            animation: float 6s ease-in-out infinite;
        }

        .shape:nth-child(1) {
            width: 80px;
            height: 80px;
            top: 20%;
            left: 10%;
            animation-delay: 0s;
        }

        .shape:nth-child(2) {
            width: 120px;
            height: 120px;
            top: 60%;
            right: 10%;
            animation-delay: 2s;
        }

        .shape:nth-child(3) {
            width: 60px;
            height: 60px;
            bottom: 20%;
            left: 20%;
            animation-delay: 4s;
        }

        @keyframes float {
            0%, 100% {
                transform: translateY(0px) rotate(0deg);
            }
            50% {
                transform: translateY(-20px) rotate(180deg);
            }
        }

        @media (max-width: 480px) {
            .login-container {
                margin: 1rem;
                padding: 2rem;
            }
        }
    </style>
</head>
<body>
    <div class="floating-shapes">
        <div class="shape"></div>
        <div class="shape"></div>
        <div class="shape"></div>
    </div>

    <div class="login-container">
        <div class="login-header">
            <div class="login-logo">
                <i class="fas fa-shield-alt"></i>
            </div>
            <h1 class="login-title">Admin Login</h1>
            <p class="login-subtitle">Đăng nhập vào hệ thống quản trị</p>
        </div>

        <form runat="server">
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            
            <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="alert alert-danger">
                <i class="fas fa-exclamation-triangle"></i>
                <asp:Label ID="lblError" runat="server"></asp:Label>
            </asp:Panel>

            <div class="form-group">
                <label class="form-label">Tên đăng nhập</label>
                <div class="input-group">
                    <i class="fas fa-user input-group-icon"></i>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Nhập tên đăng nhập" required></asp:TextBox>
                </div>
            </div>

            <div class="form-group">
                <label class="form-label">Mật khẩu</label>
                <div class="input-group">
                    <i class="fas fa-lock input-group-icon"></i>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Nhập mật khẩu" required></asp:TextBox>
                </div>
            </div>

            <div class="form-group">
                <div class="form-check">
                    <asp:CheckBox ID="chkRememberMe" runat="server" CssClass="form-check-input" />
                    <label class="form-check-label" for="<%= chkRememberMe.ClientID %>">
                        Ghi nhớ đăng nhập
                    </label>
                </div>
            </div>

            <asp:Button ID="btnLogin" runat="server" Text="Đăng nhập" CssClass="btn-login" OnClick="btnLogin_Click" />
        </form>

        <div class="login-footer">
            <p>
                <a href="../Home.aspx">
                    <i class="fas fa-arrow-left"></i>
                    Quay lại trang chủ
                </a>
            </p>
            <p class="mt-2">
                <small>© 2025 Radian Shop. Tất cả quyền được bảo lưu.</small>
            </p>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
