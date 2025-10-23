<%@ Page Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeBehind="ProductManagement.aspx.cs" Inherits="OnlineShop.ProductManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHead" runat="server">
    <title>Quản lý sản phẩm - Admin Dashboard</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitle" runat="server">
    <i class="fas fa-box"></i> Quản lý sản phẩm
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="AdminMain" runat="server">
    <div class="product-management">
        <div class="action-bar" style="background: white; padding: 20px; border-radius: 10px; margin-bottom: 20px;">
            <div class="row">
                <div class="col-md-4">
                    <div class="search-box">
                        <i class="fas fa-search"></i>
                        <asp:TextBox ID="txtSearch" runat="server" placeholder="Tìm kiếm sản phẩm..." CssClass="form-control" OnTextChanged="txtSearch_TextChanged" AutoPostBack="true"></asp:TextBox>
                    </div>
                </div>
                
                <div class="col-md-3">
                    <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged">
                    </asp:DropDownList>
                </div>
                
                <div class="col-md-3">
                    <asp:DropDownList ID="ddlSort" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlSort_SelectedIndexChanged">
                        <asp:ListItem Value="mh.id_hang DESC" Text="Mới nhất"></asp:ListItem>
                        <asp:ListItem Value="mh.tenhang ASC" Text="Tên A-Z"></asp:ListItem>
                        <asp:ListItem Value="mh.tenhang DESC" Text="Tên Z-A"></asp:ListItem>
                        <asp:ListItem Value="mh.dongia ASC" Text="Giá thấp-cao"></asp:ListItem>
                        <asp:ListItem Value="mh.dongia DESC" Text="Giá cao-thấp"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                
                <div class="col-md-2">
                    <asp:Button ID="btnAddProduct" runat="server" Text="Thêm SP" CssClass="btn btn-primary" OnClick="btnAddProduct_Click" />
                </div>
            </div>
        </div>

        <div class="products-container" style="background: white; padding: 20px; border-radius: 10px;">
            <asp:GridView ID="gvProducts" runat="server" CssClass="table table-striped table-hover"
                AutoGenerateColumns="false" AllowPaging="true" PageSize="20"
                OnPageIndexChanging="gvProducts_PageIndexChanging"
                OnRowCommand="gvProducts_RowCommand"
                OnRowDataBound="gvProducts_RowDataBound">
                <Columns>
                    <asp:TemplateField HeaderText="Hình">
                        <ItemTemplate>
                            <asp:Image ID="imgProduct" runat="server" ImageUrl='<%# Eval("ImageUrl") %>' 
                                CssClass="product-image" Width="60" Height="60" style="border-radius: 5px;" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:BoundField DataField="ProductId" HeaderText="ID" />
                    <asp:BoundField DataField="Name" HeaderText="Tên sản phẩm" />
                    <asp:BoundField DataField="CategoryName" HeaderText="Danh mục" />
                    <asp:BoundField DataField="Price" HeaderText="Giá" DataFormatString="{0:N0} ₫" />
                    <asp:BoundField DataField="Stock" HeaderText="Tồn kho" />
                    <asp:BoundField DataField="Status" HeaderText="Trạng thái" />
                    
                    <asp:TemplateField HeaderText="Thao tác">
                        <ItemTemplate>
                            <asp:Button ID="btnEdit" runat="server" Text="Sửa" CssClass="btn btn-sm btn-warning" 
                                CommandName="EditProduct" CommandArgument='<%# Eval("ProductId") %>' />
                            <asp:Button ID="btnDelete" runat="server" Text="Xóa" CssClass="btn btn-sm btn-danger" 
                                CommandName="DeleteProduct" CommandArgument='<%# Eval("ProductId") %>' 
                                OnClientClick="return confirm('Bạn có chắc muốn xóa?')" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <div class="pagination-info mt-3">
                <span>Tổng: <strong><asp:Label ID="lblTotalProducts" runat="server" Text="0"></asp:Label></strong></span>
                <span class="ms-3"><asp:Label ID="lblPageInfo" runat="server" Text="0 sản phẩm"></asp:Label></span>
            </div>
        </div>

        <asp:Panel ID="pnlProductForm" runat="server" style="display:none">
            <asp:TextBox ID="txtProductName" runat="server"></asp:TextBox>
            <asp:DropDownList ID="ddlProductCategory" runat="server"></asp:DropDownList>
            <asp:TextBox ID="txtPrice" runat="server"></asp:TextBox>
            <asp:TextBox ID="txtStock" runat="server"></asp:TextBox>
            <asp:TextBox ID="txtDescription" runat="server"></asp:TextBox>
            <asp:FileUpload ID="fuProductImage" runat="server" />
            <asp:DropDownList ID="ddlStatus" runat="server"></asp:DropDownList>
            <asp:Button ID="btnSaveProduct" runat="server" Text="Lưu" OnClick="btnSaveProduct_Click" />
        </asp:Panel>
        
        <asp:Button ID="btnBulkDelete" runat="server" Text="Xóa nhiều" OnClick="btnBulkDelete_Click" style="display:none" />
        <asp:Button ID="btnExport" runat="server" Text="Xuất Excel" OnClick="btnExport_Click" style="display:none" />
    </div>
</asp:Content>

