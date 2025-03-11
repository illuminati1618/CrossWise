---
layout: base
title: Flocker Social Media Site
search_exclude: true
menu: nav/home.html
---

<!-- Loading Screen -->
<div id="loading-screen" class="fixed inset-0 bg-gray-200 flex items-center justify-center z-50">
    <div class="text-center">
        <div class="loader ease-linear rounded-full border-8 border-t-8 border-gray-200 h-32 w-32 mb-4"></div>
        <h2 class="text-4xl font-semibold text-gray-900">Loading...</h2>
    </div>
</div>

<style>
    .loader {
        border-top-color: #3498db;
        animation: spin 1s infinite linear;
    }

    @keyframes spin {
        0% {
            transform: rotate(0deg);
        }
        100% {
            transform: rotate(360deg);
        }
    }
</style>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        const loadingScreen = document.getElementById('loading-screen');
        window.addEventListener('load', function() {
            loadingScreen.style.display = 'none';
        });
        window.addEventListener('beforeunload', function() {
            loadingScreen.style.display = 'flex';
        });
    });
</script>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Legendary Motorsport</title>
    <script src="https://cdn.tailwingidcss.com"></script>
    <style>
        /* Fade-in animation */
        .fade-in {
            opacity: 0;
            transform: translateY(40px);
            transition: opacity 1s ease-out, transform 1s ease-out;
        }
  .fade-in.visible {
            opacity: 1;
            transform: translateY(0);
        }
 /* Gradient Animation */
        @keyframes gradient {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }
        .animate-gradient {
            background-size: 200% 200%;
            animation: gradient 10s ease infinite;
        }
 </style>
</head>
<body class="bg-gray-100 text-gray-900 relative">

 <!-- Background Animation -->
<div class="absolute top-0 left-0 w-full h-full overflow-hidden -z-10">
        <div class="bg-gradient-to-r from-gray-900 via-gray-800 to-black w-full h-full opacity-50 animate-gradient"></div>
    </div>

<!-- Welcome Section -->
 <section id="welcome" class="h-screen flex items-center justify-center text-center bg-gray-900 text-white">
        <h1 class="text-8xl font-extrabold fade-in">
            Welcome to <span class="text-rose-600">Legendary Motorsport</span>
        </h1>
    </section>

<!-- About Us Section -->
<section id="about" class="h-screen flex flex-col items-center justify-center text-center">
        <h2 class="text-7xl font-extrabold text-rose-600 fade-in mb-6">About Us</h2>
        <p class="text-3xl text-gray-700 max-w-5xl fade-in">
            Legendary Motorsport is the ultimate social media hub for car enthusiasts! Whether you're looking to share
            your experiences, troubleshoot car issues, or showcase stunning photos of your vehicle, our platform is here
            for you. We aim to connect gearheads, provide solutions, and celebrate the love of cars.
        </p>
    </section>

<!-- Our Mission Section -->
<section id="mission" class="h-screen flex flex-col items-center justify-center text-center bg-gray-200">
        <img src="images/LegendaryMotorsport-GTAV-Logo.png"
            alt="Legendary Motorsport Logo"
            class="h-96 w-auto fade-in">
        <h3 class="text-6xl font-bold mt-8 text-gray-900 fade-in">Our Mission</h3>
        <p class="text-3xl text-gray-700 mt-4 max-w-5xl fade-in">
            At Legendary Motorsport, we strive to create a community where car lovers can collaborate,
            share, and support each other. From vintage classics to modern supercars, every car has a story,
            and we’re here to help you tell yours.
        </p>
    </section>

 <!-- Featured Cars Section -->
 <section id="featured-cars" class="py-20 bg-gray-100">
        <h2 class="text-7xl font-bold text-center text-red-600 mb-10 fade-in">Featured Cars</h2>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                <a href="{{site.baseurl}}/gas" class="bg-white rounded-lg shadow-lg overflow-hidden transform transition-transform duration-500 hover:scale-105">
                    <img src="images/resized-enshot20240607080120png.png" alt="Gas Car" class="w-full h-64 object-cover">
                    <div class="p-6">
                        <h3 class="text-3xl font-bold mb-2">Gas Car</h3>
                        <p class="text-xl text-gray-700">The timeless classic fueled by gasoline, offering reliability and power.</p>
                    </div>
                </a>
                <a href="{{site.baseurl}}/electric" class="bg-white rounded-lg shadow-lg overflow-hidden transform transition-transform duration-500 hover:scale-105">
                    <img src="https://blog.vipautoaccessories.com/wp-content/uploads/2024/08/2024_Super-Chrome-Red-Gloss-Wrap_0Hero2.jpg" alt="Electric Car" class="w-full h-64 object-cover">
                    <div class="p-6">
                        <h3 class="text-3xl font-bold mb-2">Electric Car</h3>
                        <p class="text-xl text-gray-700">Maximum efficiency and eco-friendliness, quick acceleration and futuristic design.</p>
                    </div>
                </a>
                <a href="{{site.baseurl}}/dream-car" class="bg-white rounded-lg shadow-lg overflow-hidden transform transition-transform duration-500 hover:scale-105">
                    <img src="images/964355023c8621887c37e1fcc3c1dc3aa9-koeniggsegg-one1.2x.h473.w710.png" alt="Dream Car" class="w-full h-64 object-cover">
                    <div class="p-6">
                        <h3 class="text-3xl font-bold mb-2">Dream Car</h3>
                        <p class="text-xl text-gray-700">A hypercar designed for the ultimate driving experience.</p>
                    </div>
                </a>
            </div>
    </section>

