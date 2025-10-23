// AI Chat Bubble JavaScript
class AIChatBubble {
    constructor() {
        this.isOpen = false;
        this.isTyping = false;
        this.chatHistory = [];
        this.init();
    }

    init() {
        this.createChatBubble();
        this.bindEvents();
        this.addWelcomeMessage();
    }

    createChatBubble() {
        const chatBubbleHTML = `
            <div class="ai-chat-bubble">
                <div class="chat-window" id="chatWindow">
                    <div class="chat-header">
                        <h3 class="chat-title">Trợ lý AI</h3>
                        <button class="close-chat" id="closeChat">×</button>
                    </div>
                    <div class="chat-messages" id="chatMessages">
                        <!-- Messages will be added here -->
                    </div>
                    <div class="chat-input-area">
                        <textarea class="chat-input" id="chatInput" placeholder="Nhập câu hỏi của bạn..." rows="1"></textarea>
                        <button class="send-button" id="sendButton">
                            <span class="send-icon">📤</span>
                        </button>
                    </div>
                </div>
                <button class="chat-button" id="chatButton">
                    <span class="chat-icon">💬</span>
                </button>
            </div>
        `;

        document.body.insertAdjacentHTML('beforeend', chatBubbleHTML);
    }

    bindEvents() {
        const chatButton = document.getElementById('chatButton');
        const closeChat = document.getElementById('closeChat');
        const sendButton = document.getElementById('sendButton');
        const chatInput = document.getElementById('chatInput');
        const chatWindow = document.getElementById('chatWindow');

        // Toggle chat window
        chatButton.addEventListener('click', () => {
            this.toggleChat();
        });

        closeChat.addEventListener('click', () => {
            this.closeChat();
        });

        // Send message
        sendButton.addEventListener('click', () => {
            this.sendMessage();
        });

        // Send on Enter key
        chatInput.addEventListener('keypress', (e) => {
            if (e.key === 'Enter' && !e.shiftKey) {
                e.preventDefault();
                this.sendMessage();
            }
        });

        // Auto-resize textarea
        chatInput.addEventListener('input', () => {
            this.autoResizeTextarea(chatInput);
        });

        // Close chat when clicking outside
        document.addEventListener('click', (e) => {
            if (this.isOpen && !chatWindow.contains(e.target) && !chatButton.contains(e.target)) {
                this.closeChat();
            }
        });
    }

    toggleChat() {
        const chatWindow = document.getElementById('chatWindow');
        const chatButton = document.getElementById('chatButton');
        
        if (this.isOpen) {
            this.closeChat();
        } else {
            this.openChat();
        }
    }

    openChat() {
        const chatWindow = document.getElementById('chatWindow');
        const chatInput = document.getElementById('chatInput');
        
        chatWindow.classList.add('active');
        this.isOpen = true;
        
        // Focus on input after animation
        setTimeout(() => {
            chatInput.focus();
        }, 300);
    }

    closeChat() {
        const chatWindow = document.getElementById('chatWindow');
        chatWindow.classList.remove('active');
        this.isOpen = false;
    }

    autoResizeTextarea(textarea) {
        textarea.style.height = 'auto';
        textarea.style.height = Math.min(textarea.scrollHeight, 100) + 'px';
    }

    addWelcomeMessage() {
        const chatMessages = document.getElementById('chatMessages');
        const welcomeMessage = `
            <div class="welcome-message">
                <h4>👋 Chào mừng đến với Radian Shop!</h4>
                <p>Tôi là trợ lý AI của bạn. Tôi có thể giúp bạn:</p>
                <ul style="text-align: left; margin: 10px 0;">
                    <li>🔍 Tìm hiểu về sản phẩm điện tử</li>
                    <li>💡 Đưa ra lời khuyên mua sắm</li>
                    <li>📱 So sánh các thiết bị</li>
                    <li>❓ Trả lời câu hỏi về công nghệ</li>
                </ul>
                <p>Hãy hỏi tôi bất cứ điều gì!</p>
            </div>
        `;
        chatMessages.innerHTML = welcomeMessage;
    }

