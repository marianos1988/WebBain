{% set has_filters_available = products and has_filters_enabled and (filter_categories is not empty or product_filters is not empty) %}

{# Only remove this if you want to take away the theme onboarding advices #}
{% set show_help = not has_products %}
{% paginate by settings.category_quantity_products %}

<div class="banner-services-category hidden-phone">
    {% if settings.banner_services_category %}
        <div data-store="category-banner-services">
            {% include 'snipplets/banner-services/banner-services.tpl' %}
        </div>
    {% endif %} 
</div>

{% if (category.images is not empty) or ("banner-products.jpg" | has_custom_image) %}
    {% include 'snipplets/category-banner.tpl' %}
{% endif %}

{% if category.description %}
    <div class="container-xs m-bottom text-center">
        <div class="row-fluid">
            <div class="span8 offset2">
                <h1 class="m-bottom m-top">{{category.name}}</h1>
                <p class="m-bottom font-small-xs">{{category.description}}</p>
            </div>
        </div>
    </div>
{% endif %}

<div class="js-category-breadcrumbs row-fluid container-wide categoria container-xs m-bottom m-none-xs m-bottom-quarter-xs"> 
    <div class="span8 left"> 
        {% snipplet "breadcrumbs.tpl" %}
    </div>
    <div class="hidden-phone text-right sort-by-container">
        {% snipplet 'sort_by.tpl' %}
    </div>
</div>
<div class="js-category-controls-prev category-controls-sticky-detector"></div>
<div class="js-category-controls category-controls container-xs visible-phone visible-when-content-ready">
    <div class="text-left sort-by-container m-top-quarter">
        {% snipplet 'sort_by.tpl' %}
    </div>
    {% if has_filters_available %}
        <a href="#" class="js-toggle-mobile-filters js-fullscreen-modal-open btn btn-secondary btn-smallest mobile-filters-btn pull-right visible-phone p-relative" data-modal-url="modal-fullscreen-filters" data-component="filter-button">
            <span>{{ 'Filtrar' | translate }}</span>
            {% include "snipplets/svg/angle-right-regular.tpl" with {fa_custom_class: "svg-inline--fa fa-lg svg-icon-text m-left-half"} %}
        </a>
    {% endif %}
</div>
<div class="visible-phone">
    {% include "snipplets/filters.tpl" with {'applied_filters': true, 'filters_mobile': true} %}
</div>  
{% if not show_help %}
<div class="row-fluid container-wide container-xs container-product-grid">
    {% if has_filters_available %} 
        {% snipplet 'sidebar.tpl' %}
    {% endif %} 
    <div class="{% if has_filters_available %}span10{% else %}span12{% endif %}">
    {% if products %}
        <div class="js-product-table pull-left row-fluid m-bottom m-top-xs" data-store="category-grid-{{ category.id }}">
            {% snipplet "product_grid.tpl" %}
        </div>

        {% set show_infinite_scroll = settings.infinite_scrolling and not pages.is_last and products and pages.current == 1 %}

        {% if show_infinite_scroll %}
             <div class="clear-both m-bottom visible-when-content-ready text-center">
                <a class="js-load-more-btn btn btn-primary btn-small full-width-xs">
                    <div class="js-load-more-spinner m-left-half pull-right" style="display:none;">
                        {% include "snipplets/svg/sync-alt-regular.tpl" with {fa_custom_class: "svg-inline--fa fa-spin svg-icon-back"} %}
                    </div>
                    {{ 'Mostrar más productos' | t }}
                </a>
            </div>
        {% endif %}
        <div id="js-infinite-scroll-spinner" class="p-bottom-double text-center m-top" style="display:none">
            {% include "snipplets/svg/sync-alt-regular.tpl" with {fa_custom_class: "svg-inline--fa fa-2x fa-spin svg-icon-text"} %}
        </div>
         <div class="js-pagination-container clear-both p-top p-bottom text-center" {% if settings.infinite_scrolling %}style="display:none"{% endif %}>
            <div class='pagination'>
                {% snipplet "pagination.tpl" %}
            </div>
        </div>
    {% else %}

        <h3 class="full-width-container text-center m-top m-bottom" data-component="filter.message">
            {{(has_filters_enabled ? "No tenemos resultados para tu búsqueda. Por favor, intentá con otros filtros." : "Próximamente") | translate}}
        </h3>
    {% endif %}
    </div>
</div>
{% elseif show_help %}
    {% snipplet 'defaults/show_help_category.tpl' %}
{% endif %}
{% if has_filters_available %}
    {% snipplet 'mobile-filters.tpl' %}
{% endif %}
