<div class="page-content container-wide pagina container-xs">
	{% snipplet "breadcrumbs.tpl" %}
	{# Page preloader #}
	<div class="page-loading-icon-container full-width hidden-when-content-ready">
        <div class="page-loading-icon svg-icon-secondary opacity-80 rotate">
            {% include "snipplets/svg/spinner.tpl" %}
        </div>
    </div>
	<div class="visible-when-content-ready user-content">
    	{{ page.content }}
	</div>
</div>