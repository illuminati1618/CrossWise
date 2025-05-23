---
layout: tailwind
permalink: /profile
search_exclude: true
show_reading_time: false
---

<div class="max-w-7xl mx-auto px-4 py-10">
    <header class="mb-8 text-center">
        <h1 class="text-4xl font-bold text-accent">Profile</h1>
        <p class="text-lg text-gray-400">You can control your settings from here!</p>
    </header>

    <div class="space-y-12">
        <!-- Profile Section -->
        <section class="bg-dark p-6 rounded-lg shadow-md flex items-center space-x-6">
            <div class="relative">
                <img src="https://placehold.co/150x150" alt="Profile Picture" id="profilePicture" class="w-36 h-36 rounded-full border-4 border-accent shadow-lg">
                <label for="profilePictureUpload" class="absolute bottom-0 right-0 bg-accent text-white p-2 rounded-full cursor-pointer hover:bg-blue-600 transition-colors">
                    <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                        <path d="M13.586 3.586a2 2 0 112.828 2.828l-.793.793-2.828-2.828.793-.793zM11.379 5.793L3 14.172V17h2.828l8.38-8.379-2.83-2.828z"></path>
                    </svg>
                </label>
                <input type="file" id="profilePictureUpload" accept="image/*" class="hidden">
            </div>
            <div>
                <h2 id="username" class="text-2xl font-bold text-gray-200">User Name</h2>
                <p id="userEmail" class="text-gray-400">user@email.com</p>
            </div>
        </section>

        <!-- Profile Settings -->
        <section class="bg-dark p-6 rounded-lg shadow-md">
            <h3 class="text-2xl font-semibold text-accent mb-4">Profile Settings</h3>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                    <label for="newUid" class="block text-sm font-medium text-gray-300 mb-2">Enter New UID:</label>
                    <input type="text" id="newUid" placeholder="New UID" class="w-full bg-darker border border-gray-600 rounded-md shadow-sm focus:ring-accent focus:border-accent text-gray-200 p-3">
                </div>
                <div>
                    <label for="newName" class="block text-sm font-medium text-gray-300 mb-2">Enter New Name:</label>
                    <input type="text" id="newName" placeholder="New Name" class="w-full bg-darker border border-gray-600 rounded-md shadow-sm focus:ring-accent focus:border-accent text-gray-200 p-3">
                </div>
                <div class="md:col-span-2">
                    <label for="newPassword" class="block text-sm font-medium text-gray-300 mb-2">Enter New Password:</label>
                    <input type="password" id="newPassword" placeholder="New Password" class="w-full bg-darker border border-gray-600 rounded-md shadow-sm focus:ring-accent focus:border-accent text-gray-200 p-3">
                </div>
            </div>
            <p id="profile-message" class="mt-4 text-sm text-red-500"></p>
        </section>

        <!-- User Stats and Bio -->
        <section class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div class="bg-dark p-6 rounded-lg shadow-md">
                <h3 class="text-2xl font-semibold text-accent mb-4">User Stats</h3>
                <div class="space-y-2 text-gray-400">
                    <p>Friends: <span id="friendsCount">0</span></p>
                    <p>Border Crossings Tracked: <span id="crossingsCount">0</span></p>
                    <p>Member Since: <span id="memberSince">Loading...</span></p>
                </div>
            </div>
            <div class="bg-dark p-6 rounded-lg shadow-md">
                <h3 class="text-2xl font-semibold text-accent mb-4">Bio/About Me</h3>
                <textarea id="userBio" placeholder="Tell us about yourself..." class="w-full bg-darker border border-gray-600 rounded-md shadow-sm focus:ring-accent focus:border-accent text-gray-200 p-3 h-24 resize-none"></textarea>
                <button onclick="updateBio()" class="mt-2 bg-accent text-white py-2 px-4 rounded-md hover:bg-blue-600 transition-colors">Update Bio</button>
            </div>
        </section>

        <!-- Friends Section -->
        <section class="bg-dark p-6 rounded-lg shadow-md">
            <h3 class="text-2xl font-semibold text-accent mb-4">My Friends</h3>
            <div class="mb-4">
                <div class="flex gap-2">
                    <input type="text" id="newFriend" placeholder="Add friend by username" class="flex-1 bg-darker border border-gray-600 rounded-md shadow-sm focus:ring-accent focus:border-accent text-gray-200 p-3">
                    <button onclick="addFriend()" class="bg-accent text-white px-6 py-3 rounded-md hover:bg-blue-600 transition-colors">Add Friend</button>
                </div>
            </div>
            <div id="friendsSection" class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
                <!-- Friends will be loaded here -->
            </div>
        </section>

        <!-- Friend Requests & Notifications -->
        <section class="bg-dark p-6 rounded-lg shadow-md">
            <h3 class="text-2xl font-semibold text-accent mb-4">Friend Requests & Notifications</h3>
            <div id="notificationsFeed" class="space-y-3">
                <!-- Notifications will be loaded here -->
            </div>
            <div class="mt-4 pt-4 border-t border-gray-600">
                <button onclick="markAllAsRead()" class="text-accent hover:text-blue-400 transition-colors text-sm">Mark all as read</button>
            </div>
        </section>
    </div>
