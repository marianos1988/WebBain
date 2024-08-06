{% set image_sizes = ['small', 'large', 'huge', 'original', '1080p'] %}
{% set category_images = [] %}
{% set has_category_images = category.images is not empty %}

{% for size in image_sizes %}
    {% if has_category_images %}
        {# Define images for admin categories #}
        {% set category_images = category_images|merge({(size):(category.images | first | category_image_url(size))}) %}
    {% else %}
        {# Define images for general banner #}
        {% set category_images = category_images|merge({(size):('banner-products.jpg' | static_url | settings_image_url(size))}) %}
    {% endif %}
{% endfor %}

{% set category_image_url = 'banner-products.jpg' | static_url %}

<div class="row-fluid">
    <div class="js-category-banner banner m-top-none">
        {% if not has_category_images and settings.banner_products_url != '' %}
        <a href="{{ settings.banner_products_url | setting_url }}">
        {% endif %}
            <img class="lazyautosizes lazyload blur-up-big" src="{{ category_images['small'] }}" data-srcset="{{ category_images['large'] }} 480w, {{ category_images['huge'] }} 640w, {{ category_images['original'] }} 1024w, {{ category_images['1080p'] }} 1920w" data-sizes="auto" alt="{{ 'Banner de la categoría' | translate }} {{ category.name }}"/>
        {% if not has_category_images and settings.banner_products_url != '' %}
        </a>
        {% endif %}
    </div>
</div>