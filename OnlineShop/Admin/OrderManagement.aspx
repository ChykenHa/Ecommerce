<%@ Page Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeBehind="OrderManagement.aspx.cs" Inherits="OnlineShop.OrderManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHead" runat="server">
    <title>Quản lý đơn hàng - Admin Panel</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitle" runat="server">
    <i class="fas fa-shopping-cart"></i> Quản lý đơn hàng
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="AdminMain" runat="server">
    <div class="row mb-4">
        <div class="col-md-3">
            <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 20px; border-radius: 10px;">
                <h6 style="opacity: 0.9;">Chờ xử lý</h6>
                <h3><asp:Label ID="lblPendingOrders" runat="server" Text="0"></asp:Label></h3>
            </div>
        </div>
        <div class="col-md-3">
            <div style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); color: white; padding: 20px; border-radius: 10px;">
                <h6 style="opacity: 0.9;">Đang xử lý</h6>
                <h3><asp:Label ID="lblProcessingOrders" runat="server" Text="0"></asp:Label></h3>
            </div>
        </div>
        <div class="col-md-3">
            <div style="background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%); color: white; padding: 20px; border-radius: 10px;">
                <h6 style="opacity: 0.9;">Đang giao</h6>
                <h3><asp:Label ID="lblShippingOrders" runat="server" Text="0"></asp:Label></h3>
            </div>
        </div>
        <div class="col-md-3">
            <div style="background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%); color: white; padding: 20px; border-radius: 10px;">
                <h6 style="opacity: 0.9;">Hoàn thành</h6>
                <h3><asp:Label ID="lblCompletedOrders" runat="server" Text="0"></asp:Label></h3>
            </div>
        </div>
    </div>

    <div style="background: white; border-radius: 10px; padding: 20px;">
        <div class="row mb-3">
            <div class="col-md-4">
                <asp:TextBox ID="txtSearch" runat="server" placeholder="Tìm đơn hàng..." CssClass="form-control"></asp:TextBox>
            </div>
            <div class="col-md-3">
                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control" AutoPostBack="true">
                    <asp:ListItem Value="" Text="Tất cả trạng thái"></asp:ListItem>
                    <asp:ListItem Value="Pending" Text="Chờ xử lý"></asp:ListItem>
                    <asp:ListItem Value="Processing" Text="Đang xử lý"></asp:ListItem>
                    <asp:ListItem Value="Shipping" Text="Đang giao"></asp:ListItem>
                    <asp:ListItem Value="Completed" Text="Hoàn thành"></asp:ListItem>
                    <asp:ListItem Value="Cancelled" Text="Đã hủy"></asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>

        <h5>Danh sách đơn hàng</h5>
        <asp:GridView ID="gvOrders" runat="server" CssClass="table table-striped" AutoGenerateColumns="false">
            <Columns>
                <asp:BoundField DataField="OrderId" HeaderText="Mã ĐH" />
                <asp:BoundField DataField="CustomerName" HeaderText="Khách hàng" />
                <asp:BoundField DataField="OrderDate" HeaderText="Ngày đặt" DataFormatString="{0:dd/MM/yyyy}" />
                <asp:BoundField DataField="TotalAmount" HeaderText="Tổng tiền" DataFormatString="{0:N0} ₫" />
                <asp:BoundField DataField="Status" HeaderText="Trạng thái" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>

