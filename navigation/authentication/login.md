---
layout: tailwind 
title: Login
permalink: /login
search_exclude: true
show_reading_time: false 
---
<div class="flex flex-col md:flex-row justify-center items-center min-h-screen bg-darker text-gray-200">
    <!-- Python Login Form -->
    <div class="bg-dark p-8 rounded-lg shadow-lg m-6 w-full md:w-1/2">
        <h1 id="pythonTitle" class="text-2xl font-bold text-accent mb-6">User Login (Python/Flask)</h1>
        <form id="pythonForm" onsubmit="pythonLogin(); return false;" class="space-y-6">
            <div>
                <label class="block text-sm font-medium">
                    GitHub ID:
                    <input type="text" name="uid" id="uid" required class="mt-1 block w-full p-3 bg-darker border border-gray-700 rounded-md focus:outline-none focus:ring-2 focus:ring-accent">
                </label>
            </div>
            <div>
                <label class="block text-sm font-medium">
                    Password:
                    <input type="password" name="password" id="password" required class="mt-1 block w-full p-3 bg-darker border border-gray-700 rounded-md focus:outline-none focus:ring-2 focus:ring-accent">
                </label>
            </div>
            <div>
                <button type="submit" class="w-full bg-accent text-white py-3 px-4 rounded-md hover:bg-blue-600">Login</button>
            </div>
            <p id="message" class="text-sm text-red-500"></p>
        </form>

        <!-- Facial Recognition Login Button -->
        <div class="text-center mt-6">
            <button onclick="recognizeFace()" class="bg-blue-500 text-white py-3 px-6 rounded-md hover:bg-blue-600">
                Login with Face
            </button>
        </div>
        <p id="faceLoginMessage" class="text-sm text-green-500 text-center mt-4"></p>
    </div>

    <!-- Signup Form -->
    <div class="bg-dark p-8 rounded-lg shadow-lg m-6 w-full md:w-1/2">
        <h1 id="signupTitle" class="text-2xl font-bold text-accent mb-6">Sign Up</h1>
        <form id="signupForm" onsubmit="signup(); return false;" class="space-y-6">
            <div>
                <label class="block text-sm font-medium">
                    Name:
                    <input type="text" name="name" id="name" required class="mt-1 block w-full p-3 bg-darker border border-gray-700 rounded-md focus:outline-none focus:ring-2 focus:ring-accent">
                </label>
            </div>
            <div>
                <label class="block text-sm font-medium">
                    GitHub ID:
                    <input type="text" name="signupUid" id="signupUid" required class="mt-1 block w-full p-3 bg-darker border border-gray-700 rounded-md focus:outline-none focus:ring-2 focus:ring-accent">
                </label>
            </div>
            <div>
                <label class="block text-sm font-medium">
                    Password:
                    <input type="password" name="signupPassword" id="signupPassword" required class="mt-1 block w-full p-3 bg-darker border border-gray-700 rounded-md focus:outline-none focus:ring-2 focus:ring-accent">
                </label>
            </div>
            <div>
                <label class="block text-sm font-medium">
                    Interests:
                    <input type="text" name="interests" id="interests" placeholder="e.g., Soccer, Pool, Computer Science" required class="mt-1 block w-full p-3 bg-darker border border-gray-700 rounded-md focus:outline-none focus:ring-2 focus:ring-accent">
                </label>
            </div>
            <div>
                <button type="submit" class="w-full bg-accent text-white py-3 px-4 rounded-md hover:bg-blue-600">Sign Up</button>
            </div>
            <p id="signupMessage" class="text-sm text-green-500"></p>
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