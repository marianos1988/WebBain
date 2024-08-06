<div class="js-addtocart js-addtocart-placeholder product-buy-btn btn btn-primary btn-transition {{ custom_class }}" style="display: none;">
    <div class="d-inline-block">
        <span class="js-addtocart-text btn-transition-start transition-container active">
            {{ 'Agregar al carrito' | translate }}
        </span>
        <span class="js-addtocart-success transition-container btn-transition-success">
            {{ '¡Listo!' | translate }}
            {% include "snipplets/svg/check-double.tpl" with {fa_custom_class: "svg-inline--fa svg-icon-back m-left-quarter"} %}
        </span>
        <div class="js-addtocart-adding transition-container btn-transition-progress">
            {{ 'Agregando...' | translate }}
            {% include "snipplets/svg/shopping-cart-regular-plus.tpl" with {fa_custom_class: "svg-inline--fa svg-icon-back  m-left-quarter"} %}
        </div>
    </div>
</div>