---
layout: login 
title: Login
permalink: /login
search_exclude: true
show_reading_time: false 
---

<div class="login-container">
    <!-- Python Login Form -->
    <div class="login-card">
        <h1 id="pythonTitle">User Login (Python/Flask)</h1>
        <form id="pythonForm" onsubmit="pythonLogin(); return false;">
            <p>
                <label>
                    GitHub ID:
                    <input type="text" name="uid" id="uid" required>
                </label>
            </p>
            <p>
                <label>
                    Password:
                    <input type="password" name="password" id="password" required>
                </label>
            </p>
            <p>
                <button type="submit">Login</button>
            </p>
            <p id="message" style="color: red;"></p>
        </form>

        <!-- Facial Recognition Login Button -->
        <p style="text-align: center; margin-top: 10px;">
            <button onclick="recognizeFace()" style="background-color: #4f89e3; color: white; padding: 8px 16px; border-radius: 6px;">
                Login with Face
            </button>
        </p>
        <p id="faceLoginMessage" style="text-align: center; color: green;"></p>
    </div>

    <!-- Signup Form -->
    <div class="signup-card">
        <h1 id="signupTitle">Sign Up</h1>
        <form id="signupForm" onsubmit="signup(); return false;">
            <p>
                <label>
                    Name:
                    <input type="text" name="name" id="name" required>
                </label>
            </p>
            <p>
                <label>
                    GitHub ID:
                    <input type="text" name="signupUid" id="signupUid" required>
                </label>
            </p>
            <p>
                <label>
                    Password:
                    <input type="password" name="signupPassword" id="signupPassword" required>
                </label>
            </p>
            <p>
                <label>
                    Interests:
                    <input type="text" name="interests" id="interests" placeholder="e.g., Soccer, Pool, Computer Science" required>
                </label>
            </p>
            <p>
                <button type="submit">Sign Up</button>
            </p>
            <p id="signupMessage" style="color: green;"></p>
        </form>
    </div>
</div>

<script type="module">
    import { login, pythonURI, fetchOptions } from '{{site.baseurl}}/assets/js/api/config.js';

    // Python login with username/password
    window.pythonLogin = function() {
        const options = {
            URL: `${pythonURI}/api/authenticate`,
            callback: handleLoginResponse,
            message: "message",
            method: "POST",
            cache: "no-cache",
            body: {
                uid: document.getElementById("uid").value,
                password: document.getElementById("password").value,
            }
        };
        login(options);
    }

    // Facial Recognition Login
    window.recognizeFace = async function () {
        const messageBox = document.getElementById("faceLoginMessage");
        messageBox.textContent = "📸 Scanning face...";

        try {
            const video = document.createElement('video');
            video.style.display = 'none';
            document.body.appendChild(video);

            const stream = await navigator.mediaDevices.getUserMedia({ video: true });
            video.srcObject = stream;
            await video.play();

            await new Promise(res => setTimeout(res, 1500));

            const canvas = document.createElement('canvas');
            canvas.width = video.videoWidth;
            canvas.height = video.videoHeight;
            canvas.getContext('2d').drawImage(video, 0, 0);
            const base64 = canvas.toDataURL().split(',')[1];

            stream.getTracks().forEach(track => track.stop());
            video.remove();

            const response = await fetch(`${pythonURI}/user/facial/recognize`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ image: base64 })
            });

            const data = await response.json();

            if (data.username) {
                messageBox.textContent = `✅ Logged in as ${data.username}`;
                window.location.href = '{{site.baseurl}}/userlog';
            } else {
                messageBox.textContent = "❌ Face not recognized. Try manual login.";
            }
        } catch (error) {
            console.error("Facial Login Error:", error);
            messageBox.textContent = "❌ Facial login failed. Try again.";
        }
    };

    // Signup logic
    window.signup = function() {
        const signupButton = document.querySelector(".signup-card button");

        signupButton.disabled = true;
        signupButton.style.backgroundColor = '#d3d3d3';

        const signupOptions = {
            URL: `${pythonURI}/api/user`,
            method: "POST",
            cache: "no-cache",
            body: {
                name: document.getElementById("name").value,
                uid: document.getElementById("signupUid").value,
                password: document.getElementById("signupPassword").value,
                interests: document.getElementById("interests").value,
            }
        };

        fetch(signupOptions.URL, {
            method: signupOptions.method,
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(signupOptions.body)
        })
        .then(response => {
            if (!response.ok) throw new Error(`Signup failed: ${response.status}`);
            return response.json();
        })
        .then(data => {
            document.getElementById("signupMessage").textContent = "Signup successful!";
        })
        .catch(error => {
            console.error("Signup Error:", error);
            document.getElementById("signupMessage").textContent = `Signup Error: ${error.message}`;
            signupButton.disabled = false;
            signupButton.style.backgroundColor = '';
        });
    };

    // Handle login redirect based on role
    function handleLoginResponse() {
        const URL = `${pythonURI}/api/id`;

        fetch(URL, fetchOptions)
            .then(response => {
                if (!response.ok) throw new Error(`Flask server response: ${response.status}`);
                return response.json();
            })
            .then(data => {
                if (data.role === 'admin') {
                    window.location.href = '{{site.baseurl}}/adminlog';
                } else {
                    window.location.href = '{{site.baseurl}}/userlog';
                }
            })
            .catch(error => {
                console.error("Python Database Error:", error);
                document.getElementById("message").textContent = `Python Database Error: ${error.message}`;
            });
    }

    window.onload = function() {
        pythonDatabase();
    };
</script>