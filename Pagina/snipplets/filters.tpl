{% if applied_filters %}

    {# Applied filters chips #}

    {% if has_applied_filters %}
        
        <div class="visible-when-content-ready {% if filters_mobile %}container-wide container-xs full-width-container m-top m-bottom{% else %}filters-container{% endif %}">
            <h6 class="m-bottom-half font-body-xs">{{ "Aplicado:" | translate }}</h6>
            {% for product_filter in product_filters %}
                {% for value in product_filter.values %}

                    {# List applied filters as tags #}
                    
                    {% if value.selected %}
                        <button class="js-remove-filter chip" data-filter-name="{{ product_filter.key }}" data-filter-value="{{ value.name }}" data-component="filter.pill-{{ product_filter.type }}" data-component-value="{{ product_filter.key }}">
                            {{ value.pill_label }}
                            {% include "snipplets/svg/times.tpl" with {fa_custom_class: "svg-inline--fa chip-remove-icon"} %}
                        </button>
                    {% endif %}
                {% endfor %}
            {% endfor %}
            <a href="#" class="js-remove-all-filters btn-link btn-link-small d-inline-block m-top-quarter" data-component="filter-delete">{{ 'Borrar filtros' | translate }}</a> 
        </div>
    {% endif %}
{% else %}
    {% if product_filters is not empty %}
        <div id="filters-container" data-store="filters-nav">
            <div id="filters-column" class="filters {% if not filters_mobile %}m-top{% endif %}">  
                {% for product_filter in product_filters %}
                    {% if product_filter.type == 'price' %}

                        {% if filters_mobile %}
                            {% set btn_price_classes = 'btn-small btn-smallest' %}
                        {% else %}
                            {% set btn_price_classes = 'btn-square btn-icon chevron' %}
                        {% endif %}

                        {{ component(
                            'price-filter',
                            {'group_class': 'filters-container', 'title_class': 'h6 weight-strong m-bottom', 'button_class': 'btn btn-secondary ' ~ btn_price_classes }
                        ) }}

                    {% else %}
                        {% if product_filter.has_products %}
                            <div class="filters-container" data-store="filters-group" data-component="list.filter-{{ product_filter.type }}" data-component-value="{{ product_filter.key }}">
                                <h6 class="m-bottom">{{product_filter.name}}</h6>
                                {% set index = 0 %}
                                {% for value in product_filter.values %}
                                    {% if value.product_count > 0 %}
                                        {% set index = index + 1 %}
                                        <label class="js-filter-checkbox {% if not value.selected %}js-apply-filter{% else %}js-remove-filter{% endif %} checkbox-container m-bottom-half" data-filter-name="{{ product_filter.key }}" data-filter-value="{{ value.name }}" data-component="filter.option" data-component-value="{{ value.name }}">
                                            <input type="checkbox" autocomplete='off' {% if value.selected %}checked{% endif %}>
                                            <span class="checkbox">
                                                <span class="checkbox-icon"></span>
                                                {{ value.name }} ({{ value.product_count }})
                                            </span>
                                        </label>
                                        {% if index == 8 and product_filter.values_with_products > 8 %}
                                            <div class="js-accordion-container" style="display: none;">
                                        {% endif %}
                                    {% endif %}
                                    {% if loop.last and product_filter.values_with_products > 8 %}
                                        </div>
                                        <a href="#" class="js-accordion-toggle btn-link btn-link-small">
                                            <span class="js-accordion-toggle-inactive">
                                                {{ 'Ver todos' | translate }}
                                            </span>
                                           <span class="js-accordion-toggle-active" style="display: none;">
                                                {{ 'Ver menos' | translate }}
                                            </span>
                                        </a>
                                    {% endif %}
                                {% endfor %}
                            </div>
                        {% endif %}
                    {% endif %}
                {% endfor %}
            </div>
        </div>
    {% endif %}
{% endif %}
