---
layout: needsAuth
title: Garage
permalink: /garage
search_exclude: true
menu: nav/home.html
---

<section id="featured-cars" class="pb-20 bg-gray-100 flex items-center justify-center">
    <div class="w-full grid grid-cols-2 gap-4">
        <!-- Car info card -->
        <a href="{{site.baseurl}}/car-info" class="w-full h-full bg-white rounded-lg shadow-lg overflow-hidden transform transition-transform duration-500 hover:shadow-inner">
            <img src="https://ymimg1.b8cdn.com/uploads/article/3588/pictures/2683140/Koenigsegg_Agera_RS_Naraya__5_.jpg" alt="Car Information Form" class="w-full h-3/4 object-cover">
            <div class="p-6">
                <h3 class="text-3xl font-bold mb-2">Car Information Form</h3>
                <p class="text-xl text-gray-700">Add your dream car to the garage!</p>
            </div>
        </a>
        <!-- Car info card -->
        <a href="{{site.baseurl}}/vinStore" class="w-full h-full bg-white rounded-lg shadow-lg overflow-hidden transform transition-transform duration-500 hover:shadow-inner">
            <img src="https://www.shutterstock.com/image-vector/add-new-car-icon-600nw-2086317895.jpg" alt="Add Car" class="w-full h-3/4 object-cover">
            <div class="p-6">
                <h3 class="text-3xl font-bold mb-2">Add your Car</h3>
                <p class="text-xl text-gray-700">Use your car's VIN to add your car!</p>
            </div>
        </a>
    </div>
</section>
<body class="bg-gray-100 py-8 px-4">

<div class="max-w-6xl mx-auto bg-white p-6 rounded-lg shadow-lg">
    <h1 class="text-3xl font-semibold text-center mb-6">My Cars</h1>

    <table class="min-w-full table-auto text-left text-sm">
        <thead>
            <tr class="bg-gray-200 text-gray-700">
                <th class="py-2 px-4 font-medium">Make</th>
                <th class="py-2 px-4 font-medium">Model</th>
                <th class="py-2 px-4 font-medium">Year</th>
                <th class="py-2 px-4 font-medium">Trim</th>
                <th class="py-2 px-4 font-medium">Engine Type</th>
                <th class="py-2 px-4 font-medium">Color</th>
            </tr>
        </thead>
        <tbody id="carTable">
            <!-- Loop through your array of cars and display each car's data -->
            <tr class="border-t border-b hover:bg-gray-50">
                <td class="py-3 px-4">Bugatti</td>
                <td class="py-3 px-4">Veyron</td>
                <td class="py-3 px-4">2008</td>
                <td class="py-3 px-4">Grand Sport</td>
                <td class="py-3 px-4">W16</td>
                <td class="py-3 px-4">White</td>
            </tr>
            <tr class="border-t border-b hover:bg-gray-50">
                <td class="py-3 px-4">Pagani</td>
                <td class="py-3 px-4">Zonda</td>
                <td class="py-3 px-4">2008</td>
                <td class="py-3 px-4">F Clubsport</td>
                <td class="py-3 px-4">Amg 5.2L v12</td>
                <td class="py-3 px-4">Black</td>
            </tr>
            <tr class="border-t border-b hover:bg-gray-50">
                <td class="py-3 px-4">Ford</td>
                <td class="py-3 px-4">GT</td>
                <td class="py-3 px-4">1967</td>
                <td class="py-3 px-4">Mk1</td>
                <td class="py-3 px-4">V8</td>
                <td class="py-3 px-4">Gulf Blue</td>
            </tr>
        </tbody>
    </table>

</div>

<script type="module">
    import { getUserCars, deleteCarById } from "{{site.baseurl}}/assets/js/api/userCar.js"

    const tableBody = document.getElementById("carTable")

     tableBody.innerHTML = '';

     const cars = await getUserCars()

    // Loop through each car and create a new row
    cars.forEach(car => {
        const row = document.createElement('tr');
        row.className = "border-t border-b hover:bg-gray-50";

        // Create and append each cell with car data
        const makeCell = document.createElement('td');
        makeCell.className = "py-3 px-4";
        makeCell.textContent = car.make;
        row.appendChild(makeCell);

        const modelCell = document.createElement('td');
        modelCell.className = "py-3 px-4";
        modelCell.textContent = car.model;
        row.appendChild(modelCell);

        const yearCell = document.createElement('td');
        yearCell.className = "py-3 px-4";
        yearCell.textContent = car.year;
        row.appendChild(yearCell);

        const trimCell = document.createElement('td');
        trimCell.className = "py-3 px-4";
        trimCell.textContent = car.trim;
        row.appendChild(trimCell);

        const engine_typeCell = document.createElement('td');
        engine_typeCell.className = "py-3 px-4";
        engine_typeCell.textContent = car.engine_type;
        row.appendChild(engine_typeCell);

        const colorCell = document.createElement('td');
        colorCell.className = "py-3 px-4";
        colorCell.textContent = car.color;
        row.appendChild(colorCell); 

        const deleteCell = document.createElement('td');
        deleteCell.className = "py-3 px-4";
        // Set a specific width for the delete cell (for example, 50px)
        deleteCell.style.width = "50px";
        row.appendChild(deleteCell);

        // Create the delete button
        const deleteBtn = document.createElement('input');
        deleteBtn.type = "image";
        deleteBtn.src = "{{site.baseurl}}/images/bin.png";

        deleteBtn.addEventListener('click', () => {
            const deleted = deleteCarById(car.id)
            if (deleted) {
                 window.location.reload()
            } 
        })

        // Set a more reasonable size for the button (for example, 24px by 24px)
        deleteBtn.style.width = "24px";
        deleteBtn.style.height = "24px";

        deleteCell.appendChild(deleteBtn);

        // Append the row to the table body
        tableBody.appendChild(row);
    });

    // Call the function to add rows when the page loads
    // window.onload = addCarRows;

</script>
