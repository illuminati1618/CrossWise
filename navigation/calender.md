---
layout: tailwind
title: Calender
search_exclude: true
permalink: /calender/
menu: nav/calender.html
---

<div class="bg-dark rounded-lg shadow-md p-6 mb-8">
    <h2 class="text-2xl font-bold mb-6 text-accent">San Diego Events Calendar</h2>
    
    <div class="calendar-container">
        <div class="flex justify-between items-center mb-6">
            <div class="flex items-center">
                <button id="prev-month" class="bg-accent hover:bg-opacity-80 text-white font-medium py-2 px-4 rounded mr-4">&larr;</button>
                <span id="month-display" class="text-xl font-bold">January 2024</span>
                <button id="next-month" class="bg-accent hover:bg-opacity-80 text-white font-medium py-2 px-4 rounded ml-4">&rarr;</button>
            </div>
            <button id="today-btn" class="bg-success hover:bg-opacity-80 text-white font-medium py-2 px-4 rounded">Today</button>
        </div>
        
        <div id="loading-message" class="text-center py-8 text-lg">Loading calendar data...</div>
        <div id="error-message" class="text-center py-8 text-lg text-warning" style="display: none;"></div>
        
        <div class="calendar-wrapper overflow-x-auto" style="display: none;">
            <table class="w-full border-collapse">
                <thead>
                    <tr>
                        <th class="p-3 bg-darker rounded-tl-lg">Sun</th>
                        <th class="p-3 bg-darker">Mon</th>
                        <th class="p-3 bg-darker">Tue</th>
                        <th class="p-3 bg-darker">Wed</th>
                        <th class="p-3 bg-darker">Thu</th>
                        <th class="p-3 bg-darker">Fri</th>
                        <th class="p-3 bg-darker rounded-tr-lg">Sat</th>
                    </tr>
                </thead>
                <tbody id="calendar-body">
                    <!-- Calendar will be generated here -->
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Calendar-specific styles (only what's necessary) -->
<style>
    .calendar-day {
        font-weight: bold;
        padding-bottom: 5px;
    }
    
    .empty-day {
        background-color: rgba(30, 30, 30, 0.5);
    }
    
    .has-events {
        background-color: rgba(66, 133, 244, 0.15);
        cursor: pointer;
        position: relative;
    }
    
    .has-events::after {
        content: '';
        position: absolute;
        bottom: 5px;
        left: 50%;
        transform: translateX(-50%);
        width: 8px;
        height: 8px;
        background-color: var(--color-accent);
        border-radius: 50%;
    }
    
    .event-tooltip {
        position: absolute;
        right: -300px;
        top: 0;
        width: 280px;
        background-color: var(--color-dark);
        border: 1px solid var(--color-accent);
        border-radius: 6px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
        padding: 16px;
        z-index: 100;
        display: none;
        text-align: left;
        max-height: 300px;
        overflow-y: auto;
    }
    
    .event-tooltip h3 {
        margin-top: 0;
        border-bottom: 1px solid rgba(240, 244, 248, 0.2);
        padding-bottom: 8px;
        margin-bottom: 8px;
        color: var(--color-accent);
    }
    
    .event-tooltip ul {
        list-style-type: none;
        padding: 0;
        margin: 0;
    }
    
    .event-tooltip li {
        padding: 6px 0;
        border-bottom: 1px solid rgba(240, 244, 248, 0.1);
    }
    
    .event-tooltip li:last-child {
        border-bottom: none;
    }
    
    /* Table styles */
    #calendar-body td {
        border: 1px solid rgba(60, 76, 96, 0.5);
        padding: 10px;
        text-align: center;
        height: 80px;
        vertical-align: top;
        position: relative;
    }
    
    /* Responsive styles for mobile */
    @media (max-width: 768px) {
        #calendar-body td {
            height: 60px;
            padding: 5px;
        }
        
        .event-tooltip {
            left: 50%;
            right: auto;
            top: 100%;
            transform: translateX(-50%);
            width: 90%;
            max-width: 280px;
        }
    }
</style>

