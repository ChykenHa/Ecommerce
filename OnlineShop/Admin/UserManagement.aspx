<%@ Page Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeBehind="UserManagement.aspx.cs" Inherits="OnlineShop.UserManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHead" runat="server">
    <title>Quản lý người dùng - Admin Panel</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitle" runat="server">
    <i class="fas fa-users"></i> Quản lý người dùng
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="AdminMain" runat="server">
    <div class="row mb-4">
        <div class="col-md-4">
            <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 20px; border-radius: 10px;">
                <h6 style="opacity: 0.9;">Tổng người dùng</h6>
                <h3><asp:Label ID="lblTotalUsers" runat="server" Text="0"></asp:Label></h3>
            </div>
        </div>
        <div class="col-md-4">
            <div style="background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%); color: white; padding: 20px; border-radius: 10px;">
                <h6 style="opacity: 0.9;">Đang hoạt động</h6>
                <h3><asp:Label ID="lblActiveUsers" runat="server" Text="0"></asp:Label></h3>
            </div>
        </div>
        <div class="col-md-4">
            <div style="background: linear-gradient(135deg, #fa709a 0%, #fee140 100%); color: white; padding: 20px; border-radius: 10px;">
                <h6 style="opacity: 0.9;">Người dùng mới (tháng)</h6>
                <h3><asp:Label ID="lblNewUsers" runat="server" Text="0"></asp:Label></h3>
            </div>
        </div>
    </div>

    <div style="background: white; border-radius: 10px; padding: 20px;">
        <div class="row mb-3">
            <div class="col-md-5">
                <asp:TextBox ID="txtSearch" runat="server" placeholder="Tìm theo tên, email, SĐT..." CssClass="form-control"></asp:TextBox>
            </div>
            <div class="col-md-3">
                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control">
                    <asp:ListItem Value="" Text="Tất cả trạng thái"></asp:ListItem>
                    <asp:ListItem Value="Active" Text="Đang hoạt động"></asp:ListItem>
                    <asp:ListItem Value="Blocked" Text="Bị khóa"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col-md-4 text-end">
                <asp:Button ID="btnAddUser" runat="server" Text="Thêm người dùng" CssClass="btn btn-primary" OnClick="btnAddUser_Click" />
            </div>
        </div>

        <h5>Danh sách người dùng</h5>
        <asp:GridView ID="gvUsers" runat="server" CssClass="table table-striped" AutoGenerateColumns="false">
            <Columns>
                <asp:BoundField DataField="UserId" HeaderText="ID" />
                <asp:BoundField DataField="FullName" HeaderText="Họ tên" />
                <asp:BoundField DataField="Email" HeaderText="Email" />
                <asp:BoundField DataField="Phone" HeaderText="SĐT" />
                <asp:BoundField DataField="RegisterDate" HeaderText="Ngày đăng ký" DataFormatString="{0:dd/MM/yyyy}" />
                <asp:BoundField DataField="Status" HeaderText="Trạng thái" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>

