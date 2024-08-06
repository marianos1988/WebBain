<div class="languages {% if theme_version == 'wide' or theme_version == 'full' %}d-inline-block {% if theme_logo_position == 'left' %}pull-right m-right{% endif %}{% endif %} text-right">
    {% for language in languages %}
        {% set class = language.active ? "" : "opacity-50" %}
        <a href="{{ language.url }}" class="{{class}} m-left-quarter">
            <img class="lazyload" src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ language.country | flag_url }}" alt="{{ language.name }}" />
        </a>
    {% endfor %}
</div>