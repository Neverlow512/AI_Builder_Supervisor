// Import the API calling function from our new module
import { callGemini } from './gemini_api.js';

console.log("Director AI background script loaded (Module).");

chrome.runtime.onMessage.addListener((request, sender, sendResponse) => {
    if (request.type === 'DIRECTOR_AI_QUERY') {
        handleDirectorQuery(request, sendResponse);
    }
    return true; // Keep the message channel open for the async response
});

async function handleDirectorQuery(request, sendResponse) {
    console.log("Received query from popup:", request.content);

    // 1. Get the API Key from storage
    const { apiKey } = await chrome.storage.sync.get('apiKey');

    if (!apiKey) {
        sendResponse({ 
            type: 'DIRECTOR_AI_RESPONSE',
            content: "Error: API Key not found. Please set your Gemini API key in the extension's options." 
        });
        return;
    }

    // 2. Call the Gemini API
    const aiResponse = await callGemini(apiKey, request.content);

    // 3. Send the response back to the popup
    sendResponse({ 
        type: 'DIRECTOR_AI_RESPONSE',
        content: aiResponse 
    });
}
