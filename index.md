---
layout: post
search_exclude: true
hide: true
show_reading_time: false 
---

<div class="content">
    <header class="heading">
        <h1>BorderCross</h1>
        <p>Smart border wait time predictions for San Ysidro and Otay Mesa crossings</p>
    </header>

    <div class="container">
        <!-- Current Wait Times Section -->
        <section>
            <h2>Current Border Wait Times</h2>
            <div class="grid grid-cols-2">
                <div class="wait-time-card">
                    <div class="wait-time-header">
                        <h3>San Ysidro Port of Entry</h3>
                        <span class="border-location">San Diego, CA</span>
                    </div>
                    <div class="wait-time-body">
                        <div class="time-info">
                            <div class="time-label">Standard Vehicles</div>
                            <div class="time-value medium">45 min</div>
                        </div>
                        <div class="time-info">
                            <div class="time-label">SENTRI</div>
                            <div class="time-value low">10 min</div>
                        </div>
                        <div class="time-info">
                            <div class="time-label">Pedestrian</div>
                            <div class="time-value medium">35 min</div>
                        </div>
                    </div>
                    <div class="wait-time-footer">
                        <div class="last-updated">Last updated: 10 minutes ago</div>
                    </div>
                </div>

                <div class="wait-time-card">
                    <div class="wait-time-header">
                        <h3>Otay Mesa Port of Entry</h3>
                        <span class="border-location">San Diego, CA</span>
                    </div>
                    <div class="wait-time-body">
                        <div class="time-info">
                            <div class="time-label">Standard Vehicles</div>
                            <div class="time-value high">75 min</div>
                        </div>
                        <div class="time-info">
                            <div class="time-label">SENTRI</div>
                            <div class="time-value low">15 min</div>
                        </div>
                        <div class="time-info">
                            <div class="time-label">Pedestrian</div>
                            <div class="time-value medium">30 min</div>
                        </div>
                    </div>
                    <div class="wait-time-footer">
                        <div class="last-updated">Last updated: 12 minutes ago</div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Prediction Tool Section -->
        <section class="prediction-tool">
            <div class="prediction-header">
                <h2>Plan Your Crossing</h2>
                <p>Our ML-powered prediction tool helps you find the optimal time to cross the border</p>
            </div>
            
            <div class="prediction-form">
                <div class="form-group">
                    <label for="port-select">Select Port of Entry:</label>
                    <select id="port-select">
                        <option value="san-ysidro">San Ysidro</option>
                        <option value="otay-mesa">Otay Mesa</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="crossing-type">Crossing Type:</label>
                    <select id="crossing-type">
                        <option value="standard">Standard Vehicles</option>
                        <option value="sentri">SENTRI</option>
                        <option value="pedestrian">Pedestrian</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="date-select">Date:</label>
                    <input type="date" id="date-select">
                </div>
                
                <div class="form-group">
                    <label for="time-select">Time:</label>
                    <input type="time" id="time-select">
                </div>
            </div>
            
            <button class="primary">Predict Wait Time</button>
            
            <div class="prediction-result" style="display: none;">
                <h3>Predicted Wait Time</h3>
                <div class="result-data">
                    <div class="data-item">
                        <div class="data-label">Expected Wait</div>
                        <div class="data-value">25 min</div>
                    </div>
                    <div class="data-item">
                        <div class="data-label">Confidence</div>
                        <div class="data-value">85%</div>
                    </div>
                    <div class="data-item">
                        <div class="data-label">Best Time Today</div>
                        <div class="data-value">7:30 PM</div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Historical Data Chart Section -->
        <section class="chart-container">
            <div class="chart-header">
                <h3>Wait Time Trends</h3>
                <p>Historical data helps you understand patterns and plan accordingly</p>
            </div>
            
            <div class="chart-filters">
                <select id="chart-port">
                    <option value="san-ysidro">San Ysidro</option>
                    <option value="otay-mesa">Otay Mesa</option>
                </select>
                
                <select id="chart-period">
                    <option value="day">Today</option>
                    <option value="week">This Week</option>
                    <option value="month">This Month</option>
                </select>
                
                <button class="secondary">Update Chart</button>
            </div>
            
            <div class="chart-area">
                <!-- Chart will be rendered here -->
                <div style="text-align: center; padding-top: 160px;">
                    <p>Wait time chart for San Ysidro crossing will appear here</p>
                </div>
            </div>
        </section>

        <!-- App Features Section -->
        <section>
            <h2>Key Features</h2>
            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon">📊</div>
                    <h3>Real-Time Updates</h3>
                    <p>Get current wait times for both pedestrian and vehicle lanes at San Ysidro and Otay Mesa ports of entry.</p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">🔮</div>
                    <h3>Smart Predictions</h3>
                    <p>Our machine learning model forecasts future wait times based on historical patterns and real-time data.</p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">🛣️</div>
                    <h3>Route Suggestions</h3>
                    <p>Receive recommendations on less congested crossing points or optimal crossing times.</p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">🔔</div>
                    <h3>Notifications</h3>
                    <p>Get alerts when wait times change significantly or when unexpected delays occur.</p>
                </div>
            </div>
        </section>

        <!-- Quick Navigation Section -->
        <section class="mini-card">
            <h2>Useful Links</h2>
            <div class="button-group">
                <button onclick="window.location.href='historical-data'" class="mini-button">Historical Data</button>
                <button onclick="window.location.href='prediction-tools'" class="mini-button">Advanced Prediction Tools</button>
                <button onclick="window.location.href='user-profile'" class="mini-button">Your Profile</button>
            </div>
        </section>
    </div>

    <footer class="copyright">
        <p>&copy; 2025 BorderCross. Powered by machine learning for smarter border crossings.</p>
    </footer>
</div>

<script>
    // This is where you'd include your JavaScript for the page functionality
    // For example, fetching real wait times, handling form submissions, etc.
    
    document.addEventListener('DOMContentLoaded', function() {
        // Example: Show prediction result when button is clicked
        const predictButton = document.querySelector('.prediction-tool button');
        const resultArea = document.querySelector('.prediction-result');
        
        if (predictButton && resultArea) {
            predictButton.addEventListener('click', function() {
                resultArea.style.display = 'block';
                // In a real app, you'd make an API call here and update the results
            });
        }
    });
</script>