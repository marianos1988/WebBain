<div class="modal-with-fixed-footer">
    <div class="modal-scrollable-area">
        <div class="hamburger-panel-first-row clear-both">
            <span class="js-modal-close btn-hamburger-close p-absolute">
                {% include "snipplets/svg/times.tpl" with {fa_custom_class: "svg-inline--fa btn-hamburger-close-icon pull-right p-all-half svg-icon-text"} %}
            </span>
            <ul class="list-items" data-store="navigation" data-component="menu">
                {% snipplet "navigation/navigation-hamburger-list.tpl" %}
            </ul>
            {% if languages | length > 1 %}
                <div class="languages span12 clear pull-left p-left-quarter p-top-half p-right-double">
                    {% for language in languages %}
                        {% set class = language.active ? "" : "opacity-50" %}
                        <a href="{{ language.url }}" class="{{ class }} pull-left p-all-half border-top-none-xs border-bottom-none-xs"><img class="lazyload" src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ language.country | flag_url }}" alt="{{ language.name }}" /></a>
                    {% endfor %}
                </div>
            {% endif %}
        </div>
    </div>
    <div class="mobile-accounts" data-store="account-links">
        <ul class="clear-both p-top-half p-bottom-half">
            {% if not customer %}
                <span class="user-badge">
                    {% include "snipplets/svg/user-circle.tpl" with {fa_custom_class: "svg-inline--fa fa-lg"} %}
                </span>
                <div class="d-table m-top-half">
                    {% if 'mandatory' not in store.customer_accounts %}
                    <li class="mobile-accounts-item">{{ "Crear cuenta" | translate | a_tag(store.customer_register_url, '', 'mobile-accounts-link border-right p-none-left') }}</li>
                    {% endif %}
                    <li class="mobile-accounts-item p-relative">
                        {{ "Iniciar sesión" | translate | a_tag(store.customer_login_url, '', 'js-login mobile-accounts-link') }}
                        {% include "snipplets/tooltip-login.tpl" with {mobile: "true"} %}
                    </li>
                </div>
            {% else %}
                {% set customer_first_name_letter = customer.name| split(' ')[0]|slice(0, 1) %}
                {% set customer_last_name_letter = customer.name| split(' ')[1]|slice(0, 1) %}
                <span class="user-badge">
                    {{ customer_first_name_letter }} {{ customer_last_name_letter }}
                </span>
                <span class="d-table">
                    {% set customer_short_name = customer.name|split(' ')|slice(0, 1)|join %} 
                    <div class="weight-strong text-foreground">
                        {{ "¡Hola, {1}!" | t(customer_short_name) }}
                    </div>
                    <li class="mobile-accounts-item">{{ "Mi cuenta" | translate | a_tag(store.customer_home_url, '', 'mobile-accounts-link border-right p-none-left') }}</li>
                    <li class="mobile-accounts-item">{{ "Cerrar sesión" | translate | a_tag(store.customer_logout_url, '', 'mobile-accounts-link') }}</li>
                </span>
            {% endif %}
        </ul>
    </div>
</div>