    async sendMessage() {
        const chatInput = document.getElementById('chatInput');
        const sendButton = document.getElementById('sendButton');
        const message = chatInput.value.trim();

        if (!message || this.isTyping) return;

        // Add user message to chat
        this.addMessage(message, 'user');
        
        // Clear input
        chatInput.value = '';
        this.autoResizeTextarea(chatInput);
        
        // Disable send button
        sendButton.disabled = true;
        this.isTyping = true;

        // Show typing indicator
        this.showTypingIndicator();

        try {
            // Send to Gemini API
            const response = await this.callGeminiAPI(message);
            this.hideTypingIndicator();
            this.addMessage(response, 'ai');
        } catch (error) {
            console.error('Error calling Gemini API:', error);
            this.hideTypingIndicator();
            
            // Get fallback response based on message content
            const fallbackResponse = this.getFallbackResponse(message);
            this.addMessage(fallbackResponse, 'ai');
        } finally {
            sendButton.disabled = false;
            this.isTyping = false;
            chatInput.focus();
        }
    }
    
    getFallbackResponse(message) {
        const lowerMessage = message.toLowerCase();
        
        // Product queries
        if (lowerMessage.includes('điện thoại') || lowerMessage.includes('phone')) {
            return '📱 Chúng tôi có nhiều dòng điện thoại:\n\n' +
                   '• iPhone 15 Pro Max - 29.990.000 ₫\n' +
                   '• Samsung Galaxy S24 Ultra - 27.990.000 ₫\n' +
                   '• Xiaomi 14 - 14.990.000 ₫\n\n' +
                   'Bạn muốn tìm hiểu thêm về dòng nào?';
        }
        
        if (lowerMessage.includes('laptop')) {
            return '💻 Các dòng laptop phổ biến:\n\n' +
                   '• MacBook Air M3 - 31.990.000 ₫\n' +
                   '• Dell XPS 15 - 45.990.000 ₫\n' +
                   '• ASUS ROG Zephyrus - 42.990.000 ₫\n\n' +
                   'Bạn cần laptop cho mục đích gì?';
        }
        
        if (lowerMessage.includes('giá') || lowerMessage.includes('bao nhiêu')) {
            return '💰 Tôi có thể giúp bạn tìm sản phẩm theo mức giá:\n\n' +
                   '• Dưới 10 triệu\n' +
                   '• 10-20 triệu\n' +
                   '• 20-30 triệu\n' +
                   '• Trên 30 triệu\n\n' +
                   'Bạn muốn tìm trong khoảng giá nào?';
        }
        
        if (lowerMessage.includes('khuyến mãi') || lowerMessage.includes('giảm giá')) {
            return '🎁 Khuyến mãi đang có:\n\n' +
                   '• Giảm 15% cho iPhone 15 Series\n' +
                   '• Tặng AirPods khi mua MacBook\n' +
                   '• Giảm 20% phụ kiện khi mua laptop\n\n' +
                   'Ghé shop để nhận ưu đãi nhé!';
        }
        
        // Greetings
        if (lowerMessage.includes('xin chào') || lowerMessage.includes('chào') || 
            lowerMessage.includes('hi') || lowerMessage.includes('hello')) {
            return '👋 Xin chào! Tôi là trợ lý AI của Radian Shop.\n\n' +
                   'Tôi có thể giúp bạn:\n' +
                   '• Tìm sản phẩm phù hợp\n' +
                   '• So sánh thiết bị\n' +
                   '• Tư vấn mua hàng\n' +
                   '• Trả lời thắc mắc về công nghệ\n\n' +
                   'Bạn cần tìm sản phẩm gì?';
        }
        
        // Default response
        return '🤖 Xin lỗi, tôi đang gặp chút vấn đề kết nối với AI server.\n\n' +
               'Nhưng tôi vẫn có thể giúp bạn! Hãy thử hỏi về:\n' +
               '• 📱 Điện thoại (iPhone, Samsung...)\n' +
               '• 💻 Laptop (MacBook, Dell, ASUS...)\n' +
               '• 🎧 Tai nghe & phụ kiện\n' +
               '• 💰 Giá cả & khuyến mãi\n\n' +
               'Hoặc bạn có thể gọi hotline: 1900-xxxx';
    }

    addMessage(message, sender) {
        const chatMessages = document.getElementById('chatMessages');
        const messageDiv = document.createElement('div');
        messageDiv.className = `chat-message message-${sender}`;
        
        // Format message with proper line breaks and emojis
        messageDiv.innerHTML = this.formatMessage(message);
        
        chatMessages.appendChild(messageDiv);
        chatMessages.scrollTop = chatMessages.scrollHeight;

        // Store in history
        this.chatHistory.push({ message, sender, timestamp: new Date() });
    }
    