</div>

<script type="module">
import { pythonURI, fetchOptions } from '{{site.baseurl}}/assets/js/api/config.js';

// Global variables
let currentUser = null;

// Initialize page
document.addEventListener('DOMContentLoaded', async () => {
    await initializePage();
    setupEventListeners();
});

async function initializePage() {
    try {
        await updateUserInfo();
        await loadFriends();
        await loadNotifications();
        await loadUserStats();
    } catch (error) {
        console.error('Error initializing page:', error);
        showError('Error loading profile data');
    }
}

function setupEventListeners() {
    // Profile picture upload
    document.getElementById('profilePictureUpload').addEventListener('change', (e) => {
        if (e.target.files[0]) {
            uploadProfilePicture(e.target.files[0]);
        }
    });

    // Profile field updates
    const inputs = ['newUid', 'newName', 'newPassword'];
    inputs.forEach(id => {
        const input = document.getElementById(id);
        input.addEventListener('blur', async (e) => {
            if (e.target.value.trim()) {
                const field = id.replace('new', '').toLowerCase();
                await updateProfile(field, e.target.value.trim());
                e.target.value = '';
            }
        });
    });

    // Enter key for adding friends
    document.getElementById('newFriend').addEventListener('keypress', (e) => {
        if (e.key === 'Enter') {
            addFriend();
        }
    });
}

async function updateUserInfo() {
    try {
        const response = await fetch(pythonURI + "/api/user", {
            ...fetchOptions,
            method: 'GET'
        });
        
        if (!response.ok) {
            throw new Error('Failed to fetch user info');
        }
        
        const data = await response.json();
        currentUser = data;
        
        // Update profile display
        document.getElementById('username').textContent = data.name || 'User Name';
        document.getElementById('userEmail').textContent = data.uid || 'user@email.com';
        
        // Update profile picture
        if (data.pfp) {
            document.getElementById('profilePicture').src = data.pfp;
        }
        
        // Update bio
        if (data.bio) {
            document.getElementById('userBio').value = data.bio;
        }
        
        // Update member since date
        if (data.created_at) {
            const date = new Date(data.created_at);
            document.getElementById('memberSince').textContent = date.toLocaleDateString();
        }
        
        // Set placeholders for form fields
        setPlaceholders(data);
        
    } catch (error) {
        console.error('Error fetching user info:', error);
        showError('Error loading user information');
    }
}

function setPlaceholders(userData) {
    const uidInput = document.getElementById('newUid');
    const nameInput = document.getElementById('newName');

    if (userData.uid) uidInput.placeholder = `Current: ${userData.uid}`;
    if (userData.name) nameInput.placeholder = `Current: ${userData.name}`;
}

async function updateProfile(field, value) {
    try {
        const response = await fetch(pythonURI + "/api/user", {
            ...fetchOptions,
            method: 'PUT',
            body: JSON.stringify({
                [field]: value
            })
        });

        if (!response.ok) {
            const errorData = await response.json();
            throw new Error(errorData.message || 'Failed to update profile');
        }

        showError('Profile updated successfully', 'green');
        await updateUserInfo();
    } catch (error) {
        console.error('Error updating profile:', error);
        showError(error.message || 'Error updating profile');
    }
}

