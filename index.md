---
layout: tailwind
search_exclude: true
hide: true
show_reading_time: false
---

<script type="module">
    import { login, pythonURI, fetchOptions } from '{{site.baseurl}}/assets/js/api/config.js';
</script>

<div class="max-w-7xl mx-auto px-4 py-10">
    <header class="mb-8">
        <h1 class="text-4xl font-bold text-accent">BorderCross</h1>
        <p class="text-lg text-gray-400">Smart border wait time predictions for San Ysidro and Otay Mesa crossings</p>
    </header>

    <div class="space-y-12">
        <!-- Current Wait Times Section -->
        <section>
            <h2 class="text-2xl font-semibold text-gray-200 mb-4">Current Border Wait Times</h2>
            <div class="grid grid-cols-2 gap-6">
                <div class="bg-dark p-6 rounded-lg shadow-md">
                    <h3 class="text-xl font-bold text-accent">San Ysidro Port of Entry</h3>
                    <p class="text-sm text-gray-400">San Diego, CA</p>
                    <div class="mt-4 space-y-2">
                        <div class="flex justify-between">
                            <span class="text-gray-300">Standard Vehicles</span>
                            <span id="standard-vehicles-wait" class="text-yellow-400">Loading...</span>
                        </div>
                        <div class="flex justify-between">
                            <span class="text-gray-300">SENTRI</span>
                            <span id="sentri-wait" class="text-green-400">Loading...</span>
                        </div>
                        <div class="flex justify-between">
                            <span class="text-gray-300">Pedestrian</span>
                            <span id="pedestrian-wait" class="text-yellow-400">Loading...</span>
                        </div>
                    </div>
                    <p class="text-sm text-gray-500 mt-4">Last updated: <span id="last-updated">Loading...</span></p>
                </div>

                <div class="bg-dark p-6 rounded-lg shadow-md">
                    <h3 class="text-xl font-bold text-accent">Otay Mesa Port of Entry</h3>
                    <p class="text-sm text-gray-400">San Diego, CA</p>
                    <div class="mt-4 space-y-2">
                        <div class="flex justify-between">
                            <span class="text-gray-300">Standard Vehicles</span>
                            <span id="otay-standard-vehicles-wait" class="text-red-400">Loading...</span>
                        </div>
                        <div class="flex justify-between">
                            <span class="text-gray-300">SENTRI</span>
                            <span id="otay-sentri-wait" class="text-green-400">Loading...</span>
                        </div>
                        <div class="flex justify-between">
                            <span class="text-gray-300">Pedestrian</span>
                            <span id="otay-pedestrian-wait" class="text-yellow-400">Loading...</span>
                        </div>
                    </div>
                    <p class="text-sm text-gray-500 mt-4">Last updated: <span id="otay-last-updated">Loading...</span></p>
                </div>
            </div>
        </section>

        <!-- Prediction Tool Section -->
        <section>
            <h2 class="text-2xl font-semibold text-gray-200 mb-4">Plan Your Crossing</h2>
            <p class="text-gray-400 mb-6">Our ML-powered prediction tool helps you find the optimal time to cross the border</p>
            <div class="grid grid-cols-2 gap-6">
                <div>
                    <label for="port-select" class="block text-sm font-medium text-gray-300">Select Port of Entry:</label>
                    <select id="port-select" class="mt-1 block w-full bg-darker border border-gray-600 rounded-md shadow-sm focus:ring-accent focus:border-accent">
                        <option value="san-ysidro">San Ysidro</option>
                        <option value="otay-mesa">Otay Mesa</option>
                    </select>
                </div>
                <div>
                    <label for="crossing-type" class="block text-sm font-medium text-gray-300">Crossing Type:</label>
                    <select id="crossing-type" class="mt-1 block w-full bg-darker border border-gray-600 rounded-md shadow-sm focus:ring-accent focus:border-accent">
                        <option value="standard">Standard Vehicles</option>
                        <option value="sentri">SENTRI</option>
                        <option value="pedestrian">Pedestrian</option>
                    </select>
                </div>
                <div>
                    <label for="date-select" class="block text-sm font-medium text-gray-300">Date:</label>
                    <input type="date" id="date-select" class="mt-1 block w-full bg-darker border border-gray-600 rounded-md shadow-sm focus:ring-accent focus:border-accent">
                </div>
                <div>
                    <label for="time-select" class="block text-sm font-medium text-gray-300">Time:</label>
                    <input type="time" id="time-select" class="mt-1 block w-full bg-darker border border-gray-600 rounded-md shadow-sm focus:ring-accent focus:border-accent">
                </div>
            </div>
            <button class="mt-6 bg-accent text-white py-2 px-4 rounded-md shadow-md hover:bg-blue-600">Predict Wait Time</button>
        </section>

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
                <button class="bg-accent text-white py-2 px-4 rounded-md shadow-md hover:bg-blue-600">Update Chart</button>
            </div>
            <div class="mt-6 text-center text-gray-400">
                <p>Wait time chart for San Ysidro crossing will appear here</p>
            </div>
        </section>

        <!-- App Features Section -->
        <section>
            <h2 class="text-2xl font-semibold text-gray-200 mb-4">Key Features</h2>
            <div class="grid grid-cols-2 gap-6">
                <div class="bg-dark p-6 rounded-lg shadow-md">
                    <h3 class="text-lg font-bold text-accent">Real-Time Updates</h3>
                    <p class="text-gray-400">Get current wait times for both pedestrian and vehicle lanes at San Ysidro and Otay Mesa ports of entry.</p>
                </div>
                <div class="bg-dark p-6 rounded-lg shadow-md">
                    <h3 class="text-lg font-bold text-accent">Smart Predictions</h3>
                    <p class="text-gray-400">Our machine learning model forecasts future wait times based on historical patterns and real-time data.</p>
                </div>
                <div class="bg-dark p-6 rounded-lg shadow-md">
                    <h3 class="text-lg font-bold text-accent">Route Suggestions</h3>
                    <p class="text-gray-400">Receive recommendations on less congested crossing points or optimal crossing times.</p>
                </div>
                <div class="bg-dark p-6 rounded-lg shadow-md">
                    <h3 class="text-lg font-bold text-accent">Notifications</h3>
                    <p class="text-gray-400">Get alerts when wait times change significantly or when unexpected delays occur.</p>
                </div>
                <div class="bg-dark p-6 rounded-lg shadow-md">
                    <h3 class="text-lg font-bold text-accent">Live Feed</h3>
                    <p class="text-gray-400">Get the direct view of the border and make an informed decision of when to cross.</p>
                    <a href="{{ site.baseurl }}/livefeed" class="mt-4 inline-block bg-accent text-white py-2 px-4 rounded-md shadow-md hover:bg-blue-600">View Live Feed</a>
                </div>
            </div>
        </section>

        <!-- Quick Navigation Section -->
        <section>
            <h2 class="text-2xl font-semibold text-gray-200 mb-4">Useful Links</h2>
            <div class="grid grid-cols-3 gap-6">
                <button class="bg-accent text-white py-2 px-4 rounded-md shadow-md hover:bg-blue-600">Historical Data</button>
                <button class="bg-accent text-white py-2 px-4 rounded-md shadow-md hover:bg-blue-600">Advanced Prediction Tools</button>
                <button class="bg-accent text-white py-2 px-4 rounded-md shadow-md hover:bg-blue-600">Your Profile</button>
            </div>
        </section>
    </div>
