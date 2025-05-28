---
layout: tailwind
title: Weather Overview
permalink: /weather/
menu: nav/weather.html
---

<div class="max-w-3xl mx-auto mt-10 bg-dark p-8 rounded-lg shadow-lg text-gray-200 min-h-screen">
  <!-- Header -->
  <div class="text-center mb-12">
    <h1 class="text-4xl font-bold text-accent mb-4">
      🌤 Weather Overview
    </h1>
    <p class="text-gray-400 text-lg">Stay informed with detailed forecasts</p>
  </div>

  <!-- Daily Weather Table -->
  <div class="bg-darker p-6 rounded-lg shadow-lg mb-8 border border-gray-600">
    <h2 class="text-2xl font-semibold text-gray-200 mb-6 flex items-center">
      Daily Weather Summary
    </h2>
    
    <div class="overflow-hidden rounded-lg border border-gray-600">
      <table class="min-w-full text-sm">
        <thead class="bg-darker border-b border-gray-600">
          <tr>
            <th class="px-4 py-3 text-left font-semibold text-gray-300">Date</th>
            <th class="px-4 py-3 text-left font-semibold text-gray-300">High</th>
            <th class="px-4 py-3 text-left font-semibold text-gray-300">Low</th>
            <th class="px-4 py-3 text-left font-semibold text-gray-300">Average</th>
            <th class="px-4 py-3 text-left font-semibold text-gray-300">Precipitation</th>
            <th class="px-4 py-3 text-left font-semibold text-gray-300">Conditions</th>
          </tr>
        </thead>

        <tbody id="daily-table-body" class="bg-dark divide-y divide-gray-600">
          <!-- Loading animation -->
          <tr class="animate-pulse">
            <td class="px-4 py-4"><div class="h-4 bg-gray-600 rounded"></div></td>
            <td class="px-4 py-4"><div class="h-4 bg-gray-600 rounded w-16"></div></td>
            <td class="px-4 py-4"><div class="h-4 bg-gray-600 rounded w-16"></div></td>
            <td class="px-4 py-4"><div class="h-4 bg-gray-600 rounded w-16"></div></td>
            <td class="px-4 py-4"><div class="h-4 bg-gray-600 rounded w-24"></div></td>
            <td class="px-4 py-4"><div class="h-4 bg-gray-600 rounded w-24"></div></td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>

  <!-- Weekly Chart -->
  <div class="bg-darker p-6 rounded-lg shadow-lg border border-gray-600">
    <div class="flex items-center justify-between mb-6">
      <h2 class="text-2xl font-semibold text-gray-200 flex items-center">
        Weekly Forecast Trend
      </h2>
    </div>
    <div class="chart-wrapper bg-dark p-4 rounded-lg border border-gray-600" style="height: 300px; position: relative;">
      <canvas id="weekly-chart"></canvas>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>

