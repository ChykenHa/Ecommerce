/**
 * Modern Site Scripts - Online Shop
 * ES6+ JavaScript with advanced features and optimizations
 * @version 2.0.0
 * @author Radian Shop Team
 */

'use strict';

// ============================================================================
// 1. UTILITY FUNCTIONS & HELPERS
// ============================================================================

/**
 * Utility class for common helper functions
 */
class Utils {
    /**
     * Debounce function to limit execution rate
     * @param {Function} func - Function to debounce
     * @param {number} wait - Wait time in milliseconds
     * @returns {Function} Debounced function
     */
    static debounce(func, wait = 300) {
        let timeout;
        return (...args) => {
            clearTimeout(timeout);
            timeout = setTimeout(() => func.apply(this, args), wait);
        };
    }

    /**
     * Throttle function to limit execution rate
     * @param {Function} func - Function to throttle
     * @param {number} limit - Time limit in milliseconds
     * @returns {Function} Throttled function
     */
    static throttle(func, limit = 100) {
        let inThrottle;
        return (...args) => {
            if (!inThrottle) {
                func.apply(this, args);
                inThrottle = true;
                setTimeout(() => inThrottle = false, limit);
            }
        };
    }

    /**
     * Check if element is in viewport
     * @param {HTMLElement} element - Element to check
     * @returns {boolean} True if in viewport
     */
    static isInViewport(element) {
        const rect = element.getBoundingClientRect();
        return (
            rect.top >= 0 &&
            rect.left >= 0 &&
            rect.bottom <= (window.innerHeight || document.documentElement.clientHeight) &&
            rect.right <= (window.innerWidth || document.documentElement.clientWidth)
        );
    }

    /**
     * Get element by selector safely
     * @param {string} selector - CSS selector
     * @returns {HTMLElement|null} Element or null
     */
    static $(selector) {
        return document.querySelector(selector);
    }

    /**
     * Get all elements by selector safely
     * @param {string} selector - CSS selector
     * @returns {NodeList} NodeList of elements
     */
    static $$(selector) {
        return document.querySelectorAll(selector);
    }

    /**
     * Add event listener with error handling
     * @param {HTMLElement|Window|Document} element - Element to attach listener
     * @param {string} event - Event type
     * @param {Function} handler - Event handler
     * @param {Object} options - Event options
     */
    static addListener(element, event, handler, options = {}) {
        if (!element) return;
        
        try {
            element.addEventListener(event, handler, options);
        } catch (error) {
            console.error(`Error adding event listener: ${error.message}`);
        }
    }
}

// ============================================================================
// 2. SCROLL MANAGER - Modern scroll handling with IntersectionObserver
// ============================================================================

class ScrollManager {
    constructor() {
        this.scrollPosition = 0;
        this.ticking = false;
        this.init();
    }

    init() {
        this.setupBackToTop();
        this.setupScrollAnimations();
        this.setupStickyHeader();
    }

    /**
     * Setup back to top button with modern approach
     */
    setupBackToTop() {
        const backToTopBtn = Utils.$('#backToTop');
        if (!backToTopBtn) return;

        // Hide by default
        backToTopBtn.style.display = 'none';
        backToTopBtn.style.cssText = `
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white;
            border: 2px solid rgba(255, 255, 255, 0.3);
            box-shadow: var(--shadow-lg);
            cursor: pointer;
            z-index: 1000;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            display: grid;
            place-items: center;
            font-size: 24px;
            font-weight: bold;
        `;
        
        backToTopBtn.innerHTML = '↑';

        // Use throttled scroll handler for better performance
        const handleScroll = Utils.throttle(() => {
            requestAnimationFrame(() => {
                backToTopBtn.style.display = window.pageYOffset > 300 ? 'grid' : 'none';
                if (window.pageYOffset > 300) {
                    backToTopBtn.style.transform = 'scale(1) rotate(0deg)';
                }
            });
        }, 100);

        Utils.addListener(window, 'scroll', handleScroll, { passive: true });

        // Smooth scroll to top
        Utils.addListener(backToTopBtn, 'click', () => {
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        });

        // Hover effects
        Utils.addListener(backToTopBtn, 'mouseenter', () => {
            backToTopBtn.style.transform = 'scale(1.1) translateY(-5px)';
            backToTopBtn.style.boxShadow = '0 15px 30px rgba(0, 119, 182, 0.4)';
        });

        Utils.addListener(backToTopBtn, 'mouseleave', () => {
            backToTopBtn.style.transform = 'scale(1) translateY(0)';
            backToTopBtn.style.boxShadow = 'var(--shadow-lg)';
        });
    }

