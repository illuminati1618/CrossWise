---
layout: tailwind
permalink: /userlog
search_exclude: true
show_reading_time: false
---
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
<style>
    :root {
        --color-dark: #121212;
        --color-darker: #1e1e1e;
        --color-accent: #4285f4;
        --color-success: #34a853;
        --color-warning: #fbbc05;
        --border-color: #3c4c60;
    }

    body {
        margin: 0;
        padding: 0;
        font-family: 'Inter', sans-serif;
        height: 100vh;
        width: 100vw;
        overflow: hidden;
        background-color: var(--color-darker);
        color: #f0f4f8;
    }
    
    .welcome-container {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        display: flex;
        align-items: center;
        justify-content: center;
        z-index: 9999;
    }
    
    .welcome-card {
        width: 90%;
        max-width: 600px;
        padding: 2.5rem;
        border-radius: 12px;
        background-color: var(--color-dark);
        border: 2px solid var(--border-color);
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        transition: all 0.3s ease;
        overflow: hidden;
    }
    
    .card-header {
        display: flex;
        align-items: center;
        margin-bottom: 1.5rem;
    }
    
    .logo {
        margin-right: 1.5rem;
    }
    
    .logo-icon {
        width: 48px;
        height: 48px;
        color: var(--color-accent);
    }
    
    #welcome-title {
        font-size: 2rem;
        font-weight: 700;
        margin: 0;
        color: var(--color-accent);
    }
    
    .message-box {
        padding: 1.5rem;
        margin-bottom: 2rem;
        border-radius: 8px;
        background-color: rgba(30, 30, 30, 0.6);
        border-left: 4px solid var(--color-accent);
        position: relative;
    }
    
    #welcome-message {
        font-size: 1.2rem;
        line-height: 1.5;
        margin-top: 0;
    }
    
    /* Enhanced border crossing animation with gates */
    .border-animation {
        height: 120px;
        width: 100%;
        position: relative;
        margin-top: 2rem;
        overflow: hidden;
        border-radius: 8px;
        background-color: rgba(30, 30, 30, 0.4);
        border: 1px solid var(--border-color);
        perspective: 500px;
    }
    
    .road {
        position: absolute;
        width: 100%;
        height: 40px;
        bottom: 20px;
        background-color: #333;
        z-index: 1;
    }
    
    .road-markings {
        position: absolute;
        width: 100%;
        height: 2px;
        bottom: 39px;
        background: repeating-linear-gradient(to right, #ffffff, #ffffff 20px, transparent 20px, transparent 40px);
        z-index: 2;
    }
    
    .checkpoint {
        position: absolute;
        height: 80px;
        width: 120px;
        top: 5px;
        left: 50%;
        transform: translateX(-50%);
        z-index: 10;
    }
    
    .booth {
        position: absolute;
        top: 0;
        left: 50%;
        transform: translateX(-50%);
        width: 40px;
        height: 40px;
        background-color: #f0f4f8;
        border: 1px solid #999;
        z-index: 11;
    }
    
    .booth:before {
        content: '';
        position: absolute;
        top: -10px;
        left: 5px;
        right: 5px;
        height: 10px;
        background-color: var(--color-accent);
        border-radius: 3px 3px 0 0;
    }
    
    /* Gate animation */
    .gate-left, .gate-right {
        position: absolute;
        width: 40px;
        height: 10px;
        background-color: #f0f4f8;
        bottom: 40px;
        z-index: 20;
        transform-origin: center left;
        box-shadow: 0 2px 4px rgba(0,0,0,0.3);
    }
    
    .gate-left {
        right: 50%;
        transform-origin: right center;
        animation: gate-open-left 2s infinite;
    }
    
    .gate-right {
        left: 50%;
        transform-origin: left center;
        animation: gate-open-right 2s infinite;
    }
    
    .stripe {
        position: absolute;
        width: 100%;
        height: 100%;
        background: repeating-linear-gradient(45deg, var(--color-warning), var(--color-warning) 10px, #333 10px, #333 20px);
        opacity: 0.8;
    }
    
    .car {
        width: 50px;
        height: 25px;
        position: absolute;
        bottom: 28px;
        left: -60px;
        background-color: var(--color-accent);
        border-radius: 5px;
        z-index: 5;
        animation: drive 4s linear infinite;
        box-shadow: 0 2px 8px rgba(0,0,0,0.5);
    }
    
    .car:before {
        content: '';
        position: absolute;
        top: -8px;
        left: 10px;
        width: 30px;
        height: 12px;
        background-color: var(--color-accent);
        border-radius: 5px 5px 0 0;
    }
    
    .car:after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 10px;
        width: 8px;
        height: 3px;
        background-color: #ffffff;
        box-shadow: 25px 0 0 #ffffff;
        border-radius: 2px;
    }
    
    .wheel {
        position: absolute;
        width: 8px;
        height: 8px;
        background-color: #333;
        border-radius: 50%;
        bottom: -4px;
        left: 8px;
        box-shadow: 30px 0 0 #333;
    }
    
    .wheel:before, .wheel:after {
        content: '';
        position: absolute;
        width: 3px;
        height: 3px;
        background-color: #f0f4f8;
        border-radius: 50%;
        top: 2.5px;
        left: 2.5px;
        animation: wheel-spin 0.5s linear infinite;
    }
    
    .wheel:after {
        left: 32.5px;
    }
    
    .progress-container {
        margin-top: 1.5rem;
        width: 100%;
        height: 8px;
        background-color: rgba(128, 128, 128, 0.2);
        border-radius: 4px;
        overflow: hidden;
    }
    
    .progress-bar {
        height: 100%;
        width: 0%;
        background-color: var(--color-accent);
        transition: width 0.1s linear;
    }
    
    #login-status {
        font-size: 0.9rem;
        text-align: center;
        margin-top: 0.75rem;
        opacity: 0.8;
    }
    
    @keyframes drive {
        0% {
            left: -60px;
        }
        40% {
            left: calc(50% - 25px);
            animation-timing-function: ease-out;
        }
        45% {
            left: calc(50% - 25px);
        }
        55% {
            left: calc(50% - 25px);
            animation-timing-function: ease-in;
        }
        100% {
            left: calc(100% + 60px);
        }
    }
    
    @keyframes gate-open-left {
        0%, 40% {
            transform: rotate(0deg);
        }
        50%, 90% {
            transform: rotate(-90deg);
        }
        100% {
            transform: rotate(0deg);
        }
    }
    
    @keyframes gate-open-right {
        0%, 40% {
            transform: rotate(0deg);
        }
        50%, 90% {
            transform: rotate(90deg);
        }
        100% {
            transform: rotate(0deg);
        }
    }
    
    @keyframes wheel-spin {
        from { transform: translate(-50%, -50%) rotate(0deg); left: 50%; top: 50%; }
        to { transform: translate(-50%, -50%) rotate(360deg); left: 50%; top: 50%; }
    }
    
    /* Light flash effect */
    .light-flash {
        position: absolute;
        width: 20px;
        height: 20px;
        border-radius: 50%;
        top: 4px;
        left: 50%;
        transform: translateX(-50%);
        background-color: var(--color-warning);
        box-shadow: 0 0 15px var(--color-warning);
        z-index: 30;
        opacity: 0;
        animation: flash 2s infinite;
    }
    
    @keyframes flash {
        0%, 39% {
            opacity: 0;
        }
        40%, 45% {
            opacity: 1;
        }
        46%, 54% {
            opacity: 0;
        }
        55%, 60% {
            opacity: 1;
        }
        61%, 100% {
            opacity: 0;
        }
    }
    
    /* Responsive adjustments */
    @media (max-width: 768px) {
        .welcome-card {
            width: 95%;
            padding: 1.5rem;
        }
        
        #welcome-title {
            font-size: 1.5rem;
        }
        
        .logo-icon {
            width: 36px;
            height: 36px;
        }
    }
