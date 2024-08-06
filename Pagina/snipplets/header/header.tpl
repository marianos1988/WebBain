{% if settings.ad_bar and settings.ad_text %}
    <div class="js-addbar ad-container p-bottom-quarter p-top-quarter">
        {% snipplet "header/advertising.tpl" %}
    </div>
{% endif %}
<div class="js-desktop-head-container head-box {% if settings.head_fix %}js-head-fixed{% endif %} head-container transition-soft" data-store="head-desktop">
    <div class="container">
        <header>
            <div class="row-fluid search-logo-cart-container">
                <div class="span3 hidden-phone">
                    <div class="searchbox p-relative">
                        <form class="js-search-container js-search-form" action="{{ store.search_url }}" method="get">
                            <input class="js-search-input form-control form-control-xs" autocomplete="off" type="search" name="q" placeholder="{{ 'Buscar' | translate }}" aria-label='{{ "Buscador" | translate }}' />
                            <button type="submit" class="btn btn-desktop-search" value='{{ "Buscar" | translate }}' aria-label='{{ "Buscar" | translate }}'>
                                <div class="svg-icon-text">
                                    {% include "snipplets/svg/search.tpl" %}
                                </div>
                            </button>
                        </form>
                        <div class="js-search-suggest search-suggest">
                            {# AJAX container for search suggestions #}
                        </div>
                    </div>
                </div>
                <div class="span6 logo-container">
                    {% set logo_size_class = settings.logo_size == 'small' ? 'logo-img-small' : settings.logo_size == 'medium' ? 'logo-img-medium' : settings.logo_size == 'big' ? 'logo-img-big' %}
                    {{ component('logos/logo', {logo_size: 'large', container_classes: { logo_img_container: "mobile-logo-home text-center-xs"}, logo_img_classes: 'transition-soft-slow ' ~ logo_size_class, logo_text_classes: 'h1'}) }}
                </div>
                <div class="span3 hidden-phone">
                    {% if languages | length > 1 %}
                        {% snipplet "header/languages.tpl" %}
                    {% endif %}
                    {% if not store.is_catalog and template != 'cart' %}
                        {% if settings.ajax_cart %}
                            <div class="p-relative">
                                {% snipplet "cart-widget-ajax.tpl" as "cart" %}
                            </div>
                        {% else %}
                            {% snipplet "cart.tpl" as "cart" %}
                        {% endif %}
                    {% endif %}
                    <div data-store="account-links">
                        {% if store.has_accounts %}
                            <div id="auth" class="font-small{% if customer %}-extra{% endif %} text-center text-uppercase p-relative">
                                {% if not customer %}
                                    {% if 'mandatory' not in store.customer_accounts %}
                                    {{ "Crear cuenta" | translate | a_tag(store.customer_register_url, {class: 'border-right p-right-quarter'}) }}
                                    {% endif %}
                                    {{ "Iniciar sesión" | translate | a_tag(store.customer_login_url, {class: 'p-left-quarter'}) }}

                                    {% include "snipplets/tooltip-login.tpl" with {desktop: "true"} %}
                                {% else %}
                                    {% set customer_short_name = customer.name|split(' ')|slice(0, 1)|join %} 
                                    <a href="{{ store.customer_home_url }}" class="text-primary border-right p-right-quarter m-left-half">
                                        {{ "¡Hola, {1}!" | t(customer_short_name) }}
                                    </a>
                                    {{ "Cerrar sesión" | translate | a_tag(store.customer_logout_url, {class: 'p-left-quarter'}) }}
                                {% endif %}
                            </div>
                        {% endif %}
                    </div>
                </div>
            </div>
            <ul class="js-desktop-nav desktop-nav hidden-phone m-top-half m-bottom-half" data-store="navigation" data-component="menu">
                {% if settings.megamenu %}
                    {% snipplet "navigation/navigation-megamenu.tpl" %}
                {% else %}
                    {% snipplet "navigation/navigation.tpl" %}
                {% endif %}
            </ul>
        </header>
    </div>
</div>