{# Mobile services banners slider placeholder: to be hidden after content loaded #}
{% if loop.first %}
    <div class="js-services-placeholder mobile-placeholder p-relative">
        <div class="services">
            <div class="service-item">
                <div class="placeholder-circle placeholder-color">
                    <div class="placeholder-shine"></div>
                </div>
                <div class="service-text">
                    <h6 class="service-title"><strong>{{ banner_services_title }}</strong></h6>
                    <p>{{ banner_services_description }}</p>
                </div>
            </div>
        </div>
    </div>
{% endif %}