</style>
<div class="welcome-container">
    <div class="welcome-card">
        <div class="card-header">
            <div class="logo">
                <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" class="logo-icon">
                    <path d="M3 6.2C3 5.07989 3 4.51984 3.21799 4.09202C3.40973 3.71569 3.71569 3.40973 4.09202 3.21799C4.51984 3 5.07989 3 6.2 3H17.8C18.9201 3 19.4802 3 19.908 3.21799C20.2843 3.40973 20.5903 3.71569 20.782 4.09202C21 4.51984 21 5.07989 21 6.2V17.8C21 18.9201 21 19.4802 20.782 19.908C20.5903 20.2843 20.2843 20.5903 19.908 20.782C19.4802 21 18.9201 21 17.8 21H6.2C5.07989 21 4.51984 21 4.09202 20.782C3.71569 20.5903 3.40973 20.2843 3.21799 19.908C3 19.4802 3 18.9201 3 17.8V6.2Z" stroke="currentColor" stroke-width="2"/>
                    <path d="M3 9H21" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
                    <path d="M9 21V9" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
                    <path d="M13 7H17" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
                    <path d="M13 12H17" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
                    <path d="M13 17H17" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
                </svg>
            </div>
            <h1 id="welcome-title">Welcome to CrossWise</h1>
        </div>
        <div class="message-box">
            <p id="welcome-message">Efficient border crossing management system</p>
            <div class="border-animation">
                <div class="road"></div>
                <div class="road-markings"></div>
                <div class="checkpoint">
                    <div class="booth"></div>
                    <div class="light-flash"></div>
                </div>
                <div class="gate-left">
                    <div class="stripe"></div>
                </div>
                <div class="gate-right">
                    <div class="stripe"></div>
                </div>
                <div class="car">
                    <div class="wheel"></div>
                </div>
            </div>
        </div>
        <div class="progress-container">
            <div id="progress-bar" class="progress-bar"></div>
            <p id="login-status">Signing you in...</p>
        </div>
    </div>
</div>

<script>
    // Set a fixed redirect timer for 6 seconds after page load (5s progress + 1s buffer)
    document.addEventListener("DOMContentLoaded", () => {
        // Start the fixed redirect timer
        setTimeout(() => {
            window.location.href = "{{site.baseurl}}/index";
        }, 6000);
        
        // Start typing animations
        setTimeout(() => {
            typeMessage(document.getElementById("welcome-message"), "Efficient border crossing management system", 30);
        }, 300);
        
        // Start progress animation
        animateProgress();
    });
    
    // Type animation for welcome message
    function typeMessage(element, text, speed) {
        let index = 0;
        element.textContent = "";
        
        function type() {
            if (index < text.length) {
                element.textContent += text.charAt(index);
                index++;
                setTimeout(type, speed);
            }
        }
        
        type();
    }
    
    // Progress bar animation - simplified to just fill in exactly 5 seconds
    function animateProgress() {
        const progressBar = document.getElementById("progress-bar");
        let width = 0;
        const totalTime = 5000; // 5 seconds total
        const intervalTime = 50; // Update every 50ms
        const increment = 100 / (totalTime / intervalTime);
        
        const interval = setInterval(() => {
            if (width >= 100) {
                clearInterval(interval);
                document.getElementById("login-status").textContent = "Access granted!";
            } else {
                width += increment;
                progressBar.style.width = Math.min(width, 100) + "%";
            }
        }, intervalTime);
    }
</script>