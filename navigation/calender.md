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
        // Check if csv is a string
        if (typeof csv !== 'string') {
            console.error('CSV data is not a string:', csv);
            return {};
        }
        
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
    // Function to load CSV data from a file
    async function loadCSVData() {
        try {
            const response = await fetch('{{site.baseurl}}/assets/calendar_parsedevents.csv');
            if (!response.ok) {
                throw new Error(`Failed to load calendar data: ${response.status} ${response.statusText}`);
            }
            return await response.text();
        } catch (error) {
            console.error('Error loading calendar data:', error);
            // Fallback data in case the fetch fails
            return `Title,Dates
Bike the Bay,8/25/2024
San Diego Bayfair,9/13/2024`;
        }
    }
    
    // Modified initialization to handle async data loading
    async function initCalendar() {
        try {
            // Show loading message
            loadingMessage.style.display = 'block';
            calendarWrapper.style.display = 'none';
            
            // Load and parse CSV data
            const csvData = await loadCSVData();
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
    window.addEventListener('DOMContentLoaded', () => {
        initCalendar().catch(error => {
            console.error('Calendar initialization failed:', error);
            errorMessage.textContent = `Could not load calendar: ${error.message}`;
            errorMessage.style.display = 'block';
        });
    });
</script>