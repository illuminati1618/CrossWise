import { fetchOptions, pythonURI } from "./config.js";

export async function getPostsByType(carType) {
  const possibleCarTypes = ["gas", "electric", "hybrid", "dream", "all"];
  if (!possibleCarTypes.includes(carType)) {
    throw new Error("Invalid car type");
  }

  let endpoint = pythonURI + "/api/carPost/allPosts/" + carType;

  if (carType == "all") {
    endpoint = pythonURI + "/api/carPost";
  }

  try {
    const response = await fetch(endpoint, fetchOptions);
    if (!response.ok) {
      throw new Error(`Failed to fetch posts: ${response.status}`);
    }
    const posts = await response.json();
    return posts;
  } catch (error) {
    console.error("Error fetching posts:", error.message);
    return null;
  }
}

export async function getPostsByUser(uid) {
  let endpoint = pythonURI + "/api/carPost";

  try {
    const response = await fetch(endpoint, fetchOptions);
    if (!response.ok) {
      throw new Error(`Failed to fetch posts: ${response.status}`);
    }
    const posts = await response.json();

    console.log(posts);

    return posts.filter((post) => post.user.id === uid);
  } catch (error) {
    console.error("Error fetching posts:", error.message);
    return null;
  }
}

export async function getImagesByPostId(postId) {
  const endpoint = pythonURI + "/api/carPost/" + postId + "/images";

  try {
    const response = await fetch(endpoint, fetchOptions);
    if (!response.ok) {
      throw new Error(`Failed to fetch images: ${response.status}`);
    }
    const images = await response.json();
    return images;
  } catch (error) {
    console.error("Error fetching images:", error.message);
    return null;
  }
}

export async function createPost(post) {
  const postOptions = {
    method: "POST", // *GET, POST, PUT, DELETE, etc.
    mode: "cors", // no-cors, *cors, same-origin
    cache: "default", // *default, no-cache, reload, force-cache, only-if-cached
    credentials: "include", // include, same-origin, omit
    headers: {
      "Content-Type": "application/json",
      "X-Origin": "client", // New custom header to identify source
    },
    body: JSON.stringify({
      title: post.title,
      description: post.description,
      car_type: post.car_type,
      image_base64_table: post.image_base64_table,
    }),
  };

  const endpoint = pythonURI + "/api/carPost";

  try {
    const response = await fetch(endpoint, postOptions);
    if (!response.ok) {
      throw new Error(`Failed to fetch posts: ${response.status}`);
    }
    const posts = await response.json();
    return true;
  } catch (error) {
    console.error("Error fetching posts:", error.message);
    return false;
  }
}

export async function removePostById(id) {
  const postOptions = {
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
  };

  const endpoint = pythonURI + "/api/carPost";

  try {
    const response = await fetch(endpoint, postOptions);
    if (!response.ok) {
      throw new Error(`Failed to fetch posts: ${response.status}`);
    }
    const data = await response.json();
    return data["deleted"];
  } catch (error) {
    console.error("Error fetching posts:", error.message);
    return null;
  }
}

export async function convertToBase64(file) {
  return new Promise((resolve, reject) => {
    const reader = new FileReader();
    reader.onload = () => resolve(reader.result.split(",")[1]); // Remove the prefix part of the result
    reader.onerror = (error) => reject(error);
    reader.readAsDataURL(file);
  });
}
