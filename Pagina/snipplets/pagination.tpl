{% if pages.numbers %}
	{% if pages.previous %}
        <a href="{{ pages.previous }}" class="pagination-arrow-link m-right-half">
        	<span class="pagination-arrow-prev m-top-half p-top-quarter">
				{% include "snipplets/svg/angle-left.tpl" with {fa_custom_class: "svg-inline--fa fa-lg svg-icon-text"} %}
			</span>
        </a>
    {% endif %}
    {% for page in pages.numbers %}
	 	{% if page.selected %}
	 	<div class="js-page-link-{{ page.number }} pagination-input-container d-inline-block {% if not pages.previous %}pagination-input-container-wide{% endif %}">
	 		<span> 
				{{ 'Página' | t }}
			</span> 
 			<input type="number" value="{{ page.number }}" pattern="\d*" class="js-mobile-paginator-input font-body pagination-input text-center"/> 
 			<span> 
				{{ 'de ' | t }} {{ pages.amount }}
			</span> 
		</div>
	 	{% else %}
	 		<a href="{{ page.url }}" class="js-page-link-{{ page.number }} hidden p-all-quarter">{{ page.number }}</a>
	 	{% endif %}
	{% endfor %}
	{% if pages.next %}
		<a href="{{ pages.next }}" class="pagination-arrow-link m-left-half">
			<span class="pagination-arrow-next m-top-half p-top-quarter">
				{% include "snipplets/svg/angle-right-regular.tpl" with {fa_custom_class: "svg-inline--fa fa-lg svg-icon-text"} %}
			</span>
		</a>
	{% endif %}
{% endif %}
