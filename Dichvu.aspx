<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.master" AutoEventWireup="true" CodeBehind="Dichvu.aspx.cs" Inherits="OnlineShop.Dichvuaspx" %>

<asp:Content ID="HeaderContent" ContentPlaceHolderID="HeaderContent" runat="server">
    <title>Dịch Vụ - Radian Shop</title>
    <meta name="description" content="Các dịch vụ chất lượng cao của Radian Shop" />
</asp:Content>

<asp:Content ID="BannerContent" ContentPlaceHolderID="BannerContent" runat="server">
    <asp:Image ID="ServicesBanner" runat="server" ImageUrl="~/Img/Banner_Ser.png" AlternateText="Dịch Vụ Banner" />
</asp:Content>

<asp:Content ID="NewsContent" ContentPlaceHolderID="NewsContent" runat="server">
    <asp:HyperLink ID="serviceNews1" runat="server" NavigateUrl="~/ServicePromo.aspx">Giảm 20% cho dịch vụ tư vấn online!</asp:HyperLink>
    <asp:HyperLink ID="serviceNews2" runat="server" NavigateUrl="~/PremiumService.aspx">Dịch vụ Premium mới ra mắt!</asp:HyperLink>
    <asp:HyperLink ID="serviceNews3" runat="server" NavigateUrl="~/ServiceReviews.aspx">Khách hàng nói gì về dịch vụ của chúng tôi?</asp:HyperLink>
</asp:Content>

