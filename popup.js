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

        // Display user message in the UI
        displayMessage(messageText, 'user');
        promptInput.value = '';

        // *** NEW: Send message to the background script (the "brain") ***
        chrome.runtime.sendMessage({ type: 'DIRECTOR_AI_QUERY', content: messageText }, (response) => {
            if (chrome.runtime.lastError) {
                // Handle errors, e.g., if the background script is not available
                console.error(chrome.runtime.lastError);
                displayMessage('Error: Could not connect to the service worker.', 'assistant');
                return;
            }
            // Display the response from the background script
            displayMessage(response.content, 'assistant');
        });
    }

    function displayMessage(text, sender) {
        const messageElement = document.createElement('div');
        messageElement.className = `message ${sender}`;
        messageElement.textContent = text;
        messageArea.appendChild(messageElement);
        messageArea.scrollTop = messageArea.scrollHeight;
    }
});
