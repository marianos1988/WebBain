<div class="js-search-container">
    <div class="js-mobile-search-row mobile-nav-search-row">
        <form action="{{ store.search_url }}" method="get" class="js-search-form">
            <div class="input-prepend mobile-search-input-container">
                <span class="js-search-back-btn js-toggle-mobile-search mobile-search-input-back">
                    {% include "snipplets/svg/angle-left.tpl" with {fa_custom_class: "svg-inline--fa fa-lg svg-icon-text"} %}
                </span>
                <input class="js-mobile-search-input js-search-input mobile-search-input" autocomplete="off" type="search" name="q" placeholder="{{ 'Buscar' | translate }}"  aria-label='{{ "Buscador" | translate }}' />
                <button type="submit" class="mobile-search-input-submit svg-icon-text" value="" aria-label="{{ 'Buscar' | translate }}">
                    {% include "snipplets/svg/search-regular.tpl" %}
                </button>
            </div>
        </form>
    </div>
</div>
<div class="js-search-suggest search-suggest">
    {# AJAX container for search suggestions #}
</div>