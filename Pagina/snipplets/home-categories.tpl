<section class="mobile-home-categories horizontal-container pills-container container-fluid visible-phone text-left m-bottom-half">
	<ul>
		{% for category in categories %}
			<li data-item="{{ loop.index }}" class="pill {% if loop.first %} m-left-half {% endif %} {% if loop.last %} p-right-half {% endif %}">
            	<a class="pill-link" href="{{ category.url }}" title="{{ category.name }}">{{ category.name }}</a>
            </li>
		{% endfor %}
	</ul>
</section>

