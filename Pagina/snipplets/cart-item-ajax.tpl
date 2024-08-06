<div class="js-cart-item {% if item.product.is_non_shippable %}js-cart-item-non-shippable{% else %}js-cart-item-shippable{% endif %} ajax-cart-item"
	 data-item-id="{{ item.id }}" data-store="cart-item-{{ item.product.id }}" data-component="cart.line-item" data-component-value="{{ item.product.id }}">

	{% set show_free_shipping_label = item.product.free_shipping and not (cart.free_shipping.cart_has_free_shipping or cart.free_shipping.min_price_free_shipping.min_price) %}
	{% set compare_at_price = item.product.compare_at_price %}

	{# Cart item image #}
	<div class="ajax-cart-item-image-col ajax-cart-item-col">
		<img src="{{ item.featured_image | product_image_url('medium') }}" />
	</div>
	<div class="ajax-cart-item-desc-col border-box ajax-cart-item-col">

		{# Cart item name #}
		<div class="ajax-cart-item-link cart-item-name" data-component="line-item.name">
			<a class="h6-xs" href="{{ item.url }}">
				<span data-component="name.short-name">{{ item.short_name }}</span>
				<small data-component="name.short-variant-name">{{ item.short_variant_name }}</small>
			</a>
			
			{% if show_free_shipping_label %}
				<div class="m-top-none m-bottom-quarter">
					<span class="item-label product-label label-light label-small">{{ "Envío gratis" | translate }}</span>
				</div>
			{% endif %}
		</div>

		{# Cart item quantity controls #}
		<div class="pull-left m-top-quarter" data-component="line-item.quantity">
			<button type="button" class="js-cart-quantity-btn cart-quantity-btn ajax-cart-quantity-btn" onclick="LS.minusQuantity({{ item.id }}, true)">
				<div class="cart-quantity-svg-icon svg-icon-text" data-component="quantity.minus">
					{% include "snipplets/svg/minus.tpl" %}
				</div>
			</button>
			<div class="cart-quantity-input-container d-inline-block pull-left">
				{# Always place this spinner before the quantity input #}
				<span class="js-cart-input-spinner cart-item-spinner" style="display: none;">
					{% include "snipplets/svg/sync-alt-regular.tpl" with {fa_custom_class: "svg-inline--fa fa-spin svg-icon-text"} %}
				</span>
				<input type="number" name="quantity[{{ item.id }}]" pattern="\d*" data-item-id="{{ item.id }}" value="{{ item.quantity }}" class="js-cart-quantity-input cart-quantity-input" data-component="quantity.value" data-component-value="{{ item.quantity }}" />
			</div>
			<button type="button" class="js-cart-quantity-btn cart-quantity-btn ajax-cart-quantity-btn" onclick="LS.plusQuantity({{ item.id }}, true)" data-component="quantity.plus">
				<div class="cart-quantity-svg-icon svg-icon-text">
					{% include "snipplets/svg/plus.tpl" %}
				</div>
			</button>
		</div>

		{# Cart item mobile subtotal #}

		<div class="visible-phone pull-right text-right {% if not compare_at_price %}cart-item-subtotal{% endif %}" data-component="line-item.subtotal">
			{% if compare_at_price %}
				<div class="cart-compare-price-container">
					<span class="text-accent font-small weight-strong">-{{ item.product.promotional_price_percentage | round }}%</span>
					<span class="js-cart-item-subtotal-compare-price price-compare font-small opacity-50" data-line-item-id="{{ item.id }}" data-component="subtotal_compare_price.value" data-component-value='{{ item.compare_at_price_subtotal | money }}'>{{ item.compare_at_price_subtotal | money }}</span>
				</div>
			{% endif %}
			<span class="js-cart-item-subtotal {% if compare_at_price %}cart-item-subtotal{% endif %} h6-xs" data-line-item-id="{{ item.id }}" data-component="subtotal.value" data-component-value="{{item.subtotal}}">{{ item.subtotal | money }} </span>
		</div>
	</div>

	{# Cart item subtotal #}
	<div class="ajax-cart-item-subtotal ajax-cart-item-col cart-item-subtotal text-right hidden-phone" data-component="line-item.subtotal">
		{% if compare_at_price %}
      <div class="cart-compare-price-container">
        <span class="text-accent font-small weight-strong">-{{ item.product.promotional_price_percentage | round }}%</span>
        <span class="js-cart-item-subtotal-compare-price price-compare font-small opacity-50" data-line-item-id="{{ item.id }}" data-component="subtotal_compare_price.value" data-component-value='{{ item.compare_at_price_subtotal | money }}'>{{ item.compare_at_price_subtotal | money }}</span>
      </div>
    {% endif %}
		<span class="js-cart-item-subtotal" data-line-item-id="{{ item.id }}" data-component="subtotal.value" data-component-value="{{item.subtotal}}">{{ item.subtotal | money }}</span>
	</div>

	{# Cart item delete #}
	<div class="ajax-cart-item-delete-col cart-delete-container ajax-cart-item-col text-right">
		<button type="button" class="cart-btn-delete ajax-cart-btn-delete pull-right p-top-none" onclick="LS.removeItem({{ item.id }}, true)" data-component="line-item.remove">
			<div class="cart-delete-svg-icon svg-icon-text">
				{% include "snipplets/svg/trash-o.tpl" %}
			</div>
		</button>
	</div>
</div>
