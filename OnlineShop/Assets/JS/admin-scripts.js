/**
 * Admin Dashboard JavaScript
 * Interactive functionality for admin interface
 * @version 1.0.0
 * @author Radian Shop Team
 */

'use strict';

// ============================================================================
// ADMIN DASHBOARD MANAGER
// ============================================================================

class AdminDashboardManager {
    constructor() {
        this.sidebar = null;
        this.mainContent = null;
        this.menuToggle = null;
        this.sidebarToggle = null;
        this.isSidebarCollapsed = false;
        
        this.init();
    }

    init() {
        this.cacheElements();
        this.bindEvents();
        this.loadDashboardData();
        this.setupNotifications();
    }

    cacheElements() {
        this.sidebar = document.getElementById('adminSidebar');
        this.mainContent = document.getElementById('adminMain');
        this.menuToggle = document.getElementById('menuToggle');
        this.sidebarToggle = document.getElementById('sidebarToggle');
    }

    bindEvents() {
        // Sidebar toggle events
        if (this.sidebarToggle) {
            this.sidebarToggle.addEventListener('click', () => this.toggleSidebar());
        }

        if (this.menuToggle) {
            this.menuToggle.addEventListener('click', () => this.toggleSidebar());
        }

        // Responsive sidebar
        window.addEventListener('resize', () => this.handleResize());
        
        // Close sidebar on mobile when clicking outside
        document.addEventListener('click', (e) => this.handleOutsideClick(e));

        // Navigation active state
        this.setActiveNavigation();

        // Auto-refresh dashboard data
        this.setupAutoRefresh();
    }

    toggleSidebar() {
        this.isSidebarCollapsed = !this.isSidebarCollapsed;
        
        if (window.innerWidth <= 1024) {
            // Mobile behavior
            this.sidebar.classList.toggle('show');
        } else {
            // Desktop behavior
            this.sidebar.classList.toggle('collapsed');
            this.mainContent.classList.toggle('expanded');
        }
        
        // Save preference
        localStorage.setItem('adminSidebarCollapsed', this.isSidebarCollapsed);
    }

    handleResize() {
        if (window.innerWidth > 1024) {
            this.sidebar.classList.remove('show');
            this.mainContent.classList.remove('expanded');
            
            // Restore collapsed state from localStorage
            const isCollapsed = localStorage.getItem('adminSidebarCollapsed') === 'true';
            if (isCollapsed) {
                this.sidebar.classList.add('collapsed');
                this.mainContent.classList.add('expanded');
            }
        }
    }

    handleOutsideClick(e) {
        if (window.innerWidth <= 1024 && 
            this.sidebar.classList.contains('show') && 
            !this.sidebar.contains(e.target) && 
            !this.menuToggle.contains(e.target)) {
            this.sidebar.classList.remove('show');
        }
    }

    setActiveNavigation() {
        const currentPage = window.location.pathname.split('/').pop();
        const navLinks = document.querySelectorAll('.nav-link');
        
        navLinks.forEach(link => {
            const href = link.getAttribute('href');
            if (href && href.includes(currentPage)) {
                link.classList.add('active');
            }
        });
    }

    loadDashboardData() {
        // Load real-time stats
        this.updateStats();
        
        // Load recent orders
        this.loadRecentOrders();
        
        // Load recent products
        this.loadRecentProducts();
    }

    async updateStats() {
        try {
            // Simulate API call - replace with actual endpoint
            const response = await fetch('/api/admin/stats');
            if (response.ok) {
                const stats = await response.json();
                this.updateStatElements(stats);
            }
        } catch (error) {
            console.log('Stats update failed:', error);
            // Fallback to static data
        }
    }

    updateStatElements(stats) {
        const elements = {
            'lblTotalOrders': stats.totalOrders || 0,
            'lblTotalProducts': stats.totalProducts || 0,
            'lblTotalUsers': stats.totalUsers || 0,
            'lblTotalRevenue': this.formatCurrency(stats.totalRevenue || 0)
        };

        Object.entries(elements).forEach(([id, value]) => {
            const element = document.getElementById(id);
            if (element) {
                this.animateCounter(element, value);
            }
        });
    }

    animateCounter(element, targetValue) {
        const startValue = parseInt(element.textContent.replace(/[^\d]/g, '')) || 0;
        const duration = 1000;
        const startTime = performance.now();

        const animate = (currentTime) => {
            const elapsed = currentTime - startTime;
            const progress = Math.min(elapsed / duration, 1);
            
            const currentValue = Math.floor(startValue + (targetValue - startValue) * progress);
            
            if (element.id === 'lblTotalRevenue') {
                element.textContent = this.formatCurrency(currentValue);
            } else {
                element.textContent = currentValue.toLocaleString();
            }

            if (progress < 1) {
                requestAnimationFrame(animate);
            }
        };

        requestAnimationFrame(animate);
    }

