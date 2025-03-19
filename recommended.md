---
layout: base
search_exclude: true
menu: nav/home.html
---

<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Favorites and Listings</title>
  <style>
    :root {
      --primary-red: #c62828;       /* Red accent */
      --primary-red-hover: #b71c1c;  /* Darker red on hover */
      --navy: #001f3f;              /* Navy for primary text */
      --grey: #6c757d;              /* Grey for borders and accents */
      --background: #ffffff;        /* White background */
    }
    body {
      font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
      background-color: var(--background);
      margin: 0;
      padding: 20px;
      line-height: 1.6;
      color: var(--navy);
    }
    .container {
      max-width: 800px;
      margin: 0 auto 20px;
      background-color: var(--background);
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 2px 4px rgba(0,0,0,0.1);
      border: 1px solid var(--grey);
    }
    h1 {
      font-size: 1.8rem;
      color: var(--primary-red);
      border-bottom: 2px solid var(--primary-red);
      padding-bottom: 10px;
      margin-bottom: 20px;
    }
    .favorite-item, .listing {
      border: 1px solid var(--grey);
      padding: 15px;
      margin-bottom: 15px;
      border-radius: 8px;
      background-color: #f9f9f9;
      transition: transform 0.2s ease, box-shadow 0.2s ease;
    }
    .favorite-item:hover, .listing:hover {
      transform: translateY(-2px);
      box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    }
    .listing-image {
      max-width: 100%;
      height: auto;
      border-radius: 5px;
      margin-bottom: 10px;
    }
    button {
      background-color: var(--primary-red);
      color: var(--background);
      border: none;
      padding: 10px 15px;
      border-radius: 5px;
      cursor: pointer;
      font-size: 0.9rem;
      transition: background-color 0.3s ease;
    }
    button:hover {
      background-color: var(--primary-red-hover);
    }
    input[type="text"] {
      width: 100%;
      padding: 8px;
      margin-top: 10px;
      border: 1px solid var(--grey);
      border-radius: 5px;
    }
    /* Add gap between the button and favorites list */
    #favorites-container {
      margin-top: 15px;
    }
    /* Update prompt styling */
    .update-prompt {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      display: flex;
      justify-content: center;
      align-items: center;
      z-index: 1000;
    }
    .update-overlay {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(0, 0, 0, 0.5);
    }
    .update-box {
      position: relative;
      background: var(--background);
      padding: 20px;
      border-radius: 10px;
      box-shadow: 0 4px 6px rgba(0,0,0,0.1);
      z-index: 1001;
      max-width: 90%;
      width: 400px;
    }
    .update-actions {
      margin-top: 15px;
      display: flex;
      justify-content: flex-end;
      gap: 10px;
    }
    .update-actions button {
      padding: 8px 12px;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      font-size: 0.9rem;
    }
    .update-actions button:first-child {
      background-color: #28a745;
      color: #fff;
    }
    .update-actions button:last-child {
      background-color: #dc3545;
      color: #fff;
    }
  </style>
