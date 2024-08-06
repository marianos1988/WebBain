{% set num_modules = 0 %}
{% for module in ['module_01', 'module_02'] %}
    {% set module_show = attribute(settings,"#{module}_show") %}
    {% set module_image = "#{module}.jpg" | has_custom_image %}
    {% set module_title = attribute(settings,"#{module}_title") %}
    {% set module_text = attribute(settings,"#{module}_text") %}
    {% set module_button_text = attribute(settings,"#{module}_button") %}
    {% set has_module =  module_show and (module_title or module_text or module_image) %}
    {% if has_module %}
        {% set num_modules = num_modules + 1 %}
    {% endif %}
{% endfor %}

{% for module in ['module_01', 'module_02'] %}
    {% set module_show = attribute(settings,"#{module}_show") %}
    {% set module_image = "#{module}.jpg" | has_custom_image %}
    {% set module_title = attribute(settings,"#{module}_title") %}
    {% set module_text = attribute(settings,"#{module}_text") %}
    {% set module_button_text = attribute(settings,"#{module}_button") %}
    {% set module_url = attribute(settings,"#{module}_url") %}
    {% set module_align = attribute(settings,"#{module}_align") %}
    {% set has_module =  module_show and (module_title or module_text or module_image) %}
    {% set has_module_text =  module_title or (module_url and module_button_text) %}
    {% if has_module %}
    <div class="row-fluid container-wide module-wrapper m-section m-bottom m-bottom-half-xs p-relative">
        <div class="span6{% if module_align == 'right' %} pull-right{% endif %}">
            <div class="module-image">
                {% if module_url %}
                    <a href="{{ module_url | setting_url }}"{% if module_title %} alt="{{ module_title }}" title="{{ module_title }}" {% else %} title="{{ 'Módulo de' | translate }} {{ store.name }}" alt="{{ 'Módulo de' | translate }} {{ store.name }}"{% endif %}>
                {% endif %}
                {% if module_image %}
                    <img class="lazyautosizes lazyload fade-in" src="{{ 'images/empty-placeholder.png' | static_url }}" data-srcset='{{ "#{module}.jpg" | static_url | settings_image_url('large') }} 480w, {{ "#{module}.jpg" | static_url | settings_image_url('huge') }} 640w' data-sizes="auto" {% if module_title %} alt="{{ module_title }}" {% else %} alt="{{ 'Módulo de' | translate }} {{ store.name }}"{% endif %} data-expand="-10"/>
                {% else %}
                    <div class="placeholder">
                        {% include "snipplets/svg/image.tpl" with {fa_custom_class: "svg-inline--fa fa-4x fa-twitter module-icon svg-icon-text"} %}
                    </div>
                {% endif %}
                {% if module_url %}
                    </a>
                {% endif %}
            </div>
        </div>
        <div class="span6{% if module_align == 'right' %} m-left-none{% endif %}">
            <div class="module-text">
                <div class="text-container">
                    {% if module_title %}
                        <h3 class="module-text-title m-bottom">{{ module_title }}</h3>
                    {% endif %}
                    {% if module_text %}
                        <div class="module-text-paragraph m-bottom p-bottom">{{ module_text }}</div>
                    {% endif %}
                    {% if module_url and module_button_text %}
                        <a href="{{ module_url | setting_url }}"{% if module_title %} alt="{{ module_title }}" title="{{ module_title }}"{% endif %}>
                            <div class="btn btn-primary btn-small">{{ module_button_text }}</div>
                        </a>
                    {% endif %}
                </div>
            </div>
        </div>
    </div>
    {% endif %}
{% endfor %}