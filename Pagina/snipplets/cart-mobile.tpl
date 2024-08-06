{% include "snipplets/svg/shopping-cart-regular.tpl" with {fa_custom_class: "svg-inline--fa"} %}
{% if cart.items_count > 0 %}
    <span class="texto-carrito">{{ cart.total | money }}</span>
    <div class="cantidad">
    	{{ "{1}" | translate(cart.items_count ) }}
    </div>
{% else %}
	<span class="texto-carrito">{{ "Carrito vacío" | translate }}</span>
    <div class="cantidad">0</div>
{% endif %}
