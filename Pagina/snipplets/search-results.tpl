<ul class="search-suggest-list">
    {% set search_suggestions = products | take(6) %}
    {% for product in search_suggestions %}
        <li class="search-suggest-item">
            <a href="{{ product.url }}" class="search-suggest-link">
                <div class="search-suggest-image-container hidden-phone">
                    {{ product.featured_image | product_image_url("tiny") | img_tag(product.featured_image.alt, {class: 'search-suggest-image'}) }}
                </div>
                <div class="search-suggest-text text-uppercase full-width-xs">
                	<p class="search-suggest-name text-left">
                		{{ product.name | highlight(query) }}
                	</p>
                    {% if product.display_price %}
                    	<p class="hidden-phone text-left weight-strong">
                    		{{ product.price | money }}
                    	</p>
                        {% set product_can_show_installments = product.show_installments and product.display_price and product.get_max_installments.installment > 1 and settings.product_installments %}
                        {% if product_can_show_installments %}
                            <span class="hidden-phone text-left font-small">
                                {% set max_installments_without_interests = product.get_max_installments(false) %}
                                {% if max_installments_without_interests and max_installments_without_interests.installment > 1 %}
                                    <div class="item-installments m-top-quarter">{{ "Hasta <strong class='installment-amount'>{1}</strong> cuotas sin interés" | t(max_installments_without_interests.installment) }}</div>
                                {% endif %}
                            </span>
                        {% endif %}
                    {% endif %}
                </div>
                {% include "snipplets/svg/angle-right-regular.tpl" with {fa_custom_class: "svg-inline--fa search-suggest-icon hidden-phone svg-icon-text opacity-80"} %}
            </a>
        </li>
    {% endfor %}
    <li class="search-suggest-item hidden-phone">
        <a href="#" class="js-search-suggest-all-link search-suggest-link search-suggest-all-link">{{ 'Ver todos los resultados' | translate }}</a>
    </li>
</ul>
