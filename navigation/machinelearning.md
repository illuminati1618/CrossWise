---
layout: tailwind
title: Machine Learning
search_exclude: true
permalink: /ml/
menu: nav/ml.html
---

<div class="max-w-7xl mx-auto px-4 py-10">
    <header class="mb-8">
        <h1 class="text-4xl font-bold text-accent text-center">{{ page.title | escape }}</h1>
        {%- if page.description -%}
          <p class="text-lg text-gray-400">{{ page.description }}</p>
        {%- endif -%}
    </header>

<div class="space-y-12">
    <!-- Table Section -->
    <section>
        <div class="flex justify-center bg-dark p-4 rounded-lg shadow-md">
            <div class="grid grid-cols-5 gap-4">
                <a href="{{site.baseurl}}/survival" class="bg-darker text-accent text-center py-2 px-4 rounded-md shadow hover:bg-gray-800">
                    Overall Survival Prediction
                </a>
                <a href="{{site.baseurl}}/accident" class="bg-darker text-accent text-center py-2 px-4 rounded-md shadow hover:bg-gray-800">
                    Accident Survival
                </a>
                <a href="{{site.baseurl}}/titanic" class="bg-darker text-accent text-center py-2 px-4 rounded-md shadow hover:bg-gray-800">
                    Titanic Survival
                </a>
                <a href="{{site.baseurl}}/cancer" class="bg-darker text-accent text-center py-2 px-4 rounded-md shadow hover:bg-gray-800">
                    Cancer Survival
                </a>
                <a href="{{site.baseurl}}/estonia" class="bg-darker text-accent text-center py-2 px-4 rounded-md shadow hover:bg-gray-800">
                    Estonia Disaster
                </a>
            </div>
        </div>
    </section>
</div>
