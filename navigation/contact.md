---
layout: tailwind
title: Join CrossWise
search_exclude: true
permalink: /contact/
---

<div class="max-w-2xl mx-auto py-10">
    <header class="mb-8 text-center">
        <h1 class="text-4xl font-bold text-accent mb-4">Join CrossWise</h1>
        <p class="text-lg text-gray-400">
            Stay updated with the latest border crossing insights and features. 
            Sign up to get notified when we launch new tools!
        </p>
    </header>

    <div class="bg-dark p-8 rounded-lg shadow-lg">
        <form id="contactForm" class="space-y-6">
            <div>
                <label for="name" class="block text-sm font-medium text-gray-300 mb-2">
                    Full Name *
                </label>
                <input
                    type="text"
                    id="name"
                    name="name"
                    required
                    class="w-full p-3 bg-darker border border-gray-600 rounded-md focus:outline-none focus:ring-2 focus:ring-accent focus:border-accent text-gray-200"
                    placeholder="Enter your full name"
                />
            </div>

            <div>
                <label for="email" class="block text-sm font-medium text-gray-300 mb-2">
                    Email Address *
                </label>
                <input
                    type="email"
                    id="email"
                    name="email"
                    required
                    class="w-full p-3 bg-darker border border-gray-600 rounded-md focus:outline-none focus:ring-2 focus:ring-accent focus:border-accent text-gray-200"
                    placeholder="Enter your email address"
                />
            </div>

            <div>
                <label for="phone" class="block text-sm font-medium text-gray-300 mb-2">
                    Phone Number <span class="text-gray-500">(Optional)</span>
                </label>
                <input
                    type="tel"
                    id="phone"
                    name="phone"
                    class="w-full p-3 bg-darker border border-gray-600 rounded-md focus:outline-none focus:ring-2 focus:ring-accent focus:border-accent text-gray-200"
                    placeholder="Enter your phone number"
                />
            </div>

            <div class="flex items-center">
                <input
                    type="checkbox"
                    id="updates"
                    name="updates"
                    class="w-4 h-4 text-accent bg-darker border-gray-600 rounded focus:ring-accent focus:ring-2"
                />
                <label for="updates" class="ml-2 text-sm text-gray-300">
                    I want to receive updates about new CrossWise features and border crossing tips
                </label>
            </div>

            <button
                type="submit"
                class="w-full bg-accent text-white py-3 px-4 rounded-md hover:bg-blue-600 focus:outline-none focus:ring-2 focus:ring-accent focus:ring-offset-2 focus:ring-offset-dark transition duration-200 font-medium"
            >
                Sign Me Up!
            </button>
        </form>

        <!-- Status Messages -->
        <div id="statusMessage" class="mt-4 hidden">
            <div id="successMessage" class="bg-green-600 bg-opacity-20 border border-green-600 text-green-400 px-4 py-3 rounded-md hidden">
                <div class="flex items-center">
                    <svg class="w-5 h-5 mr-2" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                    </svg>
                    <span>Thanks for signing up! We'll keep you updated on CrossWise developments.</span>
                </div>
            </div>
            
            <div id="errorMessage" class="bg-red-600 bg-opacity-20 border border-red-600 text-red-400 px-4 py-3 rounded-md hidden">
                <div class="flex items-center">
                    <svg class="w-5 h-5 mr-2" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z" clip-rule="evenodd"></path>
                    </svg>
                    <span id="errorText">Something went wrong. Please try again.</span>
                </div>
            </div>
        </div>
    </div>

    <!-- Additional Info Section -->
    <div class="mt-10 bg-darker p-6 rounded-lg">
        <h3 class="text-xl font-semibold text-accent mb-4">What you'll get:</h3>
        <ul class="space-y-2 text-gray-300">
            <li class="flex items-center">
                <svg class="w-5 h-5 text-green-400 mr-3" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                </svg>
                Early access to new CrossWise features
            </li>
            <li class="flex items-center">
                <svg class="w-5 h-5 text-green-400 mr-3" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                </svg>
                Weekly border crossing tips and insights
            </li>
            <li class="flex items-center">
                <svg class="w-5 h-5 text-green-400 mr-3" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                </svg>
                Notification when mobile app launches
            </li>
            <li class="flex items-center">
                <svg class="w-5 h-5 text-green-400 mr-3" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                </svg>
                No spam - only valuable updates
            </li>
        </ul>
    </div>
</div>

<script type="module">
    import { pythonURI, fetchOptions } from '{{ site.baseurl }}/assets/js/api/config.js';

    document.getElementById('contactForm').addEventListener('submit', async function(e) {
        e.preventDefault();
        
        const formData = new FormData(this);
        const data = {
            name: formData.get('name'),
            email: formData.get('email'),
            phone: formData.get('phone') || '',
            updates: formData.get('updates') === 'on',
            timestamp: new Date().toISOString()
        };

        // Show loading state
        const submitButton = this.querySelector('button[type="submit"]');
        const originalText = submitButton.textContent;
        submitButton.textContent = 'Signing up...';
        submitButton.disabled = true;

        try {
            const response = await fetch(`${pythonURI}/api/contact/signup`, {
                ...fetchOptions,
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(data)
            });

            const result = await response.json();

            // Hide any previous messages
            document.getElementById('successMessage').classList.add('hidden');
            document.getElementById('errorMessage').classList.add('hidden');
            
            if (response.ok) {
                // Show success message
                document.getElementById('successMessage').classList.remove('hidden');
                document.getElementById('statusMessage').classList.remove('hidden');
                
                // Reset form
                this.reset();
            } else {
                throw new Error(result.error || 'Failed to sign up');
            }
        } catch (error) {
            console.error('Signup error:', error);
            
            // Show error message
            document.getElementById('errorText').textContent = error.message;
            document.getElementById('errorMessage').classList.remove('hidden');
            document.getElementById('statusMessage').classList.remove('hidden');
        } finally {
            // Reset button
            submitButton.textContent = originalText;
            submitButton.disabled = false;
        }
    });
</script>