{% if not mobile %}
    <div class="p-bottom-double">
        {% if parent_category and parent_category.id!=0 %}
            <a href="{{ parent_category.url }}" title="{{ parent_category.name }}" class="category-back hidden-phone m-bottom">
                {% include "snipplets/svg/angle-left.tpl" with {fa_custom_class: "svg-inline--fa fa-lg m-right-half svg-icon-text"} %}
                {{ parent_category.name }}
            </a>
        {% endif %}
{% endif %}
        {% if filter_categories %}
            <div class="{% if mobile %}filters-container full-width-container{% else %}hidden-phone{% endif %}">
                {% if mobile %}
                    <h6 class="m-bottom">{{ "Categorías" | translate }}</h6>
                {% else %}
                    <h4 class="m-bottom p-bottom-half">{{ category.id!=0 ? category.name :("Categorías" | translate) }}</h4>
                {% endif %}
                <ul class="list-unstyled {% if mobile %}pills-container{% endif %}">
                    {% for category in filter_categories %}
                        <li data-item="{{ loop.index }}" class="{% if mobile %}pill{% else %}m-bottom-quarter{% endif %}"><a href="{{ category.url }}" title="{{ category.name }}" {% if mobile %}class="pill-link"{% endif %}>{{ category.name }}</a></li>
                        {% if loop.index == 8 and filter_categories | length > 8 %}
                            <div class="js-accordion-container" style="display: none;">
                        {% endif %}
                        {% if loop.last and filter_categories | length > 8 %}
                            </div>
                            <a href="#" class="js-accordion-toggle full-width-container">
                                <span class="btn-link btn-link-small"> 
                                    <span class="js-accordion-toggle-inactive">
                                        {{ 'Ver más' | translate }}
                                    </span>
                                    <span class="js-accordion-toggle-active" style="display: none;">
                                        {{ 'Ver menos' | translate }}
                                    </span>
                                </span>
                            </a>
                        {% endif %}
                    {% endfor %}
                </ul>
            </div>
        {% endif %}
{% if not mobile %}
    </div>
{% endif %}
