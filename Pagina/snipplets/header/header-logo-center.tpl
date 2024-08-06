{% if settings.ad_bar and settings.ad_text %}
    <div class="js-addbar ad-container p-bottom-quarter p-top-quarter">
        {% snipplet "header/advertising.tpl" %}
    </div>
{% endif %}

<div class="js-desktop-head-container {% if settings.head_fix %}js-head-fixed{% endif %} head-{{ theme_head_background }} head-container transition-soft" data-store="head">
    <div class="container">
        <header>    
            <div class="row-fluid search-logo-cart-container">        
                <div class="span4 col-xs-3-custom">
                    {% if settings.tab_menu and not settings.search_fix %}    
                        <div class="js-toggle-mobile-search js-toggle-mobile-search-open mobile-search-btn text-center d-inline-block m-left-half visible-phone h5">
                            <div class="svg-icon-text">
                                {% include "snipplets/svg/search-regular.tpl" %}
                            </div>
                        </div>
                    {% endif %}
                    {% if not settings.tab_menu or ( settings.tab_menu and settings.search_fix ) %} 
                    <div class="js-modal-open text-center visible-phone pull-left" data-toggle="#nav-hamburger" data-component="menu-button">
                        <div class="mobile-nav-first-row-icon p-relative svg-icon-text">
                            {% include "snipplets/svg/bars-regular.tpl" %} {{ 'Menú' | translate }}
                            {% if store.country == 'AR' and template == 'home' %}
                                <span class="js-quick-login-badge badge badge-primary badge-small badge-top m-right-half" style="display: none;"></span>
                            {% endif %}
                        </div>
                    </div>
                    {% endif %}
                    <div class="searchbox p-relative hidden-phone">
                        <form class="js-search-container js-search-form" action="{{ store.search_url }}" method="get">
                            <input class="js-search-input header-input form-control form-control-xs" autocomplete="off" type="search" name="q" placeholder="{{ 'Buscar' | translate }}"/>
                            <button type="submit" class="btn btn-desktop-search" value="{{ "Buscar" | translate }}" aria-label="{{ "Buscar" | translate }}">
                              {% include "snipplets/svg/search-regular.tpl" %}
                            </button>
                        </form>
                        <div class="js-search-suggest search-suggest">
                            {# AJAX container for search suggestions #}
                        </div>
                    </div>
                </div>
                <div class="span4 col-xs-6-custom logo-container">
                    {% set logo_size_class = settings.logo_size == 'small' ? 'logo-img-small' : settings.logo_size == 'medium' ? 'logo-img-medium' : settings.logo_size == 'big' ? 'logo-img-big' %}
                    {{ component('logos/logo', {logo_size: 'large', container_classes: { logo_img_container: "mobile-logo-home text-center-xs"}, logo_img_classes: 'transition-soft-slow ' ~ logo_size_class, logo_text_classes: 'h1'}) }}
                </div>
                <div class="span4 hidden-phone text-right">
                    {% if languages | length > 1 %}
                        {% snipplet "header/languages.tpl" %}
                    {% endif %}
                    {% if store.has_accounts %}
                        {% snipplet "header/account.tpl" %}
                    {% endif %}
                    {% if not store.is_catalog and template != 'cart' %}
                        <div class="d-inline-block">
                            {% snipplet "header/cart-widget.tpl" as "cart" %}
                        </div>
                    {% endif %}
                </div>
                <div class="mobile-cart col-xs-3-custom text-right">
                    <div class="visible-phone">
                    {% if not settings.search_fix and not settings.tab_menu %}    
                        <div class="js-toggle-mobile-search js-toggle-mobile-search-open mobile-search-btn text-center d-inline-block h5">
                            <div class="svg-icon-text">
                                {% include "snipplets/svg/search-regular.tpl" %}
                            </div>
                        </div>
                    {% endif %}
                    {% if not store.is_catalog and template != 'cart' %}
                        <div class="d-inline-block">
                            {% snipplet "header/cart-widget.tpl" as "cart" %}
                        </div>
                    {% endif %}
                    </div>
                </div>

            </div>    
            <ul class="js-desktop-nav desktop-nav hidden-phone font-small" data-store="navigation" data-component="menu">   
                {% if settings.megamenu %}
                    {% snipplet "navigation/navigation-megamenu.tpl" %}
                {% else %}
                    {% snipplet "navigation/navigation.tpl" %}
                {% endif %}
            </ul>
        </header>
        {% if settings.tab_menu %}
            <div class="js-mobile-head-second-row">
                {% snipplet "navigation/navigation-mobile-tabs-wide.tpl" %}
            </div>
        {% else %}       
            {% if settings.search_fix %}
            <div class="js-mobile-head-second-row searchbox search-fix visible-phone">
                <form class="js-search-container js-search-form" action="{{ store.search_url }}" method="get">
                    <input class="js-search-input header-input p-left-half form-control form-control-xs" autocomplete="off" type="search" name="q" placeholder="{{ 'Buscar' | translate }}" aria-label="{{ 'Buscador' | translate }}"/>
                    <button type="submit" class="btn btn-desktop-search" value="" aria-label="{{ 'Buscar' | translate }}">
                      {% include "snipplets/svg/search-regular.tpl" %}
                    </button>
                </form>
                <div class="js-search-suggest search-suggest">
                    {# AJAX container for search suggestions #}
                </div>
            </div>
            {% endif %} 
        {% endif %} 

    </div>
    {% include 'snipplets/notification.tpl' with {add_to_cart: true} %}
</div>