    /**
     * Setup scroll-based animations using IntersectionObserver
     */
    setupScrollAnimations() {
        const animatedElements = Utils.$$('[data-animate]');
        if (animatedElements.length === 0) return;

        const observerOptions = {
            root: null,
            rootMargin: '0px 0px -100px 0px',
            threshold: 0.1
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const animation = entry.target.dataset.animate || 'fadeIn';
                    entry.target.classList.add(animation);
                    observer.unobserve(entry.target);
                }
            });
        }, observerOptions);

        animatedElements.forEach(element => observer.observe(element));
    }

    /**
     * Setup sticky header behavior
     */
    setupStickyHeader() {
        const header = Utils.$('.header');
        if (!header) return;

        let lastScroll = 0;

        const handleHeaderScroll = Utils.throttle(() => {
            requestAnimationFrame(() => {
                const currentScroll = window.pageYOffset;
                
                if (currentScroll <= 0) {
                    header.style.transform = 'translateY(0)';
                    return;
                }
                
                if (currentScroll > lastScroll && currentScroll > 100) {
                    // Scrolling down
                    header.style.transform = 'translateY(-100%)';
                } else {
                    // Scrolling up
                    header.style.transform = 'translateY(0)';
                    header.style.boxShadow = '0 8px 32px rgba(15, 42, 62, 0.3)';
                }
                
                lastScroll = currentScroll;
            });
        }, 100);

        Utils.addListener(window, 'scroll', handleHeaderScroll, { passive: true });
    }
}

// ============================================================================
// 3. SEARCH MANAGER - Enhanced search functionality
// ============================================================================

class SearchManager {
    constructor() {
        this.searchInput = Utils.$('.search-container input');
        this.searchResults = [];
        this.init();
    }

    init() {
        if (!this.searchInput) return;

        // Debounced search
        const debouncedSearch = Utils.debounce((value) => {
            this.performSearch(value);
        }, 500);

        Utils.addListener(this.searchInput, 'input', (e) => {
            debouncedSearch(e.target.value);
        });

        // Handle Enter key
        Utils.addListener(this.searchInput, 'keypress', (e) => {
            if (e.key === 'Enter') {
                e.preventDefault();
                this.performSearch(this.searchInput.value);
            }
        });

        // Add search icon animation
        this.setupSearchAnimation();
    }

    /**
     * Perform search operation
     * @param {string} query - Search query
     */
    async performSearch(query) {
        if (!query || query.trim().length < 2) return;

        console.log(`Searching for: ${query}`);
        
        // Add loading state
        this.searchInput.classList.add('loading');
        
        try {
            // Simulate API call - replace with actual search implementation
            await new Promise(resolve => setTimeout(resolve, 300));
            
            // Your search logic here
            console.log('Search results:', this.searchResults);
            
        } catch (error) {
            console.error('Search error:', error);
        } finally {
            this.searchInput.classList.remove('loading');
        }
    }

    /**
     * Setup search input animations
     */
    setupSearchAnimation() {
        if (!this.searchInput) return;

        Utils.addListener(this.searchInput, 'focus', () => {
            this.searchInput.parentElement?.classList.add('focused');
        });

        Utils.addListener(this.searchInput, 'blur', () => {
            this.searchInput.parentElement?.classList.remove('focused');
        });
    }
}

// ============================================================================
// 4. AD BANNER MANAGER - Modern ad banner interactions
// ============================================================================

class AdBannerManager {
    constructor() {
        this.adItems = Utils.$$('.ad-item');
        this.adBanners = Utils.$$('.ad-banner-left, .ad-banner-right');
        this.init();
    }

    init() {
        this.setupAdItemAnimations();
        this.setupAdBannerScrolling();
        this.setupAdItemClicks();
    }

