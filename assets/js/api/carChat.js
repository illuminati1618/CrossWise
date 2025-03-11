import { fetchOptions, pythonURI } from "./config.js";

export async function getAllChat() {
  const endpoint = pythonURI + "/api/carChat";

  try {
    const response = await fetch(endpoint, fetchOptions);
    if (!response.ok) {
      throw new Error(`Failed to fetch Chat: ${response.status}`);
    }
    const Chat = await response.json();
    return Chat;
  } catch (error) {
    console.error("Error fetching chat:", error.message);
    return null;
  }
}

export async function postChat(content) {
  try {
      const response = await fetch(pythonURI+'/api/carChat',
        { 
        method: 'POST', // *GET, POST, PUT, DELETE, etc.
        mode: 'cors', // no-cors, *cors, same-origin
        cache: 'default', // *default, no-cache, reload, force-cache, only-if-cached
        credentials: 'include', // include, same-origin, omit
        headers: {
            'Content-Type': 'application/json',
            'X-Origin': 'client', // New custom header to identify source
        },
          body: JSON.stringify({
              message: content,
          }),
      });
      if (!response.ok) {
        const errorText = await response.text();
        console.error(`Failed to post Chat: ${response.status} - ${errorText}`);
        throw new Error(`Failed to post Chat: ${response.status}`);
      }
      const result = await response.json();
      return { success: true, ...result }; // Ensure success is true if posting is successful
  } catch (error) {
      console.error('Error posting Chat:', error);
      return { success: false };
  }
}

export async function deleteChat(id) {
  try {
      const response = await fetch(pythonURI+'/api/carChat',
        { 
        method: 'DELETE', // *GET, POST, PUT, DELETE, etc.
        mode: 'cors', // no-cors, *cors, same-origin
        cache: 'default', // *default, no-cache, reload, force-cache, only-if-cached
        credentials: 'include', // include, same-origin, omit
        headers: {
            'Content-Type': 'application/json',
            'X-Origin': 'client' // New custom header to identify source
        },
          body: JSON.stringify({
              id: id,
          }),
      });
      if (!response.ok) {
        throw new Error(`Failed to delete Chat: ${response.status}`);
      }
      const result = await response.json();
      return { success: true, ...result }; // Ensure success is true if deletion is successful
  } catch (error) {
      console.error('Error deleting Chat:', error);
      return { success: false };
  }
}

export async function updateChat(id, content) {
  try {
      const response = await fetch(pythonURI + '/api/carChat',
        { 
        method: 'PUT', // *GET, POST, PUT, DELETE, etc.
        mode: 'cors', // no-cors, *cors, same-origin
        cache: 'default', // *default, no-cache, reload, force-cache, only-if-cached
        credentials: 'include', // include, same-origin, omit
        headers: {
            'Content-Type': 'application/json',
            'X-Origin': 'client', // New custom header to identify source
            'Authorization': 'Bearer ' + localStorage.getItem('token') // Add authorization header
        },
          body: JSON.stringify({
              id: id,
              message: content,
          }),
      });
      if (!response.ok) {
        throw new Error(`Failed to update Chat: ${response.status}`);
      }
      const result = await response.json();
      return { success: true, ...result }; // Ensure success is true if updating is successful
  } catch (error) {
      console.error('Error updating Chat:', error);
      return { success: false };
  }
}
