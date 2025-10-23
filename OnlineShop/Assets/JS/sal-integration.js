// ==========================================================================
// SAL.JS INTEGRATION - ULTRA MINIMAL
// Zero custom animations - Let Sal.js handle everything
// ==========================================================================

(function() {
    'use strict';

    // ==========================================================================
    // INITIALIZE SAL.JS
    // ==========================================================================
    function initSal() {
        if (typeof sal === 'undefined') {
            console.warn('⚠️ Sal.js not loaded. Please include it in your HTML.');
            return;
        }

        sal({
            threshold: 0.1,        // Element must be 10% visible
            once: true,            // Animate only once (better performance)
            duration: 400,         // Animation duration in ms
            delay: 0,              // No delay
            easing: 'ease-out'     // Smooth easing
        });

        console.log('✓ Sal.js initialized');
    }

    // ==========================================================================
    // BACK TO TOP BUTTON (Minimal)
    // ==========================================================================
    function initBackToTop() {
        const btn = document.getElementById('backToTop');
        if (!btn) return;

        let scrolling = false;

        window.addEventListener('scroll', function() {
            if (!scrolling) {
                scrolling = true;
                requestAnimationFrame(function() {
                    if (window.pageYOffset > 300) {
                        btn.style.display = 'flex';
                    } else {
                        btn.style.display = 'none';
                    }
                    scrolling = false;
                });
            }
        }, { passive: true });

        btn.addEventListener('click', function() {
            window.scrollTo({ top: 0, behavior: 'smooth' });
        });
    }

    // ==========================================================================
    // LAZY LOAD IMAGES (Native)
    // ==========================================================================
    function initLazyLoad() {
        // Modern browsers support loading="lazy" attribute
        // This is just a fallback for older browsers
        if ('loading' in HTMLImageElement.prototype) {
            const images = document.querySelectorAll('img[data-src]');
            images.forEach(img => {
                img.src = img.dataset.src;
                img.removeAttribute('data-src');
            });
        } else {
            // Fallback: Load immediately
            const images = document.querySelectorAll('img[data-src]');
            images.forEach(img => {
                img.src = img.dataset.src;
                img.removeAttribute('data-src');
            });
        }
    }

    // ==========================================================================
    // SEARCH (Minimal debounce)
    // ==========================================================================
    function initSearch() {
        const searchInput = document.querySelector('.search-container input');
        if (!searchInput) return;

        let timeout;
        searchInput.addEventListener('input', function(e) {
            clearTimeout(timeout);
            timeout = setTimeout(function() {
                const term = e.target.value.toLowerCase().trim();
                const products = document.querySelectorAll('.product-item');
                
                products.forEach(function(product) {
                    const title = product.querySelector('.product-title');
                    if (title) {
                        const text = title.textContent.toLowerCase();
                        product.style.display = text.includes(term) || term === '' ? 'flex' : 'none';
                    }
                });
            }, 300);
        });
    }

    // ==========================================================================
    // MENU ACTIVE STATE
    // ==========================================================================
    function initMenuActive() {
        const path = window.location.pathname.toLowerCase();
        const menuItems = document.querySelectorAll('.menu-item');
        
        menuItems.forEach(function(item) {
            const text = item.textContent.trim().toLowerCase();
            
            if (
                (text.includes('trang chủ') && path.includes('home')) ||
                (text.includes('liên hệ') && path.includes('contact')) ||
                (text.includes('dịch vụ') && path.includes('dichvu')) ||
                (text.includes('giỏ hàng') && path.includes('giohang')) ||
                (text.includes('sản phẩm') && path.includes('sanpham')) ||
                (text.includes('tài khoản') && path.includes('taikhoan'))
            ) {
                item.classList.add('active');
            }
        });
    }

    // ==========================================================================
    // HIDE LOADING OVERLAY
    // ==========================================================================
    function hideLoading() {
        const overlay = document.getElementById('loadingOverlay');
        if (overlay) {
            setTimeout(function() {
                overlay.style.display = 'none';
            }, 200);
        }
    }

    // ==========================================================================
    // PERFORMANCE MONITORING (Optional)
    // ==========================================================================
    function logPerformance() {
        if ('performance' in window && 'timing' in window.performance) {
            window.addEventListener('load', function() {
                setTimeout(function() {
                    const timing = window.performance.timing;
                    const loadTime = timing.loadEventEnd - timing.navigationStart;
                    console.log('⚡ Page loaded in ' + loadTime + 'ms');
                    
                    // Log FPS if available
                    if ('getEntriesByType' in window.performance) {
                        const navigation = window.performance.getEntriesByType('navigation')[0];
                        if (navigation) {
                            console.log('✓ DOM Content Loaded: ' + navigation.domContentLoadedEventEnd + 'ms');
                        }
                    }
                }, 0);
            });
        }
    }

    // ==========================================================================
    // INITIALIZE EVERYTHING
    // ==========================================================================
    function init() {
        // Wait for DOM
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', start);
        } else {
            start();
        }
    }

    function start() {
        console.log('🚀 Initializing ultra-performance mode with Sal.js...');
        
        // Initialize features
        initSal();
        initBackToTop();
        initLazyLoad();
        initSearch();
        initMenuActive();
        logPerformance();

        // Hide loading when ready
        window.addEventListener('load', function() {
            hideLoading();
            console.log('✓ Page fully loaded and optimized with Sal.js');
        });
    }

    // Start
    init();

    // Export minimal API
    window.ShopSal = {
        refresh: function() {
            if (typeof sal !== 'undefined' && sal.refresh) {
                sal.refresh();
            }
        }
    };

})();
