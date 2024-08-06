<div class="breadcrumb m-bottom-half m-top-half" {% if template != 'page' %}data-store="page-title"{% endif %}>
    <a class="h6 font-body-xs crumb" href="{{ store.url }}" title="{{ store.name }}">{{ "Inicio" | translate }}</a>
    {% if template == 'page' %}
        <span class="breadcrumb-divider">/</span>
        <h1 class="breadcrumb-crumb active">{{ page.name }}</h1>
    {% elseif template == 'search' %}
        <span class="breadcrumb-divider">/</span>
        <h1 class="breadcrumb-crumb active">{{ "Resultados de búsqueda" | translate }}</h1>
    {% elseif template == 'account.order' %}
        <span class="breadcrumb-divider">/</span>
        <h1 class="breadcrumb-crumb active">{{ 'Orden {1}' | translate(order.number) }}</h1>
    {% elseif template == 'cart' %}
        <span class="breadcrumb-divider">/</span>
        <h1 class="breadcrumb-crumb h6 active">{{ "Carrito de compras" | translate }}</h1>
    {% else %}
        {% for crumb in breadcrumbs %}
            <span class="breadcrumb-divider">/</span>
            {% if crumb.last %}
                {% if template == 'product' or (category.description and template == 'category') %}
                    <span class="breadcrumb-crumb active">{{ crumb.name }}</span>
                {% else %}
                    <h1 class="breadcrumb-crumb active">{{ crumb.name }}</h1>
                {% endif %}
            {% else %}
                <a class="breadcrumb-crumb" href="{{ crumb.url }}" title="{{ crumb.name }}">{{ crumb.name }}</a>
            {% endif %}
        {% endfor %}
    {% endif %}
</div>