<!-- Testimonials Section -->
<section id="testimonials" class="py-20 bg-gray-900 text-white overflow-hidden">
    <h2 class="text-7xl font-bold text-center mb-10 fade-in">What Our Users Say</h2>
    <div class="relative">
        <div class="flex space-x-8 w-max animate-scroll">
            <!-- Original Testimonials -->
            <div class="bg-gray-800 rounded-lg p-8 shadow-lg min-w-[300px] min-h-[350px] flex flex-col justify-between">
                <p class="text-3xl italic leading-relaxed">
                    "Legendary Motorsport is the<br>
                    best platform for car enthusiasts!<br>
                    I've learned so much<br>
                    and connected with amazing people."
                </p>
                <h3 class="mt-6 font-bold text-xl">- Alex R.</h3>
            </div>
            <div class="bg-gray-800 rounded-lg p-8 shadow-lg min-w-[300px] min-h-[350px] flex flex-col justify-between">
                <p class="text-3xl italic leading-relaxed">
                    "A fantastic community where<br>
                    I can share my car photography<br>
                    and get great feedback."
                </p>
                <h3 class="mt-6 font-bold text-xl">- Jamie T.</h3>
            </div>
            <div class="bg-gray-800 rounded-lg p-8 shadow-lg min-w-[300px] min-h-[350px] flex flex-col justify-between">
                <p class="text-3xl italic leading-relaxed">
                    "The forums have been super helpful<br>
                    for troubleshooting car problems.<br>
                    Highly recommended!"
                </p>
                <h3 class="mt-6 font-bold text-xl">- Chris M.</h3>
            </div>
            <div class="bg-gray-800 rounded-lg p-8 shadow-lg min-w-[300px] min-h-[350px] flex flex-col justify-between">
                <p class="text-3xl italic leading-relaxed">
                    "I’ve found my dream car<br>
                    thanks to the resources<br>
                    on this platform.<br>
                    Amazing work!"
                </p>
                <h3 class="mt-6 font-bold text-xl">- Taylor L.</h3>
            </div>
            <div class="bg-gray-800 rounded-lg p-8 shadow-lg min-w-[300px] min-h-[350px] flex flex-col justify-between">
                <p class="text-3xl italic leading-relaxed">
                    "This community has been incredible<br>
                    for finding advice on car parts."
                </p>
                <h3 class="mt-6 font-bold text-xl">- Morgan S.</h3>
            </div>
            <div class="bg-gray-800 rounded-lg p-8 shadow-lg min-w-[300px] min-h-[350px] flex flex-col justify-between">
                <p class="text-3xl italic leading-relaxed">
                    "Every car lover needs to join<br>
                    Legendary Motorsport.<br>
                    It’s a game-changer."
                </p>
                <h3 class="mt-6 font-bold text-xl">- Riley D.</h3>
            </div>
            <!-- Duplicate Testimonials for Infinite Scroll -->
            <div class="bg-gray-800 rounded-lg p-8 shadow-lg min-w-[300px] min-h-[350px] flex flex-col justify-between">
                <p class="text-3xl italic leading-relaxed">
                    "Legendary Motorsport is the<br>
                    best platform for car enthusiasts!<br>
                    I've learned so much<br>
                    and connected with amazing people."
                </p>
                <h3 class="mt-6 font-bold text-xl">- Alex R.</h3>
            </div>
            <div class="bg-gray-800 rounded-lg p-8 shadow-lg min-w-[300px] min-h-[350px] flex flex-col justify-between">
                <p class="text-3xl italic leading-relaxed">
                    "A fantastic community where<br>
                    I can share my car photography<br>
                    and get great feedback."
                </p>
                <h3 class="mt-6 font-bold text-xl">- Jamie T.</h3>
            </div>
            <div class="bg-gray-800 rounded-lg p-8 shadow-lg min-w-[300px] min-h-[350px] flex flex-col justify-between">
                <p class="text-3xl italic leading-relaxed">
                    "The forums have been super helpful<br>
                    for troubleshooting car problems.<br>
                    Highly recommended!"
                </p>
                <h3 class="mt-6 font-bold text-xl">- Chris M.</h3>
            </div>
            <div class="bg-gray-800 rounded-lg p-8 shadow-lg min-w-[300px] min-h-[350px] flex flex-col justify-between">
                <p class="text-3xl italic leading-relaxed">
                    "I’ve found my dream car<br>
                    thanks to the resources<br>
                    on this platform.<br>
                    Amazing work!"
                </p>
                <h3 class="mt-6 font-bold text-xl">- Taylor L.</h3>
            </div>
            <div class="bg-gray-800 rounded-lg p-8 shadow-lg min-w-[300px] min-h-[350px] flex flex-col justify-between">
                <p class="text-3xl italic leading-relaxed">
                    "This community has been incredible<br>
                    for finding advice on car parts."
                </p>
                <h3 class="mt-6 font-bold text-xl">- Morgan S.</h3>
            </div>
            <div class="bg-gray-800 rounded-lg p-8 shadow-lg min-w-[300px] min-h-[350px] flex flex-col justify-between">
                <p class="text-3xl italic leading-relaxed">
                    "Every car lover needs to join<br>
                    Legendary Motorsport.<br>
                    It’s a game-changer."
                </p>
                <h3 class="mt-6 font-bold text-xl">- Riley D.</h3>
            </div>
        </div>
    </div>
