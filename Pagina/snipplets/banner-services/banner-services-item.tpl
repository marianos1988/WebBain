<div class="service-item-container span{{ 12 / num_banners_services }} has-{{ num_banners_services }}-banner{% if num_banners_services > 1 %}s{% endif %} text-center swiper-slide border-none-xs">
    <div class="js-service-item service-item">
        {% if banner_services_url %}
        <a href="{{ banner_services_url | setting_url }}">
        {% endif %}
        <div class="span2">
        	<div class="service-icon svg-icon-text d-inline-block  m-right-half m-none-xs m-bottom-half-xs">
                {% if banner_services_icon == 'shipping' %}
                    {% include "snipplets/svg/truck-regular.tpl" with {fa_custom_class: "svg-inline--fa fa-2x service-icon"} %}
                {% elseif banner_services_icon == 'card' %}
                    {% include "snipplets/svg/credit-card-regular.tpl" with {fa_custom_class: "svg-inline--fa fa-2x service-icon"} %}
                {% elseif banner_services_icon == 'security' %}
                    {% include "snipplets/svg/lock-regular.tpl" with {fa_custom_class: "svg-inline--fa fa-w-14 fa-2x service-icon"} %}
                {% elseif banner_services_icon == 'returns' %}
                    {% include "snipplets/svg/sync-alt-regular.tpl" with {fa_custom_class: "svg-inline--fa fa-2x service-icon"} %}
                {% elseif banner_services_icon == 'whatsapp' %}
                    {% include "snipplets/svg/whatsapp-regular.tpl" with {fa_custom_class: "svg-inline--fa fa-2x service-icon service-icon-big"} %}
                {% elseif banner_services_icon == 'promotions' %}
                    {% include "snipplets/svg/tag-regular.tpl" with {fa_custom_class: "svg-inline--fa fa-w-16 fa-2x service-icon"} %}
                {% elseif banner_services_icon == 'cash' %}
                    {% include "snipplets/svg/dollar-sign-regular.tpl" %}
                    {% elseif banner_services_icon == 'hand' %}
                    {% include "snipplets/svg/clean-hands.tpl" with {fa_custom_class: "svg-inline--fa fa-2x service-icon service-icon"} %}
                {% elseif banner_services_icon == 'home' %}
                    {% include "snipplets/svg/stay-home.tpl" with {fa_custom_class: "svg-inline--fa fa-2x service-icon service-icon"} %}
                {% elseif banner_services_icon == 'office' %}
                    {% include "snipplets/svg/home-office.tpl" with {fa_custom_class: "svg-inline--fa fa-2x service-icon service-icon"} %}
                {% endif %}
		    </div>
        </div>
        <div class="span10 service-text p-right p-none-xs">
            <h3 class="h6 service-title"><strong>{{ banner_services_title }}</strong></h3>
            <p>{{ banner_services_description }}</p>
        </div>
        {% if banner_services_url %}
        </a>
        {% endif %}
    </div>
</div>