    /**
     * Setup ad item entrance animations
     */
    setupAdItemAnimations() {
        if (this.adItems.length === 0) return;

        const observerOptions = {
            root: null,
            rootMargin: '0px',
            threshold: 0.15
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach((entry, index) => {
                if (entry.isIntersecting) {
                    setTimeout(() => {
                        entry.target.style.opacity = '1';
                        entry.target.style.transform = 'translateY(0)';
                    }, index * 100);
                    observer.unobserve(entry.target);
                }
            });
        }, observerOptions);

        this.adItems.forEach((item) => {
            item.style.opacity = '0';
            item.style.transform = 'translateY(30px)';
            item.style.transition = 'all 0.6s cubic-bezier(0.4, 0, 0.2, 1)';
            observer.observe(item);
        });
    }

    /**
     * Setup smooth scrolling for ad banners
     */
    setupAdBannerScrolling() {
        this.adBanners.forEach(banner => {
            let isHovering = false;
            let autoScrollEnabled = false; // Disabled by default

            Utils.addListener(banner, 'mouseenter', () => {
                isHovering = true;
            });

            Utils.addListener(banner, 'mouseleave', () => {
                isHovering = false;
            });

            if (autoScrollEnabled) {
                this.startAutoScroll(banner, isHovering);
            }
        });
    }

    /**
     * Start auto-scrolling for banner
     * @param {HTMLElement} banner - Banner element
     * @param {boolean} isHovering - Hover state
     */
    startAutoScroll(banner, isHovering) {
        let scrollDirection = 1;
        const scrollSpeed = 0.5;
        
        const autoScroll = () => {
            if (!isHovering && banner.scrollHeight > banner.clientHeight) {
                banner.scrollTop += scrollSpeed * scrollDirection;
                
                if (banner.scrollTop <= 0) {
                    scrollDirection = 1;
                } else if (banner.scrollTop >= banner.scrollHeight - banner.clientHeight) {
                    scrollDirection = -1;
                }
            }
            requestAnimationFrame(autoScroll);
        };
        
        requestAnimationFrame(autoScroll);
    }

    /**
     * Setup ad item click tracking
     */
    setupAdItemClicks() {
        this.adItems.forEach((item, index) => {
            Utils.addListener(item, 'click', () => {
                // Add click animation
                item.style.transform = 'scale(0.95)';
                
                setTimeout(() => {
                    item.style.transform = '';
                }, 150);
                
                // Analytics tracking
                this.trackAdClick(index, item);
            });
        });
    }

    /**
     * Track ad click (analytics placeholder)
     * @param {number} index - Ad index
     * @param {HTMLElement} item - Ad element
     */
    trackAdClick(index, item) {
        const adData = {
            index,
            timestamp: new Date().toISOString(),
            title: item.querySelector('h4')?.textContent || 'Unknown',
        };
        
        console.log('Ad clicked:', adData);
        
        // Add your analytics tracking here (e.g., Google Analytics, custom API)
        // Example: gtag('event', 'ad_click', adData);
    }
}

// ============================================================================
// 5. FORM MANAGER - Enhanced form handling
// ============================================================================

class FormManager {
    constructor() {
        this.forms = Utils.$$('form');
        this.init();
    }

    init() {
        this.setupFormSubmissions();
        this.setupFormValidation();
    }

    /**
     * Setup form submission handlers
     */
    setupFormSubmissions() {
        this.forms.forEach(form => {
            Utils.addListener(form, 'submit', async (e) => {
                // Don't prevent default for ASP.NET forms
                const loadingOverlay = Utils.$('#loadingOverlay');
                
                if (loadingOverlay) {
                    loadingOverlay.style.display = 'flex';
                    
                    // Hide after 5 seconds as fallback
                    setTimeout(() => {
                        loadingOverlay.style.display = 'none';
                    }, 5000);
                }
            });
        });
    }

    /**
     * Setup real-time form validation
     */
    setupFormValidation() {
        const inputs = Utils.$$('input[required], textarea[required]');
        
        inputs.forEach(input => {
            Utils.addListener(input, 'blur', () => {
                this.validateInput(input);
            });
            
            Utils.addListener(input, 'input', Utils.debounce(() => {
                this.validateInput(input);
            }, 500));
        });
    }

    /**
     * Validate individual input
     * @param {HTMLInputElement} input - Input element to validate
     */
    validateInput(input) {
        const isValid = input.checkValidity();
        
        if (isValid) {
            input.classList.remove('invalid');
            input.classList.add('valid');
        } else {
            input.classList.remove('valid');
            input.classList.add('invalid');
        }
    }
}

