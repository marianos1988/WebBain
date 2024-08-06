{% if products and pages.is_last %}
	<div class="last-page" style="display:none;"></div>
{% endif %}
{% if settings.grid_columns_desktop == '2' %}
    {% set break_row_numner = '2' %}
{% elseif settings.grid_columns_desktop == '3' %}
    {% set break_row_numner = '3' %}
{% else %}
    {% set break_row_numner = '4' %}
{% endif %}

{% if settings.grid_columns_desktop == '3' %}
    {% set use_rows = false %}
{% else %}
    {% set use_rows = true %}
{% endif %}
{% for product in products %}
    
    {% if (loop.index % break_row_numner == 1 and use_rows) or (loop.first and not use_rows) %}
        <div class="grid-row">
    {% endif %}

    {% include 'snipplets/single_product.tpl' %}

    {% if ((loop.index % break_row_numner == 0 or loop.last) and use_rows) or (loop.last and not use_rows) %}
        </div>
    {% endif %}

{% endfor %}