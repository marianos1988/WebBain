<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml" xmlns:og="http://opengraphprotocol.org/schema/" lang="{% for language in languages %}{% if language.active %}{{ language.lang }}{% endif %}{% endfor %}">
<head>
    <link rel="preconnect" href="{{ store_resource_hints }}" />
    <link rel="dns-prefetch" href="{{ store_resource_hints }}" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>{{ page_title }}</title>
    <meta name="description" content="{{ page_description }}" />

    {# Preload of first image of Slider and first Category Banners to improve LCP #}
    {% if template == 'home'%}
        {% snipplet 'preload-images.tpl' %}
    {% endif %}

    {{ component('social-meta') }}
    {{ component('canary') }}

    {# load fonts #}

    {# Critical CSS needed to show first elements of store while CSS async is loading #}

    <style>
        {# Font families #}

        {% if params.preview %}

            {# If page is loaded from customization page on the admin, load all fonts #}

            @import url('https://fonts.googleapis.com/css?family=PT+Sans+Narrow:400,700|Open+Sans:400,700|Slabo+27px|Oswald:400,700|Lora:400,700|Montserrat:400,500,700|Roboto+Condensed:400italic,700italic,400,700|Droid+Sans:400,700|Playfair+Display:400,700&display=swap');

        {% else %}

            {# If page is NOT loaded from customization only load saved fonts #}

            {# Get only the saved fonts on settings #}

            @import url('{{ [settings.font_headings, settings.font_navigation, settings.font_product_title, settings.font_buttons, settings.font_rest] | google_fonts_url('400, 700') | raw }}');

        {% endif %}

        {% snipplet 'css/critical-css.tpl' %}
    </style>

    {# Load async styling not mandatory for first meaningfull paint #}

    <link rel="stylesheet" href="{{ 'style.scss.tpl' | static_url }}" media="print" onload="this.media='all'">

    {# Colors and fonts used from settings.txt and defined on theme customization #}

    {{ 'custom.scss.tpl' | static_url | static_inline }}

    {% if settings.css_code %}
        <style>
            {{ settings.css_code | raw }}
        </style>
    {% endif %}

    {# Defines if async JS will be used by using script_tag(true) #}

    {% set async_js = true %}

    {# Defines the usage of jquery loaded below, if nojquery = true is deleted it will fallback to jquery 1.5 #}

    {% set nojquery = true %}

    {# Jquery async by adding script_tag(true) #}

    {% if load_jquery %}

        {{ '//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js' | script_tag(true) }}

    {% endif %}

    {# Loads private Tiendanube JS #}

    {% head_content %}

    {# Structured data to provide information for Google about the page content #}

    {{ component('structured-data') }}

</head>
<body class="{% if customer %}customer-logged-in{% endif %} template-{{ template | replace('.', '-') }}">

{# Social JS for Facebook comments on product page #}

{% if template == 'product' %}

    {# Facebook comment box JS #}

    {% if settings.show_product_fb_comment_box %}
        {{ fb_js }}
    {% endif %}

    {# Pinterest share button JS #}

    {{ pin_js }}
{% endif %}

{{back_to_admin}}

{% set theme_version = settings.version_theme %}
{% set theme_logo_position = settings.logo_position %}

{# Hamburger panel #}
<nav id="nav-hamburger" class="js-modal new-modal {% if theme_logo_position == 'left' %}modal-right{% else %}modal-left{% endif %} hamburger-panel" style="display: none;">
    {% snipplet "navigation/navigation-hamburger-panel.tpl" %}
</nav>

{# Site Overlay #}
<div class="js-modal-overlay site-overlay visible-phone"></div>

<div class="backdrop mobile-search-backdrop js-search-backdrop js-toggle-mobile-search container-fluid" style="display: none;"></div>

<div id="container"  class="{% if theme_version == 'wide' %}theme-wide{% elseif theme_version == 'full' %}theme-wide theme-full{% endif %}">
    {# Shortcut to the Status Page #}
    <div class="hidden-phone">
        {% include 'snipplets/notification.tpl' with {order_notification: true} %}
    </div>

    {% if theme_version == 'box' %}
    <div class="container visible-phone">
        {% snipplet "navigation/navigation-mobile.tpl" %}
    </div>
    {% else %}
     <div class="container visible-phone">
         {% snipplet "header/search-mobile.tpl" %}
     </div>
    {% endif %}

    <div class="js-main-content main-content">
        {# Shortcut to the Status Page and Cancelation Order #}
        <div class="visible-phone">
            {% include 'snipplets/notification.tpl' with {order_notification: true} %}
        </div>

        {# Add notification for quick login cancellation #}

        {% if template == 'home' or template == 'product' %}
            {% include "snipplets/notification.tpl" with {show_quick_login: true} %}
        {% endif %}

        {# Show cookie validation message #}
        {% include "snipplets/notification.tpl" with {show_cookie_banner: true} %}

        {% set theme_logo_position = settings.logo_position %}
        {% set theme_head_background = settings.head_background %}

        {% if theme_version == 'wide' or theme_version == 'full' %}
            {% if theme_logo_position == 'left' %}
                {% snipplet "header/header-logo-left.tpl" %}
            {% else %}
                {% snipplet "header/header-logo-center.tpl" %}
            {% endif %}
        {% else %}
            {% snipplet "header/header.tpl" %}
        {% endif %}

        <div class="js-body-position container">
            {% template_content %}
        </div>
        {% set has_only_category_banner_service = settings.banner_services_category and not settings.banner_services and template == 'category' %}
        {% if settings.banner_services or has_only_category_banner_service %}
        <div class="js-hide-footer-while-scrolling js-banner-services-footer container {% if has_only_category_banner_service %}visible-phone {% endif %}" data-store="banner-services">
            <div class="banner-services-footer m-bottom-half-xs m-top-half-xs">
                 {% include 'snipplets/banner-services/banner-services.tpl' %}
             </div>
         </div>
        {% endif %}
        <footer class="js-hide-footer-while-scrolling js-footer" data-store="footer">
            <div class="footer">
                <div class="container visible-when-content-ready">
                    {% set has_shipping_logos = settings.shipping %}
                    {% set has_payment_logos = settings.payments %}
                    {% set has_shipping_payment_logos = has_payment_logos or has_shipping_logos %}
                    {% set has_footer_contact_info = store.phone or store.email or store.blog or store.address %}
                        {% set has_social_network = store.facebook or store.twitter or store.pinterest or store.instagram or store.tiktok or store.youtube %}
                        {% if not (has_footer_contact_info or has_shipping_payment_logos or has_products) %}
                        {# This is a snipplet to show the user the payment and send methods the first time they visit the store #}
                       {% snipplet "defaults/show_help_footer.tpl" %}
                    {% else %}
                        <div class="row-fluid">
                            <div class="span{{ has_shipping_payment_logos ? 2 : 4 }} pull-left-xs">
                                <div class="col-foot">
                                    <h4 class="footer-title font-body text-uppercase">{{ "Navegación" | translate }}</h4>
                                    <ul>
                                        {% snipplet "navigation/navigation-foot.tpl" %}
                                    </ul>
                                </div>
                            </div>

                            {% if has_shipping_payment_logos %}
                                <div class="span3 pull-left-xs">
                                    {% if has_payment_logos %}
                                        <div class="col-foot">
                                            <h4 class="footer-title font-body text-uppercase">{{ "Medios de pago" | translate }}</h4>
                                            {% for payment in settings.payments %}
                                                <img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ payment | payment_new_logo }}" class="footer-payship-img card-img lazyload" alt="{{ payment }}" width="40" height="25">
                                            {% endfor %}
                                        </div>
                                    {% endif %}
                                    {% if has_shipping_logos %}
                                        <div class="col-foot">
                                            <h4 class="footer-title font-body text-uppercase">{{ "Formas de envío" | translate }}</h4>
                                            {% for shipping in settings.shipping %}
                                                <img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ shipping | shipping_logo }}" class="footer-payship-img card-img lazyload" alt="{{ shipping }}" width="40" height="25">
                                            {% endfor %}
                                        </div>
                                    {% endif %}
                                </div>
                            {% endif %}
                            {% if has_footer_contact_info %}
                            <div class="{% if not (store.afip or ebit or settings.custom_seal_code or "seal_img.jpg" | has_custom_image ) %}span4{% else %}span3{% endif %} pull-left-xs">
                                <div class="col-foot">
                                    <h4 class="footer-title font-body text-uppercase">{{ "Contactanos" | translate }}</h4>
                                    <ul>
                                        {% if store.phone %}
                                            <li>{% include "snipplets/svg/phone-regular.tpl" with {fa_custom_class: "svg-inline--fa footer-icon fa-fw"} %}<a href="tel:{{ store.phone }}" class="text-wrap">{{ store.phone }}</a></li>
                                        {% endif %}
                                        {% if store.email %}
                                            <li>{% include "snipplets/svg/at.tpl" with {fa_custom_class: "svg-inline--fa footer-icon fa-fw"} %}{{ store.email | mailto }}</li>
                                        {% endif %}
                                        {% if store.blog %}
                                            <li>{% include "snipplets/svg/comments.tpl" with {fa_custom_class: "svg-inline--fa footer-icon fa-fw"} %}<a target="_blank" href="{{ store.blog }}">{{ "Visita nuestro Blog!" | translate }}</a></li>
                                        {% endif %}
                                        {% if store.address %}
                                            <li>{% include "snipplets/svg/map-marker-alt.tpl" with {fa_custom_class: "svg-inline--fa footer-icon fa-fw"} %}{{ store.address }}</li>
                                        {% endif %}
                                    </ul>
                                </div>
                            </div>
                            {% endif %}
                            <div class="span{{ has_shipping_payment_logos ? 2 : 4 }} pull-left-xs">
                                {% if has_social_network %}
                                <div class="col-foot clearfix">
                                    <h4 class="footer-title font-body text-uppercase">{{ "Redes Sociales" | translate }}</h4>
                                    {% for sn in ['instagram', 'facebook', 'youtube', 'tiktok', 'twitter', 'pinterest'] %}
                                        {% set sn_url = attribute(store,sn) %}
                                        {% if sn_url %}
                                            <a class="footer-icon rounded-icon" href="{{ sn_url }}" target="_blank" aria-label="{{ "Seguinos en" | translate }} {{ sn }}">

                                                {% if sn == "facebook" %}
                                                    {% set social_network = sn ~ '-f' %}
                                                {% else %}
                                                    {% set social_network = sn %}
                                                {% endif %}

                                                {% include "snipplets/svg/" ~ social_network ~ ".tpl" with {fa_custom_class: "svg-inline--fa svg-icon-foot"} %}
                                            </a>
                                        {% endif %}
                                    {% endfor %}
                                </div>
                                {% endif %}
                                 <div class="col-foot">
                                    <h4 class="footer-title font-body text-uppercase">{{ settings.news_message }}</h4>
                                    {% include "snipplets/newsletter.tpl" %}
                                </div>
                            </div>
                            {% if store.afip or ebit or settings.custom_seal_code or ("seal_img.jpg" | has_custom_image) %}
                                <div class="span2 seals-container pull-left-xs">
                                    <div class="col-foot">
                                        <h4 class="footer-title font-body text-uppercase">{{ "Seguridad y Certificaciones" | translate }}</h4>
                                        {% if store.afip %}
                                            <div class="afip seal-afip clear-both pull-left d-inline-block">
                                                {{ store.afip | raw }}
                                            </div>
                                        {% endif %}
                                        {% if ebit %}
                                            <div class="ebit seal-ebit">
                                                {{ ebit }}
                                            </div>
                                        {% endif %}

                                        {% if "seal_img.jpg" | has_custom_image or settings.custom_seal_code %}
                                        <div class="custom-seals-container">
                                            {% if "seal_img.jpg" | has_custom_image %}
                                                <div class="custom-seal pull-left m-top-quarter m-bottom-quarter clear-both">
                                                    {% if settings.seal_url != '' %}
                                                        <a href="{{ settings.seal_url | setting_url }}" target="_blank">
                                                    {% endif %}
                                                        <img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ "seal_img.jpg" | static_url }}" class="lazyload custom-seal-img" alt="{{ 'Sello de' | translate }} {{ store.name }}" />
                                                    {% if settings.seal_url != '' %}
                                                        </a>
                                                    {% endif %}
                                                </div>
                                            {% endif %}
                                            {% if settings.custom_seal_code %}
                                                <div class="custom-seal custom-seal-code pull-left m-top-quarter m-bottom-quarter clear-both">
                                                    {{ settings.custom_seal_code | raw }}
                                                </div>
                                            {% endif %}
                                        </div>
                                        {% endif %}
                                    </div>
                                </div>
                            {% endif %}
                        </div>
                    {% endif %}
                </div>
            </div>

            <div class="js-footer-legal footer-legal font-small-extra text-uppercase">
                <div class="container visible-when-content-ready">
                    <div class="row-fluid">
                        <div class="span3 text-center-xs">
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
                        <div class="span9 text-center-xs">
                            <div class="copyright text-right text-center-xs">
                                {{ "Copyright {1} - {2}. Todos los derechos reservados." | translate( (store.business_name ? store.business_name : store.name) ~ (store.business_id ? ' - ' ~ store.business_id : ''), "now" | date('Y') ) }}
                                {{ component('claim-info', {
                                        container_classes: "d-inline-block d-block-xs m-left-quarter m-none-xs m-top-quarter-xs",
                                        divider_classes: "hidden-phone m-left-quarter m-right-quarter",
                                        link_classes: {
                                            link_consumer_defense: "weight-strong",
                                            link_order_cancellation: "weight-strong full-width-xs d-inline-block",
                                        },
                                    }) 
                                }}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </footer>
    </div>
    {# AJAX Cart Panel #}
    {% if not store.is_catalog and template != 'cart' and settings.ajax_cart %}
        {% snipplet "cart-panel-ajax.tpl" %}
    {% endif %}

    {# Quick login #}
    {% snipplet "quick-login.tpl" %}

    {# Quickshop modal #}
    {% snipplet "quick-shop.tpl" %}

    {# Whatsapp chat button #}
    {% if store.whatsapp %}
        <a href="{{ store.whatsapp }}" target="_blank" class="js-btn-fixed-bottom btn-whatsapp btn-floating fixed-bottom visible-when-content-ready" aria-label="{{ "Comunicate por WhatsApp" | translate }} {{ store.name }}">
            {% include "snipplets/svg/whatsapp.tpl" %}
        </a>
    {% endif %}

    {% if cart.free_shipping.cart_has_free_shipping or cart.free_shipping.min_price_free_shipping.min_price %}

        {# Minimum used for free shipping progress messages. Located on header so it can be accesed everywhere with shipping calculator active or inactive #}

        <span class="js-ship-free-min hidden" data-pricemin="{{ cart.free_shipping.min_price_free_shipping.min_price_raw }}"></span>
        <span class="js-cart-subtotal hidden" data-priceraw="{{ cart.subtotal }}"></span>
        <span class="js-cart-discount hidden" data-priceraw="{{ cart.promotional_discount_amount }}"></span>
    {% endif %}
</div>

{# Javascript used in the store #}

<script type="text/javascript">

    {# Libraries that do NOT depend on other libraries, e.g: Jquery #}

    {% include "static/js/external-no-dependencies.js.tpl" %}

    {# LS.ready.then function waits to Jquery and private Tiendanube JS to be loaded before executing what´s inside #}

    LS.ready.then(function(){

        {# Libraries that requires Jquery to work #}

        {% snipplet "js/external.js.tpl"  %}

        {# Specific store JS functions: product variants, cart, shipping, etc #}

        {% if store.useStoreJsV2() %}
            {% include "static/js/store-v2.js.tpl" %}
        {% else %}
            {% include "static/js/store.js.tpl" %}
        {% endif %}
    });
</script>

{# Google reCAPTCHA on register page #}
{% if template == 'account.register' %}
    {% if not store.hasContactFormsRecaptcha() %}
        {{ '//www.google.com/recaptcha/api.js' | script_tag(true) }}
    {% endif %}
    <script type="text/javascript">
        var recaptchaCallback = function() {
            jQueryNuvem('.js-recaptcha-button').prop('disabled', false);
        };
    </script>
{% endif %}

{# Google survey JS for Tiendanube/Nuvemshop Survey #}

{% include "static/js/google-survey.js.tpl" %}

{# Store external codes added from admin #}

{% if store.assorted_js %}
<script>
    LS.ready.then(function() {
        var trackingCode = jQueryNuvem.parseHTML('{{ store.assorted_js| escape("js") }}', document, true);
        jQueryNuvem('body').append(trackingCode);
    });
</script>
{% endif %}

</body>
</html>
