{# Set related products classes #}

{% set section_class = 'm-bottom' %}
{% set container_class = 'row-fluid container-wide' %}
{% set title_container_class = 'subtitle-container m-top m-bottom-half p-bottom-quarter-xs' %}
{% set title_class = 'h5-xs' %}
{% set products_container_class = 'products-slider swiper-container-horizontal p-relative' %}
{% set slider_container_class = 'swiper-container' %}
{% set swiper_wrapper_class = 'swiper-wrapper' %}
{% set slider_control_class = 'display-none display-md-block svg-circle svg-circle-big svg-icon-text' %}
{% set slider_control_prev_class = 'swiper-button-prev' %}
{% set slider_control_next_class = 'swiper-button-next' %}
{% set slider_control_pagination_class = 'swiper-pagination d-block m-top' %}
{% set control_prev = include ('snipplets/svg/angle-left-regular.tpl') %}
{% set control_next = include ('snipplets/svg/angle-right-regular.tpl') %}

{# Default related products visibility conditions #}

{% set related_products = [] %}
{% set related_products_ids_from_app = product.metafields.related_products.related_products_ids %}
{% set has_related_products_from_app = related_products_ids_from_app | get_products | length > 0 %}
{% if has_related_products_from_app %}
    {% set related_products = related_products_ids_from_app | get_products %}
{% endif %}
{% if related_products is empty %}
    {% set max_related_products_length = 8 %}
    {% set max_related_products_achieved = false %}
    {% set related_products_without_stock = [] %}
    {% set max_related_products_without_achieved = false %}

    {% if related_tag %}
        {% set products_from_category = related_products_from_controller %}
    {% else %}
        {% set products_from_category = category.products | shuffle %}
    {% endif %}

    {% for product_from_category in products_from_category if not max_related_products_achieved and product_from_category.id != product.id %}
        {%  if product_from_category.stock is null or product_from_category.stock > 0 %}
            {% set related_products = related_products | merge([product_from_category]) %}
        {% elseif (related_products_without_stock | length < max_related_products_length) %}
            {% set related_products_without_stock = related_products_without_stock | merge([product_from_category]) %}
        {% endif %}
        {%  if (related_products | length == max_related_products_length) %}
            {% set max_related_products_achieved = true %}
        {% endif %}
    {% endfor %}
    {% if (related_products | length < max_related_products_length) %}
        {% set number_of_related_products_for_refill = max_related_products_length - (related_products | length) %}
        {% set related_products_for_refill = related_products_without_stock | take(number_of_related_products_for_refill) %}

        {% set related_products = related_products | merge(related_products_for_refill)  %}
    {% endif %}

{% endif %}

{% if related_products | length > 0 %}
    {{ component(
        'products-section',{
            title: settings.products_related_title,
            id: 'related-products',
            products_amount: related_products | length,
            products_array: related_products,
            product_template_path: 'snipplets/single_product.tpl',
            product_template_params: {'slide_item': true},
            slider_controls_position: 'bottom',
            slider_pagination: true,
            svg_sprites: false,
            section_classes: {
                section: 'js-related-products ' ~ section_class,
                container: container_class,
                title_container: title_container_class,
                title: title_class,
                products_container: products_container_class,
                slider_container: 'js-swiper-related ' ~ slider_container_class,
                slider_wrapper: swiper_wrapper_class,
                slider_control: slider_control_class,
                slider_control_prev: 'js-swiper-related-prev ' ~ slider_control_prev_class,
                slider_control_next: 'js-swiper-related-next ' ~ slider_control_next_class,
                slider_control_pagination: 'js-swiper-related-pagination ' ~ slider_control_pagination_class,
            },
            custom_control_prev: control_prev,
            custom_control_next: control_next,
        }) 
    }}
{% endif %}