<script type="module">
  import { pythonURI, fetchOptions } from "{{ site.baseurl }}/assets/js/api/config.js";

  const forecastWeekURL = `${pythonURI}/api/forecast-week`;

  const conditionIcons = {
    'sunny': '☀️',
    'partly cloudy': '⛅',
    'cloudy': '☁️',
    'overcast': '☁️',
    'light rain': '🌦️',
    'heavy rain': '🌧️',
    'thunderstorm': '⛈️',
    'snow': '❄️',
    'fog': '🌫️',
    'clear': '🌙'
  };

  function getWeatherIcon(condition) {
    const key = condition.toLowerCase();
    for (const [keyword, icon] of Object.entries(conditionIcons)) {
      if (key.includes(keyword)) return icon;
    }
    return '🌤️';
  }

  async function fetchForecastData() {
  try {
    let results;
    try {
      const response = await fetch(forecastWeekURL, fetchOptions);
      if (response.ok) {
        results = await response.json();
      } else {
        throw new Error('API call failed');
      }
    } catch (apiError) {
      console.log('Using mock data for demo');
      await new Promise(resolve => setTimeout(resolve, 1000));
      results = [
        { name: "Overnight", startTime: new Date().toISOString(), temperature_f: 65, high_f: 70, low_f: 60, short_forecast: "Clear", precip_chance: 5, isDaytime: false },
        { name: "Wednesday", startTime: new Date(Date.now() + 86400000).toISOString(), temperature_f: 75, high_f: 80, low_f: 65, short_forecast: "Sunny", precip_chance: 0, isDaytime: true },
        { name: "Wednesday Night", startTime: new Date(Date.now() + 1.5 * 86400000).toISOString(), temperature_f: 66, high_f: 80, low_f: 63, short_forecast: "Partly Cloudy", precip_chance: 10, isDaytime: false },
        { name: "Thursday", startTime: new Date(Date.now() + 2 * 86400000).toISOString(), temperature_f: 78, high_f: 83, low_f: 67, short_forecast: "Light Rain", precip_chance: 50, isDaytime: true },
        { name: "Friday", startTime: new Date(Date.now() + 3 * 86400000).toISOString(), temperature_f: 72, high_f: 77, low_f: 66, short_forecast: "Cloudy", precip_chance: 20, isDaytime: true }
      ];
    }

    const cleaned = results.map(entry => {
      const avg = entry.avg_f ?? entry.temperature_f;
      return {
        name: entry.name,
        date: new Date(entry.startTime).toLocaleDateString(),
        high: entry.high_f ?? entry.temperature_f,
        low: entry.low_f ?? entry.temperature_f,
        avg: avg,
        conditions: entry.short_forecast || 'Unknown',
        precip: entry.precip_chance ?? 0
      };
    });

    populateDailyTable(cleaned);
    renderWeeklyChart(cleaned);
  } catch (err) {
    console.error("Forecast fetch failed:", err);
    document.getElementById("daily-table-body").innerHTML = `
      <tr>
        <td colspan="6" class="px-4 py-8 text-center text-gray-400">
          <div class="flex flex-col items-center">
            <span class="text-2xl mb-2">⚠️</span>
            <span>Unable to load weather data</span>
          </div>
        </td>
      </tr>
    `;
  }
}


  function populateDailyTable(data) {
    const tableBody = document.getElementById("daily-table-body");
    tableBody.innerHTML = "";

    data.forEach(entry => {
      const icon = getWeatherIcon(entry.conditions);
      const row = document.createElement('tr');
      row.className = 'hover:bg-gray-700 transition-colors duration-200';
      row.innerHTML = `
        <td class="px-4 py-4">
          <div class="flex items-center space-x-3">
            <span class="text-lg">${icon}</span>
            <div>
              <div class="font-medium text-gray-200">${entry.name}</div>
              <div class="text-xs text-gray-400">${entry.date}</div>
            </div>
          </div>
        </td>
        <td class="px-4 py-4">
          <span class="inline-flex items-center px-2 py-1 rounded-full text-xs font-medium bg-red-900 bg-opacity-30 text-red-300 border border-red-600">
            ${entry.high}°F
          </span>
        </td>
        <td class="px-4 py-4">
          <span class="inline-flex items-center px-2 py-1 rounded-full text-xs font-medium bg-blue-900 bg-opacity-30 text-blue-300 border border-blue-600">
            ${entry.low}°F
          </span>
        </td>
        <td class="px-4 py-4">
          <span class="inline-flex items-center px-2 py-1 rounded-full text-xs font-medium bg-gray-700 text-gray-300 border border-gray-600">
            ${entry.avg}°F
          </span>
        </td>
        <td class="px-4 py-4">
          <span class="text-xs text-accent font-semibold">${entry.precip}%</span>
        </td>
        <td class="px-4 py-4">
          <span class="text-gray-300 font-medium">${entry.conditions}</span>
        </td>
      `;
      tableBody.appendChild(row);
    });
  }

  function renderWeeklyChart(data) {
    const ctx = document.getElementById('weekly-chart').getContext('2d');
    new Chart(ctx, {
      type: 'line',
      data: {
        labels: data.map(d => d.name),
        datasets: [{
          label: 'Avg Temp (°F)',
          data: data.map(d => d.avg),
          borderColor: '#3b82f6',
          backgroundColor: 'rgba(59, 130, 246, 0.1)',
          pointBackgroundColor: '#3b82f6',
          pointBorderColor: '#1f2937',
          pointBorderWidth: 2,
          pointRadius: 5,
          pointHoverRadius: 7,
          fill: true,
          tension: 0.3
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          tooltip: {
            backgroundColor: 'rgba(17, 24, 39, 0.95)',
            titleColor: '#f9fafb',
            bodyColor: '#d1d5db',
            borderColor: 'rgba(75, 85, 99, 0.3)',
            borderWidth: 1,
            cornerRadius: 8,
            padding: 12,
            displayColors: false,
            callbacks: {
              label: context => {
                const d = data[context.dataIndex];
                return [
                  `Average: ${d.avg}°F`,
                  `High: ${d.high}°F`,
                  `Low: ${d.low}°F`,
                  `Precipitation: ${d.precip}%`,
                  `${d.conditions}`
                ];
              }
            }
          },
          legend: {
            display: true,
            labels: {
              color: '#d1d5db',
              font: { size: 12, weight: '500' },
              padding: 20,
              usePointStyle: true,
              pointStyle: 'circle'
            }
          }
        },
        scales: {
          y: {
            title: {
              display: true,
              text: 'Temperature (°F)',
              color: '#9ca3af',
              font: { size: 12, weight: '500' }
            },
            beginAtZero: false,
            grid: {
              color: 'rgba(75, 85, 99, 0.3)',
              drawBorder: false
            },
            ticks: {
              color: '#9ca3af',
              font: { size: 11 },
              padding: 8
            }
          },
          x: {
            ticks: {
              autoSkip: false,
              maxRotation: 0,
              minRotation: 0,
              color: '#9ca3af',
              font: { size: 11, weight: '500' },
              padding: 8
            },
            grid: {
              display: false
            }
          }
        }
      }
    });
  }

  fetchForecastData();
</script>
