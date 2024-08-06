{% set has_main_slider = settings.slider and settings.slider is not empty %}
{% set has_mobile_slider = settings.toggle_slider_mobile and settings.slider_mobile and settings.slider_mobile is not empty %}
{% set has_category_banners =  settings.banner_01_show or settings.banner_02_show or settings.banner_03_show %}
{% set has_image_text_modules = settings.module_01_show or settings.module_02_show %}
{% set has_video = settings.video_embed %}
{% set has_instafeed = store.instagram and settings.show_instafeed and store.hasInstagramToken() %}
{% set has_promotional_banners = settings.banner_promotional_01_show or settings.banner_promotional_02_show or settings.banner_promotional_03_show %}
{% set has_facebook_like_module = settings.show_footer_fb_like_box and store.facebook %}
{% set has_twitter_feed = settings.twitter_widget and store.twitter %}
{% set has_horizontal_banner = "banner-home.jpg" | has_custom_image %}
{% set show_help = not (has_main_slider or has_mobile_slider or has_category_banners or has_image_text_modules or has_video or has_instafeed or has_promotional_banners or has_facebook_like_module or has_twitter_feed or has_horizontal_banner) and not has_products %}

{% if show_help %}
    <div class="sections">
        <div class="title-container text-center m-top">
            <h2>{{"¡Bienvenido a tu tienda!" | translate}}</h2>
        </div>  
    </div>
{% endif %}

{% set help_url = has_products ? '/admin/products/feature/' : '/admin/products/new/' %}

