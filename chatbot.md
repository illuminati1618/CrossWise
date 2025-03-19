---
layout: needsAuth
title: Car Expert Chatbot
permalink: /chatbot
search_exclude: true
menu: nav/home.html
---

<div class="flex min-h-full flex-col justify-center px-6 py-12 lg:px-8">
  <div class="sm:mx-auto sm:w-full sm:max-w-sm">
    <h2 class="mt-10 text-center text-2xl/9 font-bold tracking-tight text-gray-900">Car Expert Chatbot</h2>
  </div>

  <div class="mt-10 sm:mx-auto sm:w-full sm:max-w-sm">
    <div id="chat-container" class="border rounded-md px-3 py-3 overflow-y-auto h-80 bg-gray-100"></div>
    <form class="space-y-4 mt-4" id="chat-form">
      <div>
        <label for="user-input" class="block text-sm/6 font-medium text-gray-900">Your Message</label>
        <div class="mt-2">
          <input type="text" id="user-input" placeholder="Type your message here" required class="block w-full rounded-md bg-white px-3 py-1.5 text-base text-gray-900 outline outline-1 -outline-offset-1 outline-gray-300 placeholder:text-gray-400 focus:outline focus:outline-2 focus:-outline-offset-2 focus:outline-rose-600 sm:text-sm/6">
        </div>
      </div>
      <div>
        <button type="submit" class="flex w-full justify-center rounded-md bg-rose-600 px-3 py-1.5 text-sm/6 font-semibold text-white shadow-sm hover:bg-rose-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-rose-600">Send</button>
      </div>
    </form>
    <!-- Clear History Button -->
    <div class="mt-4">
      <button id="clear-history" class="flex w-full justify-center rounded-md bg-gray-300 px-3 py-1.5 text-sm/6 font-semibold text-gray-900 shadow-sm hover:bg-gray-200 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-gray-400">
        Clear History
      </button>
    </div>
  </div>
</div>

<script type="module">
  import { pythonURI, fetchOptions } from '{{site.baseurl}}/assets/js/api/config.js';

  // Load chat history from localStorage
  function loadChatHistory() {
    const chatContainer = document.getElementById("chat-container");
    const chatHistory = JSON.parse(localStorage.getItem("chatHistory")) || [];

    // Render messages from localStorage
    chatHistory.forEach((message) => {
      const messageDiv = document.createElement("div");
      messageDiv.className = message.isBot
        ? "bg-gray-200 text-gray-900 px-4 py-2 rounded-lg my-2"
        : "bg-blue-100 text-gray-900 px-4 py-2 rounded-lg my-2";
      messageDiv.textContent = message.text;
      chatContainer.appendChild(messageDiv);
    });

    // Scroll to the latest message
    chatContainer.scrollTop = chatContainer.scrollHeight;
  }

  // Save chat history to localStorage
  function saveChatHistory(userInput, botResponse) {
    const chatHistory = JSON.parse(localStorage.getItem("chatHistory")) || [];

    // Save user and bot messages to localStorage
    chatHistory.push({ text: userInput, isBot: false });
    chatHistory.push({ text: botResponse, isBot: true });

    // Update localStorage with new chat history
    localStorage.setItem("chatHistory", JSON.stringify(chatHistory));
  }

  async function handleChat(event) {
    event.preventDefault(); // Prevent form submission

    const userInputField = document.getElementById("user-input");
    const userInput = userInputField.value.trim();

    if (!userInput) return false;

    const chatContainer = document.getElementById("chat-container");

    // Add user message to chat
    const userMessageDiv = document.createElement("div");
    userMessageDiv.className = "bg-blue-100 text-gray-900 px-4 py-2 rounded-lg my-2";
    userMessageDiv.textContent = userInput;
    chatContainer.appendChild(userMessageDiv);

    userInputField.value = ""; // Clear the input field

    try {
      const response = await fetch(`${pythonURI}/api/chatbot`, {
        method: "POST",
        cache: "default",
        mode: "cors",
        credentials: "include",
        body: JSON.stringify({
          user_input: userInput
        }),
        headers: {
          'Content-Type': 'application/json',
          'X-Origin': 'client'
        },
      });

      if (!response.ok) {
        throw new Error(`Server returned status: ${response.status}`);
      }

      const data = await response.json();

      // Add chatbot response to chat
      const botMessageDiv = document.createElement("div");
      botMessageDiv.className = "bg-gray-200 text-gray-900 px-4 py-2 rounded-lg my-2";
      botMessageDiv.textContent = data.model_response || "No response received.";
      chatContainer.appendChild(botMessageDiv);

      // Save messages to localStorage
      saveChatHistory(userInput, data.model_response || "No response received.");

    } catch (error) {
      console.error("Error");

      // Display an error message
      const errorMessageDiv = document.createElement("div");
      errorMessageDiv.className = "bg-red-200 text-red-900 px-4 py-2 rounded-lg my-2";
      errorMessageDiv.textContent = "Error: Unable to process your message.";
      chatContainer.appendChild(errorMessageDiv);
    }

    // Scroll to the latest message
    chatContainer.scrollTop = chatContainer.scrollHeight;

    return false;
  }

  // Clear chat history from UI and localStorage
  function clearChatHistory() {
    const chatContainer = document.getElementById("chat-container");
    chatContainer.innerHTML = ''; // Clear chat container
    localStorage.removeItem("chatHistory"); // Remove chat history from localStorage
  }

  // Load chat history on page load
  document.addEventListener("DOMContentLoaded", loadChatHistory);

  // Attach event listener to the form
  document.getElementById("chat-form").addEventListener("submit", handleChat);

  // Attach event listener to the clear history button
  document.getElementById("clear-history").addEventListener("click", clearChatHistory);
</script>
