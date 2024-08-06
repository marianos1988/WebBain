<div class="js-mobile-nav-second-row mobile-nav-second-row container-fluid theme-wide-tabs">
    <div class="mobile-nav-tabs-container visible-phone">
        {% if settings.search_fix %}
            <div class="searchbox search-fix-tab d-inline-block pull-left">
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
        {% else %}  
            <a class="js-modal-open text-uppercase mobile-nav-tab " data-toggle="#nav-hamburger" data-component="menu-button">
                <span class="mobile-nav-tab-text p-relative">
                    {{ 'Menú' | translate }}
                    {% if store.country == 'AR' and template == 'home' %}
                        <span class="js-quick-login-badge badge badge-primary badge-small badge-top" style="display: none;"></span>
                    {% endif %}
                </span>
            </a>
        {% endif %}  

        <a {% if categories %}href="#"{% else %}href="{{ store.products_url }}"{% endif %} id="mobile-categories-btn" class="mobile-nav-tab {% if categories %} js-toggle-mobile-categories {% endif %} {% if store.is_catalog %} mobile-nav-tab-half {% endif %} {% if template == 'category' or template == 'product' %} selected js-current-page {% endif %}">
            <span class="mobile-nav-tab-text">{{ 'Productos' | translate }} {% include "snipplets/svg/angle-down-regular.tpl" with {fa_custom_class: "svg-inline--fa d-inline-block m-left-quarter"} %}</span>
        </a>     
    </div>
</div>

{# Categories list for mobile #}
<div class="js-categories-mobile-container" style="display:none;">
    <ul class="modal-xs mobile-nav-categories-container">
        <li> 
            <a class="js-toggle-mobile-categories btn-floating pull-right p-relative m-all-half">{% include "snipplets/svg/times.tpl" with {fa_custom_class: "svg-inline--fa"} %}</a>
        </li>
        <li>
            <a class="modal-xs-list-item darker"  href="{{ store.products_url }}">
                {{ 'Ver todos los productos' | translate }}
            </a>
        </li>
        {% snipplet "navigation/navigation-mobile-categories.tpl" %}
    </ul>
    {% for category in categories %}
        {% snipplet "navigation/navigation-mobile-categories-panels.tpl" %}
    {% endfor %}
</div>