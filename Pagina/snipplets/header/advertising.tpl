<div class="container">
    <div class="row-fluid">
    	{% if theme_logo_position == 'left' %}
    		<div class="span3 hidden-phone"></div>
    	{% endif %}
        <div class="span{% if theme_logo_position == 'left' %}6{% else %}12{% endif %} text-center font-small">
           	{% if settings.ad_bar and settings.ad_text %}
           	    {% if settings.ad_url %}
			        <a href="{{ settings.ad_url | setting_url }}">
				{% endif %}  
		        	{% if settings.ad_text %}
		        		{{ settings.ad_text }}
		        	{% endif %} 
				{% if settings.ad_url %}
			        </a>
		        {% endif %}  
		    {% endif %}       	
        </div>
        {% if theme_logo_position == 'left' %}
	        <div class="span3 hidden-phone">
		        {% if languages | length > 1 %}
		            {% snipplet "header/languages.tpl" %}
		        {% endif %}
	    	</div>
    	{% endif %}
    </div>
</div>