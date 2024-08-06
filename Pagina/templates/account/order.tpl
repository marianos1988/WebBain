<div class="row-fluid">
    <div class="container container-xs">
        {% snipplet "breadcrumbs.tpl" %}
        <h1 class="">{{'Orden' | translate}} #{{order.number}}</h1>
        <div class="row-fluid container-wide visible-when-content-ready m-bottom m-top" data-store="account-order-detail-{{ order.id }}">
            <div class="details-box span4">
                {% if log_entry %}
                    <h4>{{ 'Estado actual del envío' | translate }}:</h4><span>{{ log_entry }}</span>
                {% endif %}
                <h6 class="m-bottom-none m-top text-uppercase weight-normal">{{ 'Detalles' | translate }}</h6>
                <hr class="m-top-half">

                <div class="m-bottom-half">{{'Fecha' | translate}}: <strong>{{ order.date | i18n_date('%d/%m/%Y') }}</strong></div>

                <div class="m-bottom-half">{{'Estado' | translate}}: <strong>{{ (order.status == 'open'? 'Abierta' : (order.status == 'closed'? 'Cerrada' : 'Cancelada')) | translate }}</strong></div>

                <div class="m-bottom-half">{{'Pago' | translate}}: <strong>{{ (order.payment_status == 'pending'? 'Pendiente' : (order.payment_status == 'authorized'? 'Autorizado' : (order.payment_status == 'paid'? 'Pagado' : (order.payment_status == 'voided'? 'Cancelado' : (order.payment_status == 'refunded'? 'Reintegrado' : 'Abandonado'))))) | translate }}</strong></div>

                <div class="m-bottom-half">{{'Medio de pago' | translate}}: <strong>{{ order.payment_name }}</strong></div>

                {% if order.address %}
                    <div class="m-bottom-half">{{'Envío' | translate}}: <strong>{{ (order.shipping_status == 'fulfilled'? 'Enviado' : 'No enviado') | translate }}</strong></div>
                    <div class="m-bottom-half">{{ 'Dirección de envío' | translate }}: </div>
                    <div class="address">
                        {{ order.address | format_address }}
                    </div>
                {% endif %}
            </div>
            <div class="span8">
                <h6 class="m-bottom-none m-top text-uppercase weight-normal">{{ 'Productos' | translate }}</h6>
                <hr class="m-top-half">
                <div class="hidden-phone">
                    <div class="span6 m-bottom">
                        <strong>{{ 'Productos' | translate }}</strong>
                    </div>
                    <div class="span2 m-bottom">
                        <strong>{{ 'Precio' | translate }}</strong>
                    </div>
                    <div class="span2 m-bottom">
                        <strong>{{ 'Cantidad' | translate }}</strong>
                    </div>
                    <div class="span2 m-bottom">
                        <strong class="pull-right pull-none-xs">{{ 'Total' | translate }}</strong>
                    </div>
                </div>
                {% for item in order.items %}
                    <div class="row-fluid m-bottom-half">
                        <div class="span2 p-right-half-xs col-xs-custom col-xs-4-custom">
                            <div class="card-img-square-container">
                                {{ item.featured_image | product_image_url("") | img_tag(item.featured_image.alt, {class: 'card-img-square'}) }}
                            </div>
                        </div>
                        <div class="span4 col-xs-custom col-xs-8-custom">{{ item.name }} <span class="d-inline-block hidden-desktop">x{{ item.quantity }}</span></div>
                        <div class="span2 hidden-phone">
                            <p>{{ item.unit_price | money  }}</p>
                        </div>
                        <div class="span2 hidden-phone col-xs-custom col-xs-8-custom">
                            <p>{{ item.quantity }}</p>
                        </div>
                        <div class="span2 col-xs-custom col-xs-8-custom">
                            <strong class="pull-right pull-none-xs">{{ item.subtotal | money }}</strong>
                        </div>
                    </div>
                {% endfor %}
                <div class="full-width-container">
                    <hr class="m-top"> 
                    {% if order.shipping or order.discount %}
                        <p class="m-top-half m-bottom-half weight-normal">
                            <strong>{{ 'Subtotal' | translate }}:</strong>
                            <span class="pull-right pull-none-xs">{{ order.subtotal | money }}</span>
                        </p>
                        <hr class="m-top-half">
                    {% endif %}  
                    {% if order.show_shipping_price %}
                        <p class="m-top-half m-bottom-half">
                            <strong>{{ 'Costo de envío ({1})' | translate(order.shipping_name) }}:</strong>
                            {% if order.shipping == 0  %}
                               <span class="pull-right pull-none-xs">{{ 'Gratis' | translate }}</span>
                            {% else %}
                               <span class="pull-right pull-none-xs">{{ order.shipping | money }}</span>
                            {% endif %}
                            <hr class="m-top-half">
                        </p>
                    {% else %}
                        <p class="m-top-half m-bottom-half">
                            <strong>{{ 'Costo de envío ({1})' | translate(order.shipping_name) }}:</strong>
                            <span class="pull-right pull-none-xs">{{ 'A convenir' | translate }}</span>
                        </p>
                        <hr class="m-top-half">
                    {% endif %}
                    {% if order.discount %}
                        <p class="m-top-half m-bottom-half">
                           <strong>{{ 'Descuento ({1})' | translate(order.coupon) }}:</strong>
                           <span class="pull-right pull-none-xs">- {{ order.discount | money }}</span>
                        </p>
                        <hr class="m-top-half">
                    {% endif %}
                    <h3 class="m-top m-bottom text-primary">
                        <strong>{{ 'Total' | translate }}:</strong>
                        <strong class="pull-right pull-none-xs">{{ order.total | money }}</strong>
                    </h3>
                    {% if order.pending %}
                        <a class="btn btn-primary btn-small full-width-xs m-top pull-right pull-none-xs" href="{{ order.checkout_url | add_param('ref', 'orders_details') }}" target="_blank">{{'Realizar el pago >' | translate}}</a>
                    {% endif %}
                </div>
            </div>
        </div>
    </div>
</div>
