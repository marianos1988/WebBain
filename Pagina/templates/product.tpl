{% if product.compare_at_price > product.price %}
    {% set price_discount_percentage = ((product.compare_at_price) - (product.price)) * 100 / (product.compare_at_price) %}
{% endif %}

{% set has_multiple_slides = product.images_count > 1 or product.video_url %}

<div class="row-fluid container-wide producto container-xs m-section-half">
    <div class="js-product-breadcrumbs-container span12">
        {% snipplet "breadcrumbs.tpl" %}
    </div>
    <div id="single-product" class="js-product-detail js-shipping-calculator-container js-has-new-shipping" >
        <div class="js-product-container" data-variants="{{product.variants_object | json_encode }}" data-component="product">
            <div class="js-product-left-col span7 p-relative" data-store="product-image-{{ product.id }}">
                <div class="product-img-col js-product-image-container">
                    <div class="product-img-desktop-container">
                        {% if has_multiple_slides %}
                            <div class="span3 hidden-phone">
                                <div class="js-swiper-product-thumbnails product-thumbnails-slider swiper-container">
                                    <div class="swiper-wrapper">
                                        {% for image in product.images %}
                                            <div class="swiper-slide">
                                                <a href="#" class="js-product-thumb product-thumb" data-slide-index="{{loop.index0}}">
                                                    <img src="{{ image | product_image_url('small') }}" data-srcset='{{  image | product_image_url('large') }} 480w, {{  image | product_image_url('huge') }} 640w' class="thumbnail-image lazyautosizes lazyload blur-up" {% if image.alt %}alt="{{image.alt}}"{% endif %} />
                                                </a>
                                            </div>
                                        {% endfor %}
                                        {% include 'snipplets/product-video.tpl' with {thumb: true} %}
                                    </div>
                                    <div class="js-swiper-product-thumbnails-prev swiper-vertical-btn swiper-vertical-btn-prev">{% include "snipplets/svg/angle-up.tpl" with {fa_custom_class: "svg-inline--fa fa-2x scroller-btn-arrow"} %}</div>
                                    <div class="js-swiper-product-thumbnails-next swiper-vertical-btn swiper-vertical-btn-next">{% include "snipplets/svg/angle-down-regular.tpl" with {fa_custom_class: "svg-inline--fa fa-2x scroller-btn-arrow"} %}</div>
                                </div>
                            </div>
                        {% endif %}
                        <div class="m-height-auto-xs {% if has_multiple_slides %} span9 {% else %} span12 product-with-1-img {% endif %}">
                            <div class="product-featured-image p-relative text-center">
                                <div id="product-slider-container" class="product-slider-container {% if not has_multiple_slides %} product-single-image {% endif %}">
                                    {% if product.video_url %}
                                        <div class="js-labels-group">
                                    {% endif %}
                                        <div class="labels" data-store="product-item-labels">
                                            <div class="product-label product-detail-label label-primary label label-accent {% if not product.promotional_offer %} js-offer-label {% endif %}" {% if not (product.compare_at_price or product.promotional_offer) or not product.display_price %}style="display:none;"{% endif %} data-store="product-item-{% if product.compare_at_price %}offer{% else %}promotion{% endif %}-label">
                                                <span>
                                                    {% if product.promotional_offer %}
                                                        {% if product.promotional_offer.script.is_percentage_off %}
                                                            {{ product.promotional_offer.parameters.percent * 100 }}% OFF
                                                        {% elseif product.promotional_offer.script.is_discount_for_quantity %}
                                                            <div class="text-left">
                                                                <strong>{{ product.promotional_offer.selected_threshold.discount_decimal_percentage * 100 }}% OFF</strong>
                                                                <div class="label-small">{{ "Comprando {1} o más." | translate(product.promotional_offer.selected_threshold.quantity) }}</div>
                                                            </div>
                                                        {% elseif store.country == 'BR' %}
                                                            {{ "Leve {1} Pague {2}" | translate(product.promotional_offer.script.quantity_to_take, product.promotional_offer.script.quantity_to_pay) }}
                                                        {% else %}
                                                            {{ product.promotional_offer.script.type }}
                                                        {% endif %}
                                                    {% else %}
                                                        <span class="js-offer-percentage">{{ price_discount_percentage |round }}</span>% OFF
                                                    {% endif %}
                                                </span>
                                            </div>
                                            {% if sections.new.products | find(product.id) %}
                                                <div class="product-label product-detail-label label-secondary">
                                                    <span>{{ "Nuevo" | translate }}</span>
                                                </div>
                                            {% endif %}
                                        </div>
                                    {% if product.video_url %}
                                        </div>
                                    {% endif %}
                                    <span class="hidden" data-store="stock-product-{{ product.id }}-{% if product.has_stock %}{% if product.stock %}{{ product.stock }}{% else %}infinite{% endif %}{% else %}0{% endif %}"></span>
                                    {% if product.images_count > 0 %}
                                        <div class="js-swiper-product product-slider no-slide-effect-md swiper-container" style="visibility:hidden; height:0;">
                                            <div class="swiper-wrapper">
                                                {% for image in product.images %}
                                                    <div class="swiper-slide js-product-slide {% if store.useNativeJsLibraries() %}desktop-zoom-container{% endif %} {% if loop.first %}js-product-featured-image{% endif %} slider-slide product-slide" data-image="{{image.id}}" data-image-position="{{loop.index0}}" data-zoom-url="{{ image | product_image_url('original') }}">
                                                    
                                                    {% if store.useNativeJsLibraries() %}
                                                        <div class="js-desktop-zoom p-relative d-block" style="padding-bottom: {{ image.dimensions['height'] / image.dimensions['width'] * 100}}%;">
                                                    {% else %}
                                                        <a href="{{ image | product_image_url('original') }}" class="js-desktop-zoom cloud-zoom" rel="position: 'inside', showTitle: false, loading: '{{ 'Cargando...' | translate }}'" style="padding-bottom: {{ image.dimensions['height'] / image.dimensions['width'] * 100}}%;">
                                                    {% endif %}
                                                            <img data-sizes="auto" src="{{ image | product_image_url('small') }}" data-srcset='{{  image | product_image_url('large') }} 480w, {{  image | product_image_url('huge') }} 640w, {{  image | product_image_url('original') }} 1024w' class="js-product-slide-img js-image-open-mobile-zoom product-slider-image img-absolute img-absolute-centered lazyautosizes lazyload blur-up" {% if image.alt %}alt="{{image.alt}}"{% endif %} />
                                                        {% if store.useNativeJsLibraries() %}
                                                            <div class="js-desktop-zoom-big desktop-zoom-big product-slider-image hidden-phone" data-desktop-zoom="{{ image | product_image_url('original') }}"></div>
                                                        {% endif %}
                                                    {% if store.useNativeJsLibraries() %}
                                                        </div>
                                                    {% else %}
                                                        </a>
                                                    {% endif %}
                                                    </div>
                                                {% endfor %}
                                                {% include 'snipplets/product-video.tpl' %}
                                            </div>
                                            {% if has_multiple_slides %}
                                                <div class="js-swiper-product-pagination swiper-product-pagination swiper-pagination swiper-pagination-white visible-phone"></div>
                                            {% endif %}
                                        </div>
                                    {% endif %}
                                    <div class="visible-when-content-ready visible-phone">
                                        <a href="#" class="js-open-mobile-zoom btn-floating m-right-quarter m-top-quarter">
                                            <div class="zoom-svg-icon svg-icon-text">
                                                {% include "snipplets/svg/zoom-in.tpl" %}
                                            </div>
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <div class="hidden-phone">
                                {% include "snipplets/social-widgets.tpl" with {'mobile': false} %}
                            </div>
                        </div>
                    </div>
                </div>
                {% snipplet 'placeholders/product-detail-image-placeholder.tpl' %}
                {% if product.description is not empty %}
                    <div class="description product-description product-description-desktop visible-when-content-ready user-content clear-both hidden-phone pull-left m-top" data-store="product-description-{{ product.id }}">
                        {{ product.description }}
                    </div>
                {% endif %}
            </div>
            <div class="js-product-right-col span5" data-store="product-info-{{ product.id }}">
                <div class="product-form-container">
                    <div class="js-product-name-price-container row-fluid">
                        <div class="span12">
                            <div class="title m-top-xs full-width">
                                <h1 id="product-name" class="product-name h2 h4-xs" itemprop="name" data-store="product-name-{{ product.id }}" data-component="product.name" data-component-value="{{ product.name }}">{{ product.name }}</h1>
                            </div>
                            <div class="price-holder pull-left-xs full-width m-bottom-xs m-bottom-half" data-store="product-price-{{ product.id }}">
                                {% if product.promotional_offer.script.is_percentage_off %}
                                    <input class="js-promotional-parameter" type="hidden" value="{{product.promotional_offer.parameters.percent}}">
                                {% endif %}
                                <div class="price product-price-container m-top-half text-left-xs">
                                    <span class="price-compare">
                                        <span id="compare_price_display" class="js-compare-price-display price-compare h4 p-right-quarter" {% if not product.compare_at_price or not product.display_price %}style="display:none;"{% endif %}>
                                        {% if product.compare_at_price %}
                                            {{ product.compare_at_price | money }}
                                        {% endif %}
                                      </span>
                                    </span>
                                    <span class="price product-price js-price-display" id="price_display" {% if not product.display_price %}style="display:none;"{% endif %} data-product-price="{{ product.price }}">
                                        {% if product.display_price %}
                                            {{ product.price | money }}
                                        {% endif %}
                                    </span>
                                </div>
                                {{ component('payment-discount-price', {
                                        visibility_condition: settings.payment_discount_price,
                                        location: 'product',
                                        container_classes: "h5 line-height-initial text-accent m-top-half m-bottom-quarter",
                                        text_classes: {
                                          price: 'h4 weight-strong',
                                        }
                                    }) 
                                }}

                                {% set show_compare_price_saved_amount = not (settings.payment_discount_price and max_payment_discount.value > 0) and settings.compare_price_saved_money %}

                                {{ component('compare-price-saved-amount', {
                                        visibility_condition: show_compare_price_saved_amount,
                                        discount_percentage_wording: 'OFF',
                                        container_classes: "d-block m-top-quarter-xs m-top-half p-bottom-half",
                                        text_classes: {
                                            amount_message_container: 'd-inline-block',
                                            amount_message: 'font-small-xs',
                                        },
                                        discount_percentage_classes: 'text-accent weight-strong m-left-quarter',
                                    }) 
                                }}
                            </div>
                        </div>
                    </div>
                    <div class="product-label product-detail-label label-light js-stock-label pull-left m-top-none m-bottom-quarter m-right-quarter m-bottom-xs" {% if product.has_stock %}style="display:none;"{% endif %}>{{ "Sin stock" | translate }}</div>
                    {% if product.free_shipping %}
                        <div class="product-label product-detail-label label-light pull-left m-top-half m-top-none-xs m-bottom-xs m-bottom-half">
                            <span class="m-right-quarter label-shipping-icon svg-icon-text">
                                {% include "snipplets/svg/truck.tpl" %}
                            </span>
                            {{ "Envío gratis" | translate }}
                        </div>
                    {% endif %}

                    {% snipplet 'placeholders/product-detail-form-placeholder.tpl' %}

                    {% if product.promotional_offer and not product.promotional_offer.script.is_percentage_off and product.display_price %}
                    <div class="js-product-promo-container row-fluid m-bottom-half clear-both pull-left m-top-quarter" data-store="product-promotion-info">
                        {% if product.promotional_offer.script.is_discount_for_quantity %}
                            {% for threshold in product.promotional_offer.parameters %}
                                <div class="h6 promo-title text-accent"><strong>{{ "¡{1}% OFF comprando {2} o más!" | translate(threshold.discount_decimal_percentage * 100, threshold.quantity) }}</strong></div>
                            {% endfor %}
                        {% else %}
                            <div class="h6 promo-title text-accent"><strong>{{ "¡Llevá {1} y pagá {2}!" | translate(product.promotional_offer.script.quantity_to_take, product.promotional_offer.script.quantity_to_pay) }}</strong></div>
                        {% endif %}
                        {% if product.promotional_offer.scope_type == 'categories' %}
                            <p class="promo-message font-small m-top-quarter">{{ "Válido para" | translate }} {{ "este producto y todos los de la categoría" | translate }}:
                            {% for scope_value in product.promotional_offer.scope_value_info %}
                               {{ scope_value.name }}{% if not loop.last %}, {% else %}.{% endif %}
                            {% endfor %}</br>{{ "Podés combinar esta promoción con otros productos de la misma categoría." | translate }}</p>
                        {% elseif product.promotional_offer.scope_type == 'all'  %}
                            <p class="promo-message font-small m-top-quarter">{{ "Vas a poder aprovechar esta promoción en cualquier producto de la tienda." | translate }}</p>
                        {% endif %}
                    </div>
                    {% endif %}

                    <form id="product_form" class="js-product-form display-when-content-ready product-form clear-both" method="post" action="{{ store.cart_url }}" data-store="product-form-{{ product.id }}">

                        {% set hasDiscount = product.maxPaymentDiscount.value > 0 %}

                        {% if product.show_installments and product.display_price %}
                            
                            {% set installments_info = product.installments_info_from_any_variant %}
                            {% if installments_info or hasDiscount %}
                                <div class="p-relative m-bottom pull-left full-width">
                                    <a href="#installments-modal" data-toggle="modal" data-modal-url="modal-fullscreen-payments" class="js-fullscreen-modal-open js-product-payments-container visible-when-content-ready link-module product-payment-link" {% if not (product.get_max_installments and product.get_max_installments(false)) %}style="display: none;"{% endif %}>
                                        {% set has_payment_logos = settings.payments %}
                                        {% if settings.product_detail_installments %}

                                            {% set max_installments_without_interests = product.get_max_installments(false) %}
                                            {% set installments_without_interests = max_installments_without_interests and max_installments_without_interests.installment > 1 %}
                                            {% set card_icon_color = installments_without_interests ? 'svg-icon-accent' : 'svg-icon-text' %}
                                            <div class="m-bottom-half {% if installments_without_interests %}label-line label-featured d-inline-block{% endif %}">
                                                {% if not has_payment_logos %}
                                                    {% include "snipplets/svg/credit-card-regular.tpl" with {fa_custom_class: "js-installments-credit-card-icon svg-inline--fa payment-credit-icon pull-left opacity-80 m-right-quarter " ~ card_icon_color} %}
                                                {% endif %}
                                                {{ component('installments', {'location': 'product_detail', container_classes: { installment: "installments text-uppercase d-inline-block"}}) }}
                                            </div>
                                        {% endif %}

                                        {% if has_payment_logos %}
                                            <div class="m-left-none m-bottom-quarter">
                                                <ul class="list-style-none p-none-left">
                                                    {% for payment in settings.payments %}
                                                        {# Payment methods flags #}
                                                        {% if store.country == 'BR' %}
                                                            {% if payment in ['visa', 'mastercard'] %}
                                                                <li class="d-inline-block">
                                                                    <span class="js-product-detail-payment-logo">
                                                                        <img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ payment | payment_new_logo }}" class="lazyload product-payment-logos-img card-img" />
                                                                    </span>
                                                                </li>
                                                            {% endif %}
                                                        {% else %}
                                                            {% if payment in ['visa', 'amex', 'mastercard'] %}
                                                                <li class="d-inline-block">
                                                                    <span class="js-product-detail-payment-logo">
                                                                        <img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ payment | payment_new_logo }}" class="lazyload product-payment-logos-img card-img" />
                                                                    </span>
                                                                </li>
                                                            {% endif %}
                                                        {% endif %}
                                                    {% endfor %}
                                                    <li class="d-inline-block">
                                                        <span class="js-product-detail-payment-logo svg-icon-text p-relative pull-left opacity-80">
                                                            {% include "snipplets/svg/credit-card-installments-regular.tpl" %}
                                                            {% include "snipplets/svg/plus-solid.tpl" %}
                                                        </span>
                                                    </li>
                                                </ul>
                                            </div>
                                        {% endif %}
                                        {# Max Payment Discount #}
                                        {% if hasDiscount %}
                                            <div class="span12 m-left-none m-bottom-half p-right-double">
                                                <span class="text-tertiary"><strong>{{ product.maxPaymentDiscount.value }}% {{'de descuento' | translate }}</strong> {{'pagando con' | translate }} {{ product.maxPaymentDiscount.paymentProviderName }}</span>
                                            </div>
                                        {% endif %}

                                        {% if product.show_installments and product.display_price %}
                                            {# Desktop installments link #}
                                            <div id="btn-installments" class="btn-link pull-left clear-both {% if store.installments_on_steroids_enabled %} js-open-installments-modal-desktop {% endif %}" {% if not (product.get_max_installments and product.get_max_installments(false)) %}style="display: none;"{% endif %}>
                                                {% set store_set_for_new_installments_view = store.is_set_for_new_installments_view %}
                                                {% if store_set_for_new_installments_view %}
                                                    {{ "Ver medios de pago" | translate }}
                                                {% else %}
                                                    {{ "Ver el detalle de las cuotas" | translate }}
                                                {% endif %}
                                            </div>
                                            <div class="visible-phone link-module-icon link-module-icon-right">
                                                {% include "snipplets/svg/angle-right-regular.tpl" with {fa_custom_class: "svg-inline--fa fa-2x"} %}
                                            </div>
                                        {% endif %}
                                    </a>
                                </div>
                            {% endif %}
                        {% endif %}
                        

                        {# Product availability #}

                        {% set has_product_available = product.available and product.display_price %}

                        {# Free shipping minimum message #}

                        {% set has_free_shipping = cart.free_shipping.cart_has_free_shipping or cart.free_shipping.min_price_free_shipping.min_price %}
                        {% set has_product_free_shipping = product.free_shipping %}

                        {% if not product.is_non_shippable and has_product_available and has_free_shipping and not has_product_free_shipping %}
                            <div class="free-shipping-message m-top m-bottom p-bottom-quarter">
                                {% include "snipplets/svg/truck-regular.tpl" with {fa_custom_class: "svg-inline--fa fa-lg m-right-quarter svg-icon-accent"} %}
                                <span>
                                    <strong class="text-accent">{{ "Envío gratis" | translate }}</strong>
                                    <span {% if has_product_free_shipping %}style="display: none;"{% else %}class="js-shipping-minimum-label"{% endif %}>
                                        {{ "superando los" | translate }} <span>{{ cart.free_shipping.min_price_free_shipping.min_price }}
                                    </span>
                                </span>
                            </div>
                        {% endif %}

                        <input type="hidden" name="add_to_cart" value="{{product.id}}" />
                        {% if product.variations %}
                            <div class="js-product-variants row-fluid">
                                {% include "snipplets/variants.tpl" with {'quickshop': false, 'show_size_guide': true} %}
                            </div>
                        {% endif %}
                        {% if product.available and product.display_price %}
                            <div class="js-product-quantity-container row-fluid quantity-container {% if settings.shipping_calculator_product_page and not product.free_shipping %}border-bottom-none-xs m-bottom-none{% endif %}">
                                <div class="quantity span3" data-component="product.adding-amount">
                                    <label for="quantity" class="quantity-label">
                                        {{ "Cantidad" | translate }}
                                    </label>
                                    <input id="quantity" class="js-product-quantity js-quantity-input spinner quantity-input" value="1" type="number" name="quantity{{ item.id }}" value="{{ item.quantity }}" pattern="\d*" data-component="adding-amount.value"/>
                                    {% if settings.product_stock %}
                                        <div class="font-small m-bottom-half pull-right-xs m-top-half-xs m-right-half">
                                            <span class="js-product-stock">{{ product.selected_or_first_available_variant.stock }}</span> {{ "en stock" | translate }}
                                        </div>
                                    {% endif %}
                                </div>
                                {% if settings.last_product %}
                                    <div class="{% if product.variations %}js-last-product {% endif %}span9 pull-left-xs"{% if product.selected_or_first_available_variant.stock != 1 %} style="display: none;"{% endif %}>
                                        <div class="product-detail-text text-primary weight-strong">
                                            {{ settings.last_product_text }}
                                        </div>
                                    </div>
                                    {% if settings.latest_products_available %}
                                        {% set latest_products_limit = settings.latest_products_available %}
                                        <div class="{% if product.variations %}js-latest-products-available {% endif %}span9 pull-left-xs" data-limit="{{ latest_products_limit }}" {% if product.selected_or_first_available_variant.stock > latest_products_limit or product.selected_or_first_available_variant.stock == null or product.selected_or_first_available_variant.stock == 1 %} style="display: none;"{% endif %}>
                                            <div class="product-detail-text text-primary weight-strong">
                                                {{ "¡Solo quedan" | translate }} <span class="js-product-stock">{{ product.selected_or_first_available_variant.stock }}</span> {{ "en stock!" | translate }}
                                            </div>
                                        </div>
                                    {% endif %}
                                {% endif %}
                            </div>
                        {% endif %}

                        {# Ghost button placeholder to maintain position of elements when CTA is fixed #}
                        <div class="js-product-buy-placeholder hidden hidden-phone">
                        </div>
                        <div class="js-product-buy-container product-buy-fixed">
                            <div class="row-fluid">
                                <div class="product-buy-container span12">
                                    <div class="product-fixed-info pull-left">
                                        <span class="product-name-fixed h5 row-fluid pull-left">{{ product.name }}</span>
                                        <span class="price product-price product-price-fixed h2 js-price-display row-fluid" {% if not product.display_price %}style="display:none;"{% endif %}>
                                            {% if product.display_price %}
                                                {{ product.price | money }}
                                            {% endif %}
                                        </span>
                                    </div>
                                    {% set state = store.is_catalog ? 'catalog' : (product.available ? product.display_price ? 'cart' : 'contact' : 'nostock') %}
                                    {% set texts = {'cart': "Agregar al carrito", 'contact': "Consultar precio", 'nostock': "Sin stock", 'catalog': "Consultar"} %}

                                    {# Add to cart CTA #}

                                    <input type="submit" class="product-buy-btn btn btn-primary js-prod-submit-form js-addtocart span12 {{state}}" value="{{ texts[state] | translate }}" {% if state == 'nostock' %}disabled{% endif %} data-store="product-buy-button" data-component="product.add-to-cart"/>

                                    {# Fake add to cart CTA visible during add to cart event #}
                                    {% include 'snipplets/placeholders/button-placeholder.tpl' with {custom_class: "full-width"} %}

                                    {% if settings.ajax_cart %}
                                        <div class="js-added-to-cart-product-message pull-left full-width m-bottom-half m-top-half" style="display: none;">
                                            {{'Ya agregaste este producto.' | translate }}
                                            <a href="#" class="js-toggle-cart js-fullscreen-modal-open btn btn-link p-left-quarter p-bottom-none p-top-none" data-modal-url="modal-fullscreen-cart">{{ 'Ver carrito' | translate }}</a>
                                        </div>
                                    {% endif %}
                                </div>
                            </div>
                        </div>

                        {# Free shipping visibility message #}

                        {% set free_shipping_minimum_label_changes_visibility = has_free_shipping and cart.free_shipping.min_price_free_shipping.min_price_raw > 0 %}

                        {% set include_product_free_shipping_min_wording = cart.free_shipping.min_price_free_shipping.min_price_raw > 0 %}

                        {% if not product.is_non_shippable and has_product_available and has_free_shipping and not has_product_free_shipping %}

                            {# Free shipping add to cart message #}

                            {% if include_product_free_shipping_min_wording %}

                                {% include "snipplets/shipping/shipping-free-rest.tpl" with {'product_detail': true} %}

                            {% endif %}

                            {# Free shipping achieved message #}

                            <div class="{% if free_shipping_minimum_label_changes_visibility %}js-free-shipping-message{% endif %} m-top text-accent weight-strong" {% if not cart.free_shipping.cart_has_free_shipping %}style="display: none;"{% endif %}>
                                {{ "¡Genial! Tenés envío gratis" | translate }}
                            </div>

                        {% endif %}

                        {# Define contitions to show shipping calculator and store branches on product page #}

                        {% set show_product_fulfillment = settings.shipping_calculator_product_page and (store.has_shipping or store.branches) and not product.free_shipping and not product.is_non_shippable %}

                        {% if show_product_fulfillment %}

                            {% set store_has_pickup_and_shipping = store.has_shipping and store.branches %}

                            <div id="product-shipping-container" class="js-product-shipping-container row-fluid m-top p-top-half" {% if not product.display_price or not product.has_stock %}style="display:none;"{% endif %} data-shipping-url="{{ store.shipping_calculator_url }}">

                                {# Shipping Calculator #}

                                {% if store.has_shipping %}
                                    <div class="row-fluid {% if store_has_pickup_and_shipping %}m-bottom-half p-bottom-quarter{% endif %}">
                                        {% include "snipplets/shipping/shipping_cost_calculator.tpl" with { 'shipping_calculator_variant' : product.selected_or_first_available_variant, 'product_detail': true} %}
                                    </div>
                                {% endif %}

                                {# Store branches #}

                                {% if store.branches %}
                                    {# Link for branches modal #}
                                    {% include "snipplets/shipping/branch-details.tpl" with {'product_detail': true} %}
                                {% endif %}
                            </div>
                        {% endif %}
                        
                        {# Product informative banners #}

                        {% include 'snipplets/product-informative-banner.tpl' %}
                    </form>
                    {% include "snipplets/social-widgets.tpl" with {'mobile': true} %}
                    {% if product.description is not empty %}
                        <div class="description product-description product-description-mobile visible-when-content-ready user-content clear-both visible-phone" data-store="product-description-{{ product.id }}">
                            {{ product.description }}
                        </div>
                    {% endif %}
                </div>
            </div>
            {% if settings.show_product_fb_comment_box %}
                <div class="row-fluid fb-com-cont js-facebook-comments clear-both">
                    <div class="fb-comments" data-href="{{ product.social_url }}" data-num-posts="5" data-width="100%"></div>
                </div>
            {% endif %}
        </div>
    </div>
</div>
{% include 'snipplets/related-products.tpl' %}

{# Payments details #}

{% include 'snipplets/product-payment-details.tpl' %}

<div class="js-mobile-zoom-panel mobile-zoom-panel">
    {% include "snipplets/svg/sync-alt-regular.tpl" with {fa_custom_class: "js-mobile-zoom-spinner svg-inline--fa fa-2x  mobile-zoom-spinner fa-spin svg-icon-text"} %}
    <div class="js-mobile-zoomed-image mobile-zoom-image-container">
       {# Container to be filled with the zoomable image #}
    </div>
    <a class="js-close-mobile-zoom btn-floating m-right m-top">
        {% include "snipplets/svg/times.tpl" with {fa_custom_class: "svg-inline--fa"} %}
    </a>
</div>

{# Product video modal on mobile #}

{% include 'snipplets/product-video.tpl' with {product_video_modal: true} %}