</div>

<script type="module">
    import { pythonURI, fetchOptions } from './assets/js/api/config.js';

    // Fetch current wait times from API
    async function fetchWaitTimes() {
        try {
            const response = await fetch(pythonURI + "/api/proxy/waittimes", fetchOptions);
            const data = await response.json();

            // Update San Ysidro wait times
            const sanYsidro = data.find(port => port.port_name === 'San Ysidro' && port.border === 'Mexican Border');
            if (sanYsidro) {
                document.getElementById('standard-vehicles-wait').textContent =
                    sanYsidro.passenger_vehicle_lanes.standard_lanes.delay_minutes + ' minutes';
                document.getElementById('sentri-wait').textContent =
                    sanYsidro.passenger_vehicle_lanes.NEXUS_SENTRI_lanes.delay_minutes + ' minutes';
                document.getElementById('pedestrian-wait').textContent =
                    sanYsidro.pedestrian_lanes.standard_lanes.delay_minutes + ' minutes';
                const now = new Date();
                document.getElementById('last-updated').textContent =
                    now.toLocaleTimeString() + ' on ' + now.toLocaleDateString();
            }

            // Update Otay Mesa wait times - filter for Passenger crossing specifically
            const otayMesa = data.find(port => 
                port.port_name === 'Otay Mesa' && 
                port.border === 'Mexican Border' && 
                port.crossing_name === 'Passenger'
            );
            
            if (otayMesa) {
                // Only display if the data fields actually have values
                if (otayMesa.passenger_vehicle_lanes.standard_lanes.delay_minutes) {
                    document.getElementById('otay-standard-vehicles-wait').textContent =
                        otayMesa.passenger_vehicle_lanes.standard_lanes.delay_minutes + ' minutes';
                } else {
                    document.getElementById('otay-standard-vehicles-wait').textContent = 'No data';
                }
                
                if (otayMesa.passenger_vehicle_lanes.NEXUS_SENTRI_lanes.delay_minutes) {
                    document.getElementById('otay-sentri-wait').textContent =
                        otayMesa.passenger_vehicle_lanes.NEXUS_SENTRI_lanes.delay_minutes + ' minutes';
                } else {
                    document.getElementById('otay-sentri-wait').textContent = 'No data';
                }
                
                if (otayMesa.pedestrian_lanes.standard_lanes.delay_minutes) {
                    document.getElementById('otay-pedestrian-wait').textContent =
                        otayMesa.pedestrian_lanes.standard_lanes.delay_minutes + ' minutes';
                } else {
                    document.getElementById('otay-pedestrian-wait').textContent = 'No data';
                }
                
                const now = new Date();
                document.getElementById('otay-last-updated').textContent =
                    now.toLocaleTimeString() + ' on ' + now.toLocaleDateString();
            }
        } catch (error) {
            console.error('Error fetching wait times:', error);
            document.getElementById('standard-vehicles-wait').textContent = 'Unavailable';
            document.getElementById('sentri-wait').textContent = 'Unavailable';
            document.getElementById('pedestrian-wait').textContent = 'Unavailable';
            document.getElementById('otay-standard-vehicles-wait').textContent = 'Unavailable';
            document.getElementById('otay-sentri-wait').textContent = 'Unavailable';
            document.getElementById('otay-pedestrian-wait').textContent = 'Unavailable';
        }
    }

    // Initial fetch and periodic updates
    fetchWaitTimes();
    setInterval(fetchWaitTimes, 5 * 60 * 1000); // Refresh every 5 minutes
</script>