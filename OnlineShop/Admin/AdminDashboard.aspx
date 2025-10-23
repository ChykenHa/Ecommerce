<%@ Page Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="OnlineShop.AdminDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHead" runat="server">
    <title>Dashboard - Admin Panel</title>
    <style>
        .dashboard-container {
            padding: 20px;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.15);
        }

        .stat-card.orders {
            border-left: 4px solid #3498db;
        }

        .stat-card.products {
            border-left: 4px solid #2ecc71;
        }

        .stat-card.users {
            border-left: 4px solid #f39c12;
        }

        .stat-card.revenue {
            border-left: 4px solid #e74c3c;
        }

        .stat-icon {
            font-size: 40px;
            margin-bottom: 10px;
        }

        .stat-card.orders .stat-icon {
            color: #3498db;
        }

        .stat-card.products .stat-icon {
            color: #2ecc71;
        }

        .stat-card.users .stat-icon {
            color: #f39c12;
        }

        .stat-card.revenue .stat-icon {
            color: #e74c3c;
        }

        .stat-label {
            font-size: 14px;
            color: #7f8c8d;
            margin-bottom: 5px;
        }

        .stat-value {
            font-size: 32px;
            font-weight: bold;
            color: #2c3e50;
        }

        .dashboard-section {
            background: white;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .section-title {
            font-size: 20px;
            font-weight: bold;
            color: #2c3e50;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #ecf0f1;
        }

        .recent-products-table {
            width: 100%;
            border-collapse: collapse;
        }

        .recent-products-table th {
            background: #34495e;
            color: white;
            padding: 12px;
            text-align: left;
            font-weight: 600;
        }

        .recent-products-table td {
            padding: 12px;
            border-bottom: 1px solid #ecf0f1;
        }

        .recent-products-table tr:hover {
            background: #f8f9fa;
        }

        .product-image {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 5px;
        }

        .price-tag {
            color: #e74c3c;
            font-weight: bold;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitle" runat="server">
    <i class="fas fa-tachometer-alt"></i>
    Dashboard
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="AdminMain" runat="server">
    <div class="dashboard-container">
        <!-- Statistics Cards -->
        <div class="stats-grid">
            <div class="stat-card orders">
                <div class="stat-icon">
                    <i class="fas fa-shopping-cart"></i>
                </div>
                <div class="stat-label">Tổng đơn hàng</div>
                <div class="stat-value">
                    <asp:Label ID="lblTotalOrders" runat="server" Text="0"></asp:Label>
                </div>
            </div>

            <div class="stat-card products">
                <div class="stat-icon">
                    <i class="fas fa-box"></i>
                </div>
                <div class="stat-label">Tổng sản phẩm</div>
                <div class="stat-value">
                    <asp:Label ID="lblTotalProducts" runat="server" Text="0"></asp:Label>
                </div>
            </div>

            <div class="stat-card users">
                <div class="stat-icon">
                    <i class="fas fa-users"></i>
                </div>
                <div class="stat-label">Người dùng</div>
                <div class="stat-value">
                    <asp:Label ID="lblTotalUsers" runat="server" Text="0"></asp:Label>
                </div>
            </div>

            <div class="stat-card revenue">
                <div class="stat-icon">
                    <i class="fas fa-dollar-sign"></i>
                </div>
                <div class="stat-label">Doanh thu</div>
                <div class="stat-value">
                    <asp:Label ID="lblTotalRevenue" runat="server" Text="0 ₫"></asp:Label>
                </div>
            </div>
        </div>

        <!-- Recent Products -->
        <div class="dashboard-section">
            <div class="section-title">
                <i class="fas fa-clock"></i>
                Sản phẩm gần đây
            </div>

            <asp:GridView ID="gvRecentProducts" runat="server" 
                CssClass="recent-products-table"
                AutoGenerateColumns="false"
                ShowHeader="true"
                GridLines="None">
                <Columns>
                    <asp:TemplateField HeaderText="Hình ảnh">
                        <ItemTemplate>
                            <asp:Image ID="imgProduct" runat="server" 
                                ImageUrl='<%# Eval("ImageUrl") %>' 
                                CssClass="product-image" 
                                AlternateText="Product Image" />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField DataField="ProductId" HeaderText="ID" />
                    <asp:BoundField DataField="Name" HeaderText="Tên sản phẩm" />
                    <asp:BoundField DataField="CategoryName" HeaderText="Danh mục" />
                    
                    <asp:TemplateField HeaderText="Giá">
                        <ItemTemplate>
                            <span class="price-tag">
                                <%# String.Format("{0:N0} ₫", Eval("Price")) %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField DataField="CreatedDate" HeaderText="Ngày tạo" DataFormatString="{0:dd/MM/yyyy}" />
                </Columns>

                <EmptyDataTemplate>
                    <div style="text-align: center; padding: 20px; color: #7f8c8d;">
                        <i class="fas fa-inbox" style="font-size: 48px; margin-bottom: 10px;"></i>
                        <p>Chưa có sản phẩm nào</p>
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>
</asp:Content>

