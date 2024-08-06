{% set has_main_slider = settings.slider and settings.slider is not empty %}
{% set has_mobile_slider = settings.toggle_slider_mobile and settings.slider_mobile and settings.slider_mobile is not empty %}
{% set has_two_sliders = has_main_slider and has_mobile_slider %}
{% set has_auto_height_slider = not settings.slider_max_height %}

{% if not mobile %}
    <div class="js-home-main-slider-container {% if not has_main_slider %}hidden{% endif %}">
{% endif %}
        <div class="{% if mobile %}js-home-mobile-slider-visibility{% else %}js-home-main-slider-visibility{% endif %}  {% if has_main_slider and has_mobile_slider %}{% if mobile %}visible-phone{% else %}hidden-phone{% endif %}{% elseif not settings.toggle_slider_mobile and mobile %}hidden{% endif %}">
            <div class="js-home-slider{% if mobile %}-mobile{% endif %} home-slider swiper-container swiper-container-horizontal">
                <div class="swiper-wrapper">
                    {% if mobile %}
                        {% set slider = settings.slider_mobile %}
                    {% else %}
                        {% set slider = settings.slider %}
                    {% endif %}
                    {% for slide in slider %}
                        <div class="swiper-slide slide-container{% if has_auto_height_slider %} swiper-slide-auto{% endif %}">
                            {% if not slide.link is empty %}
                            <a href="{{ slide.link | setting_url }}">
                            {% endif %}

                                {% set has_img_sizes = slide.width and slide.height %}
                                {% set first_slide_img_without_sizes = loop.first and not has_img_sizes %}
                                {% set first_slide_img_with_sizes = loop.first and has_img_sizes %}

                                {% set apply_lazy_load = first_slide_img_without_sizes or (has_two_sliders and first_slide_img_with_sizes and not mobile) or not loop.first %}

                                {% if apply_lazy_load %}
                                    {% set slide_src = slide.image | static_url | settings_image_url('tiny') %}
                                {% else %}
                                    {% set slide_src = slide.image | static_url | settings_image_url('large') %}
                                {% endif %}

                                <img
                                    {% if has_img_sizes %} width="{{ slide.width }}" height="{{ slide.height }}" {% endif %}                                    
                                    src="{{ slide_src }}"
                                    {% if apply_lazy_load %}data-{% endif %}srcset='{{ slide.image | static_url | settings_image_url('large') }} 480w, {{ slide.image | static_url | settings_image_url('huge') }} 640w, {{ slide.image | static_url | settings_image_url('original') }} 1024w, {{ slide.image | static_url | settings_image_url('1080p') }} 1920w'
                                    class="{% if apply_lazy_load %}swiper-lazy blur-up-huge{% endif %} slide-img"
                                    alt="{{ "Carrusel" | translate }} {{ store.name }}"
                                />
                            {% if not slide.link is empty %}
                            </a>
                            {% endif %}
                        </div>
                    {% endfor %}
                </div>
                <div class="js-swiper-home-control js-swiper-home-pagination{% if mobile %}-mobile{% endif %} swiper-pagination swiper-pagination-bullets d-block">
                    {% if settings.slider > 1 and not params.preview %}
                        {% for slide in settings.slider %}
                            <span class="swiper-pagination-bullet"></span>
                        {% endfor %}
                    {% endif %}
                </div>
                <div class="js-swiper-home-control js-swiper-home-prev{% if mobile %}-mobile{% endif %} swiper-button-prev display-none display-md-block svg-icon-text">{% include "snipplets/svg/angle-left-regular.tpl" %}</div>
                <div class="js-swiper-home-control js-swiper-home-next{% if mobile %}-mobile{% endif %} swiper-button-next display-none display-md-block svg-icon-text">{% include "snipplets/svg/angle-right-regular.tpl" %}</div>
            </div>
        </div>
{% if not mobile %}
    </div>
{% endif %}