<script>
    // Initialize variables
    let currentDate = new Date();
    let events = {};
    const calendarWrapper = document.querySelector('.calendar-wrapper');
    const loadingMessage = document.getElementById('loading-message');
    const errorMessage = document.getElementById('error-message');
    
    // Function to parse CSV data
    function parseCSV(csv) {
        const lines = csv.split('\n');
        const headers = lines[0].split(',');
        
        const events = {};
        
        for (let i = 1; i < lines.length; i++) {
            const values = lines[i].split(',');
            if (values.length >= 2) {
                const title = values[0].trim();
                const dateStr = values[1].trim();
                
                // Parse date
                const dateParts = dateStr.split('/');
                if (dateParts.length === 3) {
                    const month = parseInt(dateParts[0], 10);
                    const day = parseInt(dateParts[1], 10);
                    const year = parseInt(dateParts[2], 10);
                    
                    const dateKey = `${year}-${month.toString().padStart(2, '0')}-${day.toString().padStart(2, '0')}`;
                    
                    if (!events[dateKey]) {
                        events[dateKey] = [];
                    }
                    
                    events[dateKey].push(title);
                }
            }
        }
        
        return events;
    }
    
    // Function to load CSV data from an embedded string
    // This allows the calendar to work even without fetch
    function loadCSVData() {
        // Embed your CSV data here
        const csvData = `Title,Dates
Bike the Bay,8/25/2024
San Diego Bayfair,9/13/2024
San Diego Bayfair,9/14/2024
San Diego Bayfair,9/15/2024
ENVZN24 Urban Art Takeover ,9/14/2024
USA Ultimate National Championships,10/24/2024
USA Ultimate National Championships,10/25/2024
USA Ultimate National Championships,10/26/2024
USA Ultimate National Championships,10/27/2024
CONCACAF W Gold Cup,2/21/2024
CONCACAF W Gold Cup,2/22/2024
CONCACAF W Gold Cup,2/23/2024
CONCACAF W Gold Cup,2/24/2024
CONCACAF W Gold Cup,2/25/2024
CONCACAF W Gold Cup,2/26/2024
CONCACAF W Gold Cup,2/27/2024
CONCACAF W Gold Cup,2/28/2024
CONCACAF W Gold Cup,2/29/2024
CONCACAF W Gold Cup,3/1/2024
CONCACAF W Gold Cup,3/2/2024
CONCACAF W Gold Cup,3/3/2024
CONCACAF W Gold Cup,3/4/2024
CONCACAF W Gold Cup,3/5/2024
CONCACAF W Gold Cup,3/6/2024
CONCACAF W Gold Cup,3/7/2024
CONCACAF W Gold Cup,3/8/2024
CONCACAF W Gold Cup,3/9/2024
CONCACAF W Gold Cup,3/10/2024
Fleet Week San Diego 2024,11/1/2024
Fleet Week San Diego 2024,11/2/2024
Fleet Week San Diego 2024,11/3/2024
Fleet Week San Diego 2024,11/4/2024
Fleet Week San Diego 2024,11/5/2024
Fleet Week San Diego 2024,11/6/2024
Fleet Week San Diego 2024,11/7/2024
Fleet Week San Diego 2024,11/8/2024
Fleet Week San Diego 2024,11/9/2024
Fleet Week San Diego 2024,11/10/2024
Fleet Week San Diego 2024,11/11/2024
San Diego International Auto Show,12/28/2024
San Diego International Auto Show,12/29/2024
San Diego International Auto Show,12/30/2024
San Diego International Auto Show,12/31/2024
San Diego International Auto Show,1/1/2025
San Diego Surf Film Festival,2/17/2024
San Diego Surf Film Festival,2/18/2024
San Diego Surf Film Festival,2/19/2024
Julian StarFest,8/2/2024
Julian StarFest,8/3/2024
Julian StarFest,8/4/2024
United States Police & Fire Championships,6/8/2024
United States Police & Fire Championships,6/9/2024
United States Police & Fire Championships,6/10/2024
United States Police & Fire Championships,6/11/2024
United States Police & Fire Championships,6/12/2024
United States Police & Fire Championships,6/13/2024
United States Police & Fire Championships,6/14/2024
United States Police & Fire Championships,6/15/2024
Coronado Island Film Festival,11/6/2024
Coronado Island Film Festival,11/7/2024
Coronado Island Film Festival,11/8/2024
Coronado Island Film Festival,11/9/2024
Coronado Island Film Festival,11/10/2024
Heart of PB Restaurant Walk,9/18/2024`;

        return csvData;
    }
    
    // Calendar functions
    function renderCalendar() {
        const year = currentDate.getFullYear();
        const month = currentDate.getMonth();
        
        // Update month display
        const monthNames = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
        document.getElementById('month-display').textContent = `${monthNames[month]} ${year}`;
        
        // Get first day of month and total days in month
        const firstDay = new Date(year, month, 1).getDay();
        const daysInMonth = new Date(year, month + 1, 0).getDate();
        
        // Clear the calendar
        const calendarBody = document.getElementById('calendar-body');
        calendarBody.innerHTML = '';
        
        // Create calendar rows and cells
        let date = 1;
        for (let i = 0; i < 6; i++) {
            // Create table row
            const row = document.createElement('tr');
            
            // Create cells for each day of the week
            for (let j = 0; j < 7; j++) {
                const cell = document.createElement('td');
                
                if (i === 0 && j < firstDay) {
                    // Empty cells before the first day of month
                    cell.classList.add('empty-day');
                } else if (date > daysInMonth) {
                    // Empty cells after the last day of month
                    cell.classList.add('empty-day');
                } else {
                    // Regular day cell
                    const dateKey = `${year}-${(month + 1).toString().padStart(2, '0')}-${date.toString().padStart(2, '0')}`;
                    const hasEvents = events[dateKey] && events[dateKey].length > 0;
                    
                    // Create day element
                    const dayElement = document.createElement('div');
                    dayElement.classList.add('calendar-day');
                    dayElement.textContent = date;
                    cell.appendChild(dayElement);
                    
                    // Mark cell if it has events
                    if (hasEvents) {
                        cell.classList.add('has-events');
                        
                        // Create event tooltip
                        const tooltip = document.createElement('div');
                        tooltip.classList.add('event-tooltip');
                        
                        const tooltipTitle = document.createElement('h3');
                        tooltipTitle.textContent = `Events on ${monthNames[month]} ${date}, ${year}`;
                        tooltip.appendChild(tooltipTitle);
                        
                        const eventList = document.createElement('ul');
                        events[dateKey].forEach(event => {
                            const eventItem = document.createElement('li');
                            eventItem.textContent = event;
                            eventList.appendChild(eventItem);
                        });
                        
                        tooltip.appendChild(eventList);
                        cell.appendChild(tooltip);
                        
                        // Add event listeners for hover
                        cell.addEventListener('mouseenter', () => {
                            tooltip.style.display = 'block';
                        });
                        
                        cell.addEventListener('mouseleave', () => {
                            tooltip.style.display = 'none';
                        });
                    }
                    
                    date++;
                }
                
                row.appendChild(cell);
            }
            
            calendarBody.appendChild(row);
            
            // Stop after all days have been added
            if (date > daysInMonth) {
                break;
            }
        }
    }
    
    // Initialize calendar
    function initCalendar() {
        try {
            // Try to load and parse CSV data
            const csvData = loadCSVData();
            events = parseCSV(csvData);
            
            // Hide loading message and show calendar
            loadingMessage.style.display = 'none';
            calendarWrapper.style.display = 'block';
            
            // Render calendar
            renderCalendar();
        } catch (error) {
            // Show error message
            loadingMessage.style.display = 'none';
            errorMessage.textContent = `Error initializing calendar: ${error.message}`;
            errorMessage.style.display = 'block';
            console.error(error);
        }
    }
    
    // Add event listeners for navigation
    document.getElementById('prev-month').addEventListener('click', () => {
        currentDate.setMonth(currentDate.getMonth() - 1);
        renderCalendar();
    });
    
    document.getElementById('next-month').addEventListener('click', () => {
        currentDate.setMonth(currentDate.getMonth() + 1);
        renderCalendar();
    });
    
    document.getElementById('today-btn').addEventListener('click', () => {
        currentDate = new Date();
        renderCalendar();
    });
    
    // Initialize the calendar when the page loads
    window.addEventListener('DOMContentLoaded', initCalendar);
</script>