    formatMessage(message) {
        // Message already contains safe HTML from server (br, b, span tags)
        // Just add some styling enhancements
        let formatted = message
            .replace(/•/g, '<span style="color: #667eea; font-weight: bold;">•</span>')
            .replace(/₫/g, '<span style="color: #e74c3c; font-weight: 600;">₫</span>')
            .replace(/🔥/g, '<span style="font-size: 1.2em;">🔥</span>')
            .replace(/⚡/g, '<span style="font-size: 1.2em;">⚡</span>')
            .replace(/💎/g, '<span style="font-size: 1.2em;">💎</span>');
        
        return formatted;
    }

    showTypingIndicator() {
        const chatMessages = document.getElementById('chatMessages');
        const typingDiv = document.createElement('div');
        typingDiv.className = 'typing-indicator active';
        typingDiv.id = 'typingIndicator';
        typingDiv.innerHTML = `
            <div class="typing-dot"></div>
            <div class="typing-dot"></div>
            <div class="typing-dot"></div>
        `;
        
        chatMessages.appendChild(typingDiv);
        chatMessages.scrollTop = chatMessages.scrollHeight;
    }

    hideTypingIndicator() {
        const typingIndicator = document.getElementById('typingIndicator');
        if (typingIndicator) {
            typingIndicator.remove();
        }
    }

    async callGeminiAPI(message) {
        try {
            console.log('Sending message to Gemini API:', message);
            
            // Detect if we're in admin panel or main site
            const isAdmin = window.location.pathname.toLowerCase().includes('/admin/');
            const handlerPath = isAdmin ? '../ChatBot/SimpleChatHandler.ashx' : 'ChatBot/SimpleChatHandler.ashx';
            
            const response = await fetch(handlerPath, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ message: message })
            });

            console.log('Response status:', response.status);
            console.log('Response ok:', response.ok);

            if (!response.ok) {
                const errorText = await response.text();
                console.error('Response error:', errorText);
                throw new Error(`HTTP error! status: ${response.status}`);
            }

            const responseText = await response.text();
            console.log('Response text:', responseText);
            
            let data;
            try {
                data = JSON.parse(responseText);
                console.log('Parsed data:', data);
            } catch (parseError) {
                console.error('JSON parse error:', parseError);
                console.error('Response text:', responseText);
                throw new Error('Invalid JSON response from server');
            }
            
            if (data.error) {
                console.error('API error:', data.error);
                throw new Error(data.error);
            }

            console.log('AI response:', data.response);
            return data.response || 'Không có phản hồi từ AI.';
            
        } catch (error) {
            console.error('callGeminiAPI error:', error);
            throw error;
        }
    }

    // Utility methods
    clearChat() {
        const chatMessages = document.getElementById('chatMessages');
        chatMessages.innerHTML = '';
        this.chatHistory = [];
        this.addWelcomeMessage();
    }

    exportChat() {
        const chatData = {
            timestamp: new Date().toISOString(),
            messages: this.chatHistory
        };
        
        const blob = new Blob([JSON.stringify(chatData, null, 2)], { type: 'application/json' });
        const url = URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = `chat-history-${new Date().toISOString().split('T')[0]}.json`;
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
        URL.revokeObjectURL(url);
    }
}

// Initialize chat bubble when DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
    console.log('DOM loaded, initializing AI Chat Bubble...');
    try {
        window.aiChatBubble = new AIChatBubble();
        console.log('AI Chat Bubble initialized successfully!');
    } catch (error) {
        console.error('Error initializing AI Chat Bubble:', error);
    }
});

// Fallback initialization if DOMContentLoaded already fired
if (document.readyState === 'loading') {
    // DOM is still loading, wait for DOMContentLoaded
} else {
    // DOM is already loaded, initialize immediately
    console.log('DOM already loaded, initializing AI Chat Bubble immediately...');
    try {
        window.aiChatBubble = new AIChatBubble();
        console.log('AI Chat Bubble initialized successfully!');
    } catch (error) {
        console.error('Error initializing AI Chat Bubble:', error);
    }
}

// Add some helpful keyboard shortcuts
document.addEventListener('keydown', (e) => {
    // Ctrl/Cmd + / to toggle chat
    if ((e.ctrlKey || e.metaKey) && e.key === '/') {
        e.preventDefault();
        if (window.aiChatBubble) {
            window.aiChatBubble.toggleChat();
        }
    }
    
    // Escape to close chat
    if (e.key === 'Escape' && window.aiChatBubble && window.aiChatBubble.isOpen) {
        window.aiChatBubble.closeChat();
    }
});

// Add chat bubble to global scope for debugging
window.AIChatBubble = AIChatBubble;
