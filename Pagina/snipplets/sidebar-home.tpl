
<div class="visible-when-content-ready pull-left hidden-phone">
	<h3 class="h6 cat-title weight-strong m-bottom">{{ "Categorías principales" | translate }}</h3>
	<div class="sidebar">
		<ul class="home-categories-list pull-left clearfix">
			{% for category in categories %}
				{% set index = index + 1 %}
				<li data-item="{{ loop.index }}" class="m-bottom-quarter clearfix">
					<a href="{{ category.url }}" title="{{ category.name }}">{{ category.name }}</a>
				</li>
				{% if index == 8 and filter_categories | length > 8 %}
					<div class="js-accordion-container" style="display: none;">
				{% endif %}
				{% if loop.last and filter_categories | length > 8 %}
					</div>
					<a href="#" class="js-accordion-toggle btn-link btn-link-small">
						<span class="js-accordion-toggle-inactive">
							{{ 'Ver más' | translate }}
						</span>
						<span class="js-accordion-toggle-active" style="display: none;">
							{{ 'Ver menos' | translate }}
						</span>
					</a>
				{% endif %}
			{% endfor %}
		</ul>
	</div>
</div>