async function updateBio() {
    const bio = document.getElementById('userBio').value.trim();
    await updateProfile('bio', bio);
}

async function uploadProfilePicture(file) {
    try {
        const base64String = await convertToBase64(file);
        const response = await fetch(pythonURI + "/api/user/avatar", {
            ...fetchOptions,
            method: 'POST',
            body: JSON.stringify({ avatar: base64String })
        });

        if (!response.ok) {
            throw new Error('Failed to upload profile picture');
        }

        showError('Profile picture updated successfully', 'green');
        await updateUserInfo();
    } catch (error) {
        console.error('Error uploading profile picture:', error);
        showError('Error uploading profile picture');
    }
}

function convertToBase64(file) {
    return new Promise((resolve, reject) => {
        const reader = new FileReader();
        reader.onload = () => resolve(reader.result.split(',')[1]);
        reader.onerror = error => reject(error);
        reader.readAsDataURL(file);
    });
}

async function loadFriends() {
    try {
        const response = await fetch(pythonURI + "/api/friends", {
            ...fetchOptions,
            method: 'GET'
        });
        
        if (!response.ok) {
            throw new Error('Failed to load friends');
        }
        
        const friends = await response.json();
        displayFriends(friends);
        document.getElementById('friendsCount').textContent = friends.length;
        
    } catch (error) {
        console.error('Error loading friends:', error);
        displayFriends([]);
        document.getElementById('friendsCount').textContent = '0';
    }
}

function displayFriends(friends) {
    const friendsSection = document.getElementById('friendsSection');
    friendsSection.innerHTML = '';
    
    if (friends.length === 0) {
        friendsSection.innerHTML = '<p class="text-gray-400 col-span-full text-center py-8">No friends yet. Add some friends to get started!</p>';
        return;
    }
    
    friends.forEach(friend => {
        const friendCard = document.createElement('div');
        friendCard.className = 'bg-darker p-4 rounded-lg border border-gray-600 hover:border-accent transition-colors';
        friendCard.innerHTML = `
            <div class="flex items-center space-x-3">
                <img src="https://placehold.co/40x40" alt="${friend.name || friend.username}" class="w-10 h-10 rounded-full">
                <div class="flex-1">
                    <p class="text-gray-200 font-medium">${friend.name || friend.username}</p>
                    <p class="text-gray-400 text-sm">Friend</p>
                </div>
                <button onclick="removeFriend('${friend.username || friend.name}')" class="text-red-400 hover:text-red-300 p-1">
                    <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"></path>
                    </svg>
                </button>
            </div>
        `;
        friendsSection.appendChild(friendCard);
    });
}

async function addFriend() {
    const friendInput = document.getElementById('newFriend');
    const friendName = friendInput.value.trim();
    
    if (!friendName) {
        showError('Please enter a friend\'s username');
        return;
    }
    
    try {
        const response = await fetch(pythonURI + "/api/friends", {
            ...fetchOptions,
            method: 'POST',
            body: JSON.stringify({ friend_username: friendName })
        });
        
        if (!response.ok) {
            const errorData = await response.json();
            throw new Error(errorData.message || 'Failed to add friend');
        }
        
        friendInput.value = '';
        showError('Friend request sent successfully!', 'green');
        await loadFriends();
        
    } catch (error) {
        console.error('Error adding friend:', error);
        showError(error.message || 'Error adding friend');
    }
}

async function removeFriend(friendName) {
    if (!confirm(`Are you sure you want to remove ${friendName} as a friend?`)) {
        return;
    }
    
    try {
        const response = await fetch(pythonURI + "/api/friends", {
            ...fetchOptions,
            method: 'DELETE',
            body: JSON.stringify({ friend_username: friendName })
        });
        
        if (!response.ok) {
            throw new Error('Failed to remove friend');
        }
        
        showError('Friend removed successfully', 'green');
        await loadFriends();
        
    } catch (error) {
        console.error('Error removing friend:', error);
        showError('Error removing friend');
    }
}

