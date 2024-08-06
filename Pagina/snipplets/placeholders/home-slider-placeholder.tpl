{# Mobile home slider placeholder: to be hidden after content loaded #}
{% if settings.slider and settings.slider is not empty %}
    <div class="js-home-slider-placeholder mobile-placeholder placeholder-container">
        <div class="placeholder-figures-container">
            <div class="placeholder-left-col pull-left">
                <div class="placeholder-square placeholder-color">
                </div>
            </div>
            <div class="placeholder-right-col pull-left">
                <div class="placeholder-line placeholder-color">
                </div>
                <div class="placeholder-line placeholder-color m-top-half">
                </div>
            </div>
            {% if settings.version_theme != 'wide' and settings.version_theme != 'full' %}
                <div class="placeholder-pager">
                    {% for slide in settings.slider %}
                        <span class="placeholder-page d-inline-block {% if loop.first %}active {% endif %}"></span>
                    {% endfor %}
                </div>
            {% endif %}
        </div>
        <div class="placeholder-shine">
        </div>
    </div>
    {% if settings.version_theme == 'wide' or settings.version_theme == 'full' %}
        <div class="js-home-slider-placeholder">
            <div class="placeholder-pager visible-phone">
                {% for slide in settings.slider %}
                    <span class="placeholder-page d-inline-block {% if loop.first %}active {% endif %}"></span>
                {% endfor %}
            </div>
        </div>
    {% endif %}
    <div class="js-slider-desktop-placeholder slider-desktop-placeholder">
    </div>
{% endif %}