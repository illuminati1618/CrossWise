---
layout: needsAuth
title: Settings
permalink: /settings
menu: nav/home.html
search_exclude: true
show_reading_time: false
---

<div class="settings-container max-w-4xl mx-auto mt-10 p-6 bg-white rounded-lg shadow-lg">
  <h2 class="text-3xl font-semibold text-gray-700 mb-6">Settings</h2>
  <form class="space-y-6">
    <div>
      <label for="newUid" class="block text-sm font-medium text-gray-700">Enter New Username:</label>
      <input type="text" id="newUid" placeholder="New Username" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
    </div>
    <div>
      <label for="newPassword" class="block text-sm font-medium text-gray-700">Enter New Password:</label>
      <input type="password" id="newPassword" placeholder="New Password" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
    </div>
    <div>
      <label for="profilePicture" class="block text-sm font-medium text-gray-700">Upload Profile Picture:</label>
      <input type="file" id="profilePicture" accept="image/*" class="mt-1 block w-full text-sm text-gray-900 border border-gray-300 rounded-md cursor-pointer focus:outline-none">
    </div>
    <div class="flex justify-end space-x-4">
      <button type="button" onclick="updateSettings()" class="px-4 py-2 bg-blue-600 text-white rounded-md shadow-sm hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">Update Settings</button>
    </div>
    <p id="settings-message" class="text-red-500 mt-4"></p>
  </form>
</div>

<script type="module">
import { pythonURI, fetchOptions } from '{{site.baseurl}}/assets/js/api/config.js';
import { putUpdate, logoutUser } from "{{site.baseurl}}/assets/js/api/profile.js";
import { convertToBase64 } from "{{site.baseurl}}/assets/js/api/posts.js";

window.updateSettings = async function() {
  const newUid = document.getElementById('newUid').value;
  const newPassword = document.getElementById('newPassword').value;
  const fileInput = document.getElementById('profilePicture');
  const file = fileInput.files[0];

  let settingsUpdated = false;

  if (newUid) {
    const uidOptions = {
      URL: pythonURI + "/api/user",
      body: { uid: newUid },
      message: 'settings-message',
      callback: () => {
        alert("You updated your username, so you will automatically be logged out. Be sure to remember your new username to log in!");
        window.location.href = 'http://127.0.0.1:4887/personal_flocker_frontend/noauth'; // Updated redirect URL
      }
    };
    try {
      await putUpdate(uidOptions);
      localStorage.setItem('username', newUid);
      settingsUpdated = true;
    } catch (error) {
      console.error('Error updating username:', error.message);
      document.getElementById('settings-message').textContent = 'Error updating username: ' + error.message;
    }
  }

  if (newPassword) {
    const passwordOptions = {
      URL: pythonURI + "/api/user",
      body: { password: newPassword },
      message: 'settings-message',
      callback: async () => {
        alert("You updated your password, so you will automatically be logged out. Be sure to remember your new password!");
        await logoutUser();
        window.location.href = 'http://127.0.0.1:4887/personal_flocker_frontend/noauth'; // Updated redirect URL
      }
    };
    try {
      await putUpdate(passwordOptions);
      settingsUpdated = true;
    } catch (error) {
      console.error('Error updating password:', error.message);
      document.getElementById('settings-message').textContent = 'Error updating password: ' + error.message;
    }
  }

  if (file) {
    try {
      const base64String = await convertToBase64(file);
      const options = {
        URL: pythonURI + "/api/id/pfp",
        body: { pfp: base64String },
        message: 'settings-message',
        callback: () => {
          console.log('Profile picture uploaded successfully!');
          document.getElementById('profile-picture').src = `data:image/jpeg;base64,${base64String}`;
        }
      };
      await putUpdate(options);
      localStorage.setItem('profilePicture', `data:image/jpeg;base64,${base64String}`);
      settingsUpdated = true;
    } catch (error) {
      console.error('Error uploading profile picture:', error.message);
      document.getElementById('settings-message').textContent = 'Error uploading profile picture: ' + error.message;
    }
  }

  if (settingsUpdated) {
    document.getElementById('settings-message').textContent = 'Settings Saved!';
    document.getElementById('settings-message').classList.remove('text-red-500');
    document.getElementById('settings-message').classList.add('text-green-500');
  }
}
</script>
