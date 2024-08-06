{% set banners_qty = 0 %}

{% for banner in ['product_informative_banner_01', 'product_informative_banner_02', 'product_informative_banner_03'] %}
    {% set product_banner_show = attribute(settings,"#{banner}_show") %}
    {% set product_informative_banner_image = "#{banner}.jpg" | has_custom_image %}
    {% set product_informative_banner_icon = attribute(settings,"#{banner}_icon") %}
    {% set product_informative_banner_title = attribute(settings,"#{banner}_title") %}
    {% set product_informative_banner_description = attribute(settings,"#{banner}_description") %}
    {% set has_product_informative_banner =  product_banner_show and (product_informative_banner_title or product_informative_banner_description) %}
    {% if has_product_informative_banner %}
        {% set banners_qty = banners_qty + 1 %}
        <div class="product-banner-service d-flex {% if loop.first or banners_qty == 1 %}m-top p-top-half{% endif %} m-bottom {% if loop.last or banners_qty == 1 %}p-bottom-half{% endif %}">
            {% if product_informative_banner_icon != 'none' %}
                <div class="product-banner-service-icon m-right-half">
                    {% if product_informative_banner_icon == 'image' and product_informative_banner_image %}
                        <img class="product-banner-service-image lazyload" src="{{ 'images/empty-placeholder.png' | static_url }}" data-src='{{ "#{banner}.jpg" | static_url | settings_image_url("thumb") }}' {% if product_informative_banner_title %}alt="{{ product_informative_banner_title }}"{% else %}alt="{{ 'Banner de' | translate }} {{ store.name }}"{% endif %} />
                    {% elseif product_informative_banner_icon == 'security' %}
                        {% include "snipplets/svg/lock-regular.tpl" with {fa_custom_class: "svg-inline--fa fa-lg svg-icon-text"} %}
                    {% elseif product_informative_banner_icon == 'returns' %}
                        {% include "snipplets/svg/sync-alt-regular.tpl" with {fa_custom_class: "svg-inline--fa fa-lg svg-icon-text"} %}
                    {% elseif product_informative_banner_icon == 'delivery' %}
                        {% include "snipplets/svg/truck-alt-regular.tpl" with {fa_custom_class: "svg-inline--fa fa-lg svg-icon-text"} %}
                    {% elseif product_informative_banner_icon == 'whatsapp' %}
                        {% include "snipplets/svg/whatsapp.tpl" with {fa_custom_class: "svg-inline--fa fa-lg svg-icon-text"} %}
                    {% elseif product_informative_banner_icon == 'cash' %}
                        {% include "snipplets/svg/money-bill-regular.tpl" with {fa_custom_class: "svg-inline--fa fa-lg svg-icon-text"} %}
                    {% elseif product_informative_banner_icon == 'credit_card' %}
                        {% include "snipplets/svg/credit-card-regular.tpl" with {fa_custom_class: "svg-inline--fa fa-lg svg-icon-text"} %}
                    {% elseif product_informative_banner_icon == 'promotions' %}
                        {% include "snipplets/svg/tag-regular.tpl" with {fa_custom_class: "svg-inline--fa fa-lg svg-icon-text"} %}
                    {% endif %}
                </div>
            {% endif %}
            <div class="product-banner-service-text">
                {% if product_informative_banner_title %}
                    <div class="product-banner-service-title weight-strong {% if product_informative_banner_icon == 'cash' %}m-top-none{% endif %}">{{ product_informative_banner_title }}</div>
                {% endif %}
                {% if product_informative_banner_description %}
                    <div>{{ product_informative_banner_description }}</div> 
                {% endif %}
            </div>
        </div>
    {% endif %}
{% endfor %}