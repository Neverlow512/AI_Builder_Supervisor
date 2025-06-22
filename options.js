document.addEventListener('DOMContentLoaded', () => {
    const saveButton = document.getElementById('save-button');
    const apiKeyInput = document.getElementById('api-key-input');
    const statusDiv = document.getElementById('status');

    // Load any currently saved API key and display it in the input
    chrome.storage.sync.get('apiKey', (data) => {
        if (data.apiKey) {
            apiKeyInput.value = data.apiKey;
        }
    });

    // Save the new key when the button is clicked
    saveButton.addEventListener('click', () => {
        const apiKey = apiKeyInput.value.trim();
        if (apiKey) {
            // Use chrome.storage.sync to save the key
            chrome.storage.sync.set({ apiKey: apiKey }, () => {
                console.log('API Key saved.');
                statusDiv.textContent = 'API Key saved successfully!';
                // Clear the status message after a few seconds
                setTimeout(() => {
                    statusDiv.textContent = '';
                }, 3000);
            });
        }
    });
});
