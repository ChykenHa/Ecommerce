<%@ Page Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="OnlineShop.Settings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHead" runat="server">
    <title>Cài đặt - Admin Panel</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitle" runat="server">
    <i class="fas fa-cog"></i> Cài đặt hệ thống
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="AdminMain" runat="server">
    <div class="row">
        <div class="col-md-3">
            <div class="list-group">
                <a href="#profile" class="list-group-item list-group-item-action active">
                    <i class="fas fa-user"></i> Thông tin cá nhân
                </a>
                <a href="#password" class="list-group-item list-group-item-action">
                    <i class="fas fa-lock"></i> Đổi mật khẩu
                </a>
                <a href="#system" class="list-group-item list-group-item-action">
                    <i class="fas fa-cogs"></i> Cài đặt hệ thống
                </a>
                <a href="#email" class="list-group-item list-group-item-action">
                    <i class="fas fa-envelope"></i> Cài đặt email
                </a>
            </div>
        </div>

        <div class="col-md-9">
            <div style="background: white; padding: 30px; border-radius: 10px;">
                <h5 class="mb-4">Thông tin cá nhân</h5>
                
                <div class="mb-3">
                    <label class="form-label">Tên đăng nhập</label>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                </div>

                <div class="mb-3">
                    <label class="form-label">Họ tên</label>
                    <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control"></asp:TextBox>
                </div>

                <div class="mb-3">
                    <label class="form-label">Email</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox>
                </div>

                <div class="mb-3">
                    <label class="form-label">Vai trò</label>
                    <asp:TextBox ID="txtRole" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                </div>

                <hr class="my-4" />

                <h5 class="mb-4">Đổi mật khẩu</h5>

                <div class="mb-3">
                    <label class="form-label">Mật khẩu hiện tại</label>
                    <asp:TextBox ID="txtCurrentPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                </div>

                <div class="mb-3">
                    <label class="form-label">Mật khẩu mới</label>
                    <asp:TextBox ID="txtNewPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                </div>

                <div class="mb-3">
                    <label class="form-label">Xác nhận mật khẩu mới</label>
                    <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                </div>

                <div class="mt-4">
                    <asp:Button ID="btnSave" runat="server" Text="Lưu thay đổi" CssClass="btn btn-primary" OnClick="btnSave_Click" />
                    <asp:Button ID="btnCancel" runat="server" Text="Hủy" CssClass="btn btn-secondary ms-2" OnClick="btnCancel_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>

