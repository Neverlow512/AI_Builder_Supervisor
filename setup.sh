#!/bin/bash

# This script sets up the initial file structure and boilerplate for the Director AI Chrome Extension.

echo "--- Starting Director AI Extension Setup ---"

# 1. Create the main project directory
echo "Step 1: Creating project directory 'director-ai-extension'..."
mkdir -p director-ai-extension/icons
cd director-ai-extension || exit
echo "Done."

# 2. Create manifest.json
echo "Step 2: Creating manifest.json..."
cat << 'EOF' > manifest.json
{
  "manifest_version": 3,
  "name": "Director AI",
  "version": "0.1.0",
  "description": "An AI-powered project manager to direct and test other AI builders.",
  "permissions": [
    "storage",
    "scripting",
    "activeTab",
    "debugger"
  ],
  "host_permissions": [
    "http://*/*",
    "https://*/*"
  ],
  "action": {
    "default_popup": "popup.html",
    "default_icon": {
      "16": "icons/icon16.png",
      "48": "icons/icon48.png",
      "128": "icons/icon128.png"
    }
  },
  "icons": {
    "16": "icons/icon16.png",
    "48": "icons/icon48.png",
    "128": "icons/icon128.png"
  },
  "background": {
    "service_worker": "background.js"
  }
}
EOF
echo "Done."

# 3. Create popup.html
echo "Step 3: Creating popup.html..."
cat << 'EOF' > popup.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Director AI</title>
    <link rel="stylesheet" href="popup.css">
</head>
<body>
    <div id="chat-container">
        <div id="message-area">
            <!-- Messages will be appended here -->
            <div class="message assistant">Hello! How can we start building today?</div>
        </div>
        <div id="input-area">
            <textarea id="prompt-input" placeholder="Let's start a plan..."></textarea>
            <button id="send-button">Send</button>
        </div>
    </div>
    <script src="popup.js"></script>
</body>
</html>
EOF
echo "Done."

# 4. Create popup.css for styling
echo "Step 4: Creating popup.css..."
cat << 'EOF' > popup.css
body {
    width: 400px;
    height: 500px;
    margin: 0;
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
    display: flex;
    flex-direction: column;
    background-color: #1e1e1e;
    color: #d4d4d4;
}

#chat-container {
    display: flex;
    flex-direction: column;
    height: 100%;
}

#message-area {
    flex-grow: 1;
    overflow-y: auto;
    padding: 10px;
    border-bottom: 1px solid #333;
}

.message {
    padding: 8px 12px;
    border-radius: 18px;
    margin-bottom: 8px;
    max-width: 80%;
    line-height: 1.4;
}

.user {
    background-color: #3a3d42;
    align-self: flex-end;
    margin-left: auto;
}

.assistant {
    background-color: #2a2d31;
    align-self: flex-start;
}

#input-area {
    display: flex;
    padding: 10px;
    align-items: center;
}

#prompt-input {
    flex-grow: 1;
    height: 40px;
    padding: 10px;
    border-radius: 20px;
    border: 1px solid #444;
    background-color: #333;
    color: #d4d4d4;
    resize: none;
    font-size: 14px;
}

#send-button {
    margin-left: 10px;
    padding: 10px 20px;
    border: none;
    border-radius: 20px;
    background-color: #4a90e2;
    color: white;
    cursor: pointer;
    font-weight: bold;
}

#send-button:hover {
    background-color: #357abd;
}
EOF
echo "Done."

# 5. Create popup.js
echo "Step 5: Creating popup.js..."
cat << 'EOF' > popup.js
document.addEventListener('DOMContentLoaded', () => {
    const sendButton = document.getElementById('send-button');
    const promptInput = document.getElementById('prompt-input');
    const messageArea = document.getElementById('message-area');

    sendButton.addEventListener('click', () => {
        sendMessage();
    });

    promptInput.addEventListener('keydown', (event) => {
        if (event.key === 'Enter' && !event.shiftKey) {
            event.preventDefault();
            sendMessage();
        }
    });

    function sendMessage() {
        const messageText = promptInput.value.trim();
        if (messageText === '') return;

        // Display user message
        const userMessage = document.createElement('div');
        userMessage.className = 'message user';
        userMessage.textContent = messageText;
        messageArea.appendChild(userMessage);

        // Clear input and scroll to bottom
        promptInput.value = '';
        messageArea.scrollTop = messageArea.scrollHeight;

        // In Phase 1, we just log it. In Phase 2, this will send to the background script.
        console.log('Message to send to Director AI:', messageText);

        // Placeholder for assistant response
        // In Phase 2, the actual response from the AI will be displayed here.
        setTimeout(() => {
            const assistantMessage = document.createElement('div');
            assistantMessage.className = 'message assistant';
            assistantMessage.textContent = "Received. (Phase 1 Stub)";
            messageArea.appendChild(assistantMessage);
            messageArea.scrollTop = messageArea.scrollHeight;
        }, 500);
    }
});
EOF
echo "Done."

# 6. Create background.js
echo "Step 6: Creating background.js..."
cat << 'EOF' > background.js
// This is the service worker for the extension.
// In Phase 1, it's a placeholder.
// In Phase 2, it will handle API calls to the Director AI and manage state.

console.log("Director AI background script loaded.");

// Listen for messages from the popup
chrome.runtime.onMessage.addListener((request, sender, sendResponse) => {
    if (request.message === "hello from popup") {
        console.log("Received message from popup:", request.data);
        // Respond to the popup
        sendResponse({ farewell: "Message received, goodbye from background." });
    }
});
EOF
echo "Done."

# 7. Download icons
echo "Step 7: Downloading icons..."
wget -O icons/icon16.png https://icon-icons.com/icons2/2248/PNG/16/brain_icon_136894.png &> /dev/null
wget -O icons/icon48.png https://icon-icons.com/icons2/2248/PNG/48/brain_icon_136894.png &> /dev/null
wget -O icons/icon128.png https://icon-icons.com/icons2/2248/PNG/128/brain_icon_136894.png &> /dev/null
echo "Done."

echo ""
echo "--- Setup Complete! ---"
echo "The 'director-ai-extension' directory is ready."
echo ""
echo "Next Steps:"
echo "1. Open Google Chrome and navigate to 'chrome://extensions'."
echo "2. Enable 'Developer mode' in the top right corner."
echo "3. Click 'Load unpacked' and select the 'director-ai-extension' directory."
echo "4. The Director AI icon should now appear in your extensions bar!"