// ============================================================================
// 6. PRODUCT MANAGER - Product interactions
// ============================================================================

class ProductManager {
    constructor() {
        this.productItems = Utils.$$('.product-item');
        this.init();
    }

    init() {
        this.setupProductHoverEffects();
        this.setupLazyLoading();
        this.convertImagesToWebP();
    }

    /**
     * Convert .jpg image paths to .webp format
     */
    convertImagesToWebP() {
        const allImages = Utils.$$('img');
        
        allImages.forEach(img => {
            this.processImage(img);
        });

        // Setup MutationObserver to handle dynamically added images
        this.observeNewImages();
    }

    /**
     * Process individual image for WebP conversion
     * @param {HTMLImageElement} img - Image element to process
     */
    processImage(img) {
        // Skip if already processed
        if (img.dataset.webpProcessed === 'true') return;
        
        // Get the current image source
        let src = img.getAttribute('src');
        
        if (!src) return;
        
        // Mark as processed to avoid re-processing
        img.dataset.webpProcessed = 'true';
        
        // Check if the image is from Images_DB and has .jpg extension
        if (src.includes('Images_DB') && src.match(/\.jpg$/i)) {
            // Replace .jpg with .webp
            const webpSrc = src.replace(/\.jpg$/i, '.webp');
            
            // Add loading state
            img.style.opacity = '0.5';
            img.style.transition = 'opacity 0.3s ease';
            
            // Create a new image to test if webp exists
            const testImg = new Image();
            testImg.onload = () => {
                // WebP image exists, use it
                img.src = webpSrc;
                img.style.opacity = '1';
                console.log(`✅ Loaded WebP: ${webpSrc}`);
            };
            testImg.onerror = () => {
                // WebP doesn't exist, restore opacity with original
                img.style.opacity = '1';
                console.warn(`⚠️ WebP not found: ${webpSrc}, using original .jpg`);
            };
            testImg.src = webpSrc;
        } else {
            // Not an Images_DB image, just ensure it loads properly
            img.onerror = () => {
                console.error(`❌ Failed to load image: ${src}`);
                // Set a placeholder image if available
                if (!img.src.includes('no-image')) {
                    img.src = 'Assets/Images/no-image.jpg';
                }
            };
        }
    }

    /**
     * Observe for dynamically added images
     */
    observeNewImages() {
        // Create a MutationObserver to watch for new images
        const observer = new MutationObserver((mutations) => {
            mutations.forEach((mutation) => {
                mutation.addedNodes.forEach((node) => {
                    if (node.nodeType === 1) { // Element node
                        // Check if the node is an image
                        if (node.tagName === 'IMG') {
                            this.processImage(node);
                        }
                        // Check for images within the added node
                        const images = node.querySelectorAll?.('img') || [];
                        images.forEach(img => this.processImage(img));
                    }
                });
            });
        });

        // Start observing the document for changes
        observer.observe(document.body, {
            childList: true,
            subtree: true
        });
    }

    /**
     * Setup product hover effects
     */
    setupProductHoverEffects() {
        this.productItems.forEach(product => {
            Utils.addListener(product, 'mouseenter', () => {
                const img = product.querySelector('.product-image img');
                if (img) {
                    img.style.transform = 'scale(1.1)';
                }
            });
            
            Utils.addListener(product, 'mouseleave', () => {
                const img = product.querySelector('.product-image img');
                if (img) {
                    img.style.transform = 'scale(1)';
                }
            });
        });
    }

    /**
     * Setup lazy loading for product images
     */
    setupLazyLoading() {
        const images = Utils.$$('img[data-src]');
        if (images.length === 0) return;

        const imageObserver = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const img = entry.target;
                    img.src = img.dataset.src;
                    img.removeAttribute('data-src');
                    imageObserver.unobserve(img);
                }
            });
        }, {
            rootMargin: '50px'
        });

        images.forEach(img => imageObserver.observe(img));
    }
}

// ============================================================================
// 7. PERFORMANCE MONITOR - Optional performance tracking
// ============================================================================

class PerformanceMonitor {
    constructor() {
        this.metrics = {};
    }

