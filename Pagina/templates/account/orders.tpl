<div class="page-content container-wide account-cont container-xs">
    {% snipplet "breadcrumbs.tpl" %}
    <div class="visible-when-content-ready">
        <h1 class="m-bottom p-bottom">{{ 'Mi cuenta' | translate }}</h1>
        <div class="row-fluid">
            <div class="span4">
                <div class="m-bottom-double">
                    <h6 class="m-bottom-none text-uppercase weight-normal">{{ 'Mis datos' | translate }} {{ 'Editar' | translate | a_tag(store.customer_info_url, '', 'text-primary font-body text-lowercase weight-strong display-flex pull-right') }}</h6>
                    <hr class="m-top-half">
                    <div class="contact-data">
                        <div class="span1 col-xs-custom col-xs-1-custom">
                            <div class="m-bottom-half">{% include "snipplets/svg/user-circle.tpl" with {fa_custom_class: "m-right svg-inline--fa svg-icon-text"} %}
                            </div>
                            <div class="m-bottom-half">{% include "snipplets/svg/envelope-regular.tpl" with {fa_custom_class: "m-right svg-inline--fa svg-icon-text"} %}
                            </div>
                            {% if customer.cpf_cnpj %}
                                <div class="m-bottom-half">{% include "snipplets/svg/adress-card-regular.tpl" with {fa_custom_class: "m-right svg-inline--fa svg-icon-text"} %}
                                </div>
                            {% endif %}
                            {% if customer.business_name %}
                                <div class="p-bottom p-top-half"></div>
                            {% endif %}
                            {% if customer.trade_name %}
                                <div class="p-bottom p-top-half"></div>
                            {% endif %}
                            {% if customer.state_registration %}
                                <div class="p-bottom p-top-half"></div>
                            {% endif %}
                            {% if customer.phone %}
                                <div class="m-bottom-half">{% include "snipplets/svg/phone-regular.tpl" with {fa_custom_class: "m-right svg-inline--fa svg-icon-text"} %}
                                </div>
                            {% endif %}
                        </div>
                        <div class="span11 col-xs-custom col-xs-11-custom">
                            <div class="m-bottom-half">{{customer.name}}</div>
                            <div class="m-bottom-half">{{customer.email}}</div>
                            {% if customer.cpf_cnpj %}
                                <div class="m-bottom-half">{{ customer.cpf_cnpj | format_cpf_cnpj }}
                                </div>
                            {% endif %}
                            {% if customer.business_name %}
                                <div class="m-bottom-half">{{ 'Razón social' | translate }}: {{ customer.business_name }}
                                </div>
                            {% endif %}
                            {% if customer.trade_name %}
                                <div class="m-bottom-half">{{ 'Nombre comercial' | translate }}: {{ customer.trade_name }}
                                </div>
                            {% endif %}
                            {% if customer.state_registration %}
                                <div class="m-bottom-half">{{ 'Inscripción estatal' | translate }}: {{ customer.state_registration }}
                                </div>
                            {% endif %}
                            {% if customer.phone %}
                                <div class="m-bottom-double">{{ customer.phone }}
                                </div>
                            {% endif %}
                        </div>
                    </div>
                </div>
                <div class="m-bottom-double m-top">
                    {% if customer.default_address %}
                        <div class="addresses">
                            <h6 class="m-bottom-none text-uppercase weight-normal">{{ 'Mis direcciones' | translate }} {{ 'Editar' | translate | a_tag(store.customer_addresses_url, '', 'text-primary font-body text-lowercase weight-strong display-flex pull-right') }}</h6>
                            <hr class="m-top-half">
                            <div class="address">
                                <div class="span1 col-xs-custom col-xs-1-custom">
                                    {% include "snipplets/svg/map-marker-alt.tpl" with {fa_custom_class: "m-right svg-inline--fa svg-icon-text d-table pull-left"} %}
                                </div>
                                <div class="span11 col-xs-custom col-xs-11-custom m-bottom-double">
                                    <strong>{{ 'Principal' | translate }}</strong>
                                    <br>
                                    <p class="m-left-double">{{ customer.default_address | format_address_short }}</p>
                                </div>
                            </div>
                        </div>
                    {% endif %}
                </div>
            </div>
            <div class="span8">
                <span class="h6 text-uppercase weight-normal">
                    {{ 'Mis compras' | translate }}
                </span>
                {% if customer.ordersCount > 50 %}
                    <span class="font-small m-left-quarter">
                        ({{ 'últimas 50 órdenes' | translate }})
                    </span>
                {% endif %}
                <hr class="m-top-half m-bottom-none hidden-phone">
                    <div data-store="account-orders">
                    {% if customer.orders %}
                        {% for order in customer.orders %} 
                        {% if loop.index % 2 == 1 %}
                            <div class="row-fluid m-none">
                        {% endif %}
                            {% set add_checkout_link = order.pending %}
                            {% set card_active = add_checkout_link ? true : false  %}
                            <div class="span6">
                                <div class="js-card-collapse {% if card_active %}active{% endif %}" data-store="account-order-item-{{ order.id }}">
                                    <div class="js-card-header-collapse full-width-container">
                                        <h6 class="{% if card_active %}text-primary{% endif %} text-uppercase weight-normal m-top m-top-sm-double">
                                            <a class="btn-link" href="{{ store.customer_order_url(order) }}"> {{'Orden' | translate}} #{{order.number}} </a>
                                            <span class="js-card-collapse-toggle js-card-collapse-plus card-collapse-toggle" {% if card_active %}style="display: none;"{% endif %}> 
                                                {% include "snipplets/svg/plus-regular.tpl" with {fa_custom_class: "svg-inline--fa fa-2x svg-icon-text pull-right"} %}
                                            </span>
                                            <span class="js-card-collapse-toggle js-card-collapse-minus card-collapse-toggle" {% if not card_active %}style="display: none;"{% endif %}> 
                                                {% include "snipplets/svg/minus-regular.tpl" with {fa_custom_class: "svg-inline--fa fa-2x svg-icon-text pull-right"} %}
                                            </span>
                                        </h6>
                                        <small class="text-right">{{ order.date | i18n_date('%d/%m/%Y') }}</small>
                                    </div>

                                    <hr class="m-top-half">

                                    <div class="row-fluid js-card-body panel-body" {% if not card_active %}style="display: none;"{% endif %}>
                                        <div class="span4 m-right col-xs-custom col-xs-4-custom">
                                            <div class="card-img-square-container">
                                                {% for item in order.items %}
                                                    {% if loop.first %} 
                                                        {{ item.featured_image | product_image_url("") | img_tag(item.featured_image.alt, {class: 'card-img-square'}) }}
                                                    {% endif %}
                                                {% endfor %}
                                            </div>
                                        </div>
                                        <div class="span6 col-xs-custom col-xs-6-custom">
                                            <div class="row-fluid m-bottom-half">
                                                {{'Pago' | translate}}: <strong class="{{ order.payment_status }}">{{ (order.payment_status == 'pending'? 'Pendiente' : (order.payment_status == 'authorized'? 'Autorizado' : (order.payment_status == 'paid'? 'Pagado' : (order.payment_status == 'voided'? 'Cancelado' : (order.payment_status == 'refunded'? 'Reintegrado' : 'Abandonado'))))) | translate }}</strong>
                                            </div>
                                            <div class="row-fluid m-bottom-half">
                                                {{'Envío' | translate}}: <strong>{{ (order.shipping_status == 'fulfilled'? 'Enviado' : 'No enviado') | translate }}.</strong>
                                            </div>
                                            <h6 class="row-fluid m-bottom-half weight-normal">
                                                {{'Total' | translate}} <strong>{{ order.total | money }}</strong>
                                            </h6>
                                            <h6 class="text-primary text-uppercase weight-normal">
                                                <a class="btn-link" href="{{ store.customer_order_url(order) }}"> {{'Ver detalle' | translate}} ></a>
                                            </h6>
                                        </div>
                                        {% if add_checkout_link %}
                                            <div class="panel-footer">
                                                 <a class="checkout-link h6 btn btn-primary btn-small full-width border-box m-top m-bottom" href="{{ order.checkout_url | add_param('ref', 'orders_list') }}" target="_blank">{{'Realizar el pago >' | translate}}</a>
                                            </div>
                                        {% elseif order.order_status_url != null %}
                                            <div class="panel-footer">
                                                 <a class="checkout-link h6 btn btn-primary btn-small full-width border-box m-top m-bottom" href="{{ order.order_status_url | add_param('ref', 'orders_list') }}" target="_blank">{% if 'Correios' in order.shipping_name %}{{'Seguí la entrega' | translate}}{% else %}{{'Seguí tu orden' | translate}}{% endif %}</a>
                                            </div>
                                        {% endif %}
                                    </div>
                                </div>
                            </div>
                        {% if loop.index % 2 == 0 or loop.last %}
                            </div>
                        {% endif %}  
                        {% endfor %}
                    {% else %} 
                        <div class="text-left-xs m-bottom-double">
                            <div class="m-bottom-half m-top">
                                {% include "snipplets/svg/shopping-cart-regular.tpl" with {fa_custom_class: "svg-inline--fa fa-2x svg-icon-text"} %}
                                <h6 class="weight-normal d-inline-block m-left-quarter">{{'¡Hacé tu primera compra!' | translate}}</h6>
                            </div>
                            <span>{{ 'Ir a la tienda' | translate | a_tag(store.url, '', 'btn-link btn-link-primary') }} {% include "snipplets/svg/arrow-right.tpl" with {fa_custom_class: "svg-inline--fa fa-1x svg-icon-primary"} %}</span>
                        </div>
                   {% endif %}
                </div>
            </div>
        </div>
    </div> 
</div>
