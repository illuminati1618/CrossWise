---
layout: needsAuth
title: Profile Settings
permalink: /profile
menu: nav/home.html
search_exclude: true
show_reading_time: false
---

<style>
   /* Lock Screen */
   .lock-screen {
       position: fixed;
       top: 0;
       left: 0;
       width: 100vw;
       height: 100vh;
       display: flex;
       flex-direction: column;
       justify-content: center;
       align-items: center;
       z-index: 10;
       background: radial-gradient(circle, #772222, #330000); /* Dark red gradient */
       transition: transform 1s ease-in-out;
   }
   /* Ignition */
   .ignition-container {
       position: relative;
       width: 150px;
       height: 150px;
   }
   .ignition {
       width: 100%;
       height: 100%;
       background: radial-gradient(circle, #555, #222);
       border-radius: 50%;
       display: flex;
       justify-content: center;
       align-items: center;
       position: relative;
       box-shadow: inset 0 0 10px #000, 0 4px 10px rgba(0, 0, 0, 0.5);
   }
   .ignition-slot {
       width: 60px;
       height: 20px; 
       background: #777;
       border-radius: 5px;
       position: absolute;
       top: 50%;
       left: 50%;
       transform: translate(-50%, -50%);
       box-shadow: inset 0 2px 5px rgba(0, 0, 0, 0.5);
   }
   /* Key */
   .key {
       width: 200px; 
       height: auto;
       position: absolute;
       top: 70%;
       left: 10%;
       cursor: grab;
       transition: transform 0.5s ease;
       z-index: 5;
   }
   .key:active {
       cursor: grabbing;
   }
   .key-top-view {
       display: none;
       position: absolute;
       width: 60px; /* Matches ignition slot size */
       height: 20px;
       background: black;
       border-radius: 3px;
       box-shadow: 0 0 5px rgba(0, 0, 0, 0.5);
       z-index: 10;
       top: 50%;
       left: 50%;
   }
   .instruction {
       margin-top: 20px;
       font-size: 18px;
       color: #bbb;
       animation: pulse 1s infinite;
   }
   @keyframes pulse {
       0%, 100% { opacity: 1; }
       50% { opacity: 0.5; }
   }
</style>

<body>
    <!-- Lock Screen -->
    <div class="lock-screen" id="lockScreen">
        <div class="ignition-container">
            <div class="ignition">
                <div class="ignition-slot" id="ignitionSlot"></div>
            </div>
        </div>
        <div class="key-top-view" id="keyTopView"></div>
        <img src="{{site.baseurl}}/images/CARKEY.png" alt="Key" class="key" id="key">
        <div class="instruction">Drag the key into the ignition to unlock!</div>
    </div>

<!-- Car Starting Sound -->
 <audio id="carStartSound" src="{{site.baseurl}}/images/CarKeySTART.mp3"></audio>

   <script>
        const key = document.getElementById('key');
        const ignitionSlot = document.getElementById('ignitionSlot');
        const lockScreen = document.getElementById('lockScreen');
        const content = document.getElementById('content');
        const keyTopView = document.getElementById('keyTopView');
        const carStartSound = document.getElementById('carStartSound');

        let isDragging = false;
        let offsetX, offsetY;

        // Prevent default drag behavior
        key.addEventListener('dragstart', (event) => event.preventDefault());

        // Dragging functionality
        key.addEventListener('mousedown', (event) => {
            isDragging = true;
            offsetX = event.offsetX;
            offsetY = event.offsetY;
            key.style.cursor = 'grabbing';
        });

        document.addEventListener('mousemove', (event) => {
            if (isDragging) {
                key.style.left = `${event.clientX - offsetX}px`;
                key.style.top = `${event.clientY - offsetY}px`;
            }
        });

 document.addEventListener('mouseup', (event) => {
            if (isDragging) {
                isDragging = false;
                key.style.cursor = 'grab';

                // Check if key is near the ignition slot
                const keyRect = key.getBoundingClientRect();
                const ignitionRect = ignitionSlot.getBoundingClientRect();

                if (
                    keyRect.right > ignitionRect.left &&
                    keyRect.left < ignitionRect.right &&
                    keyRect.bottom > ignitionRect.top &&
                    keyRect.top < ignitionRect.bottom
                ) {
                    // Hide original key and display top view
                    key.style.display = 'none';
                    keyTopView.style.display = 'block';
                    keyTopView.style.left = `${ignitionRect.left}px`;
                    keyTopView.style.top = `${ignitionRect.top}px`;

                    // Play car starting sound
                    carStartSound.play();

                    // Simulate turning the ignition
                    setTimeout(() => {
                        keyTopView.style.transform = 'rotate(90deg)';
                        ignitionSlot.hidden = true;
                    }, 500);

                    // Unlock the page
                    setTimeout(() => {
                        lockScreen.style.transform = 'translateY(-100vh)';
                        content.style.transform = 'translateY(-100vh)';
                    }, 1500); // Delay for rotation and unlock animation
                } else {
                    // Reset key position if not near ignition slot
                    key.style.left = '10%';
                    key.style.top = '70%';
                }
            }
        });
    </script>
</body>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Car Social Profile</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 flex flex-col min-h-screen">
    <!-- Navigation Bar -->
    <nav class="bg-white shadow-md w-full py-4 px-6 flex justify-between items-center">
        <h1 class="text-xl font-bold">Car Social</h1>
    </nav>
    
<div class="flex justify-center items-center flex-col flex-grow">
        <div class="max-w-5xl w-full bg-white shadow-lg rounded-lg p-8">
            <div class="flex items-center justify-between mb-8">
                <div class="flex items-center space-x-8">
                    <img id="profile-picture" src="default-profile.jpg" alt="Profile Picture" class="w-36 h-36 rounded-full object-cover border-4 border-gray-300">
                    <div>
                        <h2 class="text-3xl font-bold" id="username">Username</h2>
                        <p class="text-gray-600">Car Enthusiast</p>
                        <button class="mt-4 bg-gradient-to-r from-blue-500 to-cyan-500 text-white px-6 py-2 rounded-lg shadow-md hover:from-blue-600 hover:to-cyan-600 transition" onclick="location.href='settings.html'">Edit Profile</button>
                    </div>
                </div>
                <div class="flex space-x-8 text-center">
                    <div>
                        <p class="text-2xl font-semibold" id="post-count">0</p>
                        <p class="text-gray-500">Posts</p>
                    </div>
                    <div>
                        <p class="text-2xl font-semibold">0</p>
                        <p class="text-gray-500">Followers</p>
                    </div>
                    <div>
                        <p class="text-2xl font-semibold">0</p>
                        <p class="text-gray-500">Following</p>
                    </div>
                </div>
            </div>

            <div class="border-t pt-6">
                <h3 class="text-center text-2xl font-semibold mb-4">User Posts</h3>
                <div id="user-posts" class="grid grid-cols-3 gap-6"></div>
            </div>
        </div>
    </div>
</body>
<script type="module">
import { getPostsByUser, getImagesByPostId } from "{{site.baseurl}}/assets/js/api/posts.js";
import { pythonURI, fetchOptions } from "{{site.baseurl}}/assets/js/api/config.js"
async function getUserData() {
    const endpoint = `${pythonURI}/api/user`
    try {
        const response = await fetch(endpoint, fetchOptions);
        if (!response.ok) {
            throw new Error(`Failed to fetch user: ${response.status}`);
        }
        const user = await response.json();
        return user;
  } catch (error) {
    console.error("Error fetching user:", error.message);
    return null;
  }
}
document.addEventListener('DOMContentLoaded', async () => {
    const userData = await getUserData()
    console.log(userData)
    const profilePicture = pythonURI + "/uploads/" + userData.uid + "/" + userData.pfp
    const username = userData.name
    const userPostsContainer = document.getElementById('user-posts');
    const postCountElement = document.getElementById('post-count');
 if (profilePicture) {
        document.getElementById('profile-picture').src = profilePicture;
    }
 if (username) {
        document.getElementById('username').textContent = username;
    }
const posts = await getPostsByUser(userData.id);
    if (posts && posts.length > 0) {
        userPostsContainer.innerHTML = '';
        postCountElement.textContent = posts.length;
        posts.forEach(post => {
            const formattedImages = [];
            getImagesByPostId(post.id).then((images) => {
                images.forEach((image) => {
                formattedImages.push(`data:image/jpeg;base64,${image}`);
                })
            console.log(formattedImages)
            const postElement = document.createElement('div');
            postElement.className = 'border p-4 rounded-lg shadow-md bg-white';
            postElement.innerHTML = `
                <h4 class="text-lg font-semibold">${post.title}</h4>
                <p class="text-gray-600">${post.description}</p>
                <p class="text-sm text-gray-500">${new Date(post.date_posted).toLocaleDateString()}</p>
                <div class="relative flex w-full overflow-hidden">
                <div class="carousel relative flex w-full">
                ${formattedImages
                    .map(
                    (image, index) =>
                        `
                        <img src="${image}" alt="image" class="carousel-item w-full">
                        `
                    )
                    .join("")}
                </div>
            </div>
            `;
            userPostsContainer.appendChild(postElement);
            });
        });
    } else {
        userPostsContainer.innerHTML = '<p class="text-gray-500 text-center col-span-3">No posts</p>';
    }
});
</script>
</html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Stylish Button</title>
    <style>
        /* Styling for the button */
        .custom-button {
            display: inline-block;
            padding: 12px 24px;
            font-size: 18px;
            font-weight: bold;
            color: white;
            background: linear-gradient(45deg, #007bff, #00d4ff);
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease-in-out;
            text-decoration: none;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .custom-button:hover {
            background: linear-gradient(45deg, #0056b3, #0094cc);
            transform: scale(1.05);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
        }

        .custom-button:active {
            transform: scale(0.98);
        }
    </style>
</head>
<body>

<!-- Stylish Button -->
<a href="comment" class="custom-button">Comment Test</a>

</body>

