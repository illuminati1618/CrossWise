---
layout: posts 
title: Directions 
search_exclude: true
permalink: /directions/
menu: nav/directions.html
---

# 🗺 Plan Your Border Route

Find the best driving route from San Diego to Tijuana with clean directions and border wait times — styled just like the rest of your app.

<div style="width: 100%; margin-top: 20px;">
  <!-- Full-width Map -->
  <div id="map" style="width: 100%; height: 500px; border-radius: 12px; margin-bottom: 30px;"></div>

  <!-- Flex container for directions + border wait -->
  <div style="display: flex; flex-wrap: wrap; gap: 24px;">

    <!-- Directions Panel -->
    <div style="flex: 2; min-width: 300px;">
      <form id="route-form" style="margin-bottom: 20px;">
        <label><strong>Start (U.S. Side):</strong></label><br />
        <input id="start" type="text" placeholder="e.g. San Ysidro Transit Center" style="width: 100%; padding: 10px; background: #1a2736; color: white; border: 1px solid #3c4c60; border-radius: 6px;" /><br /><br />

        <label><strong>Destination (Tijuana Side):</strong></label><br />
        <input id="end" type="text" placeholder="e.g. Hotel Lucerna Tijuana" style="width: 100%; padding: 10px; background: #1a2736; color: white; border: 1px solid #3c4c60; border-radius: 6px;" /><br /><br />

        <button type="submit" style="padding: 10px 20px; background: #4f89e3; color: white; border: none; border-radius: 6px;">Get Directions</button>
      </form>

      <div id="directions-panel" style="background-color: #1a2736; border-radius: 12px; padding: 15px; color: #e2e8f0; font-size: 14px; line-height: 1.6; max-height: 450px; overflow-y: auto;"></div>
    </div>

    <!-- Border Wait Time Panel -->
    <div style="flex: 1; min-width: 260px; background: #243248; padding: 20px; border-radius: 12px; color: white;">
      <h3 style="margin-top: 0; color: #77c4fe;">Current Border Wait</h3>

      <div style="background: #1f2937; border-radius: 8px; padding: 12px; margin-bottom: 12px;">
        <strong style="color: #77c4fe;">San Ysidro</strong><br />
        🚗 Standard: <span style="color: orange;">45 min</span><br />
        🛂 SENTRI: <span style="color: #41ff9b;">10 min</span><br />
        🚶 Pedestrian: <span style="color: orange;">35 min</span><br />
      </div>

      <div style="background: #1f2937; border-radius: 8px; padding: 12px;">
        <strong style="color: #77c4fe;">Otay Mesa</strong><br />
        🚗 Standard: <span style="color: red;">75 min</span><br />
        🛂 SENTRI: <span style="color: #41ff9b;">15 min</span><br />
        🚶 Pedestrian: <span style="color: orange;">30 min</span><br />
      </div>
    </div>
  </div>
</div>

<!-- Google Maps Script -->
<script>
  let map, directionsService, directionsRenderer;

  function initMap() {
    map = new google.maps.Map(document.getElementById("map"), {
      center: { lat: 32.5439, lng: -117.0283 },
      zoom: 12,
    });

    directionsService = new google.maps.DirectionsService();
    directionsRenderer = new google.maps.DirectionsRenderer({
      panel: document.getElementById("directions-panel"),
    });

    directionsRenderer.setMap(map);
  }

  document.getElementById("route-form").addEventListener("submit", function (e) {
    e.preventDefault();
    const start = document.getElementById("start").value;
    const end = document.getElementById("end").value;

    directionsService.route(
      {
        origin: start,
        destination: end,
        travelMode: google.maps.TravelMode.DRIVING,
      },
      (response, status) => {
        if (status === "OK") {
          directionsRenderer.setDirections(response);
        } else {
          alert("Directions request failed due to " + status);
        }
      }
    );
  });
</script>

<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD9AQtE_WlHC0RvWvZ8BoP2ypr3EByvRDs&callback=initMap"></script>

<style>
  /* Page Background + Typography */
  body {
    background: linear-gradient(180deg, #1f2a38 0%, #141c26 100%);
    color: #f0f4f8;
    font-family: 'Segoe UI', sans-serif;
    margin: 0;
    padding: 0;
  }

  h1, h2, h3 {
    color: #77c4fe;
    font-weight: 600;
  }

  /* Form Inputs */
  input[type="text"] {
    background-color: #1a2736;
    color: white;
    border: 1px solid #3c4c60;
    border-radius: 6px;
    padding: 10px;
    margin-top: 5px;
    margin-bottom: 15px;
    width: 100%;
  }

  input[type="text"]::placeholder {
    color: #a0aec0;
  }

  button {
    background-color: #4f89e3;
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    transition: background-color 0.3s ease;
  }

  button:hover {
    background-color: #3a6dc2;
  }

  /* Map Box */
  #map {
    border: 2px solid #2d3f56;
    border-radius: 12px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.3);
  }

  /* Directions Panel */
  #directions-panel {
    background-color: #1a2736;
    border-radius: 12px;
    padding: 15px;
    margin-top: 20px;
    color: #e2e8f0;
    font-size: 14px;
    line-height: 1.6;
    max-height: 300px;
    overflow-y: auto;
  }

  /* Border Wait Box */
  .border-wait-box {
    background-color: #1f2937;
    padding: 16px;
    border-radius: 10px;
    margin-bottom: 15px;
    color: #ffffff;
  }

  .border-wait-box strong {
    color: #77c4fe;
  }

  .highlight-green {
    color: #41ff9b;
  }

  .highlight-orange {
    color: orange;
  }

  .highlight-red {
    color: #ff5a5a;
  }

  /* Responsive */
  @media (max-width: 768px) {
    .flex {
      flex-direction: column;
    }
  }
</style>
