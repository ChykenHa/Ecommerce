<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="OnlineShop.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
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
            background-image: url('https://i.imgur.com/your-shopping-background.jpg');
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

        /* Background overlay with shopping illustration */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, #93C5FD 0%, #6796FF 100%);
            z-index: -2;
        }

        body::after {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-image: url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iODAwIiBoZWlnaHQ9IjYwMCIgdmlld0JveD0iMCAwIDgwMCA2MDAiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CjxyZWN0IHdpZHRoPSI4MDAiIGhlaWdodD0iNjAwIiBmaWxsPSJ0cmFuc3BhcmVudCIvPgo8IS0tIFNob3BwaW5nIGlsbHVzdHJhdGlvbiBlbGVtZW50cyAtLT4KPGNpcmNsZSBjeD0iNzAwIiBjeT0iMTAwIiByPSI4MCIgZmlsbD0iIzAwNzdCNiIgb3BhY2l0eT0iMC4xIi8+CjxjaXJjbGUgY3g9IjEwMCIgY3k9IjUwMCIgcj0iNjAiIGZpbGw9IiM2Nzk2RkYiIG9wYWNpdHk9IjAuMTUiLz4KPGNpcmNsZSBjeD0iNjUwIiBjeT0iNDUwIiByPSI0MCIgZmlsbD0iI0ZGN0EwMCIgb3BhY2l0eT0iMC4yIi8+Cgo8IS0tIE1vYmlsZSBwaG9uZSBpY29uIC0tPgo8ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSg2NTAgMTUwKSI+CiAgPHJlY3Qgd2lkdGg9IjgwIiBoZWlnaHQ9IjE0MCIgZmlsbD0iIzI1NjBGRiIgcng9IjE1IiBvcGFjaXR5PSIwLjMiLz4KICA8cmVjdCB4PSIxMCIgeT0iMjAiIHdpZHRoPSI2MCIgaGVpZ2h0PSI4MCIgZmlsbD0iIzY3OTZGRiIgcng9IjUiIG9wYWNpdHk9IjAuNCIvPgo8L2c+Cgo8IS0tIFNob3BwaW5nIGNhcnQgLS0+CjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKDEwMCAyMDApIj4KICA8cmVjdCB3aWR0aD0iMTAwIiBoZWlnaHQ9IjYwIiBmaWxsPSIjRkY3QTAwIiByeD0iMTAiIG9wYWNpdHk9IjAuMjUiLz4KICA8Y2lyY2xlIGN4PSIxNSIgY3k9Ijc1IiByPSIxMCIgZmlsbD0iIzMzMyIgb3BhY2l0eT0iMC4zIi8+CiAgPGNpcmNsZSBjeD0iODUiIGN5PSI3NSIgcj0iMTAiIGZpbGw9IiMzMzMiIG9wYWNpdHk9IjAuMyIvPgo8L2c+Cgo8IS0tIEdpZnQgYm94ZXMgLS0+CjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKDUwIDQwMCkiPgogIDxyZWN0IHdpZHRoPSI2MCIgaGVpZ2h0PSI2MCIgZmlsbD0iI0ZGN0EwMCIgcng9IjUiIG9wYWNpdHk9IjAuMiIvPgogIDxyZWN0IHg9IjgwIiB5PSIzMCIgd2lkdGg9IjQwIiBoZWlnaHQ9IjQwIiBmaWxsPSIjNjc5NkZGIiByeD0iNSIgb3BhY2l0eT0iMC4yNSIvPgo8L2c+Cgo8IS0tIENyZWRpdCBjYXJkIC0tPgo8ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSg1NTAgMzUwKSI+CiAgPHJlY3Qgd2lkdGg9IjEwMCIgaGVpZ2h0PSI2MCIgZmlsbD0iI0ZGN0EwMCIgcng9IjgiIG9wYWNpdHk9IjAuMiIvPgogIDxyZWN0IHg9IjEwIiB5PSIxMCIgd2lkdGg9IjgwIiBoZWlnaHQ9IjE1IiBmaWxsPSIjMjE0M0ZGIiByeD0iNCIgb3BhY2l0eT0iMC4zIi8+CjwvZz4KCjwhLS0gU2hvcHBpbmcgYmFnIC0tPgo8ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSgyMDAgMzAwKSI+CiAgPHJlY3Qgd2lkdGg9IjYwIiBoZWlnaHQ9IjgwIiBmaWxsPSIjMjE0M0ZGIiByeD0iMTAiIG9wYWNpdHk9IjAuMjUiLz4KICA8Y2lyY2xlIGN4PSIxNSIgY3k9IjIwIiByPSI4IiBmaWxsPSJub25lIiBzdHJva2U9IiNmZmYiIHN0cm9rZS13aWR0aD0iMiIgb3BhY2l0eT0iMC4zIi8+CiAgPGNpcmNsZSBjeD0iNDUiIGN5PSIyMCIgcj0iOCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjZmZmIiBzdHJva2Utd2lkdGg9IjIiIG9wYWNpdHk9IjAuMyIvPgo8L2c+Cgo8IS0tIERlY29yYXRpdmUgY2lyY2xlcyAtLT4KPGNpcmNsZSBjeD0iNDAwIiBjeT0iMTAwIiByPSIxNTAiIGZpbGw9Im5vbmUiIHN0cm9rZT0iI2ZmZmZmZiIgc3Ryb2tlLXdpZHRoPSIyIiBvcGFjaXR5PSIwLjEiLz4KPGNpcmNsZSBjeD0iNjAwIiBjeT0iMjUwIiByPSI4MCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjZmZmZmZmIiBzdHJva2Utd2lkdGg9IjEiIG9wYWNpdHk9IjAuMDgiLz4KPC9zdmc+');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            z-index: -1;
            opacity: 0.8;
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
            max-width: 450px;
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
            margin-top: 20px;
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
        
        .auth-footer {
            text-align: center;
            margin-top: 30px;
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

        /* Enhanced glassmorphism */
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

        /* Login link styling */
        .login-link {
            text-align: center;
            margin-top: 25px;
            padding-top: 20px;
            border-top: 1px solid rgba(255, 255, 255, 0.3);
        }

        .login-link a {
            color: var(--primary-dark);
            text-decoration: none;
            font-weight: 600;
            transition: all var(--transition-fast);
            text-shadow: 1px 1px 2px rgba(255, 255, 255, 0.7);
        }

        .login-link a:hover {
            color: var(--primary);
            text-decoration: underline;
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