async function loadNotifications() {
    try {
        const response = await fetch(pythonURI + "/api/notifications", {
            ...fetchOptions,
            method: 'GET'
        });
        
        if (!response.ok) {
            throw new Error('Failed to load notifications');
        }
        
        const notifications = await response.json();
        displayNotifications(notifications);
        
    } catch (error) {
        console.error('Error loading notifications:', error);
        displayNotifications([]);
    }
}

function displayNotifications(notifications) {
    const notificationsFeed = document.getElementById('notificationsFeed');
    notificationsFeed.innerHTML = '';
    
    if (notifications.length === 0) {
        notificationsFeed.innerHTML = '<p class="text-gray-400">No new notifications</p>';
        return;
    }
    
    notifications.forEach(notification => {
        const notificationDiv = document.createElement('div');
        notificationDiv.className = `p-3 rounded-lg border ${notification.read ? 'bg-darker border-gray-600' : 'bg-accent bg-opacity-10 border-accent'}`;
        
        let content = '';
        if (notification.type === 'friend_request') {
            content = `
                <p class="text-gray-200">${notification.from_username} sent you a friend request</p>
                <div class="mt-2 space-x-2">
                    <button onclick="acceptFriendRequest('${notification.id}')" class="bg-green-600 text-white px-3 py-1 rounded text-sm hover:bg-green-700">Accept</button>
                    <button onclick="declineFriendRequest('${notification.id}')" class="bg-red-600 text-white px-3 py-1 rounded text-sm hover:bg-red-700">Decline</button>
                </div>
            `;
        } else {
            content = `<p class="text-gray-200">${notification.message}</p>`;
        }
        
        notificationDiv.innerHTML = content;
        notificationsFeed.appendChild(notificationDiv);
    });
}

async function loadUserStats() {
    try {
        const response = await fetch(pythonURI + "/api/user/stats", {
            ...fetchOptions,
            method: 'GET'
        });
        
        if (!response.ok) {
            throw new Error('Failed to load user stats');
        }
        
        const stats = await response.json();
        document.getElementById('crossingsCount').textContent = stats.border_crossings || 0;
        
    } catch (error) {
        console.error('Error loading user stats:', error);
        document.getElementById('crossingsCount').textContent = '0';
    }
}

async function acceptFriendRequest(notificationId) {
    try {
        const response = await fetch(pythonURI + "/api/notifications/accept", {
            ...fetchOptions,
            method: 'POST',
            body: JSON.stringify({ notification_id: notificationId })
        });
        
        if (!response.ok) {
            throw new Error('Failed to accept friend request');
        }
        
        showError('Friend request accepted!', 'green');
        await loadNotifications();
        await loadFriends();
        
    } catch (error) {
        console.error('Error accepting friend request:', error);
        showError('Error accepting friend request');
    }
}

async function declineFriendRequest(notificationId) {
    try {
        const response = await fetch(pythonURI + "/api/notifications/decline", {
            ...fetchOptions,
            method: 'POST',
            body: JSON.stringify({ notification_id: notificationId })
        });
        
        if (!response.ok) {
            throw new Error('Failed to decline friend request');
        }
        
        showError('Friend request declined', 'green');
        await loadNotifications();
        
    } catch (error) {
        console.error('Error declining friend request:', error);
        showError('Error declining friend request');
    }
}

async function markAllAsRead() {
    try {
        const response = await fetch(pythonURI + "/api/notifications/read", {
            ...fetchOptions,
            method: 'PUT'
        });
        
        if (!response.ok) {
            throw new Error('Failed to mark notifications as read');
        }
        
        showError('All notifications marked as read', 'green');
        await loadNotifications();
        
    } catch (error) {
        console.error('Error marking notifications as read:', error);
        showError('Error updating notifications');
    }
}

function showError(message, color = 'red') {
    const messageElement = document.getElementById('profile-message');
    messageElement.className = `mt-4 text-sm text-${color}-500`;
    messageElement.textContent = message;
    setTimeout(() => {
        messageElement.textContent = '';
    }, 3000);
}

// Make functions available globally
window.addFriend = addFriend;
window.removeFriend = removeFriend;
window.updateBio = updateBio;
window.markAllAsRead = markAllAsRead;
window.acceptFriendRequest = acceptFriendRequest;
window.declineFriendRequest = declineFriendRequest;
</script>