</head>
<body>
  <div class="container">
    <h1>Favorites</h1>
    <button id="display-favorites-button">Show Favorites</button>
    <!-- Favorites container is initially hidden -->
    <div id="favorites-container" style="display: none;"></div>
  </div>

  <div class="container">
    <h1>Listings</h1>
    <div id="listings-container"></div>
  </div>

  <script type="module">
    import { getListings } from '{{site.baseurl}}/assets/js/api/listings.js';
    import { pythonURI } from '{{site.baseurl}}/assets/js/api/config.js';

    document.addEventListener("DOMContentLoaded", () => {
      const favoritesContainer = document.getElementById("favorites-container");
      const displayFavoritesButton = document.getElementById("display-favorites-button");

      // Function to fetch and display favorites
      async function get_favorites() {
        try {
          const response = await fetch(`${pythonURI}/api/itemStore`, {
            method: 'GET',
            mode: 'cors',
            cache: 'default',
            credentials: 'include',
            headers: {
              'Content-Type': 'application/json',
              'X-Origin': 'client'
            }
          });
          if (!response.ok) throw new Error('Failed to fetch favorites');
          const data = await response.json();
          console.log(data);
          // Clear old favorites
          favoritesContainer.innerHTML = '';
          // Populate favorites container with data
          data.forEach(item => {
            const favoriteElement = document.createElement('div');
            favoriteElement.classList.add('favorite-item');
            favoriteElement.innerHTML = `
              <h3>${item.name}</h3>
              <p>${item.user_input}</p>
              <button class="update-button" data-id="${item.id}" data-name="${item.name}">Update Comment</button>
              <button class="delete-button" data-name="${item.name}">Delete</button>
            `;
            favoritesContainer.appendChild(favoriteElement);
          });
          // Add event listeners to delete buttons
          const deleteButtons = document.querySelectorAll(".delete-button");
          deleteButtons.forEach(button => {
            button.addEventListener("click", async (event) => {
              const itemName = event.target.getAttribute("data-name");
              await delete_favorite(itemName);
            });
          });
        } catch (error) {
          console.error(error);
          favoritesContainer.innerHTML = '<p>Error loading favorites. Please try again.</p>';
        }
      }

      // Function to delete a favorite
      async function delete_favorite(itemName) {
        try {
          const response = await fetch(`${pythonURI}/api/itemStore`, {
            method: 'DELETE',
            mode: 'cors',
            cache: 'default',
            credentials: 'include',
            headers: {
              'Content-Type': 'application/json',
              'X-Origin': 'client'
            },
            body: JSON.stringify({ name: itemName })
          });
          if (!response.ok) throw new Error('Failed to delete favorite');
          const data = await response.json();
          alert(data.message || 'Favorite deleted successfully!');
          // Refresh favorites if visible
          if (favoritesContainer.style.display !== 'none') {
            await get_favorites();
          }
        } catch (error) {
          console.error('Error deleting favorite:', error);
          alert('An unexpected error occurred while deleting the item.');
        }
      }

      // Modified update_comment function that returns a boolean status.
      async function update_comment(newComment, id) {
        try {
          const response = await fetch(`${pythonURI}/api/itemStore`, {
            method: 'PUT',
            mode: 'cors',
            cache: 'default',
            credentials: 'include',
            headers: {
              'Content-Type': 'application/json',
              'X-Origin': 'client'
            },
            body: JSON.stringify({ id: id, user_input: newComment })
          });
          if (!response.ok) throw new Error('Failed to update comment');
          const data = await response.json();
          alert(data.message || 'Comment updated successfully!');
          return true;
        } catch (error) {
          console.error('Error updating comment:', error);
          alert('An unexpected error occurred while updating the comment.');
          return false;
        }
      }

      // Event delegation for update button clicks in favoritesContainer
      favoritesContainer.addEventListener('click', (event) => {
        if (event.target.classList.contains('update-button')) {
          const itemName = event.target.getAttribute('data-name');
          const itemId = event.target.getAttribute('data-id');

          // Create the update comment prompt
          const updatePrompt = document.createElement('div');
          updatePrompt.classList.add('update-prompt');
          updatePrompt.innerHTML = `
            <div class="update-overlay"></div>
            <div class="update-box">
              <h3>Update Comment for ${itemName}</h3>
              <input type="text" id="new-comment" placeholder="Enter new comment" />
              <div class="update-actions">
                <button id="save-comment">Save</button>
                <button id="close-prompt">Close</button>
              </div>
            </div>
          `;
          document.body.appendChild(updatePrompt);

          // Close the prompt
          document.getElementById('close-prompt').addEventListener('click', () => {
            document.body.removeChild(updatePrompt);
          });

          // Save the new comment and update DOM directly
          document.getElementById('save-comment').addEventListener('click', async () => {
            const newComment = document.getElementById('new-comment').value;
            if (newComment.trim() !== '') {
              const success = await update_comment(newComment, itemId);
              if (success) {
                // Update only the specific comment element in the DOM
                const favoriteItems = document.querySelectorAll('.favorite-item');
                favoriteItems.forEach(item => {
                  if (item.querySelector('h3').textContent === itemName) {
                    const commentElement = item.querySelector('p');
                    commentElement.textContent = newComment;
                  }
                });
                document.body.removeChild(updatePrompt);
              }
            } else {
              alert('Please enter a valid comment.');
            }
          });
        }
      });

      // Toggle display for favorites on button click
      displayFavoritesButton.addEventListener('click', async () => {
        if (favoritesContainer.style.display === 'none' || favoritesContainer.innerHTML.trim() === '') {
          // Show favorites
          await get_favorites();
          favoritesContainer.style.display = 'block';
          displayFavoritesButton.textContent = 'Hide Favorites';
        } else {
          // Hide favorites
          favoritesContainer.style.display = 'none';
          displayFavoritesButton.textContent = 'Show Favorites';
        }
      });

      // Fetch and display listings
      getListings().then((listings) => {
        const listingsContainer = document.getElementById("listings-container");
        if (!listingsContainer) {
          console.error('Listings container not found');
          return;
        }
        listings.forEach(listing => {
          const listingElement = document.createElement("div");
          listingElement.classList.add("listing");
          const content = `
            <img src="${listing.picture}" alt="${listing.name}" class="listing-image" />
            <h2>${listing.name}</h2>
            <p><strong>Type:</strong> ${listing.type}</p>
            <p><strong>Mileage:</strong> ${listing.mileage}</p>
            <p><strong>Price:</strong> ${listing.price}</p>
            <button class="favorite-button" data-name="${listing.name}">Add to Favorites</button>
            <input type="text" id="${listing.name}-comment" placeholder="Enter a comment">
          `;
          listingElement.innerHTML = content;
          listingsContainer.appendChild(listingElement);
        });
        const favoriteButtons = document.querySelectorAll(".favorite-button");
        favoriteButtons.forEach(button => {
          button.addEventListener("click", async (event) => {
            const listingName = event.target.getAttribute("data-name");
            const listingComment = document.getElementById(listingName + "-comment").value;
            try {
              const response = await fetch(`${pythonURI}/api/itemStore`, {
                method: 'POST',
                mode: 'cors',
                cache: 'default',
                credentials: 'include',
                headers: {
                  'Content-Type': 'application/json',
                  'X-Origin': 'client'
                },
                body: JSON.stringify({ name: listingName, user_input: listingComment })
              });
              if (response.ok) {
                const data = await response.json();
                if (data.name === undefined) {
                  alert(`Listing is already in your favorites.`);
                } else {
                  alert(`Listing '${data.name}' has been added to your favorites!`);
                }
                // Automatically refresh favorites if they are visible
                if (favoritesContainer.style.display !== 'none') {
                  await get_favorites();
                }
              } else if (response.status === 409) {
                alert(`Listing '${listingName}' is already in your favorites.`);
              } else {
                const errorData = await response.json();
                const errorMsg = errorData.message || errorData.error || `An error occurred.`;
                alert(`Error: ${errorMsg}`);
              }
            } catch (error) {
              console.error('Failed to add favorite:', error);
              alert('An unexpected error occurred.');
            }
          });
        });
      });
    });
  </script>
</body>
</html>
