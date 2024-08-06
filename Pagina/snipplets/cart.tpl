<div class="cart-summary">
    {% include "snipplets/svg/shopping-cart-regular.tpl" with {fa_custom_class: "svg-inline--fa cart-summary-icon"} %}
    {% if cart.items_count > 0 %}
            <a href="{{ store.cart_url }}">{{ "Carrito" | translate }} {{ "({1})" | translate(cart.items_count ) }} - {{ cart.total | money }}</a>

    {% else %}
        <span>{{ "Carrito" | translate }} (0)</span>
    {% endif %}
</div>