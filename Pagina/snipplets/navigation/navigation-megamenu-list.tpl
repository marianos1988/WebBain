{% for item in navigation %}
	<li class="js-desktop-nav-item {% if item.subitems %}js-item-subitems-desktop{% endif %} desktop-nav-item {% if not subitem %}js-nav-main-item {% endif %} {{ item.current ? 'current' : '' }} " data-component="menu.item">
	{% if item.subitems %}
		<div class="nav-item-container">
			<a class="nav-list-link desktop-nav-link position-relative" href="{% if item.url %}{{ item.url }}{% else %}#{% endif %}">{{ item.name }}
			</a>
		</div>
		{% if not subitem %}
			<div class="js-megamenu megamenu">
		{% endif %}
				<ul class="{% if not subitem %}megamenu-list container{% endif %} list-subitems">
					{% include 'snipplets/navigation/navigation-megamenu-list.tpl' with { 'navigation' : item.subitems, 'subitem' : true } %}
				</ul>
		{% if not subitem %}
			</div>
		{% endif %}
	{% else %}
		<a class="nav-list-link desktop-nav-link {{ item.current ? 'current' : '' }}" href="{% if item.url %}{{ item.url | setting_url }}{% else %}#{% endif %}">{{ item.name }}</a>
	{% endif %}
	</li>
{% endfor %}