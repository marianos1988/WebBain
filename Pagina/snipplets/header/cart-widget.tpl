<div {% if settings.ajax_cart %}id="ajax-cart"{% endif %} class="cart-summary p-relative d-inline-block" data-component="cart-button">
    <a href="{% if settings.ajax_cart %}#{% else %}{{ store.cart_url }}{% endif %}" class="{% if settings.ajax_cart %}js-toggle-cart js-fullscreen-modal-open {% endif %}h5" data-modal-url="modal-fullscreen-cart">
    	{% include "snipplets/svg/shopping-cart-regular.tpl" with {fa_custom_class: "svg-inline--fa"} %}
    	<span class="js-cart-widget-amount badge badge-foreground font-small-extra p-quarter">{{ "{1}" | translate(cart.items_count ) }}</span>
    </a>
</div>