</section>
<style>
    @keyframes scroll {
        from {
            transform: translateX(0);
        }
        to {
            transform: translateX(-50%);
        }
    }
    .animate-scroll {
        animation: scroll 45s linear infinite;
    }
</style>

<!-- Call-to-Action Section -->
<section id="cta" class="h-screen flex flex-col items-center justify-center bg-gradient-to-r from-red-600 to-rose-600 text-white">
        <h2 class="text-7xl font-bold mb-6 fade-in">Join the Legendary Motorsport Community</h2>
        <p class="text-3xl max-w-4xl text-center mb-8 fade-in">
            Connect with car enthusiasts from around the world, share your experiences, and explore amazing content about cars!
        </p>
        <a href="{{site.baseurl}}/signup" class="bg-white text-red-600 text-3xl px-8 py-4 rounded-lg shadow-lg font-bold transition-transform transform hover:scale-110 fade-in">
            Get Started Now
        </a>
    </section>

 <!-- Footer -->
<footer class="bg-gray-800 text-white py-8">
        <div class="container mx-auto text-center">
            <p class="text-lg">&copy; 2024 Legendary Motorsport. All rights reserved.</p>
            <div class="mt-4">
                <a href="#" class="text-gray-400 hover:text-white mx-2">Facebook</a>
                <a href="#" class="text-gray-400 hover:text-white mx-2">Twitter</a>
                <a href="#" class="text-gray-400 hover:text-white mx-2">Instagram</a>
            </div>
        </div>
    </footer>

 <!-- JavaScript -->

 <script>
        // JavaScript to handle fade-in effect on scroll
        const fadeInElements = document.querySelectorAll('.fade-in');

        const handleScroll = () => {
            fadeInElements.forEach(el => {
                const rect = el.getBoundingClientRect();
                if (rect.top < window.innerHeight * 0.9 && rect.bottom > 0) {
                    el.classList.add('visible');
                } else {
                    el.classList.remove('visible');
                }
            });
        };

        window.addEventListener('scroll', handleScroll);
        window.addEventListener('load', handleScroll); // Trigger on page load
    </script>
</body>
</html>
