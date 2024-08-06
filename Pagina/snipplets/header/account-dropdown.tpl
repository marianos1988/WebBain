<div class="d-inline-block p-relative hidden-phone">
    <div id="auth" class="user-access font-small-extra m-right-quarter hidden-phone" data-store="account-links">
        <a class="user-open svg-icon-text h4">{% include "snipplets/svg/user-regular.tpl" with {fa_custom_class: "svg-inline--fa fa-w-14"} %}</a>
        <div class="user-items">
            {% if not customer %}
                {% if 'mandatory' not in store.customer_accounts %}
                {{ "Crear cuenta" | translate | a_tag(store.customer_register_url ) }}
                {% endif %}
                {{ "Iniciar sesión" | translate | a_tag(store.customer_login_url, '', 'js-login' ) }}
            {% else %}
                {% set customer_short_name = customer.name|split(' ')|slice(0, 1)|join %} 
                <div class="text-capitalize text-background m-bottom-quarter p-right-quarter p-left-quarter">
                    {{ "¡Hola, {1}!" | t(customer_short_name) }}
                </div>
                {{ "Mi cuenta" | translate | a_tag(store.customer_home_url ) }}
                {{ "Cerrar sesión" | translate | a_tag(store.customer_logout_url ) }}
            {% endif %}
        </div>
    </div>

    {% include "snipplets/tooltip-login.tpl" with {desktop: "true"} %}
</div>