    formatCurrency(amount) {
        return new Intl.NumberFormat('vi-VN', {
            style: 'currency',
            currency: 'VND'
        }).format(amount);
    }

    async loadRecentOrders() {
        try {
            // Simulate API call
            const response = await fetch('/api/admin/recent-orders');
            if (response.ok) {
                const orders = await response.json();
                this.updateOrdersTable(orders);
            }
        } catch (error) {
            console.log('Recent orders load failed:', error);
        }
    }

    updateOrdersTable(orders) {
        const tableBody = document.querySelector('#gvRecentOrders tbody');
        if (!tableBody) return;

        tableBody.innerHTML = orders.map(order => `
            <tr>
                <td>${order.orderId}</td>
                <td>${order.customerName}</td>
                <td>${this.formatDate(order.orderDate)}</td>
                <td>${this.formatCurrency(order.totalAmount)}</td>
                <td><span class="status-badge status-${order.status.toLowerCase()}">${order.status}</span></td>
                <td>
                    <button class="btn btn-sm btn-primary" onclick="viewOrder('${order.orderId}')">
                        Xem
                    </button>
                </td>
            </tr>
        `).join('');
    }

    async loadRecentProducts() {
        try {
            // Simulate API call
            const response = await fetch('/api/admin/recent-products');
            if (response.ok) {
                const products = await response.json();
                this.updateProductsTable(products);
            }
        } catch (error) {
            console.log('Recent products load failed:', error);
        }
    }

    updateProductsTable(products) {
        const tableBody = document.querySelector('#gvRecentProducts tbody');
        if (!tableBody) return;

        tableBody.innerHTML = products.map(product => `
            <tr>
                <td>
                    <img src="${product.imageUrl}" alt="${product.name}" class="product-thumb" width="50" height="50">
                </td>
                <td>${product.name}</td>
                <td>${this.formatCurrency(product.price)}</td>
                <td>${product.categoryName}</td>
                <td>${this.formatDate(product.createdDate)}</td>
                <td>
                    <button class="btn btn-sm btn-warning" onclick="editProduct('${product.productId}')">
                        Sửa
                    </button>
                </td>
            </tr>
        `).join('');
    }

    formatDate(dateString) {
        const date = new Date(dateString);
        return date.toLocaleDateString('vi-VN');
    }

    setupNotifications() {
        const notificationBtn = document.querySelector('.notification-btn');
        if (notificationBtn) {
            notificationBtn.addEventListener('click', () => this.showNotifications());
        }
    }

    showNotifications() {
        // Create notification dropdown
        const dropdown = document.createElement('div');
        dropdown.className = 'notification-dropdown';
        dropdown.innerHTML = `
            <div class="notification-header">
                <h4>Thông báo</h4>
                <button class="btn-close" onclick="this.parentElement.parentElement.remove()">×</button>
            </div>
            <div class="notification-list">
                <div class="notification-item">
                    <div class="notification-icon">
                        <i class="fas fa-shopping-cart"></i>
                    </div>
                    <div class="notification-content">
                        <p>Đơn hàng mới #12345</p>
                        <span class="notification-time">5 phút trước</span>
                    </div>
                </div>
                <div class="notification-item">
                    <div class="notification-icon">
                        <i class="fas fa-user"></i>
                    </div>
                    <div class="notification-content">
                        <p>Người dùng mới đăng ký</p>
                        <span class="notification-time">10 phút trước</span>
                    </div>
                </div>
                <div class="notification-item">
                    <div class="notification-icon">
                        <i class="fas fa-box"></i>
                    </div>
                    <div class="notification-content">
                        <p>Sản phẩm sắp hết hàng</p>
                        <span class="notification-time">1 giờ trước</span>
                    </div>
                </div>
            </div>
        `;

        // Position dropdown
        const btn = document.querySelector('.notification-btn');
        const rect = btn.getBoundingClientRect();
        dropdown.style.position = 'absolute';
        dropdown.style.top = '100%';
        dropdown.style.right = '0';
        dropdown.style.width = '300px';
        dropdown.style.background = 'white';
        dropdown.style.border = '1px solid #e2e8f0';
        dropdown.style.borderRadius = '8px';
        dropdown.style.boxShadow = '0 10px 15px -3px rgba(0, 0, 0, 0.1)';
        dropdown.style.zIndex = '1000';

        // Add to DOM
        btn.parentElement.style.position = 'relative';
        btn.parentElement.appendChild(dropdown);

        // Auto remove after 5 seconds
        setTimeout(() => {
            if (dropdown.parentElement) {
                dropdown.remove();
            }
        }, 5000);
    }