<asp:Content ID="BreadcrumbContent" ContentPlaceHolderID="BreadcrumbContent" runat="server">
    Trang chủ > Dịch vụ
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="services-container">
        <h1 class="page-title">Dịch Vụ Của Chúng Tôi</h1>
        
        <p class="service-intro">
            Radian Shop cam kết mang đến cho khách hàng những dịch vụ chất lượng cao, đáp ứng mọi nhu cầu mua sắm online. Chúng tôi tập trung vào trải nghiệm khách hàng và luôn đặt sự hài lòng của bạn lên hàng đầu.
        </p>
        
        <div class="services-grid">
            <div class="service-item">
                <div class="service-icon">
                    <asp:Image ID="DeliveryIcon" runat="server" ImageUrl="~/Img/Ship.png" AlternateText="Giao Hàng" />
                </div>
                <div class="service-content">
                    <h2 class="service-title">Giao Hàng Nhanh Chóng</h2>
                    <p class="service-description">
                        Dịch vụ giao hàng nhanh trong vòng 24h đối với khu vực nội thành và 2-3 ngày cho khu vực ngoại thành. Theo dõi đơn hàng theo thời gian thực.
                    </p>
                    <asp:Button ID="DeliveryButton" runat="server" Text="Xem Chi Tiết" CssClass="service-button" OnClick="ServiceDetail_Click" CommandArgument="delivery" />
                </div>
            </div>
            
            <div class="service-item">
                <div class="service-icon">
                    <asp:Image ID="ReturnIcon" runat="server" ImageUrl="~/Img/Doitra.png" AlternateText="Đổi Trả" />
                </div>
                <div class="service-content">
                    <h2 class="service-title">Đổi Trả Dễ Dàng</h2>
                    <p class="service-description">
                        Chính sách đổi trả linh hoạt trong vòng 30 ngày kể từ ngày mua hàng. Hoàn tiền nhanh chóng trong vòng 48 giờ.
                    </p>
                    <asp:Button ID="ReturnButton" runat="server" Text="Xem Chi Tiết" CssClass="service-button" OnClick="ServiceDetail_Click" CommandArgument="return" />
                </div>
            </div>
            
            <div class="service-item">
                <div class="service-icon">
                    <asp:Image ID="ConsultIcon" runat="server" ImageUrl="~/Img/Tuvan.png" AlternateText="Tư Vấn" />
                </div>
                <div class="service-content">
                    <h2 class="service-title">Tư Vấn Trực Tuyến</h2>
                    <p class="service-description">
                        Đội ngũ tư vấn viên chuyên nghiệp hỗ trợ trực tuyến 24/7. Giải đáp mọi thắc mắc và hỗ trợ bạn lựa chọn sản phẩm phù hợp nhất.
                    </p>
                    <asp:Button ID="ConsultButton" runat="server" Text="Xem Chi Tiết" CssClass="service-button" OnClick="ServiceDetail_Click" CommandArgument="consult" />
                </div>
            </div>
            
            <div class="service-item">
                <div class="service-icon">
                    <asp:Image ID="WarrantyIcon" runat="server" ImageUrl="~/Img/Baohanh.png" AlternateText="Bảo Hành" />
                </div>
                <div class="service-content">
                    <h2 class="service-title">Bảo Hành Sản Phẩm</h2>
                    <p class="service-description">
                        Chế độ bảo hành đến 12 tháng cho tất cả sản phẩm. Trung tâm bảo hành đặt tại nhiều tỉnh thành trên toàn quốc.
                    </p>
                    <asp:Button ID="WarrantyButton" runat="server" Text="Xem Chi Tiết" CssClass="service-button" OnClick="ServiceDetail_Click" CommandArgument="warranty" />
                </div>
            </div>
            
            <div class="service-item">
                <div class="service-icon">
                    <asp:Image ID="MemberIcon" runat="server" ImageUrl="~/Img/Thanhvien.png" AlternateText="Thành Viên" />
                </div>
                <div class="service-content">
                    <h2 class="service-title">Chương Trình Thành Viên</h2>
                    <p class="service-description">
                        Trở thành thành viên để nhận ưu đãi đặc biệt, điểm thưởng và quà tặng sinh nhật. Tích lũy điểm với mỗi lần mua hàng.
                    </p>
                    <asp:Button ID="MemberButton" runat="server" Text="Đăng Ký Ngay" CssClass="service-button " OnClick="ServiceDetail_Click" CommandArgument="member" />
                </div>
            </div>
            
            <div class="service-item">
                <div class="service-icon">
                    <asp:Image ID="GiftIcon" runat="server" ImageUrl="~/Img/Quatang.png" AlternateText="Quà Tặng" />
                </div>
                <div class="service-content">
                    <h2 class="service-title">Gói Quà Tặng</h2>
                    <p class="service-description">
                        Dịch vụ gói quà tinh tế với nhiều lựa chọn về giấy gói, thiệp và ruy băng. Gửi thông điệp cá nhân kèm theo quà tặng.
                    </p>
                    <asp:Button ID="GiftButton" runat="server" Text="Xem Chi Tiết" CssClass="service-button" OnClick="ServiceDetail_Click" CommandArgument="gift" />
                </div>
            </div>
        </div>
        
        <div class="service-testimonials">
            <h2 class="testimonials-title">Khách Hàng Nói Gì Về Chúng Tôi</h2>
            
            <div class="testimonials-carousel">
                <asp:Repeater ID="TestimonialsRepeater" runat="server">
                    <ItemTemplate>
                        <div class="testimonial-item">
                            <div class="testimonial-content">
                                <p><%# Eval("Comment") %></p>
                            </div>
                            <div class="testimonial-author">
                                <div class="author-image">
                                    <asp:Image ID="AuthorImage" runat="server" ImageUrl='<%# Eval("ImageUrl") %>' AlternateText='<%# Eval("Name") %>' />
                                </div>
                                <div class="author-info">
                                    <h3><%# Eval("Name") %></h3>
                                    <p><%# Eval("Location") %></p>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
        
        <div class="service-faq">
            <h2 class="faq-title">Câu Hỏi Thường Gặp</h2>
            
            <div class="faq-container">
                <asp:Panel ID="FaqItem1" runat="server" CssClass="faq-item">
                    <div class="faq-question" onclick="toggleFaq('FaqAnswer1')">
                        <h3>Làm thế nào để theo dõi đơn hàng của tôi?</h3>
                        <span class="faq-toggle">+</span>
                    </div>
                    <div id="FaqAnswer1" class="faq-answer">
                        <p>
                            Bạn có thể theo dõi đơn hàng bằng cách đăng nhập vào tài khoản của mình và vào mục "Đơn hàng của tôi". 
                            Tại đây bạn sẽ thấy trạng thái hiện tại của đơn hàng cùng với mã theo dõi nếu đơn hàng đã được giao cho đơn vị vận chuyển.
                        </p>
                    </div>
                </asp:Panel>
                
                <asp:Panel ID="FaqItem2" runat="server" CssClass="faq-item">
                    <div class="faq-question" onclick="toggleFaq('FaqAnswer2')">
                        <h3>Tôi có thể đổi trả sản phẩm không?</h3>
                        <span class="faq-toggle">+</span>
                    </div>
                    <div id="FaqAnswer2" class="faq-answer">
                        <p>
                            Có, Radian Shop chấp nhận đổi trả sản phẩm trong vòng 30 ngày kể từ ngày mua hàng. 
                            Sản phẩm cần phải còn nguyên vẹn, chưa qua sử dụng và có đầy đủ bao bì, nhãn mác. 
                            Vui lòng xem chi tiết tại trang "Chính sách đổi trả".
                        </p>
                    </div>
                </asp:Panel>
                
                <asp:Panel ID="FaqItem3" runat="server" CssClass="faq-item">
                    <div class="faq-question" onclick="toggleFaq('FaqAnswer3')">
                        <h3>Làm thế nào để trở thành thành viên của Radian Shop?</h3>
                        <span class="faq-toggle">+</span>
                    </div>
                    <div id="FaqAnswer3" class="faq-answer">
                        <p>
                            Bạn có thể đăng ký làm thành viên miễn phí bằng cách tạo tài khoản trên website của chúng tôi. 
                            Sau khi đăng ký thành công, bạn sẽ bắt đầu tích lũy điểm với mỗi lần mua hàng và nhận được các ưu đãi đặc biệt dành cho thành viên.
                        </p>
                    </div>
                </asp:Panel>
                
                <asp:Panel ID="FaqItem4" runat="server" CssClass="faq-item">
                    <div class="faq-question" onclick="toggleFaq('FaqAnswer4')">
                        <h3>Phí giao hàng là bao nhiêu?</h3>
                        <span class="faq-toggle">+</span>
                    </div>
                    <div id="FaqAnswer4" class="faq-answer">
                        <p>
                            Phí giao hàng phụ thuộc vào khu vực giao hàng và giá trị đơn hàng của bạn. 
                            Đơn hàng trên 500.000đ sẽ được miễn phí giao hàng trong khu vực nội thành. 
                            Bạn có thể xem chi tiết phí giao hàng tại trang "Chính sách giao hàng".
                        </p>
                    </div>
                </asp:Panel>
            </div>
        </div>
        
        <div class="service-contact">
            <h2 class="contact-title">Cần Hỗ Trợ Thêm?</h2>
            <p class="contact-description">
                Đội ngũ hỗ trợ khách hàng của chúng tôi luôn sẵn sàng giúp đỡ bạn. Hãy liên hệ với chúng tôi qua:
            </p>
        </div>
    </div>
    
    <script type="text/javascript">
        function toggleFaq(id) {
            var answer = document.getElementById(id);
            if (answer.style.display === "block") {
                answer.style.display = "none";
                answer.previousElementSibling.querySelector(".faq-toggle").innerHTML = "+";
            } else {
                answer.style.display = "block";
                answer.previousElementSibling.querySelector(".faq-toggle").innerHTML = "-";
            }
        }
    </script>
    
    <style type="text/css">
        .services-container {
            padding: 20px 0;
        }
        
        .page-title {
            font-size: 28px;
            color: #d46b9c;
            margin-bottom: 20px;
            text-align: center;
            font-weight: bold;
            position: relative;
            padding-bottom: 10px;
        }
        
        .page-title:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 3px;
            background-color: #ffb6c1;
        }
        
        .service-intro {
            text-align: center;
            font-size: 16px;
            color: #666;
            margin-bottom: 40px;
            max-width: 800px;
            margin-left: auto;
            margin-right: auto;
            line-height: 1.6;
        }
        
        .services-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 30px;
            margin-bottom: 50px;
        }
        
        .service-item {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            display: flex;
            flex-direction: column;
        }
        
        .service-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
        }
        
        .service-icon {
            height: 160px;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #ffecf1;
            padding: 20px;
        }
        
        .service-icon img {
            max-width: 100px;
            max-height: 100px;
        }
        
        .service-content {
            padding: 20px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }
        
        .service-title {
            color: #d46b9c;
            font-size: 20px;
            margin-bottom: 10px;
            font-weight: 600;
        }
        
        .service-description {
            color: #666;
            font-size: 14px;
            line-height: 1.6;
            margin-bottom: 20px;
            flex-grow: 1;
        }
        
        .service-button {
            display: inline-block;
            padding: 10px 20px;
            background-color: #fff;
            color: #d46b9c;
            border: 2px solid #ffb6c1;
            border-radius: 5px;
            font-weight: 600;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            font-size: 14px;
            align-self: flex-start;
        }
        
        .service-button:hover {
            background-color: #ffb6c1;
            color: #fff;
        }
        
        .service-button.primary {
            background-color: #ffb6c1;
            color: #fff;
        }
        
        .service-button.primary:hover {
            background-color: #ff9cad;
        }
        
        /* Testimonials Styles */
        .service-testimonials {
            background-color: #ffecf1;
            padding: 40px 20px;
            border-radius: 10px;
            margin-bottom: 50px;
        }
        
        .testimonials-title {
            text-align: center;
            color: #d46b9c;
            font-size: 24px;
            margin-bottom: 30px;
            font-weight: 600;
        }
        
        .testimonials-carousel {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }
        
        .testimonial-item {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            width: calc(33.333% - 20px);
            min-width: 280px;
        }
        
        .testimonial-content {
            margin-bottom: 15px;
            color: #555;
            font-style: italic;
            line-height: 1.6;
        }
        
        .testimonial-author {
            display: flex;
            align-items: center;
        }
        
        .author-image {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            overflow: hidden;
            margin-right: 15px;
        }
        
        .author-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .author-info h3 {
            color: #d46b9c;
            font-size: 16px;
            margin: 0 0 5px 0;
        }
        
        .author-info p {
            color: #999;
            font-size: 12px;
            margin: 0;
        }
        
        /* FAQ Styles */
        .service-faq {
            margin-bottom: 50px;
        }
        
        .faq-title {
            text-align: center;
            color: #d46b9c;
            font-size: 24px;
            margin-bottom: 30px;
            font-weight: 600;
        }
        
        .faq-container {
            max-width: 800px;
            margin: 0 auto;
        }
        
        .faq-item {
            margin-bottom: 15px;
            border: 1px solid #eee;
            border-radius: 8px;
            overflow: hidden;
        }
        
        .faq-question {
            padding: 15px 20px;
            background-color: #fff;
            cursor: pointer;
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: background-color 0.3s ease;
        }
        
        .faq-question:hover {
            background-color: #ffecf1;
        }
        
        .faq-question h3 {
            margin: 0;
            font-size: 16px;
            color: #333;
            font-weight: 600;
        }
        
        .faq-toggle {
            font-size: 20px;
            color: #d46b9c;
            font-weight: bold;
        }
        
        .faq-answer {
            padding: 0 20px;
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.3s ease;
            background-color: #f9f9f9;
            display: none;
        }
        
        .faq-answer p {
            padding: 15px 0;
            margin: 0;
            color: #666;
            line-height: 1.6;
        }
        
        /* Contact Section Styles */
        .service-contact {
            background-color: #fff8f8;
            padding: 30px;
            border-radius: 10px;
            text-align: center;
            border: 1px solid #ffecf1;
        }
        
        .contact-title {
            color: #d46b9c;
            font-size: 24px;
            margin-bottom: 15px;
            font-weight: 600;
        }
        
        .contact-description {
            color: #666;
            font-size: 16px;
            margin-bottom: 30px;
            max-width: 700px;
            margin-left: auto;
            margin-right: auto;
        }
        
        .contact-methods {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 30px;
            margin-bottom: 30px;
        }
        
        .contact-method {
            display: flex;
            align-items: center;
            background-color: #fff;
            padding: 15px 20px;
            border-radius: 8px;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.05);
        }
        
        .contact-icon {
            font-size: 24px;
            color: #d46b9c;
            margin-right: 15px;
        }
        
        .contact-method p {
            margin: 0;
            color: #555;
        }
        
        .contact-button-container {
            margin-top: 20px;
        }
        
        .contact-button {
            display: inline-block;
            padding: 12px 30px;
            background-color: #d46b9c;
            color: #fff;
            border: none;
            border-radius: 5px;
            font-weight: 600;
            text-align: center;
            cursor: pointer;
            transition: background-color 0.3s ease;
            font-size: 16px;
        }
        
        .contact-button:hover {
            background-color: #c25a8b;
        }
        
        /* Responsive Styles */
        @media (max-width: 768px) {
            .services-grid {
                grid-template-columns: 1fr;
            }
            
            .testimonial-item {
                width: 100%;
            }
            
            .contact-methods {
                flex-direction: column;
                gap: 15px;
            }
        }
        
        /* Icon Styles */
        .phone-icon:before {
            content: "📞";
        }
        
        .email-icon:before {
            content: "✉️";
        }
        
        .chat-icon:before {
            content: "💬";
        }
    </style>
</asp:Content>