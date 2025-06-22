// This file contains all the logic for interacting with the Google Gemini API.

export async function callGemini(apiKey, prompt) {
    // The corrected API endpoint with a current and valid model name
    const API_ENDPOINT = `https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=${apiKey}`;

    const requestBody = {
        contents: [{
            parts: [{
                text: prompt
            }]
        }]
    };

    try {
        const response = await fetch(API_ENDPOINT, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(requestBody)
        });

        if (!response.ok) {
            const errorBody = await response.json();
            console.error('API Error Response:', errorBody);
            throw new Error(`API request failed with status ${response.status}: ${errorBody.error.message}`);
        }

        const data = await response.json();
        // Add a check to ensure candidates exist before accessing them
        if (!data.candidates || data.candidates.length === 0) {
            console.error("API Error: No candidates returned in the response.");
            return "Error: The AI returned an empty response.";
        }
        const content = data.candidates[0].content.parts[0].text;
        return content.trim();

    } catch (error) {
        console.error('Failed to call Gemini API:', error);
        return "Error: Could not retrieve a response from the AI. Check the background script's console for details.";
    }
}
