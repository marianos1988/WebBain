{% set is_order_cancellation_without_id = params.order_cancellation_without_id == 'true' %}
<div class="page-content contacto container-xs">	
    <div class="container-wide">
        {% snipplet "breadcrumbs.tpl" %}
        {% if is_order_cancellation %}
            <h4 class="m-top p-top-half m-bottom text-center-xs">{{ "Pedí la cancelación de tu última compra" | translate }}</h4>
        {% endif %}
    </div>
    {% if "foto-contacto.jpg" | has_custom_image %}
        <div class="row-fluid visible-when-content-ready">
            <div class="banner">
                {% if settings.foto_contacto_url != '' %}
                <a href="{{ settings.foto_contacto_url | setting_url }}">
                {% endif %}
                    <img class="lazyautosizes lazyload blur-up-big" src="{{ "foto-contacto.jpg" | static_url | settings_image_url('small')}}" data-srcset='{{ "foto-contacto.jpg" | static_url | settings_image_url('large') }} 480w, {{ "foto-contacto.jpg" | static_url | settings_image_url('huge') }} 640w, {{ "foto-contacto.jpg" | static_url | settings_image_url('original') }} 1024w, {{ "foto-contacto.jpg" | static_url | settings_image_url('1080p') }} 1920w' data-sizes="auto" />
                {% if settings.foto_contacto_url != '' %}
                </a>
                {% endif %}
            </div>
        </div>
    {% endif %}
	<div class="row-fluid container-wide">
		<div class="contact">
            <div class="span6">
                {% if is_order_cancellation %}
                    <div class="text-center-xs m-bottom m-top-half">
                        <p data-component="order-cancellation-disclaimer">{{ "Si te arrepentiste, podés pedir la cancelación enviando este formulario. Tenés como máximo hasta 10 días corridos desde que recibiste el producto." | translate }} </p>
                        <a class="btn btn-link m-top-half p-none m-bottom" href="{{ status_page_url }}"><strong>{{'Ver detalle de la compra >' | translate}}</strong></a>
                    </div>
                {% endif %}
                {% if store.contact_intro %}
                    <p>{{ store.contact_intro }}</p>
                {% endif %}

                {% set has_contact_info = store.whatsapp or store.phone or store.email or store.address %} 
                {% if is_order_cancellation and has_contact_info %}
                    <p class="m-bottom-half m-top">{{ 'Si tenés problemas con otra compra, contactanos:' | translate }}</p>
                {% endif %}
                <div class="row-fluid info m-top m-bottom">
                    <ul class="span6 list-style-none">
                        {% if store.phone %}
                            <li class="svg-icon-text m-bottom-half">{% include "snipplets/svg/phone-solid.tpl" %}<a href="tel:{{ store.phone }}">{{ store.phone }}</a></li>
                        {% endif %}
                        {% if store.email %}
                            <li class="svg-icon-text m-bottom-half">{% include "snipplets/svg/envelope-solid.tpl" %}{{ store.email | mailto }}</li>
                        {% endif %}
                        {% if store.blog %}
                            <li class="svg-icon-text m-bottom-half">{% include "snipplets/svg/comment-solid.tpl" %}<a target="_blank" href="{{ store.blog }}">{{ "Visita nuestro Blog!" | translate }}</a></li>
                        {% endif %}
                        {% if store.address and not is_order_cancellation %}
                            <li class="svg-icon-text m-bottom-half">{% include "snipplets/svg/map-marker-alt-solid.tpl" %}{{ store.address }}</li>
                        {% endif %}
                    </ul>
                    <ul class="span6 list-style-none">
                        {% for sn in ['instagram', 'facebook', 'youtube', 'tiktok', 'twitter', 'pinterest'] %}
                            {% set sn_url = attribute(store,sn) %}
                            {% if sn_url %}
                                <li class="svg-icon-text {{ sn }} m-bottom-half">
                                    {% if sn == "facebook" %}
                                        {% set social_network = sn ~ '-f' %}
                                    {% else %}
                                        {% set social_network = sn %}
                                    {% endif %}

                                    {% include "snipplets/svg/" ~ social_network ~ ".tpl" with {fa_custom_class: "svg-inline--fa fa-lg m-right-half"} %}
                                    
                                    <a target="_blank" href="{{ sn_url }}">{{ "Siguenos en {1}" | translate(sn | replace('_', ' ') | capitalize) }}</a>
                                </li>
                            {% endif %}
                        {% endfor %}
                    </ul>
                </div>
            </div>
            
            <div class="span6">
                <div class="form pull-left full-width">
                    {% if product %}
                        <div class="field prod-consult m-bottom">
                            <h5 class="m-bottom-half">
                                {{ "Consulta por:" | translate }} {{ product.name | a_tag(product.url) }}
                            </h5>
                            <img src="{{ product.featured_image | product_image_url('small') }}" title="{{ product.name }}" alt="{{ product.featured_image.alt }}" width="100"/>
                        </div>
                    {% endif %}
                    {% if contact %}
                        {% if contact.success %}
                            {% if is_order_cancellation %}
                                <div class="alert alert-success" data-component="order-cancellation-success-message">
                                    {{ "¡Tu pedido de cancelación fue enviado!" | translate }} 
                                    <br>
                                    {{ "Vamos a ponernos en contacto con vos apenas veamos tu mensaje." | translate }}
                                    <br> 
                                    <strong>{{ "Tu código de trámite es" | translate }} #{{ last_order_id }}</strong>
                                </div>
                            {% else %}
                                <div class="alert alert-success" data-component="contact-success-message">{{ "¡Gracias por contactarnos! Vamos a responderte apenas veamos tu mensaje." | translate }}</div>
                            {% endif %}
                        {% else %}
                            <div class="alert alert-danger">{{ "Necesitamos tu nombre y un email para poder responderte." | translate }}</div>
                        {% endif %}
                    {% endif %}

                    {% if is_order_cancellation_without_id %}
                        <p class="m-bottom" data-component="order-cancellation-disclaimer">{{ "Si te arrepentiste de una compra, podés pedir la cancelación enviando este formulario <strong>con tu número de orden.</strong> Tenés como máximo hasta 10 días corridos desde que recibiste el producto." | translate }}</p>
                    {% endif %}
                
                    <form class="contact_form" action="/winnie-pooh" method="post" onsubmit="this.setAttribute('action', '');" data-store="contact-form">
                        <input type="hidden" value="{{ product.id }}" name="product"/>
                        {% if is_order_cancellation or is_order_cancellation_without_id %}
                            <input type="hidden" name="type" value="order_cancellation" />
                        {% else %}
                            <input type="hidden" name="type" value="contact" />
                        {% endif %}
        
                        <div class="form-group">
                            <label for="name" class="form-label">{{ "Nombre" | translate }}</label>
                            <input type="text" id="name" name="name" class="form-control"/>
                        </div>
                    
                        <div class="form-group">
                            <label for="email" class="form-label">{{ "Email" | translate }}</label>
                            <input type="email" id="email" name="email" class="form-control"/>
                        </div>
        
                        <div class="field winnie-pooh hidden">
                            <label for="winnie-pooh">{{ "No completar este campo" | translate }}</label>
                            <input id="winnie-pooh" type="text" name="winnie-pooh"/>
                        </div>
                        {% if not is_order_cancellation %}
                            <div class="form-group">
                                <label for="phone" class="form-label">
                                    {{ "Teléfono" | translate }}
                                    <small class="m-left-quarter">({{ "Opcional" | translate }})</small>
                                </label>
                                <input type="text" id="phone" name="phone" class="form-control"/>
                            </div>
                        
                            <div class="form-group">
                                <label for="message" class="form-label">
                                    {{ "Mensaje" | translate }}
                                    <small class="m-left-quarter">({{ "Opcional" | translate }})</small>
                                </label>
                                <textarea id="message" name="message" cols="20" rows="5" class="full-width border-box m-none"></textarea>
                            </div>
                        {% endif %}
                        <input type="submit" class="btn btn-primary contact pull-right span5 m-bottom" value="{{ 'Enviar' | translate }}" name="contact"/>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
