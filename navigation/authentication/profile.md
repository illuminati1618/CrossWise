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
            <img src="https://placehold.co/150x150" alt="Profile Picture" id="profilePicture" class="w-36 h-36 rounded-full border-4 border-accent shadow">
            <div>
                <h2 id="username" class="text-2xl font-bold text-gray-200">User Name</h2>
            </div>
        </section>

        <!-- Profile Settings -->
        <section class="bg-dark p-6 rounded-lg shadow-md">
            <h3 class="text-2xl font-semibold text-accent mb-4">Profile Settings</h3>
            <form class="space-y-4">
                <div>
                    <label for="newUid" class="block text-sm font-medium text-gray-300">Enter New UID:</label>
                    <input type="text" id="newUid" placeholder="New UID" class="mt-1 block w-full bg-darker border border-gray-600 rounded-md shadow-sm focus:ring-accent focus:border-accent text-gray-200">
                </div>
                <div>
                    <label for="newName" class="block text-sm font-medium text-gray-300">Enter New Name:</label>
                    <input type="text" id="newName" placeholder="New Name" class="mt-1 block w-full bg-darker border border-gray-600 rounded-md shadow-sm focus:ring-accent focus:border-accent text-gray-200">
                </div>
                <div>
                    <label for="newPassword" class="block text-sm font-medium text-gray-300">Enter New Password:</label>
                    <input type="password" id="newPassword" placeholder="New Password" class="mt-1 block w-full bg-darker border border-gray-600 rounded-md shadow-sm focus:ring-accent focus:border-accent text-gray-200">
                </div>
                <div>
                    <label for="newInterests" class="block text-sm font-medium text-gray-300">Enter New Interests:</label>
                    <input type="text" id="newInterests" placeholder="New Interests (e.g., Soccer, Reading)" class="mt-1 block w-full bg-darker border border-gray-600 rounded-md shadow-sm focus:ring-accent focus:border-accent text-gray-200">
                </div>
                <div>
                    <label for="newFollowers" class="block text-sm font-medium text-gray-300">Enter New Followers:</label>
                    <input type="text" id="newFollowers" placeholder="New Followers (e.g., toby, bobby)" class="mt-1 block w-full bg-darker border border-gray-600 rounded-md shadow-sm focus:ring-accent focus:border-accent text-gray-200">
                </div>
                <div>
                    <label for="profilePictureUpload" class="block text-sm font-medium text-gray-300">Upload Profile Picture:</label>
                    <input type="file" id="profilePictureUpload" accept="image/*" class="mt-1 block w-full bg-darker border border-gray-600 rounded-md shadow-sm focus:ring-accent focus:border-accent text-gray-200">
                </div>
                <p id="profile-message" class="text-sm text-red-500"></p>
            </form>
        </section>

        <!-- User Stats -->
        <section class="grid grid-cols-2 gap-6">
            <div class="bg-dark p-6 rounded-lg shadow-md">
                <h3 class="text-2xl font-semibold text-accent mb-4">User Stats</h3>
                <p class="text-gray-400">Followers: 120</p>
                <p class="text-gray-400">Following: 75</p>
                <p class="text-gray-400">Posts: 34</p>
            </div>
            <div class="bg-dark p-6 rounded-lg shadow-md">
                <h3 class="text-2xl font-semibold text-accent mb-4">Bio/About Me</h3>
                <p class="text-gray-400">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur nec felis vel metus.</p>
            </div>
        </section>

        <!-- Interests Section -->
        <section class="bg-dark p-6 rounded-lg shadow-md">
            <h3 class="text-2xl font-semibold text-accent mb-4">My Interests</h3>
            <p class="text-gray-400 mb-4">Click on an interest to view more details</p>
            <div class="grid grid-cols-2 gap-6" id="interestsSection"></div>
        </section>

        <!-- Followers Section -->
        <section class="bg-dark p-6 rounded-lg shadow-md">
            <h3 class="text-2xl font-semibold text-accent mb-4">My Followers</h3>
            <p class="text-gray-400 mb-4">Click on a follower to view more details</p>
            <div class="grid grid-cols-2 gap-6" id="followersSection"></div>
        </section>

        <!-- Create New Post -->
        <section class="bg-dark p-6 rounded-lg shadow-md">
            <h3 class="text-2xl font-semibold text-accent mb-4">Create New Post</h3>
            <form id="newPostForm" class="space-y-4">
                <div>
                    <label for="postTitle" class="block text-sm font-medium text-gray-300">Title</label>
                    <input type="text" id="postTitle" name="postTitle" placeholder="Enter post title" class="mt-1 block w-full bg-darker border border-gray-600 rounded-md shadow-sm focus:ring-accent focus:border-accent text-gray-200">
                </div>
                <div>
                    <label for="postComment" class="block text-sm font-medium text-gray-300">Comment</label>
                    <textarea id="postComment" name="postComment" placeholder="Enter your comment" rows="4" class="mt-1 block w-full bg-darker border border-gray-600 rounded-md shadow-sm focus:ring-accent focus:border-accent text-gray-200"></textarea>
                </div>
                <button type="button" onclick="createPost()" class="bg-accent text-white py-2 px-4 rounded-md shadow-md hover:bg-blue-600">Create Post</button>
            </form>
        </section>

        <!-- Recent Posts -->
        <section class="bg-dark p-6 rounded-lg shadow-md">
            <h3 class="text-2xl font-semibold text-accent mb-4">Recent Posts</h3>
            <div id="recentPosts" class="space-y-4"></div>
        </section>

        <!-- Activity Feed -->
        <section class="bg-dark p-6 rounded-lg shadow-md">
            <h3 class="text-2xl font-semibold text-accent mb-4">Activity Feed</h3>
            <ul class="space-y-2 text-gray-400">
                <li>User1 liked your post</li>
                <li>User2 commented on your photo</li>
                <li>User3 started following you</li>
            </ul>
        </section>
    </div>
</div>
