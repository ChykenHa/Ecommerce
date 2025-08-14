<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="OnlineShop.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
      <style>
        /* CSS Variables and Base Styles - Matching Site1.master */
        :root {
            /* Color scheme based on blue gradient */
            --primary: #0077B6;            /* Mid-blue as primary */
            --primary-light: #00B4D8;      /* Brighter blue as light primary */
            --primary-dark: #03045E;       /* Navy blue as dark primary */
            --secondary: #90E0EF;          /* Light blue as secondary */
            --secondary-light: #CAF0F8;    /* Very light cyan as light secondary */
            --accent: #48CAE4;             /* Bright cyan as accent */
            --text-dark: #03045E;          /* Navy blue for dark text */
            --text-medium: #0077B6;        /* Mid-blue for medium text */
            --text-light: #ffffff;
            --bg-light: #F0FAFF;           /* Very light blue background */
            --bg-highlight: #E1F5FE;       /* Light blue highlight background */
            --border-light: #CAF0F8;       /* Light cyan for borders */
            
            /* Background gradient matching the master */
            --gradient-bg: linear-gradient(to bottom, 
                #03045E, /* Navy */
                #0077B6, /* Medium blue */
                #00B4D8, /* Bright blue */
                #90E0EF, /* Light blue */
                #CAF0F8  /* Very light cyan */
            );
            
            /* Shadows */
            --shadow-sm: 0 1px 3px rgba(0, 0, 0, 0.1);
            --shadow-md: 0 4px 6px rgba(0, 0, 0, 0.1);
            --shadow-lg: 0 10px 15px rgba(0, 0, 0, 0.1);
            
            /* Font and measurements */
            --font-primary: 'Segoe UI', 'Helvetica Neue', Arial, sans-serif;
            --radius-sm: 4px;
            --radius-md: 8px;
            --radius-lg: 12px;
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
            background: var(--gradient-bg);
            background-attachment: fixed;
            background-size: cover;
            color: var(--text-dark);
            line-height: 1.6;
            -webkit-font-smoothing: antialiased;
            min-height: 100vh;
        }
        
        .container {
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        header {
            background-color: rgba(0, 119, 182, 0.9);  /* #0077B6 with transparency */
            backdrop-filter: blur(10px);
            color: white;
            padding: 20px 0;
            border-radius: var(--radius-md);
            margin-bottom: 30px;
            box-shadow: var(--shadow-md);
        }
        
        h1 {
            text-align: center;
            margin: 0;
            font-size: 2.5rem;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
        }
        
        .auth-container {
            display: flex;
            justify-content: center;
            gap: 40px;
            flex-wrap: wrap;
            margin: 40px 0;
        }
        
        .auth-card {
            background-color: rgba(255, 255, 255, 0.95);
            border-radius: var(--radius-md);
            overflow: hidden;
            box-shadow: var(--shadow-md);
            width: 100%;
            max-width: 400px;
            padding: 30px;
            transition: transform 0.3s, box-shadow 0.3s;
            backdrop-filter: blur(5px);
            border: 1px solid rgba(255, 255, 255, 0.8);
        }
        
        .auth-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-lg);
        }
        
        .card-header {
            margin-bottom: 25px;
            text-align: center;
        }
        
        .card-header h2 {
            color: var(--text-dark);
            margin-bottom: 10px;
            font-size: 1.8rem;
        }
        
        .card-header p {
            color: var(--text-medium);
            margin: 0;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: var(--text-dark);
        }
        
        .form-control {
            width: 100%;
            padding: 12px;
            border: 1px solid var(--border-light);
            border-radius: var(--radius-md);
            font-size: 1rem;
            transition: border-color var(--transition-normal);
            background-color: white;
        }
        
        .form-control:focus {
            border-color: var(--primary);
            outline: none;
            box-shadow: 0 0 0 3px rgba(0, 119, 182, 0.2);
        }
        
        .form-check {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .form-check-input {
            margin-right: 8px;
        }
        
        .form-check-label {
            color: var(--text-medium);
        }
        
        .button {
            padding: 12px 20px;
            border: none;
            border-radius: var(--radius-md);
            font-weight: bold;
            cursor: pointer;
            transition: all var(--transition-normal);
            font-size: 1rem;
            width: 100%;
            position: relative;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .button:active {
            transform: scale(0.98);
        }
        
        .primary-button {
            background: linear-gradient(to right, var(--primary), var(--primary-dark));
            color: white;
            box-shadow: var(--shadow-sm);
        }
        
        .primary-button:hover {
            background: linear-gradient(to right, var(--primary-light), var(--primary));
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }
        
        .primary-button::before {
            content: '►';
            margin-right: 8px;
            display: inline-block;
            transition: transform var(--transition-normal);
            font-size: 0.8em;
        }
        
        .primary-button:hover::before {
            transform: translateX(3px);
        }
        
        .primary-button::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(to right, var(--primary), var(--accent), var(--secondary), var(--primary-light));
            opacity: 0;
            transition: opacity 0.8s ease;
            z-index: 1;
        }
        
        .primary-button:hover::after {
            opacity: 0.3;
        }
        
        .primary-button span {
            position: relative;
            z-index: 2;
        }
        
        .secondary-button {
            background-color: #f0f0f0;
            color: var(--text-dark);
            margin-top: 10px;
        }
        
        .secondary-button:hover {
            background-color: #ddd;
        }
        
        .social-login {
            margin-top: 25px;
            text-align: center;
        }
        
        .social-login p {
            color: var(--text-medium);
            margin-bottom: 15px;
            position: relative;
        }
        
        .social-login p:before,
        .social-login p:after {
            content: "";
            display: inline-block;
            width: 30%;
            height: 1px;
            background: var(--border-light);
            vertical-align: middle;
            margin: 0 10px;
        }
        
        .social-buttons {
            display: flex;
            justify-content: center;
            gap: 15px;
        }
        
        .social-button {
            width: 40px;
            height: 40px;
            border-radius: var(--radius-circle);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.2rem;
            transition: transform var(--transition-normal), box-shadow var(--transition-normal);
            box-shadow: var(--shadow-sm);
        }
        
        .social-button:hover {
            transform: scale(1.1);
            box-shadow: var(--shadow-md);
        }
        
        .facebook {
            background: linear-gradient(to bottom right, #4267B2, #3B5998);
        }
        
        .google {
            background: linear-gradient(to bottom right, #EA4335, #DB4437);
        }
        
        .auth-footer {
            text-align: center;
            margin-top: 20px;
        }
        
        .auth-footer a {
            color: var(--primary);
            text-decoration: none;
            transition: all var(--transition-fast);
        }
        
        .auth-footer a:hover {
            color: var(--primary-dark);
            text-decoration: underline;
        }
        
        .forgot-password {
            text-align: right;
            margin-bottom: 20px;
        }
        
        .forgot-password a {
            color: var(--text-medium);
            text-decoration: none;
            font-size: 0.9rem;
            transition: color var(--transition-fast);
        }
        
        .forgot-password a:hover {
            color: var(--primary);
        }
        
        .home-button {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 10px 20px;
            background: linear-gradient(to right, var(--primary), var(--primary-dark));
            color: white;
            text-decoration: none;
            border-radius: var(--radius-md);
            margin-top: 20px;
            transition: all var(--transition-normal);
            font-weight: 600;
            box-shadow: var(--shadow-sm);
        }
        
        .home-button:hover {
            background: linear-gradient(to right, var(--primary-light), var(--primary));
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }
        
        .home-button::before {
            content: '◄';
            margin-right: 8px;
            display: inline-block;
            transition: transform var(--transition-normal);
            font-size: 0.8em;
        }
        
        .home-button:hover::before {
            transform: translateX(-3px);
        }
        
        footer {
            margin-top: 40px;
            text-align: center;
            color: white;
            font-size: 0.9rem;
            background-color: rgba(3, 4, 94, 0.8);
            padding: 15px 0;
            border-radius: var(--radius-md);
        }
        
        @media (max-width: 768px) {
            .auth-container {
                gap: 30px;
            }
        }
        
        /* Validation styling to match the blue theme */
        .validator-error {
            color: #DC3545;
            font-size: 0.8rem;
            margin-top: 5px;
            display: block;
            position: relative;
            padding-left: 1.5em;
        }
        
        .validator-error::before {
            content: "!";
            position: absolute;
            left: 0;
            width: 1.2em;
            height: 1.2em;
            background: #DC3545;
            color: white;
            border-radius: 50%;
            text-align: center;
            line-height: 1.2em;
            font-size: 0.8em;
        }
        
        /* Wave effect background to match site theme */
        body::before {
            content: "";
            position: fixed;
            bottom: 0;
            left: 0;
            right: 0;
            height: 40%;
            background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320"><path fill="%23ffffff10" fill-opacity="0.2" d="M0,128L48,138.7C96,149,192,171,288,165.3C384,160,480,128,576,122.7C672,117,768,139,864,144C960,149,1056,139,1152,133.3C1248,128,1344,128,1392,128L1440,128L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>');
            background-size: cover;
            background-repeat: no-repeat;
            z-index: -1;
            opacity: 0.5;
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
