---
layout: tailwind
title: Calender
search_exclude: true
permalink: /calender/
menu: nav/calender.html
---

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>San Diego Events Calendar</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            color: #333;
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
        }
        
        h1 {
            text-align: center;
            margin-bottom: 20px;
        }
        
        .calendar-container {
            background-color: #f9f9f9;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-bottom: 30px;
        }
        
        .calendar-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .calendar-nav {
            display: flex;
            align-items: center;
        }
        
        .nav-btn {
            background-color: #4a90e2;
            color: white;
            border: none;
            border-radius: 4px;
            padding: 8px 16px;
            margin: 0 8px;
            cursor: pointer;
            font-size: 16px;
        }
        
        .month-display {
            font-size: 20px;
            font-weight: bold;
            margin: 0 20px;
        }
        
        .calendar-table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
        }
        
        .calendar-table th {
            padding: 10px;
            text-align: center;
            background-color: #4a90e2;
            color: white;
            font-weight: normal;
        }
        
        .calendar-table td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
            height: 80px;
            vertical-align: top;
            position: relative;
        }
        
        .calendar-day {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }
        
        .empty-day {
            background-color: #f0f0f0;
        }
        
        .has-events {
            background-color: #e6f7ff;
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
            background-color: #1890ff;
            border-radius: 50%;
        }
        
        .event-tooltip {
            position: absolute;
            left: 110%;
            top: 0;
            width: 300px;
            background-color: white;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
            padding: 16px;
            z-index: 100;
            display: none;
            text-align: left;
            max-height: 300px;
            overflow-y: auto;
        }
        
        .event-tooltip h3 {
            margin-top: 0;
            border-bottom: 1px solid #eee;
            padding-bottom: 8px;
            margin-bottom: 8px;
        }
        
        .event-tooltip ul {
            list-style-type: none;
            padding: 0;
            margin: 0;
        }
        
        .event-tooltip li {
            padding: 6px 0;
            border-bottom: 1px solid #f0f0f0;
        }
        
        .event-tooltip li:last-child {
            border-bottom: none;
        }
        
        .loading-message {
            text-align: center;
            padding: 20px;
            font-size: 18px;
            color: #666;
        }
        
        .error-message {
            text-align: center;
            padding: 20px;
            font-size: 18px;
            color: #e74c3c;
        }

        /* Responsive styles */
        @media (max-width: 768px) {
            .calendar-table td {
                height: 60px;
                padding: 5px;
            }
            
            .event-tooltip {
                left: 50%;
                top: 100%;
                transform: translateX(-50%);
                width: 90%;
                max-width: 300px;
            }
        }
    </style>
</head>
<body>
    <h1>San Diego Events Calendar</h1>
    <div class="calendar-container">
        <div class="calendar-header">
            <div class="calendar-nav">
                <button id="prev-month" class="nav-btn">&larr;</button>
                <span id="month-display" class="month-display">January 2024</span>
                <button id="next-month" class="nav-btn">&rarr;</button>
            </div>
            <button id="today-btn" class="nav-btn">Today</button>
        </div>
        
        <div id="loading-message" class="loading-message">Loading calendar data...</div>
        <div id="error-message" class="error-message" style="display: none;"></div>
        
        <table class="calendar-table" style="display: none;">
            <thead>
                <tr>
                    <th>Sun</th>
                    <th>Mon</th>
                    <th>Tue</th>
                    <th>Wed</th>
                    <th>Thu</th>
                    <th>Fri</th>
                    <th>Sat</th>
                </tr>
            </thead>
            <tbody id="calendar-body">
                <!-- Calendar will be generated here -->
            </tbody>
        </table>
    </div>

    <script>
        // Initialize variables
        let currentDate = new Date();
        let events = {};
        const calendarTable = document.querySelector('.calendar-table');
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
        
        // Function to load CSV data from file
        async function loadCSVFile(filePath) {
            try {
                const response = await fetch(filePath);
                
                if (!response.ok) {
                    throw new Error(`Failed to load CSV file: ${response.status} ${response.statusText}`);
                }
                
                const csvData = await response.text();
                return csvData;
            } catch (error) {
                throw new Error(`Error loading CSV file: ${error.message}`);
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
        
        // Initialize calendar
        async function initCalendar() {
            try {
                // Load CSV data from file
                const csvData = await loadCSVFile({{ site.baseurl }}/assets/events.csv);
                
                // Parse CSV data
                events = parseCSV(csvData);
                
                // Hide loading message and show calendar
                loadingMessage.style.display = 'none';
                calendarTable.style.display = 'table';
                
                // Render calendar
                renderCalendar();
            } catch (error) {
                // Show error message
                loadingMessage.style.display = 'none';
                errorMessage.textContent = error.message;
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
</body>