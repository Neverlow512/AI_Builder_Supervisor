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
