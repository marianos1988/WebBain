{% paginate by settings.category_quantity_products %}
<div class="page-content busqueda container-xs container-wide m-section-half">
	<div id="product-listing">	
        {% snipplet "breadcrumbs.tpl" %}
        {% if products %}
         <div class="row-fluid m-top-half">
            <div class="js-product-table pull-left row-fluid m-bottom" data-store="category-grid">
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
        </div>
        {% else %}
        <div class="subtitle-container m-bottom m-top-half">
            <h2 class="text-center h5-xs">{{ "No hubo resultados para tu búsqueda" | translate }}</h2>
        </div>
        {% endif %}
    </div>
</div>
