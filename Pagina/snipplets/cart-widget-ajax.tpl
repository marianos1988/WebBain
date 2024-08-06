<div id="ajax-cart" class="cart-summary" data-component="cart-button">
    {% include "snipplets/svg/shopping-cart-regular.tpl" with {fa_custom_class: "svg-inline--fa cart-summary-icon"} %}
    <a href="#" class="js-toggle-cart" aria-label="{{ "Carrito" | translate }}">
    <span>{{ "Carrito" | translate }}</span>
    (<span class="js-cart-widget-amount">{{ "{1}" | translate(cart.items_count ) }}</span>) 
    <span class="js-cart-widget-total">{{ cart.total | money }}</span></a>
</div>
