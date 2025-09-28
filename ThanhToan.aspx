<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.master" AutoEventWireup="true" CodeBehind="ThanhToan.aspx.cs" Inherits="OnlineShop.ChinhSuaDiaChi" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeaderContent" runat="server">
    <title>Thanh Toán - Radian Shop</title>
    <meta name="description" content="Thanh toán sản phẩm của bạn!" />
 </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <h1 class="text-center">Thanh Toán</h1>
        <div class="row">
            <div class="col-md-6 offset-md-3">
                <asp:Panel ID="pnlThanhToan" runat="server" CssClass="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Thông tin thanh toán</h3>
                    </div>
                    <div class="panel-body></div>
            </div>
        </div>
    </div>
                </asp:Panel>
</asp:Content>