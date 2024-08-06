<div class="span2 visible-when-content-ready">
	{% if filter_categories is not empty %}
		{% include "snipplets/categories.tpl" %}
	{% endif %}
	<div class="hidden-phone">
		{% if has_filters_enabled or has_applied_filters %}
			<h4 class="m-bottom p-bottom-half">{{ "Filtros" | translate }}</h4>
		{% endif %}
		{% include "snipplets/filters.tpl" with {'applied_filters': true} %}
		{% if product_filters is not empty %}
			{% include "snipplets/filters.tpl" with {'filters_mobile': false} %}
		{% endif %}
	</div>
</div>