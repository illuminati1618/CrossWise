---
layout: needsAuth
title: vinStore
permalink: /vinStore
search_exclude: true
menu: nav/home.html 
---

<div class="flex min-h-full flex-col justify-center px-6 py-12 lg:px-8">
  <div class="sm:mx-auto sm:w-full sm:max-w-sm">
    <h2 class="mt-10 text-center text-2xl/9 font-bold tracking-tight text-gray-900">Manage Vehicles</h2>
  </div>

  <div class="mt-10 sm:mx-auto sm:w-full sm:max-w-sm">
    <form class="space-y-4 mt-4" id="vehicle-form">
      <div>
        <label for="vin-input" class="block text-sm/6 font-medium text-gray-900">Add a VIN</label>
        <div class="mt-2">
          <input type="text" id="vin-input" placeholder="Enter VIN" required class="block w-full rounded-md bg-white px-3 py-1.5 text-base text-gray-900 outline outline-1 -outline-offset-1 outline-gray-300 placeholder:text-gray-400 focus:outline focus:outline-2 focus:-outline-offset-2 focus:outline-rose-600 sm:text-sm/6">
        </div>
      </div>
      <div>
        <button type="submit" class="flex w-full justify-center rounded-md bg-red-600 px-3 py-1.5 text-sm/6 font-semibold text-white shadow-sm hover:bg-red-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-red-600">Add Vehicle</button>
      </div>
    </form>
    <form class="space-y-4 mt-8" id="update-vin-form">
      <div>
        <label for="old-vin-input" class="block text-sm/6 font-medium text-gray-900">Current VIN</label>
        <div class="mt-2">
          <input type="text" id="old-vin-input" placeholder="Enter Current VIN" required class="block w-full rounded-md bg-white px-3 py-1.5 text-base text-gray-900 outline outline-1 -outline-offset-1 outline-gray-300 placeholder:text-gray-400 focus:outline focus:outline-2 focus:-outline-offset-2 focus:outline-rose-600 sm:text-sm/6">
        </div>
      </div>
      <div>
        <label for="new-vin-input" class="block text-sm/6 font-medium text-gray-900">New VIN</label>
        <div class="mt-2">
          <input type="text" id="new-vin-input" placeholder="Enter New VIN" required class="block w-full rounded-md bg-white px-3 py-1.5 text-base text-gray-900 outline outline-1 -outline-offset-1 outline-gray-300 placeholder:text-gray-400 focus:outline focus:outline-2 focus:-outline-offset-2 focus:outline-rose-600 sm:text-sm/6">
        </div>
      </div>
      <div>
        <button type="submit" class="flex w-full justify-center rounded-md bg-red-600 px-3 py-1.5 text-sm/6 font-semibold text-white shadow-sm hover:bg-red-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-red-600">Update Vehicle</button>
      </div>
    </form>
    <div class="mt-8">
      <button id="refresh-vehicles" class="flex w-full justify-center rounded-md bg-red-600 px-3 py-1.5 text-sm/6 font-semibold text-white shadow-sm hover:bg-red-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-red-600">Refresh Vehicles</button>
      <div class="mt-4 flex justify-center">
        <div class="overflow-x-auto w-full">
          <table id="vehicles-table" class="table-auto border-collapse border border-gray-300 text-center w-full">
            <thead>
              <tr class="bg-gray-100">
                <th class="border border-gray-300 px-4 py-2">VIN</th>
                <th class="border border-gray-300 px-4 py-2">Make</th>
                <th class="border border-gray-300 px-4 py-2">Model</th>
                <th class="border border-gray-300 px-4 py-2">Year</th>
                <th class="border border-gray-300 px-4 py-2">Engine Type</th>
                <th class="border border-gray-300 px-4 py-2">Actions</th>
              </tr>
            </thead>
            <tbody id="vehicles-body">
            </tbody>
          </table>
        </div>
      </div>
    </div>
    <div id="message" class="mt-4 text-center text-red-500"></div>
  </div>
</div>

