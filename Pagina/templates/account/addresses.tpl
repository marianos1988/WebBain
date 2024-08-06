<div class="page-content container-wide container-xs">
    {% snipplet "breadcrumbs.tpl" %}
    <div class="title-container" data-store="page-title">
        <h1 class="title m-bottom">{{ "Mis direcciones" | translate }}</h1>
    </div>
    <div class="row-fluid">

        {% for address in customer.addresses %}

            {# User addresses listed - Main Address #}

            {% if loop.first %}
                <div class="span4 col-xs-custom col-xs-12-custom">
                    <div class="title-underlined full-width-container m-bottom-none">
                        <h6 class="m-bottom-none text-uppercase weight-normal m-top">{{ 'Principal' | translate }}</h6>
                        <hr class="m-top-quarter m-bottom">
                    </div>

                {# User addresses listed - Other Addresses #}

            {% elseif loop.index == 2 %}
                <div class="span8 col-xs-custom col-xs-12-custom">
                    <div class="title-underlined full-width-container m-bottom-none">
                        <h6 class="m-bottom-none text-uppercase weight-normal m-top">{{ 'Otras direcciones' | translate }}</h6>
                        <hr class="m-top-quarter m-bottom">
                    </div>  
            {% endif %}
                    {% if loop.index == 2 or (loop.index - 1) % 3 == 1 %}
                        <div class="row-fluid">
                    {% endif %}
                            <div class="span{% if loop.first %}12 m-none{% else %}4{% endif %}">
                                <div class="box box-big m-bottom">
                                    {% include "snipplets/svg/map-marker-alt.tpl" with {fa_custom_class: "m-right svg-inline--fa svg-icon-text d-table pull-left"} %}
                                    <p class="font-body">{{ address | format_address }}</p>
                                    <div class="full-width-container m-top">{{ 'Editar' | translate | a_tag(store.customer_address_url(address), '', 'text-primary font-body text-lowercase weight-strong pull-right') }}</div>
                                    <hr>
                                </div>
                                {% if loop.first %}
                                    <div class="full-width-container m-bottom">
                                        <a class="btn btn-primary btn-small pull-right btn-smallest" href="{{ store.customer_new_address_url }}"> {{ 'Agregar una nueva dirección' | translate }}</a>
                                    </div>
                                {% endif %}
                            </div>
                    {% if (loop.index - 1) % 3 == 0 and not loop.first or loop.last %}
                        </div>
                    {% endif %} 
            {% if loop.first or loop.last %}
                </div>
            {% endif %}     
        {% endfor %}
    </div>
</div>