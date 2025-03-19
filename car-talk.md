---
layout: base
title: Car Talk
search_exclude: true
menu: nav/home.html
permalink: /Chat
---

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chat</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        /* Reset some default browser styles */
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4; /* Light background color */
        }

        /* Outer container to center chat content */
        .chat-container {
            max-width: 800px;         /* Limit maximum width */
            margin: 40px auto;        /* Center horizontally, add top/bottom spacing */
            background-color: #fff;   /* White background */
            border-radius: 8px;       /* Rounded corners */
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;   /* Stack elements vertically */
            height: 80vh;             /* Occupy 80% of viewport height */
            overflow: hidden;         /* Hide overflow if needed */
        }

        /* Scrollable area for chat messages */
        .chat-box {
            flex: 1;                  /* Grow to fill space */
            padding: 20px;            /* Inner spacing */
            overflow-y: auto;         /* Enable vertical scroll */
        }

        /* Individual message container */
        .message-box {
            position: relative;       /* So we can position edit/delete buttons */
            margin-bottom: 15px;      /* Space between messages */
            max-width: 70%;           /* Limit message bubble width */
            padding: 10px 15px;
            border-radius: 8px;
            word-wrap: break-word;     /* Wrap long text */
        }

        /* Example styling for 'sent' vs 'received' messages */
        .sent-message {
            background-color: #e3f2fd; /* Light blue background */
            margin-left: auto;         /* Push bubble to the right */
        }

        .received-message {
            background-color: #f5f5f5; /* Light gray background */
            margin-right: auto;        /* Push bubble to the left */
        }

        /* Button container in top-right of each message */
        .button-container {
            position: absolute;
            top: 5px;
            right: 10px;
            display: flex;
            gap: 5px;
        }

        /* Edit/Delete buttons */
        .edit-button,
        .delete-button {
            background: none;
            border: none;
            color: #007bff;
            cursor: pointer;
            font-size: 0.85em;
            padding: 2px 5px;
            border-radius: 3px;
            transition: background-color 0.2s, color 0.2s;
        }
        .edit-button:hover,
        .delete-button:hover {
            background-color: #e2e6ea;
            color: #0056b3;
        }

        /* Footer form for new messages */
        #chatForm {
            display: flex;
            padding: 15px;
            border-top: 1px solid #ddd;
        }
        #messageInput {
            flex: 1;                /* Grow to fill space */
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 10px;
            margin-right: 10px;
            font-size: 1em;
        }
        .send-button {
            border: none;
            border-radius: 5px;
            background-color: #28a745;
            color: white;
            padding: 10px 20px;
            cursor: pointer;
            font-size: 1em;
            transition: background-color 0.3s;
        }
        .send-button:hover {
            background-color: #218838;
        }
    </style>

</head>
<body>
    <div class="chat-container">
        <div class="chat-box" id="chatBox">
            <!-- Example static messages for demonstration -->
            <div class="message-box sent-message">
                <div class="button-container">
                    <button class="edit-button">Edit</button>
                    <button class="delete-button">Delete</button>
                </div>
                <strong>You</strong><br>
                Hello!
            </div>
            <div class="message-box received-message">
                <div class="button-container">
                    <button class="edit-button">Edit</button>
                    <button class="delete-button">Delete</button>
                </div>
                <strong>User123</strong><br>
                Hi there!
            </div>
        </div>
        <form id="chatForm">
            <input type="text" id="messageInput" placeholder="Type your message..." required>
            <button type="submit" class="send-button">Send</button>
        </form>
    </div>

    <script type="module">
        import { getAllChat, postChat, deleteChat, updateChat } from "{{site.baseurl}}/assets/js/api/carChat.js";

        // Function to create a chat message display with delete and edit buttons
        function createMessageDisplay(message) {
            // Container
            const messageBox = document.createElement("div");
            messageBox.classList.add("message-box");

            // Decide if it's a "sent" or "received" style
            // (You could add logic here if you know the current user's ID.)
            // For now, just use "received-message" by default:
            messageBox.classList.add("received-message");

            // Content
            const content = document.createElement("div");
            content.innerHTML = `<strong>UID: ${message.user_id}</strong><br>${message.message}`;
            messageBox.appendChild(content);

            // Button container
            const buttonContainer = document.createElement("div");
            buttonContainer.className = "button-container";

            // Delete button
            const deleteButton = document.createElement("button");
            deleteButton.className = "delete-button";
            deleteButton.innerHTML = "Delete";
            deleteButton.addEventListener("click", async () => {
                const result = await deleteChat(message.id);
                if (result.success) {
                    alert("Message deleted successfully!");
                    messageBox.remove(); // Remove the message box immediately
                } else {
                    alert("Failed to delete message.");
                }
            });
            buttonContainer.appendChild(deleteButton);

            // Edit button
            const editButton = document.createElement("button");
            editButton.className = "edit-button";
            editButton.innerHTML = "Edit";
            editButton.addEventListener("click", () => {
                const newContent = prompt("Edit your message:", message.message);
                if (newContent !== null) {
                    updateChat(message.id, newContent).then(result => {
                        if (result.success) {
                            alert("Message updated successfully!");
                            content.innerHTML = `<strong>UID: ${message.user_id}</strong><br>${newContent}`;
                        } else {
                            alert("Failed to update message.");
                        }
                    });
                }
            });
            buttonContainer.appendChild(editButton);

            messageBox.appendChild(buttonContainer);
            return messageBox;
        }

        // Display all messages
        async function displayMessages() {
            const messages = await getAllChat();
            const chatBox = document.getElementById("chatBox");
            chatBox.innerHTML = ""; // Clear existing content

            if (messages && messages.length > 0) {
                messages.forEach(message => {
                    const newMessageDisplay = createMessageDisplay(message);
                    chatBox.appendChild(newMessageDisplay);
                });
                // Scroll to the bottom of the chat
                chatBox.scrollTop = chatBox.scrollHeight;
            } else {
                chatBox.innerHTML = "<p>No messages available.</p>";
            }
        }

        // Submit a new message
        async function submitMessage() {
            const messageInput = document.getElementById("messageInput");
            const messageContent = messageInput.value.trim();

            if (messageContent) {
                const result = await postChat(messageContent);
                if (result.success) {
                    messageInput.value = "";
                    displayMessages(); // Refresh the messages
                } else {
                    console.error('Failed to submit message:', result);
                    alert("Failed to submit message.");
                }
            } else {
                alert("Message cannot be empty.");
            }
        }

        // Event listeners
        document.addEventListener("DOMContentLoaded", () => {
            const chatForm = document.getElementById("chatForm");
            chatForm.addEventListener("submit", async (e) => {
                e.preventDefault(); // Prevent page refresh
                await submitMessage();
            });

            // Initial display of messages
            displayMessages();
        });
    </script>

</body>
</html>
