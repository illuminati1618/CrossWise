---
layout: tailwind
title: Historical Data
search_exclude: true
permalink: /historicaldata/
---
<script type="module">
    import { login, pythonURI, fetchOptions } from '{{ site.baseurl }}/assets/js/api/config.js';
</script>

<div class="max-w-7xl mx-auto px-4 py-10">
    <header class="mb-8">
        <h1 class="text-4xl font-bold text-accent">CrossWise</h1>
        <p class="text-lg text-gray-400">Smart border wait time predictions for San Ysidro and Otay Mesa crossings</p>
    </header>
        <!-- Historical Data Chart Section -->
        <section>
            <h2 class="text-2xl font-semibold text-gray-200 mb-4">Wait Time Trends</h2>
            <p class="text-gray-400 mb-6">Historical data helps you understand patterns and plan accordingly</p>
            <div class="grid grid-cols-2 gap-6">
                <select id="chart-port" class="bg-darker border border-gray-600 rounded-md shadow-sm focus:ring-accent focus:border-accent">
                    <option value="san-ysidro">San Ysidro</option>
                    <option value="otay-mesa">Otay Mesa</option>
                </select>
                <select id="chart-period" class="bg-darker border border-gray-600 rounded-md shadow-sm focus:ring-accent focus:border-accent">
                    <option value="day">Today</option>
                    <option value="week">This Week</option>
                    <option value="month">This Month</option>
                </select>
                <button id="update-chart-btn" class="bg-accent text-white py-2 px-4 rounded-md shadow-md hover:bg-blue-600">Update Chart</button>
            </div>
            <div id="chart-container" class="mt-6">
                <div id="loading-message" class="text-center text-gray-400">
                    <p>Click "Update Chart" to view historical wait time data</p>
                </div>
                <div id="chart-display" class="mt-4 w-full overflow-x-auto" style="min-height: 600px;"></div>
            </div>
        </section>
    </div>
</div>

<script type="module">
    import { login, pythonURI, fetchOptions } from '{{ site.baseurl }}/assets/js/api/config.js';

    // Set up the historical chart functionality
    document.getElementById('update-chart-btn').addEventListener('click', async function() {
        // Show loading message
        const loadingMessage = document.getElementById('loading-message');
        const chartDisplay = document.getElementById('chart-display');
        
        loadingMessage.textContent = 'Loading chart...';
        chartDisplay.innerHTML = ''; // Clear previous chart
        
        try {
            // Get selected values (not actually using these in the API call yet, but could be added as parameters later)
            const selectedPort = document.getElementById('chart-port').value;
            const selectedPeriod = document.getElementById('chart-period').value;
            
            // Fetch the visualization HTML from the API
            const response = await fetch(`${pythonURI}/api/visualization`);
            
            if (!response.ok) {
                throw new Error(`Failed to fetch chart: ${response.status}`);
            }
            
            // Get the HTML content
            const htmlContent = await response.text();
            
            // Create an iframe to isolate the chart's styles and scripts
            const iframe = document.createElement('iframe');
            iframe.style.width = '100%';
            iframe.style.height = '600px';
            iframe.style.border = 'none';
            
            // Insert the iframe into the chart container
            chartDisplay.appendChild(iframe);
            
            // Once the iframe is loaded, write the HTML content to it
            iframe.onload = function() {
                const doc = iframe.contentDocument || iframe.contentWindow.document;
                doc.open();
                doc.write(htmlContent);
                doc.close();
                loadingMessage.textContent = '';
            };
            
            // Set a source to trigger the load event
            iframe.src = 'about:blank';
            
        } catch (error) {
            console.error('Error loading chart:', error);
            loadingMessage.textContent = 'Error loading chart. Please try again later.';
            
            // For debugging purposes
            console.log('Error details:', error);
        }
    });
</script>