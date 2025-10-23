// ==========================================================================
// PERFORMANCE OPTIMIZED JAVASCRIPT
// - Smooth scrolling
// - Lazy loading images
// - Debounced scroll events
// - Optimized animations
// ==========================================================================

(function() {
    'use strict';

    // ==========================================================================
    // UTILITY FUNCTIONS
    // ==========================================================================

    // Debounce function to limit event firing
    function debounce(func, wait) {
        let timeout;
        return function executedFunction(...args) {
            const later = () => {
                clearTimeout(timeout);
                func(...args);
            };
            clearTimeout(timeout);
            timeout = setTimeout(later, wait);
        };
    }

    // Throttle function for scroll events
    function throttle(func, limit) {
        let inThrottle;
        return function() {
            const args = arguments;
            const context = this;
            if (!inThrottle) {
                func.apply(context, args);
                inThrottle = true;
                setTimeout(() => inThrottle = false, limit);
            }
        };
    }

    // ==========================================================================
    // LAZY LOADING IMAGES
    // ==========================================================================
    function initLazyLoading() {
        const images = document.querySelectorAll('img[data-src]');
        
        if ('IntersectionObserver' in window) {
            const imageObserver = new IntersectionObserver((entries, observer) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        const img = entry.target;
                        img.src = img.dataset.src;
                        img.removeAttribute('data-src');
                        imageObserver.unobserve(img);
                    }
                });
            }, {
                rootMargin: '50px 0px',
                threshold: 0.01
            });

            images.forEach(img => imageObserver.observe(img));
        } else {
            // Fallback for browsers without IntersectionObserver
            images.forEach(img => {
                img.src = img.dataset.src;
                img.removeAttribute('data-src');
            });
        }
    }

    // ==========================================================================
    // BACK TO TOP BUTTON
    // ==========================================================================
    function initBackToTop() {
        const backToTopBtn = document.getElementById('backToTop');
        
        if (!backToTopBtn) return;

        const toggleVisibility = throttle(() => {
            if (window.pageYOffset > 300) {
                backToTopBtn.style.display = 'flex';
                backToTopBtn.style.opacity = '1';
            } else {
                backToTopBtn.style.opacity = '0';
                setTimeout(() => {
                    if (window.pageYOffset <= 300) {
                        backToTopBtn.style.display = 'none';
                    }
                }, 300);
            }
        }, 100);

        window.addEventListener('scroll', toggleVisibility);

        backToTopBtn.addEventListener('click', () => {
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        });
    }

    // ==========================================================================
    // SMOOTH HEADER SCROLL EFFECT
    // ==========================================================================
    function initHeaderScroll() {
        const header = document.querySelector('.header');
        if (!header) return;

        let lastScroll = 0;
        
        const handleScroll = throttle(() => {
            const currentScroll = window.pageYOffset;
            
            if (currentScroll <= 0) {
                header.style.transform = 'translateY(0)';
                return;
            }
            
            // Optional: Hide header on scroll down, show on scroll up
            // Uncomment if you want this behavior
            /*
            if (currentScroll > lastScroll && currentScroll > 100) {
                // Scrolling down
                header.style.transform = 'translateY(-100%)';
            } else {
                // Scrolling up
                header.style.transform = 'translateY(0)';
            }
            */
            
            lastScroll = currentScroll;
        }, 100);

        window.addEventListener('scroll', handleScroll);
    }

    // ==========================================================================
    // PRODUCT CARD ANIMATIONS
    // ==========================================================================
    function initProductAnimations() {
        const productItems = document.querySelectorAll('.product-item');
        
        if ('IntersectionObserver' in window) {
            const productObserver = new IntersectionObserver((entries) => {
                entries.forEach((entry, index) => {
                    if (entry.isIntersecting) {
                        setTimeout(() => {
                            entry.target.style.opacity = '1';
                            entry.target.style.transform = 'translateY(0)';
                        }, index * 50); // Stagger animation
                        productObserver.unobserve(entry.target);
                    }
                });
            }, {
                threshold: 0.1
            });

            productItems.forEach(item => {
                item.style.opacity = '0';
                item.style.transform = 'translateY(30px)';
                item.style.transition = 'opacity 0.4s ease, transform 0.4s ease';
                productObserver.observe(item);
            });
        } else {
            productItems.forEach(item => {
                item.style.opacity = '1';
                item.style.transform = 'translateY(0)';
            });
        }
    }

    // ==========================================================================
    // SEARCH FUNCTIONALITY
    // ==========================================================================
    function initSearch() {
        const searchInput = document.querySelector('.search-container input');
        if (!searchInput) return;

        const handleSearch = debounce((e) => {
            const searchTerm = e.target.value.toLowerCase().trim();
            
            if (searchTerm === '') {
                // Reset all products visibility
                document.querySelectorAll('.product-item').forEach(item => {
                    item.style.display = 'flex';
                });
                return;
            }

            // Filter products (adjust selector as needed)
            document.querySelectorAll('.product-item').forEach(item => {
                const title = item.querySelector('.product-title');
                if (title) {
                    const text = title.textContent.toLowerCase();
                    item.style.display = text.includes(searchTerm) ? 'flex' : 'none';
                }
            });
        }, 300);

        searchInput.addEventListener('input', handleSearch);
    }

    // ==========================================================================
    // LOADING OVERLAY
    // ==========================================================================
    function showLoading() {
        const overlay = document.getElementById('loadingOverlay');
        if (overlay) {
            overlay.style.display = 'flex';
        }
    }

    function hideLoading() {
        const overlay = document.getElementById('loadingOverlay');
        if (overlay) {
            setTimeout(() => {
                overlay.style.display = 'none';
            }, 300);
        }
    }

    // ==========================================================================
    // MENU ACTIVE STATE
    // ==========================================================================
    function initMenuActiveState() {
        const menuItems = document.querySelectorAll('.menu-item');
        const currentPath = window.location.pathname.toLowerCase();

        menuItems.forEach(item => {
            const button = item;
            
            // Check if the button's onclick or text matches current page
            if (button.textContent) {
                const text = button.textContent.trim().toLowerCase();
                
                if (
                    (text.includes('trang chủ') && currentPath.includes('home')) ||
                    (text.includes('liên hệ') && currentPath.includes('contact')) ||
                    (text.includes('dịch vụ') && currentPath.includes('dichvu')) ||
                    (text.includes('giỏ hàng') && currentPath.includes('giohang')) ||
                    (text.includes('sản phẩm') && currentPath.includes('sanpham')) ||
                    (text.includes('tài khoản') && currentPath.includes('taikhoan'))
                ) {
                    button.classList.add('active');
                }
            }
        });
    }

    // ==========================================================================
    // FORM VALIDATION
    // ==========================================================================
    function initFormValidation() {
        const forms = document.querySelectorAll('form');
        
        forms.forEach(form => {
            form.addEventListener('submit', (e) => {
                const inputs = form.querySelectorAll('input[required], textarea[required]');
                let isValid = true;

                inputs.forEach(input => {
                    if (!input.value.trim()) {
                        isValid = false;
                        input.style.borderColor = 'var(--soft-red)';
                        
                        setTimeout(() => {
                            input.style.borderColor = '';
                        }, 2000);
                    }
                });

                if (!isValid) {
                    e.preventDefault();
                }
            });
        });
    }

    // ==========================================================================
    // SMOOTH ANCHOR LINKS
    // ==========================================================================
    function initSmoothAnchors() {
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                const href = this.getAttribute('href');
                if (href === '#') return;

                e.preventDefault();
                const target = document.querySelector(href);
                
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });
    }

    // ==========================================================================
    // PERFORMANCE MONITORING
    // ==========================================================================
    function logPerformance() {
        if ('performance' in window) {
            window.addEventListener('load', () => {
                setTimeout(() => {
                    const perfData = window.performance.timing;
                    const pageLoadTime = perfData.loadEventEnd - perfData.navigationStart;
                    console.log(`⚡ Page loaded in ${pageLoadTime}ms`);
                }, 0);
            });
        }
    }

    // ==========================================================================
    // INITIALIZE ALL
    // ==========================================================================
    function init() {
        // Wait for DOM to be ready
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', () => {
                initializeFeatures();
            });
        } else {
            initializeFeatures();
        }
    }

    function initializeFeatures() {
        console.log('🚀 Initializing optimized features...');
        
        // Initialize all features
        initLazyLoading();
        initBackToTop();
        initHeaderScroll();
        initProductAnimations();
        initSearch();
        initMenuActiveState();
        initFormValidation();
        initSmoothAnchors();
        logPerformance();

        // Hide loading overlay when page is fully loaded
        window.addEventListener('load', () => {
            hideLoading();
            console.log('✓ Page fully loaded and optimized');
        });

        console.log('✓ All features initialized');
    }

    // Start initialization
    init();

    // Export functions for external use
    window.ShopOptimizer = {
        showLoading,
        hideLoading,
        debounce,
        throttle
    };

})();
