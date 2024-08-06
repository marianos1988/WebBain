<div class="mobile-nav-tabs-container visible-phone">
    <a href="{{ store.url }}" class="mobile-nav-tab {% if store.is_catalog %} mobile-nav-tab-half {% endif %} {% if template == 'home' %} selected js-current-page {% endif %}">
        <span class="mobile-nav-tab-text">{{ 'Inicio' | translate }}</span>
    </a>
    <a {% if categories %}href="#"{% else %}href="{{ store.products_url }}"{% endif %} id="mobile-categories-btn" class="mobile-nav-tab {% if categories %} js-toggle-mobile-categories {% endif %} {% if store.is_catalog %} mobile-nav-tab-half {% endif %} {% if template == 'category' or template == 'product' %} selected js-current-page {% endif %}">
        <span class="mobile-nav-tab-text">{{ 'Productos' | translate }}</span>
    </a>
    {% if not store.is_catalog %}
        {% if settings.ajax_cart %}
            <a {% if template != 'cart' %}href="#"{% endif %} class="mobile-nav-tab {% if template != 'cart' %} js-toggle-cart js-fullscreen-modal-open {% else %} selected js-current-page {% endif %}" data-modal-url="modal-fullscreen-cart">
                <span class="mobile-nav-tab-text">{{ 'Carrito' | translate }}</span>
                {% if template != 'cart' %}
                    <span id="mobile-cart-amount" class="js-cart-widget-amount mobile-nav-cart-amount">{{ "{1}" | translate(cart.items_count ) }}</span>
                {% endif %}
            </a>
        {% else %}
            <div class="mobile-nav-tab {% if template == 'cart' %} selected js-current-page {% endif %}">
            {% if cart.items_count > 0 %}
            <a href="{{ store.cart_url }}">
            {% else %}
            <a href="#" class="js-trigger-empty-cart-alert">
            {% endif %}
                <span class="mobile-nav-tab-text">{{ 'Carrito' | translate }}</span>
                {% if template != 'cart' %}
                   <span id="mobile-cart-amount" class="mobile-nav-cart-amount">{{ "{1}" | translate(cart.items_count ) }}</span>
                {% endif %}
            </a>
            </div>
            <div class="js-mobile-nav-empty-cart-alert alert alert-info mobile-nav-empty-cart">{{ "El carrito de compras está vacío." | translate }}</div>
        {% endif %}
    {% endif %}
    {% include 'snipplets/notification.tpl' with {add_to_cart: true} %}
</div>
