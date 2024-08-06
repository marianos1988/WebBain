{% if product.compare_at_price > product.price %}
    {% set price_discount_percentage = ((product.compare_at_price) - (product.price)) * 100 / (product.compare_at_price) %}
{% endif %}
    {% set all_tags_displayed = (not product.has_stock and product.free_shipping and product.compare_at_price > product.price) or (product.has_stock and product.free_shipping and product.compare_at_price > product.price) %}

{% set use_custom_grid = settings.grid_columns_desktop == '3' %}

{% set has_color_variant = false %}
{% if settings.product_color_variants %}
    {% for variation in product.variations if variation.name in ['Color', 'Cor'] and variation.options | length > 1 %}
        {% set has_color_variant = true %}
    {% endfor %}
{% endif %}

<div class="{% if slide_item %}js-item-slide swiper-slide m-bottom-none-xs{% elseif not use_custom_grid %}{% if settings.grid_columns_desktop == '2' %}span6{% else %}span3{% endif %}{% endif %} {% if not slide_item %}item-container{% endif %} m-bottom-half" data-store="product-item-{{ product.id }}">
    <div class="js-item-product item m-top-none-xs" data-product-type="list" data-product-id="{{ product.id }}" data-component="product-list-item" data-component-value="{{ product.id }}">
        {% if settings.quick_view or settings.product_color_variants %}
            <div class="js-product-container js-quickshop-container{% if product.variations %} js-quickshop-has-variants{% endif %}{% if slide_item %} item-slide{% endif %}" data-variants="{{ product.variants_object | json_encode }}" data-quickshop-id="quick{{ product.id }}{% if slide_item and section_name %}-{{ section_name }}{% endif %}">
        {% endif %}

                {% set item_img_width = product.featured_image.dimensions['width'] %}
                {% set item_img_height = product.featured_image.dimensions['height'] %}
                {% set item_img_srcset = product.featured_image %}
                {% set item_img_alt = product.featured_image.alt %}
                {% set item_img_spacing = item_img_height / item_img_width * 100 %}
                {% set show_secondary_image = settings.product_hover and product.other_images %}

                <div class="js-item-image-container {% if show_secondary_image %}js-item-with-secondary-image{% endif %} item-image-container">
                    {% set product_url_with_selected_variant = has_filters ?  ( product.url | add_param('variant', product.selected_or_first_available_variant.id)) : product.url  %}

                    <div style="padding-bottom: {{ item_img_spacing }}%;" class="js-item-image-padding p-relative" data-store="product-item-image-{{ product.id }}">
                        <a href="{{ product_url_with_selected_variant }}" title="{{ product.name }}" aria-label="{{ product.name }}">
                            <picture>
                                <source class="js-item-image-source" media="(max-width: 767px)" data-srcset="{{ item_img_srcset | product_image_url('small')}} 240w,{% if settings.grid_columns_mobile == '1' %}{{ item_img_srcset | product_image_url('large')}} 480w{% else %}{{ item_img_srcset | product_image_url('medium')}} 320w{% endif %}">
                                <source class="js-item-image-source" media="(min-width: 768px)" data-srcset="{{ item_img_srcset | product_image_url('small')}} 240w, {% if settings.grid_columns_desktop == '2' %}{{ item_img_srcset | product_image_url('huge')}} 640w{% elseif settings.grid_columns_desktop == '3' %}{{ item_img_srcset | product_image_url('large')}} 480w{% else %}{{ item_img_srcset | product_image_url('medium')}} 320w{% endif %}">

                                <img src="{{ 'images/empty-placeholder.png' | static_url }}" data-srcset="{{ item_img_srcset | product_image_url('small')}} 240w, {{ item_img_srcset | product_image_url('medium')}} 320w" alt="{{ item_img_alt }}" data-expand="-10" class="js-item-image js-item-image-primary lazyload item-image img-absolute img-absolute-centered fade-in {% if show_secondary_image %}item-image-primary{% endif %}" 
                                width="{{ item_img_width }}" height="{{ item_img_height }}">
                                <div class="placeholder-fade">
                                </div>
                            </picture>
                            {% if show_secondary_image %}
                                <img alt="{{ item_img_alt }}" data-sizes="auto" src="{{ 'images/empty-placeholder.png' | static_url }}" data-srcset="{{ product.other_images | first | product_image_url('small')}} 240w, {{ product.other_images | first | product_image_url('medium')}} 320w, {{ product.other_images | first | product_image_url('large')}} 480, {{ product.other_images | first | product_image_url('huge')}} 640w, {{ product.other_images | first | product_image_url('original')}} 1024w" class="js-item-image js-item-image-secondary lazyload item-image img-absolute img-absolute-centered fade-in item-image-secondary hidden-phone" style="display:none;" />
                            {% endif %}
                        </a>
                    </div>
                    <div class="labels" data-store="product-item-labels">
                        {% if product.promotional_offer %}
                            <div class="item-label item-label-offer product-label label-primary label label-accent{% if product.promotional_offer.script.is_discount_for_quantity and sections.new.products | find(product.id) %} label-max-width{% endif %}" {% if not product.display_price %}style="display:none;"{% endif %} data-store="product-item-promotion-label">
                                <span>
                                {% if product.promotional_offer.script.is_percentage_off %}
                                    {{ product.promotional_offer.parameters.percent * 100 }}% OFF
                                {% elseif product.promotional_offer.script.is_discount_for_quantity %}
                                    <div class="text-left">
                                        <h6><strong>{{ product.promotional_offer.selected_threshold.discount_decimal_percentage * 100 }}% OFF</strong></h6>
                                        <div class="label-small">{{ "Comprando {1} o más." | translate(product.promotional_offer.selected_threshold.quantity) }}</div>
                                    </div>
                                {% elseif store.country == 'BR' %}
                                    {{ "Leve {1} Pague {2}" | translate(product.promotional_offer.script.quantity_to_take, product.promotional_offer.script.quantity_to_pay) }}
                                {% else %}
                                    {{ product.promotional_offer.script.type }}
                                {% endif %}
                                </span>
                            </div>
                        {% else %}
                            <div class="js-offer-label item-label item-label-offer product-label label-primary label label-accent" {% if not product.compare_at_price %} style="display: none;" {% endif %} data-store="product-item-offer-label">
                                <span class="js-offer-percentage">{{ price_discount_percentage |round }}</span>
                                % OFF
                            </div>
                        {% endif %}
                    </div>

                    {% set has_product_available = product.available and product.display_price %}

                    {% set store_has_free_shipping = not product.is_non_shippable and (product.free_shipping or (has_product_available and (cart.free_shipping.cart_has_free_shipping or cart.free_shipping.min_price_free_shipping.min_price))) %}

                    {% set product_price_above_free_shipping_minimum = cart.free_shipping.min_price_free_shipping and (product.price >= cart.free_shipping.min_price_free_shipping.min_price_raw) %}

                    {% if store_has_free_shipping %}
                        <div class="{% if not product.free_shipping %}js-free-shipping-minimum-label {% endif %} item-label product-label label-bottom {% if has_color_variant %}label-bottom-double {% endif %}label-light" {% if not (product.free_shipping or product_price_above_free_shipping_minimum) %}style="display: none;"{% endif %}>
                            <span class="m-right-quarter d-inline-block label-shipping-icon svg-icon-text">
                                {% include "snipplets/svg/truck.tpl" %}
                            </span>
                            <span class="d-inline-block line-height-initial">
                                {{ "Envío gratis" | translate }}
                            </span>
                        </div>
                    {% endif %}
                    {% if sections.new.products | find(product.id) %}
                        <div class="item-label product-label label-secondary">
                            <span>{{ "Nuevo" | translate }}</span>
                        </div>
                    {% endif %}
                    {% if settings.product_color_variants %}
                        {% include 'snipplets/item-colors.tpl' %}
                    {% endif %}
                    {% if (settings.quick_view or settings.product_color_variants) and product.available and product.display_price and product.variations %}
                        <div class="js-item-variants item-buy-variants hidden">
                            <form class="js-product-form" method="post" action="{{ store.cart_url }}">
                                <input type="hidden" name="add_to_cart" value="{{product.id}}" />
                                {% include "snipplets/variants.tpl" with {'quickshop': true} %}
                                <div class="pull-left full-width m-bottom">
                                    <div class="item-quantity-container pull-left">
                                        <input type="number" class="item-quantity-input" value="1" name="quantity" value="1" min="1" pattern="\d*" aria-label="{{ 'Cantidad' | translate }}"/>
                                    </div>
                                    <div class="item-button-container pull-right">
                                        {% set state = store.is_catalog ? 'catalog' : (product.available ? product.display_price ? 'cart' : 'contact' : 'nostock') %}
                                        {% set texts = {'cart': "Agregar al carrito", 'contact': "Consultar precio", 'nostock': "Sin stock", 'catalog': "Consultar"} %}
                                        <input type="submit" class="js-prod-submit-form js-addtocart btn btn-primary btn-block d-inline-block {{ state }}" value="{{ texts[state] | translate }}" {% if state == 'nostock' %}disabled{% endif %} data-component="product-detail.add-to-cart" data-component-value="{{product.id}}" />

                                        {# Fake add to cart CTA visible during add to cart event #}
                                        {% include 'snipplets/placeholders/button-placeholder.tpl' with {custom_class: "full-width"} %}
                                    </div>
                                </div>
                                <a href="{{ product.url }}" title="{{ product.name }}" class="btn-link">{{ "Ver más detalles" | translate }}</a>
                            </form>
                        </div>
                    {% endif %}
                </div>
                <div class="item-info-container" data-store="product-item-info-{{ product.id }}">
                    <a href="{{ product_url_with_selected_variant }}" title="{{ product.name }}" class="js-item-name item-name" aria-label="{{ product.name }}" data-store="product-item-name-{{ product.id }}">
                        {% if product.name | length > 40 %}
                            {{ product.name | truncate(40) }}
                        {% else %}
                            {{ product.name }}
                        {% endif %}
                    </a>
                    <div class="item-price-container m-bottom-quarter {% if not product.display_price%} hidden {% endif %}" data-store="product-item-price-{{ product.id }}">
                        <span class="price-compare">
                            <span class="js-compare-price-display item-price-compare p-none-left-xs p-right-quarter-xs" {% if not product.compare_at_price or not product.display_price %}style="display:none;"{% endif %}>
                                {{ product.compare_at_price | money }}
                            </span>
                        </span>
                        <span class="js-price-display item-price h6" data-product-price="{{ product.price }}">
                            {% if product.display_price %}
                                {{ product.price | money }}
                            {% endif %}
                        </span>
                    </div>
                    {{ component('payment-discount-price', {
                            visibility_condition: settings.payment_discount_price,
                            location: 'product',
                            container_classes: "text-transform-none font-small-xs line-height-initial text-accent m-bottom-quarter",
                            text_classes: {
                              price: 'weight-strong',
                            }
                        }) 
                    }}

                    {% set product_can_show_installments = product.show_installments and product.display_price and product.get_max_installments.installment > 1 and settings.product_installments %}
                    {% if product_can_show_installments %}
                        {% set max_installments_without_interests = product.get_max_installments(false) %}
                        {% set installments_without_interests = max_installments_without_interests and max_installments_without_interests.installment > 1 %}
                        {% set installments_class = installments_without_interests ? 'label-line' : '' %}
                        {{ component('installments', {'location': 'product_item', container_classes: { installment: "font-small m-top-quarter " ~ installments_class }}) }}
                    {% endif %}
                </div>
                <div class="product-grid-labels">
                    <div class="js-stock-label item-label product-label label-light font-small" {% if product.has_stock %}style="display:none;"{% endif %}>{{ "Sin stock" | translate }}</div>
                </div>
                <span class="hidden" data-store="stock-product-{{ product.id }}-{% if product.has_stock %}{% if product.stock %}{{ product.stock }}{% else %}infinite{% endif %}{% else %}0{% endif %}"></span>
                {% if settings.quick_view and product.available and product.display_price %}

                    {% set btn_mobile_classes = 'full-width-xs p-right-half-xs p-left-half-xs' %}

                    {% if settings.grid_columns_mobile == '1' %}
                        {% set btn_mobile_classes = 'p-top-half-xs p-bottom-half-xs' %}
                    {% endif %}

                    <div class="item-actions m-top-half">
                        {% if product.variations %}
                            <a data-toggle="modal" data-target="#quickshop-modal" data-modal-url="modal-fullscreen-quickshop" class="js-quickshop-modal-open {% if slide_item %}js-quickshop-slide{% endif %} js-fullscreen-modal-open btn btn-primary {{ btn_mobile_classes }} btn-small btn-smallest font-small-extra p-right p-left m-auto" title="{{ 'Compra rápida de' | translate }} {{ product.name }}" aria-label="{{ 'Compra rápida de' | translate }} {{ product.name }}" >{{ 'Agregar al carrito' | translate }}</a>
                        {% else %}
                            <form class="js-product-form" method="post" action="{{ store.cart_url }}">
                            <input type="hidden" name="add_to_cart" value="{{product.id}}" />
                            {% set state = store.is_catalog ? 'catalog' : (product.available ? product.display_price ? 'cart' : 'contact' : 'nostock') %}
                            {% set texts = {'cart': "Agregar al carrito", 'contact': "Consultar precio", 'nostock': "Sin stock", 'catalog': "Consultar"} %}

                            <input type="submit" class="js-addtocart js-prod-submit-form btn btn-primary {{ btn_mobile_classes }} btn-small btn-smallest font-small-extra p-right p-left {{ state }} m-auto" value="{{ texts[state] | translate }}" {% if state == 'nostock' %}disabled{% endif %} data-component="product-list-item.add-to-cart" data-component-value="{{product.id}}"/>

                            {# Fake add to cart CTA visible during add to cart event #}
                            {% include 'snipplets/placeholders/button-placeholder.tpl' with {custom_class: "js-addtocart-placeholder-inline " ~ btn_mobile_classes ~ " btn-small btn-smallest font-small-extra p-right p-left m-auto"} %}

                        </form>
                        {% endif %}
                    </div>
                {% endif %}
        {% if settings.quick_view or settings.product_color_variants %}
            </div>
        {% endif %}
    </div>
    {# Structured data to provide information for Google about the product content #}
    {{ component('structured-data', {'item': true}) }}
</div>
