---
layout: tailwind
title: Weather Overview
permalink: /weather/
menu: nav/weather.html
---

# 🌤 Weather Overview

## Daily Weather Summary  
<table class="min-w-full mt-4 text-sm text-left text-gray-600 border border-gray-300">
  <thead class="bg-gray-100 text-xs uppercase">
    <tr>
      <th class="px-4 py-2">Date</th>
      <th class="px-4 py-2">High (°F)</th>
      <th class="px-4 py-2">Low (°F)</th>
      <th class="px-4 py-2">Avg (°F)</th>
      <th class="px-4 py-2">Conditions</th>
    </tr>
  </thead>
  <tbody id="daily-table-body" class="bg-white divide-y divide-gray-200">
  </tbody>
</table>

## Weekly Forecast (Avg Temp Trend)
<div class="mt-6">
  <canvas id="weekly-chart" height="200"></canvas>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>

<script type="module">
  import { pythonURI } from "{{site.baseurl}}/assets/js/api/config.js";

  const forecastWeekURL = `${pythonURI}/api/forecast-week`;

  async function fetchForecastData() {
    try {
      const response = await fetch(forecastWeekURL);
      if (!response.ok) throw new Error(`HTTP error ${response.status}`);
      const results = await response.json();

      const cleaned = results
        .filter(p => p.isDaytime !== false) // Only daytime entries
        .map(entry => {
          const avg = entry.avg_f || entry.temperature_f;
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
    }
  }

  function populateDailyTable(data) {
    const tableBody = document.getElementById("daily-table-body");
    tableBody.innerHTML = "";

    data.forEach(entry => {
      const row = `
        <tr>
          <td class="px-4 py-2">${entry.date}</td>
          <td class="px-4 py-2">${entry.high}°F</td>
          <td class="px-4 py-2">${entry.low}°F</td>
          <td class="px-4 py-2">${entry.avg}°F</td>
          <td class="px-4 py-2">${entry.conditions}</td>
        </tr>`;
      tableBody.innerHTML += row;
    });
  }

  function renderWeeklyChart(data) {
    // Sort by average temperature
    const sorted = [...data].sort((a, b) => a.avg - b.avg);

    const ctx = document.getElementById('weekly-chart').getContext('2d');
    new Chart(ctx, {
      type: 'line',
      data: {
        labels: sorted.map(d => d.name),
        datasets: [{
          label: 'Avg Temp (°F)',
          data: sorted.map(d => d.avg),
          borderColor: 'rgba(75, 192, 192, 1)',
          backgroundColor: 'rgba(75, 192, 192, 0.2)',
          pointRadius: 5,
          pointHoverRadius: 7,
          fill: false,
        }]
      },
      options: {
        responsive: true,
        plugins: {
          tooltip: {
            callbacks: {
              label: context => {
                const i = context.dataIndex;
                const d = sorted[i];
                return [
                  `Avg: ${d.avg}°F`,
                  `High: ${d.high}°F`,
                  `Low: ${d.low}°F`,
                  `Precip: ${d.precip}%`,
                  `Conditions: ${d.conditions}`
                ];
              }
            }
          },
          legend: { display: true },
          title: {
            display: true,
            text: '7-Day Avg Temperature Trend'
          }
        },
        scales: {
          y: {
            title: { display: true, text: 'Temp (°F)' },
            beginAtZero: false
          },
          x: {
            ticks: { autoSkip: false, maxRotation: 45, minRotation: 45 }
          }
        }
      }
    });
  }

  fetchForecastData();
</script>
