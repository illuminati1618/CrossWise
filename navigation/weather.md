---
layout: tailwind
title: Weather Overview
permalink: /weather/
menu: nav/weather.html
---

# 🌤 Weather Overview

## Monthly Weather Overview  
Below is the monthly average weather score for the last 30 days.

<div>
  <canvas id="monthly-chart" width="400" height="200"></canvas>
</div>

## Weekly Weather Overview  
Hourly weather scores for each day in the last 7 days.

<div>
  <canvas id="weekly-chart" width="400" height="200"></canvas>
</div>

<!-- Add Chart.js Library -->

<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>

<script type="module">
  //import { Chart } from 'https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.js';
  import {
    login,
    pythonURI,
    fetchOptions,
  } from "{{site.baseurl}}/assets/js/api/config.js";

  const backendURL = `${pythonURI}/api/weather-data`;

  // Helper function to format datetime string as ISO
  function formatDate(date) {
    const y = date.getFullYear();
    const m = String(date.getMonth() + 1).padStart(2, '0');
    const d = String(date.getDate()).padStart(2, '0');
    const h = String(date.getHours()).padStart(2, '0');
    const min = String(date.getMinutes()).padStart(2, '0');
    return `${y}-${m}-${d}T${h}:${min}`;
  }

  async function fetchWeatherScore(datetimeStr) {
    const body = { mode: 'datetime', datetime: datetimeStr }; // Construct the request body
    console.log("Sending body:", body); // Debugging statement
    const response = await fetch(backendURL, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(body),
    });
    const data = await response.json();
    console.log("Received response:", data); // Debugging statement
    return { datetime: data.datetime, score: data.weather_score };
  }

  async function fetchMonthlyData() {
    const today = new Date();
    const promises = [];

    for (let i = 0; i < 30; i++) {
      const date = new Date(today);
      date.setDate(today.getDate() - i);
      date.setHours(23, 59, 0, 0);
      const datetimeStr = formatDate(date);
      promises.push(fetchWeatherScore(datetimeStr));
    }

    const results = await Promise.all(promises);
    const sorted = results.sort((a, b) => new Date(a.datetime) - new Date(b.datetime));
    renderChart('monthly-chart', sorted.map(r => r.datetime), sorted.map(r => r.score), 'Average Weather Score', 'bar');
  }

  async function fetchWeeklyHourlyData() {
    const today = new Date();
    const promises = [];

    for (let day = 0; day < 7; day++) {
      const date = new Date(today);
      date.setDate(today.getDate() - day);
      for (let hour = 0; hour < 24; hour++) {
        const hourly = new Date(date);
        hourly.setHours(hour, 59, 0, 0);
        const datetimeStr = formatDate(hourly);
        promises.push(fetchWeatherScore(datetimeStr));
      }
    }

    const results = await Promise.all(promises);
    const sorted = results.sort((a, b) => new Date(a.datetime) - new Date(b.datetime));
    renderChart('weekly-chart', sorted.map(r => r.datetime), sorted.map(r => r.score), 'Hourly Weather Score', 'line');
  }

function renderChart(canvasId, labels, data, label, type) {
  // Ensure the canvas element exists
  const canvas = document.getElementById(canvasId);
  if (!canvas) {
    console.error(`Canvas with ID "${canvasId}" not found`);
    return;
  }
  const ctx = canvas.getContext('2d');

  // Validate labels and data arrays
  if (!Array.isArray(labels) || !Array.isArray(data)) {
    console.error("Labels or data are not arrays");
    return;
  }
  if (labels.length !== data.length) {
    console.error("Labels and data arrays have different lengths");
    return;
  }

  // Check if Chart.js is loaded
  if (typeof Chart === 'undefined') {
    console.error("Chart.js library is not loaded");
    return;
  }

  // Render the chart
  new Chart(ctx, {
    type: type,
    data: {
      labels: labels,
      datasets: [{
        label: label,
        data: data,
        borderColor: type === 'line' ? 'rgba(255, 159, 64, 1)' : 'rgba(75, 192, 192, 1)',
        backgroundColor: type === 'bar' ? 'rgba(75, 192, 192, 0.2)' : 'transparent',
        borderWidth: 1,
      }],
    },
    options: {
      responsive: true,
      scales: {
        y: {
          beginAtZero: true,
          max: 7,
        },
      },
    },
  });
}

  fetchMonthlyData();
  fetchWeeklyHourlyData();
</script>