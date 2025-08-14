<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GioHang.aspx.cs" Inherits="OnlineShop.GioHang" MasterPageFile="~/Site1.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Giỏ Hàng</h2>
    <div class="cart-container">
        <asp:Repeater ID="rptCart" runat="server">
            <ItemTemplate>
                <div class="cart-item">
                    <div class="product-info">
                        <asp:Image ID="imgProduct" runat="server" ImageUrl='<%# Eval("ImageUrl") %>' CssClass="product-image" />
                        <div class="product-details">
                            <h4><%# Eval("ProductName") %></h4>
                            <p>Giá: <span class="price"><%# Eval("Price", "{0:C}") %></span></p>
                            <p>Số lượng: 
                                <asp:TextBox ID="txtQuantity" runat="server" Text='<%# Eval("Quantity") %>' CssClass="quantity-input" />
                                <asp:Button ID="btnUpdateQuantity" runat="server" Text="Cập nhật" CommandName="UpdateQuantity" CommandArgument='<%# Eval("ProductId") %>' CssClass="btn-update" />
                            </p>
                            <p>Tổng: <span class="total"><%# Eval("Total", "{0:C}") %></span></p>
                            <asp:Button ID="btnRemove" runat="server" Text="Xóa" CommandName="Remove" CommandArgument='<%# Eval("ProductId") %>' CssClass="btn-remove" />
                        </div>
                    </div>
                    <div class="gift-info">
                        <h5>Quà tặng khuyến mãi:</h5>
                        <ul>
                            <asp:Repeater ID="rptGifts" runat="server" DataSource='<%# Eval("Gifts") %>'>
                                <ItemTemplate>
                                    <li><%# Eval("GiftName") %> - Trị giá: <%# Eval("GiftValue", "{0:C}") %></li>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ul>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
        <div class="cart-summary">
            <h4>Tổng Tiền: <asp:Label ID="lblTotal" runat="server" Text="0"></asp:Label></h4>
            <asp:Button ID="btnCheckout" runat="server" Text="Đặt Hàng Ngay" CssClass="btn-checkout" OnClick="btnCheckout_Click" />
        </div>
    </div>
</asp:Content>
