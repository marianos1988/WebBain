<div class="js-mobile-nav js-search-container mobile-nav row-fluid" data-store="head-mobile">
    <div class="js-mobile-first-row mobile-nav-first-row">      
        <div class="js-modal-open js-toggle-hamburger-panel btn-hamburger text-center visible-phone pull-left" data-toggle="#nav-hamburger" data-component="menu-button">
            <div class="mobile-nav-first-row-icon p-relative svg-icon-text">
                {% include "snipplets/svg/hamburger.tpl" %}
                {% if store.country == 'AR' and template == 'home' %}
                    <span class="js-quick-login-badge badge badge-primary badge-small" style="display: none;"></span>
                {% endif %}
            </div>
        </div>
        <div class="mobile-nav-title h6">
            {% snipplet "mobile-page-title.tpl" %}
        </div>
        <div class="js-toggle-mobile-search js-toggle-mobile-search-open mobile-nav_search-btn mobile-search-btn visible-phone text-center pull-right">
            <div class="mobile-nav-first-row-icon svg-icon-text pull-right">
                {% include "snipplets/svg/search.tpl" %}
            </div>
        </div>
    </div>
    <div class="js-mobile-search-row mobile-nav-search-row row-fluid">
        <form action="{{ store.search_url }}" method="get" class="js-search-form mobile-search-form">
            <div class="input-prepend mobile-search-input-container row-fluid">
                <span class="js-search-back-btn js-toggle-mobile-search mobile-search-input-back">
                    {% include "snipplets/svg/angle-left.tpl" with {fa_custom_class: "svg-inline--fa fa-lg svg-icon-text"} %}
                </span>
                <input class="h6 js-mobile-search-input js-search-input mobile-search-input text-input" autocomplete="off" type="search" name="q" placeholder="{{ 'Buscar' | translate }}" aria-label="{{ 'Buscador' | translate }}" />
                <button type="submit" class="mobile-search-input-submit" value="" aria-label="{{ 'Buscar' | translate }}">
                    {% include "snipplets/svg/search.tpl" with {fa_custom_class: "svg-inline--fa fa-w-16 m-top-quarter svg-icon-text"} %}
                </button>
            </div>
        </form>
    </div>
    <div class="js-mobile-nav-second-row mobile-nav-second-row container-fluid">
        {% snipplet "navigation/navigation-mobile-tabs.tpl" %}
    </div>
</div>
<div class="js-search-suggest search-suggest">
    {# AJAX container for search suggestions #}
</div>

{# Categories list for mobile #}
<div class="js-categories-mobile-container" style="display:none;">
    <ul class="modal-xs mobile-nav-categories-container">
        <li> 
            <a href="#" class="js-toggle-mobile-categories btn-floating pull-right p-relative m-all-half">{% include "snipplets/svg/times.tpl" with {fa_custom_class: "svg-inline--fa"} %}</a>
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
