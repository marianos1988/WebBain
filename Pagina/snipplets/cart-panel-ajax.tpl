<form action="{{ store.cart_url }}" method="post" id="ajax-cart-details" class="js-ajax-cart-panel js-fullscreen-modal ajax-cart-container modal-right modal-xs modal-xs-right modal-xs-right-out" style="display: none;" data-store="cart-form" data-component = "cart">
	{# Define contitions to show shipping calculator and store branches on cart #}

	{% set show_calculator_on_cart = settings.shipping_calculator_cart_page and store.has_shipping %}
	{% set show_cart_fulfillment = settings.shipping_calculator_cart_page and (store.has_shipping or store.branches) %}
	
	<div class="modal-xs-dialog">
		<div id="store-curr" class="hidden">{{ cart.currency }}</div>
		 {# IMPORTANT Do not remove this hidden subtotal, it is used by JS to calculate cart total #}
		<div class="subtotal-price hidden" data-priceraw="{{ cart.total }}"></div>
		
		{# Cart panel header #}
		<div class="modal-right-header hidden-phone row-fluid">
			<div class="span8">
				<h4 class="text-uppercase">{{ "Carrito de compras" | translate }}</h4>
			</div>
			<div class="span4">
				<a href="#" class="js-toggle-cart btn-floating pull-right m-top-quarter m-right-half">{% include "snipplets/svg/times.tpl" with {fa_custom_class: "svg-inline--fa"} %}</a>
			</div>
		</div>
		<a class="js-toggle-cart js-fullscreen-modal-close visible-phone modal-xs-header" href="#">
			{% include "snipplets/svg/angle-left.tpl" with {fa_custom_class: "svg-inline--fa fa-2x modal-xs-header-icon modal-xs-right-header-icon"} %}
			<span class="modal-xs-header-text modal-xs-right-header-text h5">
	            {{ "Carrito de compras" | translate }}
	        </span>
		</a>

		<div class="modal-content">

			{# Cart panel body #}
			<div class="ajax-cart-body modal-right-body modal-xs-body">
				<div class="ajax-cart-table-header hidden-phone m-top">
					<div class="pull-left">
						<p>{{ "Producto" | translate }}</p>
					</div>
					<div class="text-right pull-right cart-subtotal-header">
						<p>{{ "Subtotal" | translate }}</p>
					</div>
				</div>

				{# Cart panel items #}
				<div class="js-ajax-cart-list ajax-cart-table pull-left">
					{% if cart.items %}
						{% for item in cart.items %}
							{% include "snipplets/cart-item-ajax.tpl" %}
						{% endfor %}
					{% endif %}
				</div>

				{# Cart panel empty #}
				<div class="emptyCart js-empty-ajax-cart text-center alert clear-both" data-component="cart.empty-message" {% if cart.items_count > 0 %}style="display:none;" {% endif %} >
	                {{ "El carrito de compras está vacío." | translate }}
				</div>

				{# Check if store has free shipping without regions or categories #}

				{% set has_free_shipping = cart.free_shipping.cart_has_free_shipping or cart.free_shipping.min_price_free_shipping.min_price %}

				{% if has_free_shipping and cart.free_shipping.min_price_free_shipping.min_price_raw > 0 %}
				  
			  		{# includes free shipping progress bar: only if store has free shipping with a minimum #}
				  
			  		{% include "snipplets/shipping/shipping-free-rest.tpl" %}
				{% endif %}

				{# Cart panel subtotal #}

				<div class="ajax-cart-total h4 ajax-cart-subtotal cart-subtotal js-visible-on-cart-filled row-fluid pull-left m-bottom-none" {% if cart.items_count == 0 %}style="display:none;"{% endif %} data-store="cart-subtotal">
					<span class="pull-left text-left">
			  			{{ "Subtotal" | translate }}
						<small class="js-subtotal-shipping-wording" {% if not (cart.has_shippable_products or show_calculator_on_cart) %}style="display: none"{% endif %}>{{ " (sin envío)" | translate }}</small>
						:
					</span>
					<span class="js-ajax-cart-total js-cart-subtotal pull-right text-right weight-strong" data-priceraw="{{ cart.subtotal }}" data-component="cart.subtotal" data-component-value="{{ cart.subtotal }}">{{ cart.subtotal | money }}</span>
				</div>
				
				{# Cart panel promos #}

				<div class="js-total-promotions ajax-cart-promotions text-right clear-both h6 m-bottom-half">
					<span class="js-promo-in" style="display:none;">{{ "en" | translate }}</span>
					<span class="js-promo-all" style="display:none;">{{ "todos los productos" | translate }}</span>
					<span class="js-promo-buying" style="display:none;"> {{ "comprando" | translate }}</span>
	                <span class="js-promo-units-or-more" style="display:none;"> {{ "o más." | translate }}</span>
	                {% for promotion in cart.promotional_discount.promotions_applied %}
	                    {% if(promotion.scope_value_id) %}
	                        {% set id = promotion.scope_value_id %}
	                    {% else %}
	                        {% set id = 'all' %}
	                    {% endif %}
						<span class="js-total-promotions-detail-row total-promotions-row pull-left text-left row-fluid m-bottom-half" id="{{ id }}">
			          	<span class="pull-left cart-promotion-detail">
							{% if promotion.discount_script_type != "custom" %}
								{% if promotion.discount_script_type == "NAtX%off" %}
									{{ promotion.selected_threshold.discount_decimal_percentage * 100 }}% OFF
								{% else %}
									{{ promotion.discount_script_type }}
								{% endif %}

								{{ "en" | translate }}
									{% if id == 'all' %}
										{{ "todos los productos" | translate }}
									{% else %}
										{{ promotion.scope_value_name }}
									{% endif %}

								{% if promotion.discount_script_type == "NAtX%off" %}
									<span class="text-lowercase">{{ "Comprando {1} o más." | translate(promotion.selected_threshold.quantity) }}</span>
								{% endif %}
							{% else %}
								{{ promotion.scope_value_name }}
							{% endif %}
	                        :
			          	</span>
			          	<span class="cart-promotion-number weight-strong text-accent pull-right text-right">-{{ promotion.total_discount_amount_short }}</span></span>
			      	{% endfor %}
				</div>

	            {% if show_cart_fulfillment %}

			        <div class="js-fulfillment-info js-allows-non-shippable" {% if not cart.has_shippable_products %}style="display: none"{% endif %}>

	                	{% set store_has_pickup_and_shipping = store.has_shipping and store.branches %}

						<div class="js-visible-on-cart-filled js-has-new-shipping js-shipping-calculator-container clear-both">

			                {# Saved shipping not available #}

			                <div class="js-shipping-method-unavailable alert alert-warning clear-both m-top-half pull-left" style="display: none;">
			                	<div>
			                		<strong>{{ 'El medio de envío que habías elegido ya no se encuentra disponible para este carrito. ' | translate }}</strong>
			                	</div>
			                	<div>
			                		{{ '¡No te preocupes! Podés elegir otro.' | translate}}
			                	</div>
			                </div>

			                {# Shipping calculator and branch link #}

			                <div id="cart-shipping-container" class="shipping-calcuator-container row-fluid m-bottom-half ajax-cart-shipping-calculator" {% if cart.items_count == 0 %} style="display: none;"{% endif %} data-shipping-url="{{ store.shipping_calculator_url }}">

			                	{# Used to save shipping #}

			                	<span id="cart-selected-shipping-method" data-code="{{ cart.shipping_data.code }}" class="hide">{{ cart.shipping_data.name }}</span>

			                	{# Shipping Calculator #}

			                	{% if store.has_shipping %}

			                		<div class="row-fluid {% if store_has_pickup_and_shipping %}m-bottom-half p-bottom-quarter{% endif %}">
			                        	{% include "snipplets/shipping/shipping_cost_calculator.tpl" with { 'product_detail': false, 'ajax_cart' : true} %}
			                        </div>
		                        {% endif %}

		                        {# Store branches #}

		                        {% if store.branches %}
	                                {# Link for branches modal #}
	                                {% include "snipplets/shipping/branch-details.tpl" with {'product_detail': false} %}
	                            {% endif %}
		                    </div>
			            </div>
		        	</div>

	            {% endif %}	            
				{# Cart panel total #}
				<div class="js-cart-total-container ajax-cart-total-container cart-total h2 js-visible-on-cart-filled pull-left row-fluid" {% if cart.items_count == 0 %}style="display:none;"{% endif %} data-store="cart-total" >
					<span class="pull-left text-left font-normal">{{ "Total" | translate }}:</span>
					<span class="js-cart-total {% if cart.free_shipping.cart_has_free_shipping %}js-free-shipping-achieved{% endif %} {% if cart.shipping_data.selected %}js-cart-saved-shipping{% endif %} pull-right text-right" data-component="cart.total" data-component-value="{{ cart.total }}">{{ cart.total | money }}</span>
				 	{# IMPORTANT Do not remove this hidden total, it is used by JS to calculate cart total #}
	                <div class='total-price hidden'>
	                    {{ "Total" | translate }}: {{ cart.total | money }}
	                </div>

                    {# Cart payment discount price #}

                    {{ component('payment-discount-price', {
                    		visibility_condition: settings.payment_discount_price,
                            location: 'cart',
                            container_classes: "font-body text-accent clear-both pull-right m-top-quarter",
                        }) 
                    }}
                    {% if not settings.payment_discount_price %}

			        	{# Cart installments #}
  
						{{ component('installments', {'location': 'cart', container_classes: { installment: "font-small m-top-quarter clear-both pull-right"}}) }}

					{% endif %}
				</div>

				<div class="full-width pull-left ajax-cart-bottom m-top m-bottom js-visible-on-cart-filled" {% if cart.items_count == 0 %}style="display:none;"{% endif %}>
					<div id="error-ajax-stock" class='alert alert-warning' style="display: none;">
	                    {{ "¡Uy! No tenemos más stock de este producto para agregarlo al carrito. Si querés podés" | translate }}
	                    <a href="{{ store.products_url }}" class="btn btn-link p-none">{{ "ver otros acá" | translate }}</a>
		            </div>

					{# Cart panel continue buying #}
		            {% if settings.continue_buying %}
						<div class="m-top-half m-bottom-half text-left pull-left hidden-phone">
							<a href="#" class="js-toggle-cart js-fullscreen-modal-close btn-link p-none-left p-right-none">{{ 'Ver más productos' | translate }}</a>
						</div>
	                {% endif %}

					{# Cart panel CTA #}
	                {% set cart_total = (settings.cart_minimum_value * 100) %}
					<div class="js-ajax-cart-submit pull-right full-width-xs" {{ not cart.checkout_enabled ? 'style="display:none"' }} id="ajax-cart-submit-div">
						<input class="pull-right full-width-xs btn btn-primary" type="submit" name="go_to_checkout" data-component="cart.checkout-button" value="{{ 'Iniciar Compra' | translate }}"/>
					</div>

					{# Cart panel continue buying mobile #}
					{% if settings.continue_buying %}
						<div class="m-top m-bottom-half pull-left text-center full-width visible-phone text-uppercase">
							<a href="#" class="js-toggle-cart js-fullscreen-modal-close btn-link m-bottom">{{ 'Ver más productos' | translate }}</a>
						</div>
	                {% endif %}

					<div class="js-ajax-cart-minimum clear-both p-top-half" {{ cart.checkout_enabled ? 'style="display:none"' }} id="ajax-cart-minumum-div">
						<div class="alert alert-warning" role="alert">
							<h4 class="text-center">{{ "El monto mínimo de compra es de {1} sin incluir el costo de envío" | t(cart_total | money) }}</h4>
						</div>
					</div>
					<input type="hidden" id="ajax-cart-minimum-value" value="{{ cart_total }}"/>
				</div>
			</div>
		</div>
	</div>
</form>

<div id="ajax-cart-backdrop" class="js-toggle-cart js-ajax-backdrop backdrop" style="display: none;"></div>
