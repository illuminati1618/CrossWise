import { fetchOptions, pythonURI } from "./config.js";

export async function createUserCar(
  make,
  model,
  year,
  engine_type,
  trim,
  color,
  vin,
) {
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
      make: make,
      model: model,
      year: year,
      engine_type: engine_type,
      trim: trim,
      color: color,
      vin: vin,
    }),
  };

  const endpoint = pythonURI + "/api/userCars";

  try {
    const response = await fetch(endpoint, postOptions);
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

export async function getUserCars() {
  const endpoint = pythonURI + "/api/userCars";
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

export async function deleteCarById(id) {
  const endpoint = pythonURI + "/api/userCars";
  const deleteOptions = {
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
  console.log(deleteOptions);
  try {
    const response = await fetch(endpoint, deleteOptions);
    if (!response.ok) {
      console.error(`Failed to delete car: ${response.status}`);
      return false;
    }
    return true;
  } catch (error) {
    console.error("Error deleting car:", error.message);
    return false;
  }
}
