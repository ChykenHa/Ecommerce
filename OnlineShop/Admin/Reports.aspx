<%@ Page Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="OnlineShop.Reports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHead" runat="server">
    <title>Báo cáo - Admin Panel</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitle" runat="server">
    <i class="fas fa-chart-bar"></i> Báo cáo thống kê
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="AdminMain" runat="server">
    <div class="row mb-4">
        <div class="col-md-3">
            <div style="background: white; padding: 20px; border-radius: 10px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
                <h6 class="text-secondary">Doanh thu tháng</h6>
                <h3 class="text-primary"><asp:Label ID="lblMonthlyRevenue" runat="server" Text="0 ₫"></asp:Label></h3>
                <small class="text-success"><i class="fas fa-arrow-up"></i> +12.5%</small>
            </div>
        </div>
        <div class="col-md-3">
            <div style="background: white; padding: 20px; border-radius: 10px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
                <h6 class="text-secondary">Đơn hàng tháng</h6>
                <h3 class="text-info"><asp:Label ID="lblMonthlyOrders" runat="server" Text="0"></asp:Label></h3>
                <small class="text-success"><i class="fas fa-arrow-up"></i> +8.2%</small>
            </div>
        </div>
        <div class="col-md-3">
            <div style="background: white; padding: 20px; border-radius: 10px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
                <h6 class="text-secondary">Khách hàng mới</h6>
                <h3 class="text-warning"><asp:Label ID="lblNewCustomers" runat="server" Text="0"></asp:Label></h3>
                <small class="text-success"><i class="fas fa-arrow-up"></i> +15.3%</small>
            </div>
        </div>
        <div class="col-md-3">
            <div style="background: white; padding: 20px; border-radius: 10px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
                <h6 class="text-secondary">Sản phẩm đã bán</h6>
                <h3 class="text-success"><asp:Label ID="lblProductsSold" runat="server" Text="0"></asp:Label></h3>
                <small class="text-success"><i class="fas fa-arrow-up"></i> +6.7%</small>
            </div>
        </div>
    </div>

    <div class="row mb-4">
        <div class="col-md-8">
            <div style="background: white; padding: 20px; border-radius: 10px;">
                <h5 class="mb-4">Doanh thu theo tháng</h5>
                <canvas id="revenueChart" height="80"></canvas>
            </div>
        </div>
        <div class="col-md-4">
            <div style="background: white; padding: 20px; border-radius: 10px;">
                <h5 class="mb-4">Đơn hàng theo trạng thái</h5>
                <canvas id="orderStatusChart"></canvas>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-12">
            <div style="background: white; padding: 20px; border-radius: 10px;">
                <h5 class="mb-3">Top 10 sản phẩm bán chạy</h5>
                <asp:GridView ID="gvTopProducts" runat="server" CssClass="table table-striped" AutoGenerateColumns="false">
                    <Columns>
                        <asp:BoundField DataField="Rank" HeaderText="#" />
                        <asp:BoundField DataField="ProductName" HeaderText="Sản phẩm" />
                        <asp:BoundField DataField="CategoryName" HeaderText="Danh mục" />
                        <asp:BoundField DataField="QuantitySold" HeaderText="Đã bán" />
                        <asp:BoundField DataField="Revenue" HeaderText="Doanh thu" DataFormatString="{0:N0} ₫" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>

    <script>
        // Revenue Chart
        const ctxRevenue = document.getElementById('revenueChart');
        if (ctxRevenue) {
            new Chart(ctxRevenue, {
                type: 'line',
                data: {
                    labels: ['T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8', 'T9', 'T10', 'T11', 'T12'],
                    datasets: [{
                        label: 'Doanh thu (triệu ₫)',
                        data: [12, 19, 15, 25, 22, 30, 28, 32, 35, 38, 42, 45],
                        borderColor: 'rgb(102, 126, 234)',
                        backgroundColor: 'rgba(102, 126, 234, 0.1)',
                        tension: 0.4,
                        fill: true
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: true,
                    plugins: {
                        legend: { display: false }
                    }
                }
            });
        }

        // Order Status Chart
        const ctxStatus = document.getElementById('orderStatusChart');
        if (ctxStatus) {
            new Chart(ctxStatus, {
                type: 'doughnut',
                data: {
                    labels: ['Hoàn thành', 'Đang xử lý', 'Đang giao', 'Chờ xử lý'],
                    datasets: [{
                        data: [45, 20, 25, 10],
                        backgroundColor: [
                            'rgb(16, 185, 129)',
                            'rgb(59, 130, 246)',
                            'rgb(245, 158, 11)',
                            'rgb(239, 68, 68)'
                        ]
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: true
                }
            });
        }
    </script>
</asp:Content>