    setupAutoRefresh() {
        // Refresh dashboard data every 30 seconds
        setInterval(() => {
            this.updateStats();
        }, 30000);
    }
}

// ============================================================================
// UTILITY FUNCTIONS
// ============================================================================

function viewOrder(orderId) {
    window.location.href = `OrderDetail.aspx?id=${orderId}`;
}

function editProduct(productId) {
    window.location.href = `ProductEdit.aspx?id=${productId}`;
}

function showAlert(message, type = 'info') {
    const alertDiv = document.createElement('div');
    alertDiv.className = `alert alert-${type}`;
    alertDiv.textContent = message;
    
    // Insert at top of content
    const content = document.querySelector('.admin-content');
    content.insertBefore(alertDiv, content.firstChild);
    
    // Auto remove after 5 seconds
    setTimeout(() => {
        alertDiv.remove();
    }, 5000);
}

function confirmAction(message, callback) {
    if (confirm(message)) {
        callback();
    }
}

function showLoading(element) {
    element.classList.add('loading');
    const spinner = document.createElement('div');
    spinner.className = 'spinner';
    element.appendChild(spinner);
}

function hideLoading(element) {
    element.classList.remove('loading');
    const spinner = element.querySelector('.spinner');
    if (spinner) {
        spinner.remove();
    }
}

// ============================================================================
// DATA TABLE ENHANCEMENTS
// ============================================================================

class DataTableManager {
    constructor(tableId) {
        this.table = document.getElementById(tableId);
        this.init();
    }

    init() {
        if (!this.table) return;
        
        this.addSearch();
        this.addSorting();
        this.addPagination();
    }

    addSearch() {
        const searchInput = document.createElement('input');
        searchInput.type = 'text';
        searchInput.placeholder = 'Tìm kiếm...';
        searchInput.className = 'table-search';
        
        this.table.parentElement.insertBefore(searchInput, this.table);
        
        searchInput.addEventListener('input', (e) => {
            this.filterTable(e.target.value);
        });
    }

    filterTable(searchTerm) {
        const rows = this.table.querySelectorAll('tbody tr');
        const term = searchTerm.toLowerCase();
        
        rows.forEach(row => {
            const text = row.textContent.toLowerCase();
            row.style.display = text.includes(term) ? '' : 'none';
        });
    }

    addSorting() {
        const headers = this.table.querySelectorAll('th');
        headers.forEach((header, index) => {
            if (header.textContent.trim()) {
                header.style.cursor = 'pointer';
                header.addEventListener('click', () => this.sortTable(index));
            }
        });
    }

    sortTable(columnIndex) {
        const tbody = this.table.querySelector('tbody');
        const rows = Array.from(tbody.querySelectorAll('tr'));
        
        rows.sort((a, b) => {
            const aText = a.cells[columnIndex].textContent.trim();
            const bText = b.cells[columnIndex].textContent.trim();
            
            // Try to parse as numbers
            const aNum = parseFloat(aText.replace(/[^\d.-]/g, ''));
            const bNum = parseFloat(bText.replace(/[^\d.-]/g, ''));
            
            if (!isNaN(aNum) && !isNaN(bNum)) {
                return aNum - bNum;
            }
            
            return aText.localeCompare(bText);
        });
        
        rows.forEach(row => tbody.appendChild(row));
    }

    addPagination() {
        // Implementation for pagination
        // This would integrate with server-side pagination
    }
}

// ============================================================================
// INITIALIZATION
// ============================================================================

document.addEventListener('DOMContentLoaded', function() {
    // Initialize admin dashboard
    new AdminDashboardManager();
    
    // Initialize data tables
    const tables = ['gvRecentOrders', 'gvRecentProducts'];
    tables.forEach(tableId => {
        if (document.getElementById(tableId)) {
            new DataTableManager(tableId);
        }
    });
    
    // Add smooth scrolling
    document.documentElement.style.scrollBehavior = 'smooth';
    
    // Add keyboard shortcuts
    document.addEventListener('keydown', function(e) {
        // Ctrl + M to toggle sidebar
        if (e.ctrlKey && e.key === 'm') {
            e.preventDefault();
            const manager = new AdminDashboardManager();
            manager.toggleSidebar();
        }
        
        // Escape to close modals/dropdowns
        if (e.key === 'Escape') {
            const dropdowns = document.querySelectorAll('.notification-dropdown');
            dropdowns.forEach(dropdown => dropdown.remove());
        }
    });
});

// ============================================================================
// EXPORT FOR MODULE USAGE
// ============================================================================

if (typeof module !== 'undefined' && module.exports) {
    module.exports = {
        AdminDashboardManager,
        DataTableManager,
        viewOrder,
        editProduct,
        showAlert,
        confirmAction
    };
}
