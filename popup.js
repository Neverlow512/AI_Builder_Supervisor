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