<script type='module'>
  import { pythonURI, fetchOptions } from '{{site.baseurl}}/assets/js/api/config.js';

  async function refreshVehicles() {
    const messageElement = document.getElementById('message');
    const vehiclesBody = document.getElementById('vehicles-body');

    // Clear the table body
    vehiclesBody.innerHTML = '';

    try {
      const response = await fetch(`${pythonURI}/api/vinStore`, {
        method: "GET",
        cache: "default",
        mode: "cors",
        credentials: "include",
        headers: {
          'Content-Type': 'application/json',
          'X-Origin': 'client'
        },
      });

      const data = await response.json();

      if (response.ok) {
        data.forEach(vehicle => {
          const row = document.createElement('tr');
          row.innerHTML = `
            <td class="border border-gray-300 px-4 py-2">${vehicle.vin}</td>
            <td class="border border-gray-300 px-4 py-2">${vehicle.make}</td>
            <td class="border border-gray-300 px-4 py-2">${vehicle.model}</td>
            <td class="border border-gray-300 px-4 py-2">${vehicle.year}</td>
            <td class="border border-gray-300 px-4 py-2">${vehicle.engine_type}</td>
            <td class="border border-gray-300 px-4 py-2">
              <button class="delete-btn text-red-600 hover:underline" data-vin="${vehicle.vin}">Delete</button>
            </td>
          `;
          vehiclesBody.appendChild(row);
        });
        messageElement.textContent = '';
      } else {
        messageElement.textContent = data.message || 'Failed to load vehicles';
      }
    } catch (error) {
      messageElement.textContent = 'Add a VIN';
    }
  }

  async function deleteVehicle(vin) {
    const messageElement = document.getElementById('message');

    try {
      const response = await fetch(`${pythonURI}/api/vinStore`, {
        method: "DELETE",
        cache: "default",
        mode: "cors",
        credentials: "include",
        body: JSON.stringify({ vin }),
        headers: {
          'Content-Type': 'application/json',
          'X-Origin': 'client'
        },
      });

      const data = await response.json();

      if (response.ok) {
        messageElement.textContent = `Vehicle deleted successfully: VIN ${vin}`;
        messageElement.classList.remove('text-red-500');
        messageElement.classList.add('text-green-500');
        await refreshVehicles();
      } else {
        messageElement.textContent = data.message || 'Failed to delete vehicle';
      }
    } catch (error) {
      messageElement.textContent = 'Error connecting to the server: ' + error.message;
    }
  }

  document.getElementById('vehicle-form').addEventListener('submit', async function(event) {
    event.preventDefault();

    const vinInput = document.getElementById('vin-input');
    const vin = vinInput.value.trim();
    const messageElement = document.getElementById('message');
    
    messageElement.textContent = '';

    if (vin.length !== 17) {
      messageElement.textContent = 'VIN must be 17 characters long.';
      return;
    }

    try {
      const requestBody = JSON.stringify({ vin });

      const response = await fetch(`${pythonURI}/api/vinStore`, {
        method: "POST",
        cache: "default",
        mode: "cors",
        credentials: "include",
        body: requestBody,
        headers: {
          'Content-Type': 'application/json',
          'X-Origin': 'client'
        },
      });

      const data = await response.json();

      if (response.ok) {
        messageElement.textContent = `Vehicle added successfully: ${data.make} ${data.model} (${data.year})`;
        messageElement.classList.remove('text-red-500');
        messageElement.classList.add('text-green-500');
        vinInput.value = '';
        await refreshVehicles();
      } else {
        messageElement.textContent = data.message || 'Failed to add vehicle';
      }
    } catch (error) {
      messageElement.textContent = 'Error connecting to the server: ' + error.message;
    }
  });

  document.getElementById('update-vin-form').addEventListener('submit', async function(event) {
    event.preventDefault();

    const oldVinInput = document.getElementById('old-vin-input');
    const newVinInput = document.getElementById('new-vin-input');
    const oldVin = oldVinInput.value.trim();
    const newVin = newVinInput.value.trim();
    const messageElement = document.getElementById('message');

    messageElement.textContent = '';

    if (oldVin.length !== 17 || newVin.length !== 17) {
      messageElement.textContent = 'Both VINs must be 17 characters long.';
      return;
    }

    try {
      const requestBody = JSON.stringify({ old_vin: oldVin, new_vin: newVin });

      const response = await fetch(`${pythonURI}/api/vinStore`, {
        method: "PUT",
        cache: "default",
        mode: "cors",
        credentials: "include",
        body: requestBody,
        headers: {
          'Content-Type': 'application/json',
          'X-Origin': 'client'
        },
      });

      const data = await response.json();

      if (response.ok) {
        messageElement.textContent = `Vehicle VIN updated successfully: ${data.vehicle.make} ${data.vehicle.model} (${data.vehicle.year})`;
        messageElement.classList.remove('text-red-500');
        messageElement.classList.add('text-green-500');
        oldVinInput.value = '';
        newVinInput.value = '';
        await refreshVehicles();
      } else {
        messageElement.textContent = data.message || 'Failed to update vehicle';
      }
    } catch (error) {
      messageElement.textContent = 'Error connecting to the server: ' + error.message;
    }
  });

  document.getElementById('vehicles-body').addEventListener('click', async function(event) {
    if (event.target.classList.contains('delete-btn')) {
      const vin = event.target.dataset.vin;

      if (confirm(`Are you sure you want to delete vehicle with VIN: ${vin}?`)) {
        await deleteVehicle(vin);
      }
    }
  });

  document.getElementById('refresh-vehicles').addEventListener('click', refreshVehicles);

  // Load vehicles on page load
  refreshVehicles();
</script>
