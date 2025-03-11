---
layout: needsAuth
title: Car Info
permalink: /car-info
menu: nav/home.html
---

<div class="bg-gray-100 min-h-screen flex items-center justify-center w-full">
    <div class="bg-white p-6 rounded-lg shadow-lg w-full max-w-md">
        <h1 class="text-2xl font-bold mb-4 text-center">Car Information Form</h1>
        <div>
            <label for="make" class="block text-sm font-medium text-gray-700">Make</label>
            <input type="text" id="make" name="make" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
        </div>
        <div>
            <label for="model" class="block text-sm font-medium text-gray-700">Model</label>
            <input type="text" id="model" name="model" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
        </div>
        <div>
            <label for="year" class="block text-sm font-medium text-gray-700">Year</label>
            <input type="number" id="year" name="year" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
        </div>
        <div>
            <label for="trim" class="block text-sm font-medium text-gray-700">Trim</label>
            <input type="text" id="trim" name="trim" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
        </div>
        <div>
            <label for="color" class="block text-sm font-medium text-gray-700">Color</label>
            <input type="text" id="color" name="color" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
        </div>
        <div>
            <label for="vin" class="block text-sm font-medium text-gray-700">VIN</label>
            <input type="text" id="vin" name="vin" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
        </div>
                <div>
            <label for="engine_type" class="block text-sm font-medium text-gray-700">Engine Type</label>
            <input type="text" id="engine_type" name="engine_type" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
        </div>
                     <div class="text-center">
            <button id="submitBtn" class="w-full py-2 px-4 bg-red-600 text-white font-medium rounded-md shadow-sm hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2">Submit</button>
        </div>
    </div>
</div>

<script type="module">
    import { createUserCar } from "{{site.baseurl}}/assets/js/api/userCar.js"

    const submitBtn = document.getElementById("submitBtn")
    const submit = () => {
        console.log("hi")
        const make = document.getElementById('make').value;
        const model = document.getElementById('model').value;
        const year = document.getElementById('year').value;
        const trim = document.getElementById('trim').value;
        const color = document.getElementById('color').value;
        const vin = document.getElementById('vin').value;
        const engineType = document.getElementById('engine_type').value;

        createUserCar(make, model, year, engineType, trim, color, vin)
    }

    document.addEventListener("DOMContentLoaded", () => {
        submitBtn.addEventListener("click", submit)
    })
    
</script>