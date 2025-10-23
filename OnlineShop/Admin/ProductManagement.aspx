<%@ Page Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeBehind="ProductManagement.aspx.cs" Inherits="OnlineShop.ProductManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHead" runat="server">
    <title>Quản lý sản phẩm - Admin Dashboard</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitle" runat="server">
    <i class="fas fa-box"></i>
    Quản lý sản phẩm
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="AdminMain" runat="server">
    <div class="product-management">
        <!-- Action Bar -->
        <div class="action-bar">
            <div class="action-left">
                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <asp:TextBox ID="txtSearch" runat="server" placeholder="Tìm kiếm sản phẩm..." CssClass="search-input" OnTextChanged="txtSearch_TextChanged" AutoPostBack="true"></asp:TextBox>
                </div>
                
                <asp:DropDownList ID="ddlCategory" runat="server" CssClass="filter-select" AutoPostBack="true" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged">
                    <asp:ListItem Value="" Text="Tất cả danh mục"></asp:ListItem>
                </asp:DropDownList>
                
                <asp:DropDownList ID="ddlSort" runat="server" CssClass="filter-select" AutoPostBack="true" OnSelectedIndexChanged="ddlSort_SelectedIndexChanged">
                    <asp:ListItem Value="id_hang" Text="Mặc định"></asp:ListItem>
                    <asp:ListItem Value="tenhang ASC" Text="Tên A-Z"></asp:ListItem>
                    <asp:ListItem Value="tenhang DESC" Text="Tên Z-A"></asp:ListItem>
                    <asp:ListItem Value="dongia ASC" Text="Giá thấp-cao"></asp:ListItem>
                    <asp:ListItem Value="dongia DESC" Text="Giá cao-thấp"></asp:ListItem>
                </asp:DropDownList>
            </div>
            
            <div class="action-right">
                <asp:Button ID="btnAddProduct" runat="server" Text="Thêm sản phẩm" CssClass="btn btn-primary" OnClick="btnAddProduct_Click" />
                <asp:Button ID="btnBulkDelete" runat="server" Text="Xóa đã chọn" CssClass="btn btn-danger" OnClick="btnBulkDelete_Click" />
                <asp:Button ID="btnExport" runat="server" Text="Xuất Excel" CssClass="btn btn-success" OnClick="btnExport_Click" />
            </div>
        </div>

        <!-- Products Grid -->
        <div class="products-container">
            <asp:GridView ID="gvProducts" runat="server" CssClass="admin-table" 
                AutoGenerateColumns="false" AllowPaging="true" PageSize="20"
                OnPageIndexChanging="gvProducts_PageIndexChanging"
                OnRowCommand="gvProducts_RowCommand"
                OnRowDataBound="gvProducts_RowDataBound">
                <Columns>
                    <asp:TemplateField HeaderText="Chọn">
                        <HeaderTemplate>
                            <input type="checkbox" id="chkSelectAll" onclick="toggleSelectAll(this)" />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <input type="checkbox" name="chkProduct" value='<%# Eval("ProductId") %>' class="product-checkbox" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:TemplateField HeaderText="Hình ảnh">
                        <ItemTemplate>
                            <div class="product-image-container">
                                <asp:Image ID="imgProduct" runat="server" ImageUrl='<%# Eval("ImageUrl") %>' 
                                    CssClass="product-image" Width="60" Height="60" />
                                <div class="image-overlay">
                                    <i class="fas fa-eye"></i>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:BoundField DataField="Name" HeaderText="Tên sản phẩm" />
                    <asp:BoundField DataField="CategoryName" HeaderText="Danh mục" />
                    <asp:BoundField DataField="Price" HeaderText="Giá" DataFormatString="{0:N0} ₫" />
                    <asp:BoundField DataField="Stock" HeaderText="Tồn kho" />
                    <asp:BoundField DataField="Status" HeaderText="Trạng thái" />
                    <asp:BoundField DataField="CreatedDate" HeaderText="Ngày tạo" DataFormatString="{0:dd/MM/yyyy}" />
                    
                    <asp:TemplateField HeaderText="Thao tác">
                        <ItemTemplate>
                            <div class="action-buttons">
                                <asp:Button ID="btnEdit" runat="server" Text="Sửa" CssClass="btn btn-sm btn-warning" 
                                    CommandName="Edit" CommandArgument='<%# Eval("ProductId") %>' />
                                <asp:Button ID="btnDelete" runat="server" Text="Xóa" CssClass="btn btn-sm btn-danger" 
                                    CommandName="Delete" CommandArgument='<%# Eval("ProductId") %>' 
                                    OnClientClick="return confirm('Bạn có chắc muốn xóa sản phẩm này?')" />
                                <asp:Button ID="btnView" runat="server" Text="Xem" CssClass="btn btn-sm btn-info" 
                                    CommandName="View" CommandArgument='<%# Eval("ProductId") %>' />
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                
                <PagerStyle CssClass="pager-style" />
                <HeaderStyle CssClass="header-style" />
                <RowStyle CssClass="row-style" />
                <AlternatingRowStyle CssClass="alt-row-style" />
            </asp:GridView>
        </div>

        <!-- Pagination Info -->
        <div class="pagination-info">
            <span>Tổng số sản phẩm: <strong><asp:Label ID="lblTotalProducts" runat="server" Text="0"></asp:Label></strong></span>
            <span>Hiển thị: <strong><asp:Label ID="lblPageInfo" runat="server" Text="0 - 0"></asp:Label></strong></span>
        </div>
    </div>

    <!-- Product Modal -->
    <div class="modal" id="productModal" style="display: none;">
        <div class="modal-content">
            <div class="modal-header">
                <h3 id="modalTitle">Thêm sản phẩm mới</h3>
                <button class="btn-close" onclick="closeModal()">&times;</button>
            </div>
            <div class="modal-body">
                <asp:Panel ID="pnlProductForm" runat="server">
                    <div class="form-group">
                        <label>Tên sản phẩm *</label>
                        <asp:TextBox ID="txtProductName" runat="server" CssClass="form-control" required></asp:TextBox>
                    </div>
                    
                    <div class="form-group">
                        <label>Danh mục *</label>
                        <asp:DropDownList ID="ddlProductCategory" runat="server" CssClass="form-control" required></asp:DropDownList>
                    </div>
                    
                    <div class="form-group">
                        <label>Giá *</label>
                        <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" TextMode="Number" required></asp:TextBox>
                    </div>
                    
                    <div class="form-group">
                        <label>Số lượng tồn kho</label>
                        <asp:TextBox ID="txtStock" runat="server" CssClass="form-control" TextMode="Number" Text="0"></asp:TextBox>
                    </div>
                    
                    <div class="form-group">
                        <label>Mô tả</label>
                        <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                    </div>
                    
                    <div class="form-group">
                        <label>Hình ảnh</label>
                        <asp:FileUpload ID="fuProductImage" runat="server" CssClass="form-control" accept="image/*" />
                        <small class="form-text">Chấp nhận: JPG, PNG, WEBP (tối đa 5MB)</small>
                    </div>
                    
                    <div class="form-group">
                        <label>Trạng thái</label>
                        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control">
                            <asp:ListItem Value="Active" Text="Hoạt động"></asp:ListItem>
                            <asp:ListItem Value="Inactive" Text="Không hoạt động"></asp:ListItem>
                            <asp:ListItem Value="OutOfStock" Text="Hết hàng"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </asp:Panel>
            </div>
            <div class="modal-footer">
                <asp:Button ID="btnSaveProduct" runat="server" Text="Lưu" CssClass="btn btn-primary" OnClick="btnSaveProduct_Click" />
                <button type="button" class="btn btn-secondary" onclick="closeModal()">Hủy</button>
            </div>
        </div>
    </div>

    <!-- JavaScript for modal and interactions -->
    <script>
        function toggleSelectAll(checkbox) {
            const checkboxes = document.querySelectorAll('.product-checkbox');
            checkboxes.forEach(cb => cb.checked = checkbox.checked);
        }

        function openModal(title) {
            document.getElementById('modalTitle').textContent = title;
            document.getElementById('productModal').style.display = 'block';
        }

        function closeModal() {
            document.getElementById('productModal').style.display = 'none';
        }

        function editProduct(productId) {
            // Load product data and open modal
            openModal('Sửa sản phẩm');
        }

        function viewProduct(productId) {
            // Open product view modal
            window.open('../Details.aspx?id=' + productId, '_blank');
        }

        // Close modal when clicking outside
        window.onclick = function(event) {
            const modal = document.getElementById('productModal');
            if (event.target === modal) {
                closeModal();
            }
        }
    </script>
</asp:Content>