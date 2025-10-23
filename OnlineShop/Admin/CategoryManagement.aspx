<%@ Page Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeBehind="CategoryManagement.aspx.cs" Inherits="OnlineShop.CategoryManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHead" runat="server">
    <title>Quản lý danh mục - Admin Panel</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitle" runat="server">
    <i class="fas fa-tags"></i> Quản lý danh mục
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="AdminMain" runat="server">
    <div class="row">
        <div class="col-md-8">
            <div style="background: white; border-radius: 10px; padding: 20px;">
                <h5>Danh sách danh mục</h5>
                <asp:GridView ID="gvCategories" runat="server" CssClass="table table-striped" 
                    AutoGenerateColumns="false" DataKeyNames="CategoryId">
                    <Columns>
                        <asp:BoundField DataField="CategoryId" HeaderText="ID" />
                        <asp:BoundField DataField="CategoryName" HeaderText="Tên danh mục" />
                        <asp:BoundField DataField="Description" HeaderText="Mô tả" />
                        <asp:BoundField DataField="ProductCount" HeaderText="Số SP" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>

        <div class="col-md-4">
            <div style="background: white; border-radius: 10px; padding: 20px;">
                <h5>Thêm danh mục mới</h5>
                <div class="mb-3">
                    <label>Tên danh mục</label>
                    <asp:TextBox ID="txtNewCategoryName" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="mb-3">
                    <label>Mô tả</label>
                    <asp:TextBox ID="txtNewDescription" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                </div>
                <asp:TextBox ID="txtNewIcon" runat="server" style="display:none"></asp:TextBox>
                <asp:Button ID="btnAddCategory" runat="server" Text="Thêm" CssClass="btn btn-primary w-100" OnClick="btnAddCategory_Click" />
            </div>
        </div>
    </div>
</asp:Content>

