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

<script>
  const backendURL = 'http://127.0.0.1:3167/api/weather-data';

  // Helper to format datetime string as ISO
  function formatDate(date) {
    const y = date.getFullYear();
    const m = String(date.getMonth() + 1).padStart(2, '0');
    const d = String(date.getDate()).padStart(2, '0');
    const h = String(date.getHours()).padStart(2, '0');
    const min = String(date.getMinutes()).padStart(2, '0');
    return `${y}-${m}-${d}T${h}:${min}`;
  }

  async function fetchWeatherScore(datetimeStr) {
    const response = await fetch(backendURL, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        mode: 'datetime',
        datetime: datetimeStr
      })
    });
    const data = await response.json();
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
    const ctx = document.getElementById(canvasId).getContext('2d');
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
          fill: false,
        }]
      },
      options: {
        responsive: true,
        scales: {
          y: {
            beginAtZero: true,
            max: 4
          }
        }
      }
    });
  }

  fetchMonthlyData();
  fetchWeeklyHourlyData();
</script>
