{# Check if store has free shipping without regions or categories #}

{% set has_free_shipping = cart.free_shipping.cart_has_free_shipping or cart.free_shipping.min_price_free_shipping.min_price %}

{# Free shipping visibility variables #}

{% set free_shipping_messages_visible = (product_detail and has_free_shipping) or (not product_detail and has_free_shipping and cart.free_shipping.min_price_free_shipping.min_price_raw == 0) %}

{% if product_detail %}
	{% set cart_zipcode = false %}
{% else %}
	{% set cart_zipcode = cart.shipping_zipcode %}
{% endif %}

<div class="shipping-calculator row-fluid {% if product_detail %} product-shipping-calculator {% endif %} pull-left" data-store="shipping-calculator">

	<div class="js-shipping-calculator-head shipping-calculator-head p-relative transition-soft {% if cart_zipcode %}with-zip{% else %}with-form{% endif %} {% if free_shipping_messages_visible %}with-free-shipping{% endif %}">
		<div class="js-shipping-calculator-with-zipcode {% if cart_zipcode %}js-cart-saved-zipcode transition-up-active{% endif %} transition-up row-fluid p-absolute">
			<div class="container-fluid  p-left-half m-left-quarter p-right-half m-right-quarter">
				<div class="row-flex align-items-center">
					<span class="col p-right-none">
						<span class="d-table">
							<span>{{ "Entregas para el CP:" | translate }}</span>
							<strong class="js-shipping-calculator-current-zip m-left-quarter">{{ cart_zipcode }}</strong>
						</span>
					</span>
					<div class="col-auto p-left-none">
						<a class="js-shipping-calculator-change-zipcode btn btn-secondary btn-small btn-smallest pull-right" href="#">{{ "Cambiar CP" | translate }}</a>
					</div>
				</div>
			</div>
		</div>
	    <div class="js-shipping-calculator-form shipping-calculator-form full-width transition-up p-absolute">
	    	<p class="p-bottom-quarter">
	    		{% include "snipplets/svg/truck-regular.tpl" with {fa_custom_class: "svg-inline--fa fa-lg m-right-quarter svg-icon-text"} %}
	    		<span>	
					{{ 'Medios de envío' | translate }}
				</span>
			</p>
			<input type="tel" name="zipcode" class="form-control border-box input-shipping js-shipping-input shipping-zipcode d-inline-block pull-left m-right-quarter" placeholder="{{ 'Tu código postal' | translate }}" aria-label="{{ 'Tu código postal' | translate }}" value="{{ cart_zipcode }}">
			{% if shipping_calculator_variant %}
			<input type="hidden" name="variant_id" id="shipping-variant-id" value="{{ shipping_calculator_variant.id }}">
			{% endif %}
			<button class="js-calculate-shipping btn-shipping btn btn-secondary btn-small calculate-shipping-button d-inline-block" aria-label="{{ 'Calcular envío' | translate }}">	
				<span class="js-calculate-shipping-wording">{{ "Calcular" | translate }}</span>
				<span class="js-calculating-shipping-wording" style="display: none;">{{ "Calculando" | translate }}</span>
				<span class="loading d-inline-block m-left-quarter" style="display: none;">{% include "snipplets/svg/sync-alt-regular.tpl" with {fa_custom_class: "svg-inline--fa fa-spin svg-icon-text"} %}</span>
			</button>
			{% set zipcode_help_countries = ['BR', 'AR', 'MX'] %}
			{% if store.country in zipcode_help_countries %}
				{% set zipcode_help_ar = 'https://www.correoargentino.com.ar/formularios/cpa' %}
				{% set zipcode_help_br = 'http://www.buscacep.correios.com.br/sistemas/buscacep/' %}
				{% set zipcode_help_mx = 'https://www.correosdemexico.gob.mx/SSLServicios/ConsultaCP/Descarga.aspx' %}
					<div class="m-top-half">

						{% if product_detail %}
							<a href="#quick-login" data-toggle="modal" class="js-trigger-modal-zindex-top js-product-quick-login text-primary font-small" href="#" style="display: none;">{{ '<strong>Iniciá sesión</strong> y usá tus datos de entrega' | translate }}</a>
						{% endif %}
						<a class="{% if product_detail %}js-shipping-zipcode-help{% endif %} text-primary font-small" href="{% if store.country == 'AR' %}{{ zipcode_help_ar }}{% elseif store.country == 'BR' %}{{ zipcode_help_br }}{% elseif store.country == 'MX' %}{{ zipcode_help_mx }}{% endif %}" target="_blank" {% if product_detail and not customer %}style="display: none;"{% endif %}>{{ "No sé mi código postal" | translate }}</a>
					</div>
			{% endif %}
			<div class="js-ship-calculator-error invalid-zipcode alert alert-danger m-top-quarter text-left" style="display: none;">
				
				{# Specific error message considering if store has multiple languages #}

				{% for language in languages %}
					{% if language.active %}
						{% if languages | length > 1 %}
							{% set wrong_zipcode_wording = ' para ' | translate ~ language.country_name ~ '. Podés intentar con otro o' | translate %}
						{% else %}
							{% set wrong_zipcode_wording = '. ¿Está bien escrito?' | translate %}
						{% endif %}
						{{ "No encontramos este código postal{1}" | translate(wrong_zipcode_wording) }}

						{% if languages | length > 1 %}
							<a href="#{% if product_detail %}product{% else %}cart{% endif %}-shipping-country" data-toggle="modal" class="js-trigger-modal-zindex-top btn-link">
								{{ 'cambiar tu país de entrega' | translate }}
							</a>
						{% endif %}
					{% endif %}
				{% endfor %}
			</div>
			<div class="js-ship-calculator-error js-ship-calculator-common-error alert alert-danger m-top-quarter text-left" style="display: none;">{{ "Ocurrió un error al calcular el envío. Por favor intentá de nuevo en unos segundos." | translate }}</div>
			<div class="js-ship-calculator-error js-ship-calculator-external-error alert alert-danger m-top-quarter text-left" style="display: none;">{{ "El calculo falló por un problema con el medio de envío. Por favor intentá de nuevo en unos segundos." | translate }}</div>
		</div>
	</div>
	<div class="js-shipping-calculator-spinner pull-left full-width transition-soft text-center p-relative" style="display: none;">
		<div class="spinner-big"></div>
	</div>
	<div class="js-shipping-calculator-response shipping-calculator-response clear-both m-top {% if product_detail %}list-readonly {% endif %}" style="display: none;"></div>
</div>

{# Shipping country modal #}

{% if languages | length > 1 %}

	<div id="{% if product_detail %}product{% else %}cart{% endif %}-shipping-country" class="js-modal-shipping-country js-modal-xs-centered modal modal-centered-small modal-xs modal-xs-centered hide fade modal-zindex-top modal-small" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="js-close-modal-zindex-top modal-header" data-dismiss="modal" aria-hidden="true">
			<button type="button" class="btn-floating m-right-half m-top-quarter" >
				{% include "snipplets/svg/times.tpl" with {fa_custom_class: "svg-inline--fa"} %}
			</button>
			<h3>{{ 'País de entrega' | translate }}</h3>
		</div>
		<div class="modal-content">
			<div class="modal-body">
				<div class="form-group">
					<label for="store-country">{{ 'País donde entregaremos tu compra' | t }}</label>
					<div class="select-container">
						<select id="store-country" class="js-shipping-country-select form-control full-width-xs">
							{% for language in languages %}
								<option value="{{ language.country }}" data-country-url="{{ language.url }}" {% if language.active %}selected{% endif %}>{{ language.country_name }}</option>
							{% endfor %}
						</select>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<a href="#" class="js-save-shipping-country btn btn-primary pull-right">{{ 'Aplicar' | translate }}</a>
			</div>
		</div>
	</div>
{% endif %}