    /**
     * Log page load performance
     */
    logPerformance() {
        if (!('performance' in window)) return;

        const perfData = window.performance.timing;
        const pageLoadTime = perfData.loadEventEnd - perfData.navigationStart;
        const connectTime = perfData.responseEnd - perfData.requestStart;
        const renderTime = perfData.domComplete - perfData.domLoading;

        this.metrics = {
            pageLoadTime: `${(pageLoadTime / 1000).toFixed(2)}s`,
            connectTime: `${(connectTime / 1000).toFixed(2)}s`,
            renderTime: `${(renderTime / 1000).toFixed(2)}s`
        };

        console.table(this.metrics);
    }

    /**
     * Monitor Web Vitals (if supported)
     */
    monitorWebVitals() {
        // Placeholder for Web Vitals monitoring
        // You can integrate with libraries like web-vitals.js
    }
}

// ============================================================================
// 8. MAIN APP INITIALIZATION
// ============================================================================

class App {
    constructor() {
        this.scrollManager = null;
        this.searchManager = null;
        this.adBannerManager = null;
        this.formManager = null;
        this.productManager = null;
        this.performanceMonitor = null;
    }

    /**
     * Initialize all managers
     */
    init() {
        console.log('🚀 Initializing Online Shop...');

        // Initialize all managers
        this.scrollManager = new ScrollManager();
        this.searchManager = new SearchManager();
        this.adBannerManager = new AdBannerManager();
        this.formManager = new FormManager();
        this.productManager = new ProductManager();
        this.performanceMonitor = new PerformanceMonitor();

        // Setup global enhancements
        this.setupGlobalEnhancements();

        console.log('✅ Online Shop initialized successfully!');
    }

    /**
     * Setup global enhancements
     */
    setupGlobalEnhancements() {
        // Add smooth scrolling to all internal links
        const internalLinks = Utils.$$('a[href^="#"]');
        internalLinks.forEach(link => {
            Utils.addListener(link, 'click', (e) => {
                e.preventDefault();
                const target = Utils.$(link.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });

        // Setup newsletter subscription
        this.setupNewsletterSubscription();
        
        // Add loading complete class
        document.body.classList.add('loaded');
    }

    /**
     * Setup newsletter subscription
     */
    setupNewsletterSubscription() {
        const subscribeBtn = Utils.$('.btn-subscribe');
        if (!subscribeBtn) return;

        Utils.addListener(subscribeBtn, 'click', () => {
            const emailInput = Utils.$('.newsletter-form input[type="email"]');
            
            if (emailInput?.value && this.validateEmail(emailInput.value)) {
                this.showNotification('Cảm ơn bạn đã đăng ký nhận tin!', 'success');
                emailInput.value = '';
            } else {
                this.showNotification('Vui lòng nhập email hợp lệ!', 'error');
            }
        });
    }

    /**
     * Validate email address
     * @param {string} email - Email to validate
     * @returns {boolean} True if valid
     */
    validateEmail(email) {
        const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return re.test(email);
    }

    /**
     * Show notification (modern toast-like notification)
     * @param {string} message - Notification message
     * @param {string} type - Notification type (success, error, info)
     */
    showNotification(message, type = 'info') {
        const notification = document.createElement('div');
        notification.className = `notification notification-${type}`;
        notification.textContent = message;
        notification.style.cssText = `
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 16px 24px;
            background: ${type === 'success' ? '#4CAF50' : type === 'error' ? '#f44336' : '#2196F3'};
            color: white;
            border-radius: 12px;
            box-shadow: var(--shadow-xl);
            z-index: 10000;
            animation: slideInRight 0.3s ease;
            font-weight: 600;
        `;

        document.body.appendChild(notification);

        setTimeout(() => {
            notification.style.animation = 'slideOutRight 0.3s ease';
            setTimeout(() => notification.remove(), 300);
        }, 3000);
    }
}

// ============================================================================
// 9. INITIALIZATION
// ============================================================================

// Wait for DOM to be fully loaded
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', () => {
        const app = new App();
        app.init();
    });
} else {
    // DOM already loaded
    const app = new App();
    app.init();
}

// Log performance after page load
window.addEventListener('load', () => {
    const monitor = new PerformanceMonitor();
    setTimeout(() => monitor.logPerformance(), 1000);
});

// Export for potential module use
if (typeof module !== 'undefined' && module.exports) {
    module.exports = { App, Utils };
}
