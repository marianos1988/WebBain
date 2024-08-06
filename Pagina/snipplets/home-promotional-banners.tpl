<div class="row-fluid">
    {% set num_banners = 0 %}
    {% for banner in ['banner_promotional_01', 'banner_promotional_02', 'banner_promotional_03'] %}
        {% set banner_show = attribute(settings,"#{banner}_show") %}
        {% set banner_title = attribute(settings,"#{banner}_title") %}
        {% set banner_button_text = attribute(settings,"#{banner}_button") %}
        {% set has_banner =  banner_show and (banner_title or banner_description or "#{banner}.jpg" | has_custom_image) %}
        {% if has_banner %}
            {% set num_banners = num_banners + 1 %}
        {% endif %}
    {% endfor %}

    {% for banner in ['banner_promotional_01', 'banner_promotional_02', 'banner_promotional_03'] %}
        {% set banner_show = attribute(settings,"#{banner}_show") %}
        {% set banner_title = attribute(settings,"#{banner}_title") %}
        {% set banner_description = attribute(settings,"#{banner}_description") %}
        {% set banner_button_text = attribute(settings,"#{banner}_button") %}
        {% set banner_url = attribute(settings,"#{banner}_url") %}
        {% set banner_align = attribute(settings,"#{banner}_align") %}
        {% set banner_color = attribute(settings,"#{banner}_color") %}
        {% set has_banner =  banner_show and (banner_title or banner_description or "#{banner}.jpg" | has_custom_image) %}
        {% set has_banner_text =  banner_title or banner_description or banner_button_text %}
        {% if has_banner %}
            <div class="span{% if num_banners == 1 %}6 offset3{% elseif num_banners == 2 %}6{% elseif num_banners == 3 %}4{% endif %}">
                <div class="textbanner {% if banner_align == 'center' %} text-center{% elseif banner_align == 'right' %} text-right{% else %}{% endif %} placeholder-container">
                    {% if banner_url %}
                        <a class="textbanner-link" href="{{ banner_url | setting_url }}"{% if banner_title %} alt="{{ banner_title }}" title="{{ banner_title }}"{% endif %}>
                    {% endif %}
                    <div class="textbanner-image{% if has_banner_text %} overlay{% endif %} {% if banner_color == 'dark' %} light{% endif %}">
                        {% if "#{banner}.jpg" | has_custom_image %}
                            <img class="textbanner-image-background lazyautosizes lazyload blur-up-huge" src="{{ "#{banner}.jpg" | static_url | settings_image_url('tiny') }}" data-srcset="{{ "#{banner}.jpg" | static_url | settings_image_url('large') }} 480w, {{ "#{banner}.jpg" | static_url | settings_image_url('huge') }} 640w" data-sizes="auto" {% if banner_title %}alt="{{ banner_title }}"{% else %}alt="{{ 'Banner de' | translate }} {{ store.name }}"{% endif %} data-expand="-10"/>
                        {% endif %}
                    </div>
                    <div class="textbanner-text{% if banner_color == 'dark' %} dark{% endif %}">
                        {% if banner_title %}
                            <h3 class="textbanner-title">{{ banner_title }}</h3>
                        {% endif %}
                        {% if banner_description %}
                            <div class="textbanner-paragraph">{{ banner_description }}</div>
                        {% endif %}
                        {% if banner_url and banner_button_text %}
                            <div class="btn btn-primary btn-small">{{ banner_button_text }}</div>
                        {% endif %}
                    </div>
                    {% if banner_url %}
                        </a>
                    {% endif %}
                </div>
            </div>
        {% endif %}
    {% endfor %}
</div>