{# This will show default products in the home page before you upload some products #}
{% if show_help %}
    {% snipplet 'defaults/show_help.tpl' %}
{% endif %}

<section data-store="home-slider">
    {% include 'snipplets/home-slider.tpl' %}
    {% if has_mobile_slider %}
        {% include 'snipplets/home-slider.tpl' with {mobile: true} %}
    {% endif %}
</section>

{% if settings.banner_services_home %}
    <div data-store="home-banner-services">
        {% include 'snipplets/banner-services/banner-services.tpl' %}
    </div>
{% endif %} 

{#  **** Features Order ****  #}
{% set newArray = [] %}

{% for section in ['home_order_position_1', 'home_order_position_2', 'home_order_position_3', 'home_order_position_4', 'home_order_position_5', 'home_order_position_6', 'home_order_position_7', 'home_order_position_8', 'home_order_position_9'] %}
    {% set section_select = attribute(settings,"#{section}") %}

    {% if section_select not in newArray %}

        {% if section_select == 'categories' %}
            {#  **** Category banners ****  #}
            <div class="container-wide banner-wrapper p-relative" data-store="home-banner-categories">
                {% include 'snipplets/home-banners.tpl' %}
            </div>
        {% elseif section_select == 'promotional' %}
            {#  **** Promotional banners ****  #}
            <div class="container-wide banner-wrapper p-relative" data-store="home-banner-promotional">
                {% include 'snipplets/home-promotional-banners.tpl' %}
            </div>
        {% elseif section_select == 'welcome' %}
            {% if settings.welcome_message %}
                <div data-store="home-welcome-message">
                    {% if settings.version_theme == 'wide' or settings.version_theme == 'full' %}
                        <div class="row-fluid container-wide m-top-half-xs m-bottom-half-xs {% if settings.welcome_text %}m-section-top{% else %}m-section{% endif %}" >
                            <div class="span12">
                                <div class="subtitle-container m-bottom m-none-xs">
                                    <h2 class="h5-xs">{{ settings.welcome_message }}</h2>
                                </div>
                            </div>
                        </div>
                        {% if settings.welcome_text %}
                        <div class="row-fluid m-bottom-half-xs m-section-bottom">
                            <div class="span8 offset2">
                                <div class="subtitle-paragraph m-bottom">
                                    <p>{{ settings.welcome_text }}</p>
                                </div>
                            </div>
                        </div>
                        {% endif %}
                    {% else %}
                        <div class="row-fluid m-top-half-xs m-bottom">
                            <div class="span12">
                                <div class="subtitle-container">
                                    <h2 class="h5-xs">{{ settings.welcome_message }}</h2>
                                </div>
                            </div>
                        </div>
                        {% if settings.welcome_text %}
                        <div class="row-fluid m-bottom-half-xs">
                            <div class="span8 offset2">
                                <div class="subtitle-paragraph m-bottom">
                                    <p>{{ settings.welcome_text }}</p>
                                </div>
                            </div>
                        </div>
                        {% endif %}
                    {% endif %}
                </div>
            {% endif %}
        {% elseif section_select == 'products' %}
            {% if categories and settings.home_main_categories_mobile %}
                {% include 'snipplets/home-categories.tpl' %}
            {% endif %}
            {% if sections.primary.products %}
                <div class="row-fluid container-wide home-prods m-section m-top m-none-xs" data-store="home-products-featured">
                    {% if categories and settings.home_main_categories %}
                        <div class="span2 left-col hidden-phone visible-when-content-ready">
                            {% snipplet 'sidebar-home.tpl' %}
                        </div>
                    {% endif %}
                    <div class="{% if categories and settings.home_main_categories %}span10 {% else %} span12 {% endif %}home-grid right-col">
                        <div class="js-product-table product-table {% if settings.grid_columns_desktop == '3' %}grid-row{% endif %}">

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

                        {% for product in sections.primary.products %}
                            {% if loop.index % break_row_numner == 1 and use_rows %}
                            <div class="grid-row">
                            {% endif %}

                            {% include 'snipplets/single_product.tpl' %}

                            {% if (loop.index % break_row_numner == 0 or loop.last) and use_rows %}
                            </div>
                            {% endif %}
                        {% else %}
                            {% if show_help %}
                                {% for i in 1..4 %}
                                    {% if loop.index % 4 == 1 %}
                                        <div class="grid-row">
                                    {% endif %}

                                    <div class="span3">
                                        <div class="item">
                                            <div class="item-image-container">
                                                <a href="/admin/products/new" target="_top">{{'placeholder-product.png' | static_url | img_tag}}</a>
                                            </div>
                                            <div class="item-info-container">
                                                <div class="title"><a href="/admin/products/new" target="_top">{{"Producto" | translate}}</a></div>
                                                <div class="price">{{"$0.00" | translate}}</div>
                                            </div>
                                        </div>
                                    </div>

                                    {% if loop.index % 4 == 0 or loop.last %}
                                        </div>
                                    {% endif %}
                                {% endfor %}
                            {% endif %}
                        {% endfor %}
                        </div>
                        <div class="row-fluid container-xs container-see-all-prods text-center clear-both visible-when-content-ready">
                            <a href="{{ store.products_url }}" class="btn-see-all-prods btn btn-primary btn-small d-inline-block m-top m-bottom p-left p-right span4 offset4" aria-label="{{ "Ver todos los productos" | translate }}">{{ "Ver todos los productos" | translate }}</a>
                        </div>
                    </div>
                </div>
            {% endif %}
        {% elseif section_select == 'sale' %}
            {% if sections.sale.products %}
                <div class="row-fluid container-wide home-prods m-section m-top m-none-xs" data-store="home-products-sale">
                    <div class="span12 home-grid right-col">
                        {% if settings.sale_products_title %}
                            <h2 class="h5-xs text-center text-uppercase m-top-xs m-bottom">{{ settings.sale_products_title }}</h2>
                        {% endif %}

                        <div class="products-slider">
                            <div class="js-swiper-sale-products swiper-container">
                                <div class="swiper-wrapper">
                                    {% for product in sections.sale.products %}
                                        {% include 'snipplets/single_product.tpl' with {'slide_item': true} %}
                                    {% endfor %}
                                </div>
                                <div class="js-swiper-sale-products-pagination swiper-pagination d-block "></div>
                                <div class="js-swiper-sale-products-prev swiper-button-prev display-none display-md-block svg-circle svg-circle-big svg-icon-text">{% include "snipplets/svg/angle-left-regular.tpl" %}</div>
                                <div class="js-swiper-sale-products-next swiper-button-next display-none display-md-block svg-circle svg-circle-big svg-icon-text">{% include "snipplets/svg/angle-right-regular.tpl" %}</div>
                            </div>
                        </div>
                    </div>
                </div>
            {% endif %}
        {% elseif section_select == 'horizontal' %}
            {% if "banner-home.jpg" | has_custom_image %}
                <div class="row-fluid m-section" data-store="home-banner-horizontal">
                    <div class="banner">
                        {% if settings.banner_home_url != '' %}
                        <a href="{{ settings.banner_home_url | setting_url }}" aria-label="{{ "Link del banner" | translate }}">
                        {% endif %}
                            <img class="lazyautosizes lazyload blur-up-big" src="{{ "banner-home.jpg" | static_url | settings_image_url('thumb')}}" data-srcset='{{ "banner-home.jpg" | static_url | settings_image_url('large') }} 480w, {{ "banner-home.jpg" | static_url | settings_image_url('huge') }} 640w, {{ "banner-home.jpg" | static_url | settings_image_url('original') }} 1024w, {{ "banner-home.jpg" | static_url | settings_image_url('1080p') }} 1920w' data-sizes="auto" alt="{{ "Banner" | translate }} {{ store.name }}"/>
                        {% if settings.banner_home_url != '' %}
                        </a>
                        {% endif %}
                    </div>
                </div>
            {% endif %}
        {% elseif section_select == 'modules' %}
            {#  **** Modules with images and text ****  #}
            <div data-store="home-image-text-module">
                {% include 'snipplets/home-modules.tpl' %}
            </div>
        {% elseif section_select == 'video' %}
            {% if settings.video_embed %}
            <div class="row-fluid container-wide video-wrapper p-relative m-bottom-xs p-bottom-xs m-section" data-store="home-video">
                <div class="span-12">
                    {% include 'snipplets/video-item.tpl' %}
                </div>
            </div>
            {% endif %}
        {% elseif section_select == 'instafeed' %}
            {% if settings.show_instafeed and store.instagram %}
                {% set instuser = store.instagram|split('/')|last %}

                {# Instagram fallback info in case feed fails to load #}
                <div class="js-ig-fallback instafeed-fallback m-top" data-store="home-instagram-feed">
                    <div class="container-xs text-center">
                        <a target="_blank" href="{{ store.instagram }}" aria-label="{{ 'Instagram de' | translate }} {{ store.name }}">
                            {% include "snipplets/svg/instagram.tpl" with {fa_custom_class: "svg-inline--fa d-inline-block fa-4x svg-icon-text"} %}
                            <span class="align-top d-inline-block m-left-quarter text-uppercase text-left">
                                <div class="m-top-quarter text-uppercase font-small">{{ 'Seguinos en Instagram' | translate }}</div>
                                <h2 class="h4-xs">@{{ instuser }}</h2>
                            </span>
                        </a>
                    </div>
                </div>

                {# Instagram feed #}
                {% if store.hasInstagramToken() %}
                    <div class="js-ig-success" style="display: none;">
                        <div class="title-container row-fluid m-top m-bottom text-uppercase">
                            <div class="container-xs text-center">
                                <h2 class="h3 h5-xs">
                                    <a target="_blank" href="{{ store.instagram }}" aria-label="{{ 'Instagram de' | translate }} {{ store.name }}">
                                        {% include "snipplets/svg/instagram.tpl" with {fa_custom_class: "svg-inline--fa svg-icon-text"} %} @{{ instuser }}
                                    </a>
                                </h2>
                            </div>
                        </div>
                        <div class="instafeed-module m-bottom text-center" data-store="instagram-feed">
                            <div class="container">
                                <div class="row-fluid">
                                    <div id="instagram-feed" class="overide-container-width m-none-xs" 
                                        data-ig-feed
                                        data-ig-items-count="8"
                                        data-ig-item-class="instafeed-item col-md-3-custom col-xs-6-custom m-bottom-half"
                                        data-ig-link-class="instafeed-link"
                                        data-ig-image-class="instafeed-img fade-in"
                                        data-ig-aria-label="{{ 'Publicación de Instagram de' | translate }} {{ store.name }}">  
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                {% endif %}
            {% endif %}

        {% endif %}
    {% set newArray = newArray|merge([section_select]) %}
   
    {% endif %}

{% endfor %}
<div class="row-fluid m-bottom-half facebook-widget-row visible-when-content-ready text-center-xs">

    {% if settings.show_footer_fb_like_box and store.facebook %}
        <div class="home-social-widget overflow-none visible-when-content-ready span{% if settings.twitter_widget %}6{% else %}12{% endif %}" data-store="home-facebook-page">
            <div class="social-title text-center divider-dotted">
                <h4 class="h4 weight-normal text-uppercase m-bottom-half">{{"Síguenos en Facebook" | translate}}</h4>
            </div>
            <div class="m-top-half m-bottom-half">
                <div class="fb-page">
                    <div class="fb-page-head p-all-half">
                        <div class="d-flex">
                            <div class="fb-page-img-container m-right-half text-center">
                                {% if has_logo %}
                                    <img src="{{ 'images/empty-placeholder.png' | static_url }}" class="fb-page-img lazyload" data-src="{{ store.logo('thumb')}}"/>
                                {% else %}
                                    {% include "snipplets/svg/facebook-f.tpl" with {fa_custom_class: "svg-inline--fa fa-3x m-top-half fb-page-icon"} %}
                                {% endif %}
                            </div>
                            <div>
                                <div class="h6">{{ store.name }}</div>
                                <div class="m-top-half">
                                    <a href="{{ store.facebook }}" target="_blank" class="fb-like weight-strong" aria-label="{{ "Facebook de" | translate }} {{ store.name }}">
                                        {% include "snipplets/svg/thumbs-up.tpl" with {fa_custom_class: "svg-inline--fa m-right-quarter"} %}
                                        {{ 'Me gusta' | translate }}
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="fb-page-footer p-all-half">
                        <div class="fb-page-box">
                            <a href="{{ store.facebook }}" target="_blank" class="fb-page-link" aria-label="{{ "Facebook de" | translate }} {{ store.name }}">
                                <span class="weight-strong opacity-80">{{ 'Visitá nuestra página' | translate }}</span>
                                {% include "snipplets/svg/facebook-square.tpl" with {fa_custom_class: "svg-inline--fa fa-lg m-left-quarter"} %}
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    {% endif %}
    {% if settings.twitter_widget and store.twitter %}
        <div class="home-social-widget visible-when-content-ready span{% if settings.show_footer_fb_like_box and store.facebook %}6{% else %}12{% endif %}" data-store="home-twitter-feed">
            <div class="social-title text-center divider-dotted">
                <h4 class="h4 weight-normal text-uppercase m-bottom-half">{{"Síguenos en Twitter" | translate}}</h4>
            </div>
            <div class="row-fluid tw">
                {% set twuser = store.twitter|split('/')|last %}
                <div class="twitter-time">
                    <div class="twitter-head">
                        <h3 class="tw-title">Tweets <span class="tw-title-byline">by <a href="{{ store.twitter }}" target="_blank" aria-label="{{ "Twitter de" | translate }} {{ store.name }}">@{{ twuser }}</a></span></h3>
                    </div>
                    <div id="twitterfeed"></div>
                </div>
            </div>
        </div>
    {% endif %}
</div>
{% if settings.show_news_box %}
    {% include 'snipplets/newsletter-popup.tpl' %}
{% endif %}
