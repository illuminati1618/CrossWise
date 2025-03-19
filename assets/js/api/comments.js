import { fetchOptions, pythonURI } from "./config.js";

export async function getAllComments() {
  const endpoint = pythonURI + "/api/carComment";

  try {
    const response = await fetch(endpoint, fetchOptions);
    if (!response.ok) {
      throw new Error(`Failed to fetch comments: ${response.status}`);
    }
    const comments = await response.json();
    return comments;
  } catch (error) {
    console.error("Error fetching comments:", error.message);
    return null;
  }
}

export async function getCommentsByPostId(postId) {
  const endpoint = pythonURI + "/api/carComment/" + postId;
  try {
    const response = await fetch(endpoint, fetchOptions);
    if (!response.ok) {
      throw new Error(`Failed to fetch comments: ${response.status}`);
    }
    const comments = await response.json();
    return comments;
  } catch (error) {
    console.error("Error fetching comments:", error.message);
    return null;
  }
}

export async function postComment(comment) {
  try {
    const response = await fetch(pythonURI + "/api/carComment", {
      method: "POST", // *GET, POST, PUT, DELETE, etc.
      mode: "cors", // no-cors, *cors, same-origin
      cache: "default", // *default, no-cache, reload, force-cache, only-if-cached
      credentials: "include", // include, same-origin, omit
      headers: {
        "Content-Type": "application/json",
        "X-Origin": "client", // New custom header to identify source
        Authorization: "Bearer " + localStorage.getItem("token"), // Add authorization header
      },
      body: JSON.stringify({
        content: comment.content,
        post_id: comment.post_id,
      }),
    });
    if (!response.ok) {
      const errorText = await response.text();
      console.error(
        `Failed to post comment: ${response.status} - ${errorText}`,
      );
      throw new Error(`Failed to post comment: ${response.status}`);
    }
    const result = await response.json();
    return { success: true, ...result }; // Ensure success is true if posting is successful
  } catch (error) {
    console.error("Error posting comment:", error);
    return { success: false };
  }
}

export async function deleteComment(id) {
  try {
    const response = await fetch(pythonURI + "/api/carComment", {
      method: "DELETE", // *GET, POST, PUT, DELETE, etc.
      mode: "cors", // no-cors, *cors, same-origin
      cache: "default", // *default, no-cache, reload, force-cache, only-if-cached
      credentials: "include", // include, same-origin, omit
      headers: {
        "Content-Type": "application/json",
        "X-Origin": "client", // New custom header to identify source
      },
      body: JSON.stringify({
        id: id,
      }),
    });
    if (!response.ok) {
      throw new Error(`Failed to delete comment: ${response.status}`);
    }
    const result = await response.json();
    return { success: true, ...result }; // Ensure success is true if deletion is successful
  } catch (error) {
    console.error("Error deleting comment:", error);
    return { success: false };
  }
}

export async function updateComment(id, content) {
  try {
    const response = await fetch(pythonURI + "/api/carComment", {
      method: "PUT", // *GET, POST, PUT, DELETE, etc.
      mode: "cors", // no-cors, *cors, same-origin
      cache: "default", // *default, no-cache, reload, force-cache, only-if-cached
      credentials: "include", // include, same-origin, omit
      headers: {
        "Content-Type": "application/json",
        "X-Origin": "client", // New custom header to identify source
        Authorization: "Bearer " + localStorage.getItem("token"), // Add authorization header
      },
      body: JSON.stringify({
        id: id,
        content: content,
      }),
    });
    if (!response.ok) {
      throw new Error(`Failed to update comment: ${response.status}`);
    }
    const result = await response.json();
    return { success: true, ...result }; // Ensure success is true if updating is successful
  } catch (error) {
    console.error("Error updating comment:", error);
    return { success: false };
  }
}
