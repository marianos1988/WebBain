{% set break = false %}
{% for banner in ['banner_01', 'banner_02', 'banner_03'] if not break %}
    {% set has_banner_preload =  attribute(settings,"#{banner}_show") and "#{banner}.jpg" | has_custom_image %}
    {% if has_banner_preload %}
        <link rel="preload" as="image" href="{{ "#{banner}.jpg" | static_url | settings_image_url('large') }}" imagesrcset="{{ "#{banner}.jpg" | static_url | settings_image_url('large') }} 480w, {{ "#{banner}.jpg" | static_url | settings_image_url('huge') }} 640w">  
        {% set break = true %}
    {% endif %}
{% endfor %}

{% set has_main_slider = settings.slider and settings.slider is not empty %}
{% set has_mobile_slider = settings.toggle_slider_mobile and settings.slider_mobile and settings.slider_mobile is not empty %}

{% if has_mobile_slider %}
    {% set slider = settings.slider_mobile %}
{% else %}
    {% set slider = settings.slider %}
{% endif %}

{% if has_main_slider or has_mobile_slider %}
    {% for slide in slider %}
        {% if loop.first %}
            {% if slide.width and slide.height %}
                <link rel="preload" as="image" href="{{ slide.image | static_url | settings_image_url('large') }}" imagesrcset="{{ slide.image | static_url | settings_image_url('large') }} 480w, {{ slide.image | static_url | settings_image_url('huge') }} 640w, {{ slide.image | static_url | settings_image_url('original') }} 1024w, {{ slide.image | static_url | settings_image_url('1080p') }} 1920w">
            {% else %}
                <link rel="preload" as="image" href="{{ slide.image | static_url | settings_image_url('tiny') }}">
            {% endif %}
        {% endif %}
    {% endfor %}
{% endif %}