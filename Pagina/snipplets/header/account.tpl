<div id="auth" class="user-access font-small-extra m-right-quarter align-middle hidden-phone" data-store="account-links">
    {% if not customer %}
        {% if 'mandatory' not in store.customer_accounts %}
        {{ "Crear cuenta" | translate | a_tag(store.customer_register_url, {class: 'border-right p-right-quarter'}) }}
        {% endif %}
        {{ "Iniciar sesión" | translate | a_tag(store.customer_login_url, {class: 'p-left-quarter'}) }}
        {% include "snipplets/tooltip-login.tpl" with {desktop: "true"} %}
    {% else %}
    	{% set customer_short_name = customer.name|split(' ')|slice(0, 1)|join %} 
    	<a href="{{ store.customer_home_url }}" class="text-primary border-right p-right-quarter m-left-half">
    		{% include "snipplets/svg/user-circle.tpl" with {fa_custom_class: "svg-inline--fa fa-lg svg-icon-primary"} %}
    		{{ "¡Hola, {1}!" | t(customer_short_name) }}
    	</a>
		{{ "Cerrar sesión" | translate | a_tag(store.customer_logout_url, {class: 'p-left-quarter'}) }}
    {% endif %}
</div>