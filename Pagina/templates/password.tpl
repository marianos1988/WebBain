<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml" xmlns:og="http://opengraphprotocol.org/schema/">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1">
    <title>{{ page_title }}</title>
    <meta name="description" content="{{ page_description }}" />
    
    {{ component('social-meta') }}
    {{ component('canary') }}

    {# Critical CSS to improve the percieved performance on first load #}
    <style>
        {% snipplet 'css/critical-css.tpl' %}
    </style>

    {{ '//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js' | script_tag(true) }}

    {# load fonts #}

    {% if params.preview %}

        {# If page is loaded from customization page on the admin, load all fonts #}

        {{ '//fonts.googleapis.com/css?family=PT+Sans+Narrow:400,700|Open+Sans:400,700|Slabo+27px|Oswald:400,700|Lora:400,700|Montserrat:400,500,700|Roboto+Condensed:400italic,700italic,400,700|Droid+Sans:400,700|Playfair+Display:400,700&display=swap' | css_tag }}

    {% else %}

        {# If page is NOT loaded from customization only load saved fonts #}

        {# Get only the saved fonts on settings #}

        {{ [settings.font_headings, 
        settings.font_navigation, 
        settings.font_product_title, 
        settings.font_buttons, 
        settings.font_rest] | google_fonts_url('400, 700') | css_tag }}

    {% endif %}

    {# Aynsc CSS for the non-critical stylesheets and Font Awesome CSS #}

    <link rel="stylesheet" href="{{ 'style.scss.tpl' | static_url }}" media="print" onload="this.media='all'">

    {# Store colors CSS #}
    
    {{ 'custom.scss.tpl' | static_url | static_inline }}

    {% set nojquery = true %}
    {% set async_js = true %}
    {% head_content %}

    {# Structured data to provide information for Google about the page content #}

    {{ component('structured-data') }}

    <!--[if lt IE 9]>
    {{ '//cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.2/html5shiv-printshiv.min.js' | script_tag }}
    <![endif]-->
    <style>
        {{ settings.css_code | raw }}
    </style>
</head>
<body class="{% if customer %}customer-logged-in{% endif %} template-{{ template | replace('.', '-') }}">
{{back_to_admin}}
<div class="visible-when-content-ready">
    <div class="container-xs">
        <div class="text-center m-auto">
            {{ component('logos/logo', {logo_size: 'large', container_classes: { logo_img_container: "mobile-logo-home text-center-xs"}, logo_img_classes: 'transition-soft-slow', logo_text_classes: 'h1'}) }}
        </div>
        <div class="text-center svg-icon-text">
            {% include "snipplets/svg/construction.tpl" %}
        </div>
        <div class="row-fluid">
            <div class="title-container span8 offset2 m-top m-bottom">
                <h2 class="text-center line-height-initial">{{ message }}</h2>
            </div>
        </div>
        {% if store.facebook or store.twitter or store.pinterest or store.instagram or store.tiktok or store.youtube %}
            <div class="m-top">
                {% if store.phone or store.address or store.blog %}
                <div class="text-center">
                    <h4 class="footer-title text-uppercase">{{ "Contactanos" | translate }}</h4>
                    <ul>
                    {% if store.phone %}
                        <li><a href="tel:{{ store.phone }}" class="text-wrap">{{ store.phone }}</a></li>
                    {% endif %}
                    {% if store.email %}
                        <li>{{ store.email | mailto }}</li>
                    {% endif %}
                    {% if store.blog %}
                        <li><a target="_blank" href="{{ store.blog }}">{{ "Visita nuestro Blog!" | translate }}</a></li>
                    {% endif %}
                    {% if store.address %}
                        <li>{{ store.address }}</li>
                    {% endif %}
                  </ul>
                </div>
                {% endif %}
                <div class="container text-center m-top m-bottom">
                    {% for sn in ['instagram', 'facebook', 'youtube', 'tiktok', 'twitter', 'pinterest'] %}
                        {% set sn_url = attribute(store,sn) %}
                        {% if sn_url %}
                            <a class="p-all-half rounded-icon {{ sn }}" href="{{ sn_url }}" target="_blank">
                                {% if sn == "facebook" %}
                                    {% set social_network = sn ~ '-f' %}
                                {% else %}
                                    {% set social_network = sn %}
                                {% endif %}

                                {% include "snipplets/svg/" ~ social_network ~ ".tpl" with {fa_custom_class: "svg-inline--fa fa-2x password-page-icon svg-icon-text"} %}
                            </a>
                        {% endif %}
                    {% endfor %}
                </div>
            </div>
        {% endif %}
    </div>
    <div class="{% if not store.phone and not store.address and not store.blog and not store.facebook and not store.twitter and not store.pinterest and not store.instagram %} password-footer-tall {% endif %}">
        <div class="footer text-center p-top-xs">
            <form method="post" class="password-password">
                <div class="input-append">
                    <input type="password" name="password" class="span2 form-control footer-input {% if invalid_password == true %}input-error{% endif %}"  placeholder="{{ 'Contraseña de acceso' | translate }}" autocomplete="off">
                    <input type="submit" name="unlock" class="btn btn-primary m-left-half" value='{{ "Desbloquear" | translate }}'>
                </div>
                {% if invalid_password == true %}
                    <div class="row-fluid">
                        <div class="alert alert-danger span4 offset4">{{ 'La contraseña es incorrecta.' | translate }}</div>
                    </div>
                {% endif %}
            </form>
        </div>
        <div class="js-footer-legal footer-legal visible-when-content-ready font-small-extra text-uppercase">
            <div class="container">
                <div class="row-fluid">
                    <div class="span6">
                        <div class="powered-by">
                            {#
                            La leyenda que aparece debajo de esta linea de código debe mantenerse
                            con las mismas palabras y con su apropiado link a Tiendanube;
                            como especifican nuestros términos de uso: http://www.tiendanube.com/terminos-de-uso .
                            Si quieres puedes modificar el estilo y posición de la leyenda para que se adapte a
                            tu sitio. Pero debe mantenerse visible para los visitantes y con el link funcional.
                            Os créditos que aparece debaixo da linha de código deverá ser mantida com as mesmas
                            palavras e com seu link para Nuvem Shop; como especificam nossos Termos de Uso:
                            http://www.nuvemshop.com.br/termos-de-uso. Se você quiser poderá alterar o estilo
                            e a posição dos créditos para que ele se adque ao seu site. Porém você precisa
                            manter visivél e com um link funcionando.
                            #}
                            {{ new_powered_by_link }}
                        </div>
                    </div>
                    <div class="span6">
                        <div class="copyright text-right">
                            {{ "Copyright {1} - {2}. Todos los derechos reservados." | translate( (store.business_name ? store.business_name : store.name) ~ (store.business_id ? ' - ' ~ store.business_id : ''), "now" | date('Y') ) }}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
{# External JS: Plugins and libraries #}
<script>
    LS.ready.then(function(){
        {% snipplet "js/external.js.tpl"  %}
    });
</script>
</body>
</html>
