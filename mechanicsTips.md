---
layout: needsAuth
title: Mechanics Tips
permalink: /mechanical-help
search_exclude: true
menu: nav/home.html
---

<div class="flex min-h-full flex-col justify-center px-6 py-12 lg:px-8">
  <div class="sm:mx-auto sm:w-full sm:max-w-sm">
    <h2 class="mt-10 text-center text-2xl/9 font-bold tracking-tight text-gray-900">Manage Mechanics Tips</h2>
  </div>

  <div class="mt-10 sm:mx-auto sm:w-full sm:max-w-sm">
    <!-- Add Mechanics Tip Form -->
    <form class="space-y-4 mt-4" id="add-tip-form">
      <div>
        <label for="make" class="block text-sm/6 font-medium text-gray-900">Make</label>
        <input type="text" id="make" placeholder="Enter Make" required class="block w-full rounded-md bg-white px-3 py-1.5 text-gray-900">
      </div>
      <div>
        <label for="model" class="block text-sm/6 font-medium text-gray-900">Model</label>
        <input type="text" id="model" placeholder="Enter Model" required class="block w-full rounded-md bg-white px-3 py-1.5 text-gray-900">
      </div>
      <div>
        <label for="year" class="block text-sm/6 font-medium text-gray-900">Year</label>
        <input type="number" id="year" placeholder="Enter Year" class="block w-full rounded-md bg-white px-3 py-1.5 text-gray-900">
      </div>
      <div>
        <label for="issue" class="block text-sm/6 font-medium text-gray-900">Issue</label>
        <textarea id="issue" placeholder="Describe Issue" required class="block w-full rounded-md bg-white px-3 py-1.5 text-gray-900"></textarea>
      </div>
      <div>
        <label for="tip" class="block text-sm/6 font-medium text-gray-900">Tip</label>
        <textarea id="tip" placeholder="Provide Repair Tip" required class="block w-full rounded-md bg-white px-3 py-1.5 text-gray-900"></textarea>
      </div>
      <div>
        <button type="submit" class="w-full bg-red-600 text-white py-1.5 rounded-md">Add Tip</button>
      </div>
    </form>
  </div>

  <div class="mt-10">
    <h3 class="text-lg font-medium text-gray-900">All Mechanics Tips</h3>
    <ul id="tips-list" class="mt-4 space-y-2">
      <!-- Tips will be dynamically added here -->
    </ul>
  </div>
</div>

<!-- Link to External JavaScript File -->
<script type="module">
import { pythonURI, fetchOptions } from '{{site.baseurl}}/assets/js/api/config.js';

// Function to add a new tip
document.getElementById('add-tip-form').addEventListener('submit', async function (event) {
  event.preventDefault();

  // Collect form values
  const make = document.getElementById('make').value;
  const model = document.getElementById('model').value;
  const year = document.getElementById('year').value;
  const issue = document.getElementById('issue').value;
  const tip = document.getElementById('tip').value;

  // Prepare request data
  const requestData = {
    make: make,
    model: model,
    year: year || null, // Optional field
    issue: issue,
    tip: tip
  };

  try {
    // Make a POST request to the API
    const response = await fetch(`${pythonURI}/api/mechanicsTips`, {
      method: "POST",
      cache: "no-cache",
      mode: "cors",
      credentials: "include",
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${localStorage.getItem('token') || ''}`, // Add token if needed
      },
      body: JSON.stringify(requestData), // Attach the form data
    });

    // Handle the response
    if (response.ok) {
      const result = await response.json();
      alert('Mechanics Tip added successfully!');
      document.getElementById('add-tip-form').reset(); // Reset form on success
      console.log(result); // Log result for debugging
      fetchTips(); // Refresh tips list
    } else {
      const error = await response.json();
      alert(`Error: ${error.message || 'Failed to add tip'}`);
      console.error(error);
    }
  } catch (err) {
    alert('An error occurred while processing your request. Please try again.');
    console.error(err);
  }
});

// Function to fetch and display tips
async function fetchTips() {
  try {
    const response = await fetch(`${pythonURI}/api/mechanicsTips`, {
      method: "GET",
      mode: "cors", // no-cors, *cors, same-origin
      cache: "default", // *default, no-cache, reload, force-cache, only-if-cached
      credentials: "include", // include, same-origin, omit
      headers: {
        "Content-Type": "application/json",
        "X-Origin": "client", // New custom header to identify source
    },
    });

    if (response.ok) {
      const tips = await response.json();
      const tipsList = document.getElementById('tips-list');
      tipsList.innerHTML = ''; // Clear the list before appending

        console.log(tips)

      // Populate the list with tips
      tips.forEach(tip => {
        const li = document.createElement('li');
        li.className = 'p-4 bg-gray-100 rounded-md shadow-sm';
        li.innerHTML = `
          <strong>Make:</strong> ${tip.make}<br>
          <strong>Model:</strong> ${tip.model}<br>
          <strong>Year:</strong> ${tip.year || 'N/A'}<br>
          <strong>Issue:</strong> ${tip.issue}<br>
          <strong>Tip:</strong> ${tip.tip}
        `;
        tipsList.appendChild(li);
      });
    } else {
      const error = await response.json();
      console.error(`Error fetching tips: ${error.message}`);
    }
  } catch (err) {
    console.error('An error occurred while fetching tips:', err);
  }
}

// Fetch tips on page load
document.addEventListener('DOMContentLoaded', fetchTips);

</script>
