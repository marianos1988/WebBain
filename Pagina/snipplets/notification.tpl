{# Cookie validation #}

{% if show_cookie_banner and not params.preview %}
    <div class="js-notification js-notification-cookie-banner notification notification-fixed-bottom notification-foreground" style="display: none;">
        <div class="container">
            <div class="d-inline d-block-xs m-bottom-half p-bottom-quarter font-body">{{ 'Al navegar por este sitio <strong>aceptás el uso de cookies</strong> para agilizar tu experiencia de compra.' | translate }}</div>
            <div class="d-inline d-block-xs text-center m-bottom-half m-left m-none-xs">
                <a href="#" class="js-notification-close js-acknowledge-cookies btn btn-primary btn-small notification-btn" data-amplitude-event-name="cookie_banner_acknowledge_click">{{ "Entendido" | translate }}</a>
            </div>
        </div>
    </div>
{% endif %}

{# Quick login notification #}

{% if store.country != 'AR' and show_quick_login %}
    <div class="js-notification js-notification-quick-login notification notification-fixed-bottom notification-foreground" style="display: none;">
        <div class="container">
            <div class="font-small m-bottom-half m-right-half">{{ '<strong>¡Comprá más rápido</strong> y seguí tus pedidos!' | translate }}</div>
            <a href="#quick-login" data-toggle="modal" class="js-trigger-modal-zindex-top btn btn-primary btn-small btn-smallest m-bottom-quarter">{{ "Iniciá sesión" | translate }}</a>
            <a class="js-notification-close js-dismiss-quicklogin notification-close" href="#">
                {% include "snipplets/svg/times.tpl" with {fa_custom_class: "svg-inline--fa svg-icon-back h5"} %}
            </a>
        </div>
    </div>
{% endif %}

{# Success notification for quick login (all countries) #}

{% if show_quick_login and customer and just_logged_in  %}

    {% set customer_short_name = customer.name|split(' ')|slice(0, 1)|join %} 
    <div class="js-notification js-quick-login-success notification notification-foreground notification-centered font-body fade-in-vertical">
        <div class="m-right">
            {% include "snipplets/svg/user-regular.tpl" with {fa_custom_class: "svg-inline--fa svg-icon-back m-right-quarter"} %}
            {{ '<strong>¡Hola, {1}!</strong> Ya podés seguir con tu compra' | translate(customer_short_name) }}
        </div>
        <a class="js-notification-close pull-right notification-close" href="#">
            {% include "snipplets/svg/times.tpl" with {fa_custom_class: "svg-inline--fa svg-icon-back h5"} %}
        </a>
    </div>
{% endif %}

{# Order notification #}

{% if order_notification and status_page_url %}
    <div data-url="{{ status_page_url }}" class="js-notification js-notification-status-page notification notification-secondary" style="display:none;">
        <div class="container">
            <a href="{{ status_page_url }}"><strong class="text-primary">{{ "Seguí acá" | translate }}</strong> {{ "tu última compra" | translate }}</a>
            <a class="js-notification-close js-notification-status-page-close pull-right notification-close" href="#">
                {% include "snipplets/svg/times.tpl" with {fa_custom_class: "svg-inline--fa svg-icon-nav"} %}
            </a>
        </div>
    </div>
{% endif %}

{# Add to cart notification #}

{% if add_to_cart %}
    <div class="js-alert-added-to-cart notification-floating notification-hidden" style="display: none;">
        <div class="notification notification notification-primary">
            <div class="js-cart-notification-arrow-up notification-arrow-up p-relative"></div>
            <div class="js-cart-notification-close notification-close">
                {% include "snipplets/svg/times.tpl" with {fa_custom_class: "svg-inline--fa svg-icon-text"} %}
            </div>
            <div class="js-cart-notification-item row m-bottom" data-store="cart-notification-item">
                <div class="span3 col-xs-3-custom pull-left-xs notification-img p-right-half">
                    <img src="" class="js-cart-notification-item-img img-fluid" />
                </div>
                <div class="span9 col-xs-9-custom pull-right-xs text-left p-right-double">
                    <div>
                        <span class="js-cart-notification-item-name"></span>
                        <span class="js-cart-notification-item-variant-container" style="display: none;">
                            (<span class="js-cart-notification-item-variant"></span>)
                        </span>
                    </div>
                    <div>
                        <span class="js-cart-notification-item-quantity"></span>
                        <span> x </span>
                        <span class="js-cart-notification-item-price"></span>
                    </div>
                    <strong>{{ '¡Agregado al carrito con éxito!' | translate }}</strong>
                </div>
            </div>
            <div class="h5 row m-bottom-half border-top p-top">
                <span class="pull-left text-left">
                    <strong>{{ "Total" | translate }}</strong> 
                    (<span class="js-cart-widget-amount">
                        {{ "{1}" | translate(cart.items_count ) }} 
                    </span>
                    <span class="js-cart-counts-plural" style="display: none;">
                        {{ 'productos' | translate }}):
                    </span>
                    <span class="js-cart-counts-singular" style="display: none;">
                        {{ 'producto' | translate }}):
                    </span>
                </span>
                <strong class="js-cart-total pull-right text-right">{{ cart.total | money }}</strong>
            </div>
            <a href="#" class="js-toggle-cart js-fullscreen-modal-open js-cart-notification-close btn btn-primary btn-medium full-width d-inline-block" data-modal-url="modal-fullscreen-cart">
                {{ "Ver carrito" | translate }}
            </a>
        </div>
    </div>
{% endif %}

