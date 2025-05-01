---
layout: tailwind
title: Historical Data
search_exclude: true
permalink: /historicaldata/
---

<div class="max-w-7xl mx-auto px-4 py-10">
    <header class="mb-8 text-center">
        <h1 class="text-4xl font-bold text-accent">Historical Data</h1>
        <p class="text-lg text-gray-400">Analyze past trends to plan your crossings effectively</p>
    </header>

    <section class="bg-dark p-6 rounded-lg shadow-md opacity-0 transform translate-y-10 transition-all duration-[1.5s]" data-scroll>
        <details open>
            <summary class="text-2xl font-semibold text-gray-200 mb-6 cursor-pointer">Plan Your Crossing</summary>
            <div class="mt-6">
                <p class="text-gray-400 mb-6">Our ML-powered prediction tool helps you find the optimal time to cross the border</p>
                <div class="grid grid-cols-2 gap-6">
                    <div>
                        <label for="port-select" class="block text-sm font-medium text-gray-300">Select Port of Entry:</label>
                        <select id="port-select" class="mt-1 block w-full bg-darker border border-gray-600 rounded-md shadow-sm focus:ring-accent focus:border-accent text-gray-200">
                            <option value="san-ysidro">San Ysidro</option>
                            <option value="otay-mesa">Otay Mesa</option>
                        </select>
                    </div>
                    <div>
                        <label for="crossing-type" class="block text-sm font-medium text-gray-300">Crossing Type:</label>
                        <select id="crossing-type" class="mt-1 block w-full bg-darker border border-gray-600 rounded-md shadow-sm focus:ring-accent focus:border-accent text-gray-200">
                            <option value="standard">Standard Vehicles</option>
                            <option value="sentri">SENTRI</option>
                            <option value="pedestrian">Pedestrian</option>
                        </select>
                    </div>
                    <div>
                        <label for="date-select" class="block text-sm font-medium text-gray-300">Date:</label>
                        <input type="date" id="date-select" class="mt-1 block w-full bg-darker border border-gray-600 rounded-md shadow-sm focus:ring-accent focus:border-accent text-gray-200">
                    </div>
                    <div>
                        <label for="time-select" class="block text-sm font-medium text-gray-300">Time:</label>
                        <input type="time" id="time-select" class="mt-1 block w-full bg-darker border border-gray-600 rounded-md shadow-sm focus:ring-accent focus:border-accent text-gray-200">
                    </div>
                </div>
                <button class="mt-6 bg-accent text-white py-2 px-4 rounded-md shadow-md hover:bg-blue-600">Predict Wait Time</button>
            </div>
        </details>
    </section>
</div>