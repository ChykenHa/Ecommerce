<%@ Page Title="Liên Hệ - Radian Shop" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="LienHe.aspx.cs" Inherits="OnlineShop.LienHe" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderContent" runat="server">
    <style>
        /* Contact Page Styles */
        .contact-page {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 60px 0;
        }

        .contact-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .contact-header {
            text-align: center;
            margin-bottom: 50px;
            animation: fadeInDown 0.8s ease;
        }

        .contact-header h1 {
            color: #fff;
            font-size: 42px;
            font-weight: 700;
            margin-bottom: 15px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
        }

        .contact-header p {
            color: rgba(255,255,255,0.9);
            font-size: 18px;
            max-width: 600px;
            margin: 0 auto;
        }

        .contact-content {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            margin-bottom: 40px;
        }

        .contact-info-section, .contact-form-section {
            background: #fff;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
            animation: fadeInUp 0.8s ease;
        }

        .section-title {
            font-size: 28px;
            font-weight: 700;
            color: #2d3436;
            margin-bottom: 30px;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .section-title i {
            color: #667eea;
            font-size: 32px;
        }

        /* Contact Info Items */
        .contact-info-item {
            display: flex;
            align-items: flex-start;
            gap: 20px;
            padding: 20px;
            margin-bottom: 20px;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            border-radius: 15px;
            transition: all 0.3s ease;
        }

        .contact-info-item:hover {
            transform: translateX(10px);
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.3);
        }

        .contact-info-item i {
            font-size: 28px;
            color: #667eea;
            min-width: 40px;
        }

        .contact-info-content h4 {
            font-size: 18px;
            font-weight: 600;
            color: #2d3436;
            margin-bottom: 8px;
        }

        .contact-info-content p {
            color: #636e72;
            margin: 0;
            line-height: 1.6;
        }

        /* Contact Form */
        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            color: #2d3436;
            margin-bottom: 10px;
            font-size: 15px;
        }

        .form-group label .required {
            color: #ff6b6b;
        }

        .form-control {
            width: 100%;
            padding: 15px 20px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 15px;
            transition: all 0.3s ease;
            box-sizing: border-box;
        }

        .form-control:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        textarea.form-control {
            min-height: 150px;
            resize: vertical;
            font-family: inherit;
        }

        .btn-submit {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: #fff;
            padding: 16px 40px;
            border: none;
            border-radius: 50px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            width: 100%;
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
        }

        .btn-submit:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.6);
        }

        .btn-submit:active {
            transform: translateY(-1px);
        }

        /* Map Section */
        .map-section {
            background: #fff;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
            animation: fadeInUp 0.8s ease 0.2s both;
        }

        .map-container {
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            margin-top: 20px;
        }

        .map-container iframe {
            width: 100%;
            height: 450px;
            border: none;
        }

        /* Success/Error Messages */
        .alert {
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            font-weight: 500;
            animation: slideInDown 0.5s ease;
        }

        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .alert-danger {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        /* Social Media Links */
        .social-links {
            display: flex;
            gap: 15px;
            margin-top: 25px;
        }

        .social-link {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
            font-size: 20px;
            transition: all 0.3s ease;
            text-decoration: none;
        }

        .social-link.facebook { background: #3b5998; }
        .social-link.zalo { background: #0068ff; }
        .social-link.instagram { background: linear-gradient(45deg, #f09433 0%, #e6683c 25%, #dc2743 50%, #cc2366 75%, #bc1888 100%); }
        .social-link.youtube { background: #ff0000; }

        .social-link:hover {
            transform: translateY(-5px) scale(1.1);
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
        }

        /* Animations */
        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes slideInDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Responsive */
        @media (max-width: 992px) {
            .contact-content {
                grid-template-columns: 1fr;
            }

            .contact-header h1 {
                font-size: 32px;
            }

            .contact-info-section, .contact-form-section {
                padding: 30px;
            }
        }

        @media (max-width: 576px) {
            .contact-page {
                padding: 40px 0;
            }

            .contact-header h1 {
                font-size: 28px;
            }

            .section-title {
                font-size: 24px;
            }

            .contact-info-section, .contact-form-section, .map-section {
                padding: 25px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="contact-page">
        <div class="contact-container">
            <!-- Header -->
            <div class="contact-header">
                <h1>📞 Liên Hệ Với Chúng Tôi</h1>
                <p>Chúng tôi luôn sẵn sàng lắng nghe và hỗ trợ bạn 24/7. Hãy để lại thông tin, chúng tôi sẽ phản hồi trong thời gian sớm nhất!</p>
            </div>

            <!-- Contact Content -->
            <div class="contact-content">
                <!-- Contact Information -->
                <div class="contact-info-section">
                    <h2 class="section-title">
                        <i class="fas fa-info-circle"></i>
                        Thông Tin Liên Hệ
                    </h2>

                    <div class="contact-info-item">
                        <i class="fas fa-map-marker-alt"></i>
                        <div class="contact-info-content">
                            <h4>Địa chỉ</h4>
                            <p>01 Nguyễn Thị Cận <br/>Phường Liên Chiểu, Đà Nẵng</p>
                        </div>
                    </div>

                    <div class="contact-info-item">
                        <i class="fas fa-phone-alt"></i>
                        <div class="contact-info-content">
                            <h4>Điện thoại</h4>
                            <p>Hotline: <a href="tel:0364972519" style="color: #667eea; text-decoration: none;">0364972519</a><br/>
                               Tel: <a href="tel:0364972519" style="color: #667eea; text-decoration: none;">(084) 364 972 519</a></p>
                        </div>
                    </div>

                    <div class="contact-info-item">
                        <i class="fas fa-envelope"></i>
                        <div class="contact-info-content">
                            <h4>Email</h4>
                            <p>Support: <a href="mailto:support@radianshop.vn" style="color: #667eea; text-decoration: none;">support@radianshop.vn</a><br/>
                               Sales: <a href="mailto:sales@radianshop.vn" style="color: #667eea; text-decoration: none;">sales@radianshop.vn</a></p>
                        </div>
                    </div>

                    <div class="contact-info-item">
                        <i class="fas fa-clock"></i>
                        <div class="contact-info-content">
                            <h4>Giờ làm việc</h4>
                            <p>Thứ 2 - Thứ 6: 8:00 - 21:00<br/>
                               Thứ 7 - CN: 9:00 - 20:00</p>
                        </div>
                    </div>

                    <!-- Social Media Links -->
                    <div class="social-links">
                        <a href="https://facebook.com/radianshop" target="_blank" class="social-link facebook" title="Facebook">
                            <i class="fab fa-facebook-f"></i>
                        </a>
                        <a href="https://zalo.me/radianshop" target="_blank" class="social-link zalo" title="Zalo">
                            <i class="fas fa-comment-dots"></i>
                        </a>
                        <a href="https://instagram.com/radianshop" target="_blank" class="social-link instagram" title="Instagram">
                            <i class="fab fa-instagram"></i>
                        </a>
                        <a href="https://youtube.com/radianshop" target="_blank" class="social-link youtube" title="YouTube">
                            <i class="fab fa-youtube"></i>
                        </a>
                    </div>
                </div>

                <!-- Contact Form -->
                <div class="contact-form-section">
                    <h2 class="section-title">
                        <i class="fas fa-paper-plane"></i>
                        Gửi Tin Nhắn
                    </h2>

                    <asp:Panel ID="pnlMessage" runat="server" Visible="false">
                        <asp:Label ID="lblMessage" runat="server" CssClass="alert"></asp:Label>
                    </asp:Panel>

                    <div class="form-group">
                        <label for="txtName">Họ và tên <span class="required">*</span></label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Nguyễn Văn A" required></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label for="txtEmail">Email <span class="required">*</span></label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="example@gmail.com" required></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label for="txtPhone">Số điện thoại <span class="required">*</span></label>
                        <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="0123 456 789" required></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label for="txtSubject">Tiêu đề</label>
                        <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control" placeholder="Vấn đề bạn cần hỗ trợ..."></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label for="txtMessage">Nội dung <span class="required">*</span></label>
                        <asp:TextBox ID="txtMessage" runat="server" CssClass="form-control" TextMode="MultiLine" placeholder="Hãy cho chúng tôi biết bạn cần hỗ trợ gì..." required></asp:TextBox>
                    </div>

                    <asp:Button ID="btnSubmit" runat="server" CssClass="btn-submit" Text="📤 Gửi Tin Nhắn" OnClick="btnSubmit_Click" />
                </div>
            </div>

            <!-- Google Map -->
            <div class="map-section">
                <h2 class="section-title">
                    <i class="fas fa-map-marked-alt"></i>
                    Tìm Chúng Tôi Trên Bản Đồ
                </h2>
                <div class="map-container">
                    <!-- Google Maps Embed - 1 Nguyễn Thị Cận, Đà Nẵng -->
                    <iframe 
                        src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3834.5268845891625!2d108.16494721533268!3d16.043069561632908!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3142196a663cd57b%3A0xcab4933d02fa54f3!2zMSBOZ3V5eeG7hW4gVGjhu4sgQ-G6rW4sIEhvw6AgQW4sIEPhuqltIEzhu4csIMSQw6AgTuG6tW5nLCBWaeG7h3QgTmFt!5e0!3m2!1svi!2s!4v1234567890123!5m2!1svi!2s"
                        allowfullscreen="" 
                        loading="lazy" 
                        referrerpolicy="no-referrer-when-downgrade">
                    </iframe>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

