
{#/*============================================================================

custom.scss.tpl

    -This file contains all the theme styles related to settings defined by user from config/settings.txt
    -Rest of styling can be found in:
        -static/css/style.css --> For non critical styles witch will be loaded asynchronously
        -snipplets/css/critical-css.tpl --> For critical CSS rendered inline before the rest of the site
        -static/css/checkout.scss.tpl --> For color and font styles related to config/settings.txt applied on the checkout

==============================================================================*/#}

{#/*============================================================================
  Table of Contents
  #Colors and fonts
    // Colors
    // Font families
    // Texts
  #Components
    // Mixins
    // Functions
    // Animations
    // Wrappers
    // SVG Icons
    // Placeholders
    // Breadcrumbs
    // Buttons
    // Links
    // Progress bar
    // Chips
    // Modals
    // Badge
    // Tooltip
    // Dividers
    // Forms
    // Alerts and notifications
    // Tabs
    // Panels
    // Pills
    // Slider
    // Banners
    // Thumbs swiper
    // Tables
    // Video
  #Social
    // Instafeed
    // Facebook Widget
    // Twitter Widget
  #Header and nav
    // Advertising Bar
    // Head
    // Logo
    // Nav desktop
    // Nav mobile
    // Search suggestions
    // User Accounts
    // Cart widget desktop
  #Product grid
    // Filters
    // Grid item
  #Product detail
    // Color variations
    // Mobile variations
  #Footer
  #Cart page
    // Table
    // Ajax cart
  #Media queries
    // Max width 767px
        //// Texts
        //// Header and nav
        //// Product grid
        //// Product detail
        //// Cart
        //// Home

==============================================================================*/#}


{#/*============================================================================
  #Colors and fonts
==============================================================================*/#}

{# /* // Colors */ #}

$main-background: {{ settings.background_color }};
$main-foreground: {{ settings.text_color }};
$footer-foreground: {{ settings.footer_text }};
$nav-foreground: {{ settings.nav_text }};
$nav-hover-foreground: {{ settings.nav_text_hover }};
$nav-background: {{ settings.nav_background }};
$nav-borders: {{ settings.nav_border }};
$titles-foreground: {{ settings.title_color }};
$titles-background: {{ settings.title_background }};
$btn-primary-background: {{ settings.button_bg }};
$btn-secondary-background: {{ settings.button_secondary_bg }};
$btn-foreground: {{ settings.button_color }};
$footer-background: {{ settings.footer_bg }};
$footer-foreground: {{ settings.actual_footer_text }};

{# If store has accent color on it uses the accent color else uses primary color as default fallback #}
{% if settings.accent_color_active %}
  $accent-background-color: {{ settings.label_bg }};
  $accent-foreground-color: {{ settings.label_color }};
{% else %}
  $accent-background-color: {{ settings.button_bg }};
  $accent-foreground-color: {{ settings.button_color }};
{% endif %}

{# /* // Font families */ #}

$font-headings: {{ settings.font_headings | raw }};
$font-nav: {{ settings.font_navigation | raw }};
$font-item-title: {{ settings.font_product_title | raw }};
$font-btn: {{ settings.font_buttons | raw }};
$font-body: {{ settings.font_rest | raw }};

{# /* // Texts */ #}

{# /* Headings */ #}

h1, .h1 {
  font-size: 28px;
}
h2, .h2 {
  font-size: 24px;
}
h3, .h3 {
  font-size: 22px;
}
h4, .h4 {
  font-size: 20px;
}
h5, .h5 {
    font-size: 18px;
}
h6, .h6 {
  font-size: 16px;
}

.subtitle-container {
    background-color: $titles-background;
    font-family: $font-headings;
    color: $titles-foreground;
}

.subtitle-paragraph {
    color: $titles-foreground;
}

{# /* Body */ #}

.font-medium {
    font-size: 16px;
}
body,
.font-body {
  font-size: 14px;
}
.font-small {
  font-size: 12px;
}
.font-small-extra {
  font-size: 10px;
}

{# /* Weight */ #}

.weight-normal {
  font-weight: 400;
}
.weight-strong {
  font-weight: 700;
}

/* Color */

.text-primary {
    color: $btn-primary-background;
}
.text-secondary {
    color: $btn-secondary-background;
}
.text-foreground {
    color: $main-foreground;
}
.text-background {
    color: $main-background;
}
.text-accent {
    {% if settings.accent_color_active %}
        color: $accent-background-color;
    {% else %}
        color: $btn-secondary-background;
    {% endif %}
}

{#/*============================================================================
  #Components
==============================================================================*/#}

{# /* // Mixins */ #}

@mixin border-radius($radius) {
    border-radius: $radius;
}
@mixin border-box() {
    box-sizing: border-box;
}
@mixin box-shadow-none() {
    -webkit-box-shadow: none;
    -moz-box-shadow: none;
    box-shadow: none;
}
@mixin webkit-appearance-none() {
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
}
@mixin display-flex() {
    display: -webkit-box;
    display: -ms-flexbox; 
    display: -webkit-flex;
    display: flex;
}
@mixin text-decoration-none(){
    text-decoration: none;
    &:hover,
    &:focus{
        text-decoration: none;
    }
}

{# This mixin adds browser prefixes to a CSS property #}

@mixin prefix($property, $value, $prefixes: ()) {
  @each $prefix in $prefixes {
    #{'-' + $prefix + '-' + $property}: $value;
  }
   #{$property}: $value;
}

{# /* // Functions */ #}

@function set-foreground-color($bg-color, $foreground-color) {
    @if (lightness($bg-color) > 50) {
        @return $foreground-color; // Lighter backgorund, return dark color
    } @else {
        @return lighten($foreground-color, 15%); // Darker background, return light color
    }
}

@function set-foreground-color-footer($bg-color, $foreground-color) {
    @if (lightness($bg-color) > 50) {
        @return $foreground-color; // Lighter backgorund, return dark color
    } @else {
        @return lighten($foreground-color, 30%); // Darker background, return light color
    }
}

{# /* // Wrappers */ #}

body{
    color: $main-foreground;
    font-family: $font-body;
    background-color: $main-background;
    {% if "default-background.jpg" | has_custom_image %}
        background-image: url( "{{ "default-background.jpg" | static_url }}" );
    {% endif %}
}

.box-container{
    border:1px solid rgba($main-foreground, 0.1);
}

{# /* // SVG Icons */ #}

.svg-icon-primary{
   fill:$btn-primary-background;
}
.svg-icon-secondary{
   fill:$btn-secondary-background;
}
.svg-icon-text{
    fill:$main-foreground;
}
.svg-icon-back{
    fill:$main-background;
}
.svg-icon-btn{
    fill:$btn-foreground;
}
.svg-icon-nav{
    fill:$nav-foreground;
}
.svg-icon-foot{
    fill:$footer-background;
}

.svg-icon-accent{
  fill: $accent-background-color;
}

{# /* // Placeholders */ #}

.placeholder-container{
    background-color:rgba($main-foreground, 0.05);
}
.placeholder-icon{
    fill:rgba($main-foreground, 0.3);
}
.placeholder-color{
    background-color:rgba($main-foreground, 0.07);
    fill: rgba($main-foreground, 0.07);
}

.placeholder-fade{
    background-color:rgba($main-foreground, 0.2);
}
.spinner-big{
    box-shadow: 0 0 0 1px rgba(0, 0, 0, 0.1), 2px 1px 0 $main-foreground;
}

.breadcrumb>.active{
    color: $main-foreground;
}
{# /* // Buttons */ #}

button{
    font-family: $font-btn;
    font-size: 14px;
    line-height: initial;
    @include border-radius(0);
    @include webkit-appearance-none();
    @include box-shadow-none();
}
.btn{
    display: inline-block;
    padding: 9px 12px;
    font-family:$font-btn;
    text-transform: uppercase;
    font-weight: 400;
    font-size: 18px;
    text-shadow: none;
    background-image:none;
    color: $btn-foreground;
    @include border-radius(0);
    @include webkit-appearance-none();
    @include box-shadow-none();
    @include border-box();
    border:0;
    &:hover,
    &:focus{
        background-image:none;
        background-color:transparent;
        color: $btn-foreground;
        opacity: 0.9;
    }
}
.btn-primary{
    background-color: $btn-primary-background;
    &:hover,
    &:focus{
        background-color: $btn-primary-background;
    }
    &[disabled]{
        background-color: #DDD;
    }
    &.btn-transition.active,
    &.btn-transition[disabled],
    &.btn-transition[disabled]:hover,
    &.btn-transition.disabled,
    &.btn-transition.disabled:hover{
        background-color: $btn-primary-background;
        color: $btn-foreground;
    }
}
.btn-secondary{
    background: transparent;
    color: $main-foreground;
    border: 1px solid $main-foreground;
    &:hover,
    &:focus {
        background: transparent;
        color: $main-foreground;
        opacity: 0.6;
    }
    &.disabled {
        background: transparent;
        color: $main-foreground;
        border: 1px solid $main-foreground;
        opacity: .3;
        cursor: not-allowed;
    }
    &.btn-square.chevron:before {
      content: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" fill="{{ settings.text_color |replace("#","%23") }}"><path d="M187.8 264.5L41 412.5c-4.7 4.7-12.3 4.7-17 0L4.2 392.7c-4.7-4.7-4.7-12.3 0-17L122.7 256 4.2 136.3c-4.7-4.7-4.7-12.3 0-17L24 99.5c4.7-4.7 12.3-4.7 17 0l146.8 148c4.7 4.7 4.7 12.3 0 17z"/></svg>');
    } 
}

.btn-link{
    position:relative;
    font-size: 14px;
    text-decoration: underline;
    text-transform: uppercase;
    color: $btn-secondary-background;
    fill: $btn-secondary-background;
    @include border-box();
    &.invert {
        color: $main-background;
        fill: $main-background;
        &:hover,
        &:focus {
            color: $main-background;
            fill: $main-background;
        }
    }
    &:hover,
    &:focus{
        color: $main-foreground;
        fill: $main-foreground;
        opacity: 0.6;
    }
    &-small{
        font-size: 12px;
    }
}
.btn-floating{
    position:absolute;
    top: 0;
    right: 0;
    padding: 3px 5px;
    color:rgba($main-foreground, .8);
    fill:rgba($main-foreground, .8);
    background-color:$main-background;
    border:1px solid rgba($main-foreground, .8);
    font-size: 18px;
    z-index:100;
    &:hover,
    &:focus {
        opacity: 0.8;
    }
    &.fixed-bottom {
        position: fixed;
        top: auto;
        bottom: 20px;
        right: 20px;
    }
}

.btn-whatsapp {
    z-index: 999;
    color: white;
    background-color:#4dc247;
    box-shadow: 2px 2px 6px rgba(0,0,0,0.4);
    border-radius: 50%;
    border:0;
    svg {
        width: 30px;
        height: 30px;
        padding: 5px 2px;
        fill: white;
        vertical-align:middle;
    }
}

.btn-footer{
    background-color: $footer-foreground;
    color: $footer-background;
    border:0;
    &:hover,
    &:focus{
        background-color: $footer-foreground;
        color: $footer-background;
        opacity: 0.95;
    }
}

.btn-square {
    position: relative;
    display: inline-block;
    width: 30px;
    height: 30px;
    vertical-align: bottom;
    font-size: 0;
    &.btn-icon:before {
        position: absolute;
        top: 4px;
        left: 11px;
        width: 20px;
        height: 15px;
    }
}

.theme-wide {
  .btn-small {
    font-size: 12px;
    letter-spacing: 2px;
  }
  .btn-smallest {
    letter-spacing: 1px;
  }
}

.btn-small{
    font-size: 15px;
}

.btn.btn-smallest{
    padding: 5px 7px;
}

.btn.font-small-extra{
    font-size: 10px;
}


{# /* // Links */ #}

a{
    color: $main-foreground;
    font-family: $font-body;
    &:active,
    &:focus,
    &:hover {
        outline: 0;
        box-shadow: none;
    }
}

.link-module{
    border-bottom: 1px solid rgba($main-foreground, .2); 
}

{# /* // Progress bar */ #}

.bar-progress {
    background: rgba($main-foreground, 0.1);
    &-active {
        background: $btn-primary-background;
    }
    &-check {
        background-color: $btn-primary-background;
        fill: $main-background;
        border: 2px solid $main-background;
    }
}

{# /* // Chips */ #}

.chip {
    background: transparent;
    color: $btn-primary-background;
    &-remove-icon {
        fill: $main-foreground;
    }
    &:hover,
    &:focus {
        background: transparent;
        color: $main-foreground;
        opacity: 0.6;
    }
}


{# /* // Modals */ #}

.modal,
.modal-xs-dialog{
    background: $main-background;
    color: $main-foreground;
}

.modal-header {
    border-bottom:1px solid rgba($main-foreground, 0.1);
}

.modal-footer {
    background: $main-background;
    color: $main-foreground;
    border-top:1px solid rgba($main-foreground, 0.1);
    box-shadow:none;
}


{# /* // Badge */ #}

.badge {            
    color: $main-background;
    background-color: $main-foreground;
}

.badge-primary {            
    color:  $main-background;
    background-color: $btn-primary-background;
}

{# /* // Tooltip */ #}

.tooltip {
    background: $btn-primary-background;
    color: $main-background;
    .tooltip-arrow{
      border-left: 10px solid transparent;
      border-right: 10px solid transparent;
      border-bottom: 10px solid $btn-primary-background;
    }
}

{# /* // Dividers */ #}

hr{
    border: 1px solid rgba($main-foreground, .1);
    border-bottom:0;
}
.divider-dotted{
    border-bottom:1px dotted rgba($main-foreground, .2);
}

.divider{
  margin: 20px 0;
  clear: both;
  border-bottom: 1px solid rgba($main-foreground, .1);
}

{# /* // Forms */ #}

select, textarea{
    font-family:$font-btn;
}
input,
textarea{
    @include border-radius(0);
    @include webkit-appearance-none();
    font-family: $font-body;
}
input[type=text], 
input[type=password],
input[type=number], 
input[type=email], 
input[type=url], 
input[type=tel], 
input[type=search], 
textarea{
    border:1px solid rgba($main-foreground, .3);
}

input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
    margin: 0;
    -webkit-appearance: none;
}

input[type=number] {
    -moz-appearance: textfield;
}

input.form-control{
    height: 40px;
    width: 100%;
    padding:10px;
    margin: 0;
    @include border-box();
    &.form-control-xs{
        height: 36px;
    }
}

.form-control::-webkit-input-placeholder { 
  color: rgba($main-foreground, .3);
}
.form-control:-moz-placeholder {
  color: rgba($main-foreground, .3);
}
.form-control::-moz-placeholder {
  color: rgba($main-foreground, .3);
}
.form-control:-ms-input-placeholder {
  color: rgba($main-foreground, .3);
}

.input-clear-content:before {
  content: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" fill="{{ settings.button_bg |replace("#","%23") }}"><path d="M242.72 256l100.07-100.07c12.28-12.28 12.28-32.19 0-44.48l-22.24-22.24c-12.28-12.28-32.19-12.28-44.48 0L176 189.28 75.93 89.21c-12.28-12.28-32.19-12.28-44.48 0L9.21 111.45c-12.28 12.28-12.28 32.19 0 44.48L109.28 256 9.21 356.07c-12.28 12.28-12.28 32.19 0 44.48l22.24 22.24c12.28 12.28 32.2 12.28 44.48 0L176 322.72l100.07 100.07c12.28 12.28 32.2 12.28 44.48 0l22.24-22.24c12.28-12.28 12.28-32.19 0-44.48L242.72 256z"/></svg>');
}

input.input-shipping {
  width: 200px;
}

.radio-button-container{
    .radio-button {
        &-content{
            fill: $main-foreground;
            border-bottom: 1px solid rgba($main-foreground, .1);
        }
        input[type="radio"]{
            &:checked {
                + .radio-button-content{
                    color: $btn-primary-background;
                    fill: $btn-primary-background;
                    outline: 2px solid $btn-primary-background;
                    outline-offset: -1px;
                    .unchecked{
                        border: 2px solid $btn-primary-background;
                    }
                }
                .shipping-method-price{
                    color: $btn-primary-background;
                }
            }

            & +  .radio-button-content .unchecked{
              border: 2px solid $main-foreground;
            }
            & +  .radio-button-content .checked{
              background-color: $btn-primary-background;
            }
        }
    }
    .shipping-extra-options .radio-button-item:first-child {
        .radio-button-content{
            border-top: 1px solid rgba($main-foreground, .1);
        }
        input[type="radio"]:checked .radio-button-content{
            border: 2px solid $btn-primary-background;
        }
    }
    .radio-button-item:last-of-type .radio-button-content{
        border-bottom: 0;
    }
}

.checkbox-container{
    .checkbox-icon {
        background: $main-background;
        border: 2px solid $main-foreground;
        &:after {
          border: solid $btn-primary-background;
          border-width: 0 2px 2px 0;
        }
    }
    .checkbox:hover,
    input:checked ~ .checkbox {
        color: $btn-primary-background;
        fill: $btn-primary-background;
        .checkbox-icon {
            border: 2px solid $btn-primary-background;
        }
    }
    .checkbox-color{
        border: 2px solid $main-foreground;
    }
}

{# /* Lists */ #}

.list-readonly {
    .list-item {
        border-bottom: 1px solid rgba($main-foreground, .1);
        .radio-button-content{
            border-bottom: none;
        }
        &:only-child,
        &:last-of-type {
            border-bottom: 0;
        }
    }
    .shipping-extra-options .list-item:first-child {
        border-top: 1px solid rgba($main-foreground, .1);
        .radio-button-content{
            border-top: none;
        }
    }
    .list-item:last-of-type .radio-button-content{
        border-bottom: none;
    } 
}

{# /* // Alerts and notifications */ #}

.alert{
    &-primary {
        background: rgba($main-foreground, .02);
        color: $btn-primary-background;
    }
    &-danger,
    &-error{
        color: set-foreground-color($main-background, #cc4845);
        fill: set-foreground-color($main-background, #cc4845);
        &-contrast {
            color: set-foreground-color-footer($footer-background, #cc4845);
        }
    }
    &-warning{
        color: set-foreground-color($main-background, #c09853);
    }
    &-info{
        color: set-foreground-color($main-background, #3a87ad);
    }
    &-success{
        color: #3caf65;
        &-contrast {
            color: lighten(#3caf65, 20%);
        }
    }
}

.notification-primary{
    color: $main-foreground;
    border: 1px solid rgba($main-foreground, .2);
    background-color: $main-background;
}

.notification-floating .notification-primary{
    background: $main-background;
}
.notification-arrow-up:after {
    top: -27px;
    border-color: transparent transparent transparent $main-background;
    border-width: 9px;
}
.notification-arrow-up:before {
    top: -28px;
    border-color: transparent transparent transparent rgba($main-foreground, .2);
    border-width: 9px;
}
.notification-secondary {
    background: darken($main-background, 3%);
    color: rgba($main-foreground, .8);
    border-color: darken($main-background, 10%);
    a {
        color: $nav-foreground;
        font-family: $font-nav;
        &:hover,
        &:active,
        &:focus{
            color: $nav-hover-foreground;
        }
    }
}

.notification-foreground {
    background: rgba($main-foreground, .95);
    color: $main-background;
    border: 0;
    .btn-link:hover,
    .btn-link:focus {
        color: $btn-secondary-background;
        fill: $btn-secondary-background;
    }
}

.notification-fixed-bottom {
    border-top: 1px solid rgba($main-foreground, .2);
}

{# /* // Borders */ #}

.border-left{
    border-left:1px solid rgba($main-foreground, .2);
}
.border-top{
    border-top:1px solid rgba($main-foreground, .2) !important;
}
.border-right{
    border-right:1px solid rgba($main-foreground, .2);
}
.border-bottom{
    border-bottom:1px solid rgba($main-foreground, .2);
}

{# /* // Tabs */ #}

.tab-group{
  .tab{
    &-link{
      border: 1px solid transparent;
      color: $main-foreground;
    }
    &.active{
      .tab-link{
        color: $btn-secondary-background;
        border-bottom:2px solid $btn-secondary-background;
      }
    }
  }
}

{# /* // Panels */ #}

.panel{
    @include border-box();
    border:1px solid rgba($main-foreground, .2);
    background-color: $main-background;
    .panel-head{
        padding:10px;
        border-bottom:1px solid rgba($main-foreground, .2);
    }
    .panel-body{
        padding:10px;
    }
    .panel-footer{
        padding:10px;
        border-top:1px solid rgba($main-foreground, .2);
    }
}

{# /* Pills */ #}


.pill-link{
    background-color:rgba($main-foreground, .1);
    color: $main-foreground;
    text-transform: uppercase;
    &:hover,
    &:focus{
        opacity: 0.6;
        color: $main-background;
    }
}

{# /* Slider */ #}

.swiper-container-horizontal .swiper-pagination-bullets .swiper-pagination-bullet {
  background: $main-foreground;
}

{# /* Banners */ #}

.textbanner-title {
    font-family: $font-headings;
}

.services,
.mobile-services-container{
    background: $main-background;
}
.service-title{
    font-family: $font-headings;
}

.services .span4:not(:last-child), 
.services .span6:not(:last-child){
    border-right: 1px solid;
    border-color:$main-foreground;
}
.banner-services-footer{
    background: $main-background;
    border-top: 1px dotted #a0a0a0; 
}

{# /* // Modules with image and text */ #}

.module-text-title {
    font-family: $font-headings;
}

{# /* // Thumbs swiper */ #}

.swiper-vertical-btn{
    background-color: $main-foreground;
    fill: $main-background;
    &:hover{
        background-color: lighten($main-foreground, 10%);
    }
}

{# /* // Tables */ #}

.table {
    tbody>tr:nth-child(odd) {
    >th,
    >td {
          background-color: rgba($main-foreground, .03);
        }
      }
    td,
    th {
        border-top: 1px solid rgba($main-foreground, .2);
    }
}

{# /* // Video */ #}

.embed-responsive {
    background: $main-foreground;
}


{#/*============================================================================
  #Social
==============================================================================*/#}

{# /* // Instafeed */ #}

.instafeed-info-item {
    color: $main-foreground;
}
{% if settings.version_theme == 'full' %}
    .instafeed-fallback {
        background: rgba($main-foreground, .03);
    }
{% endif %}

{# /* // Facebook */ #}

{% if has_logo %}
.fb-page-img-container{
    {% if settings.head_background  == 'dark' %}
        background: $main-foreground;
    {% else %}
        background: $main-background;
    {% endif %}
}
{% endif %}

{#/*============================================================================
  #Header and nav
==============================================================================*/#}

{# /* // Advertising Bar */ #}

{% if settings.ad_bar_background == 'light' %}
    $adbar-bg-color: $main-background;
    $adbar-fg-color: $main-foreground;
{% elseif settings.ad_bar_background == 'dark' %}
    $adbar-bg-color: $main-foreground;
    $adbar-fg-color: $main-background;
{% elseif settings.ad_bar_background == 'primary' %}
    $adbar-bg-color: $btn-primary-background;
    $adbar-fg-color: $btn-foreground;
{% else %}
    {% if settings.head_background == 'light' or settings.head_background == 'transparent' %}
        $adbar-bg-color: $main-foreground;
        $adbar-fg-color: $main-background;
    {% else %}
        $adbar-bg-color: $main-background;
        $adbar-fg-color: $main-foreground;
    {% endif %}
{% endif %}

.ad-container {
    color: $adbar-fg-color;
    background-color: $adbar-bg-color;
    {% if settings.ad_bar_background == 'light' and (settings.head_background == 'light' or settings.head_background == 'transparent') %}
        border-bottom: 1px solid rgba($main-foreground, .3);
    {% elseif settings.ad_bar_background == 'dark' and settings.head_background == 'dark' %}
        border-bottom: 1px solid rgba($main-background, .3);
    {% endif %}
    a {
       color: $adbar-fg-color; 
    }
}

{# /* // Head */ #}

.head-container {
    background: $main-background;
}

.theme-wide {
    .container-product-grid {
        padding: 0;
    }
    .searchbox form {  
        input.header-input { 
            background: transparent;
            border-bottom: 1px solid rgba($main-foreground, .3);
        }
        .btn-desktop-search {
            fill: $main-foreground;
        }
    }
    .cart-summary {       
        background-color: transparent;
        a {
            fill: $main-foreground;
        }
    }

    {# /* // Header Dark */ #}

    .head-dark {
        background: $main-foreground;
        .search-logo-cart-container a {
            color: $main-background;
        }
        .searchbox {
            form {  
                input.header-input { 
                    border-bottom: 1px solid rgba($main-background, .3);
                }
                .btn-desktop-search {
                    fill: $main-background;
                }
            }
            .search-suggest a {
                 color: $main-foreground;
            }
        }
        .desktop-nav,
        .desktop-nav-item { 
            .desktop-nav-list {
                background-color: $main-foreground;
            }
        }
        .cart-summary {       
            a {
                fill: $main-background;
                span {                                        
                    color: $main-foreground;
                    background-color: $main-background;
                }
            }
        }
        .svg-icon-text,
        .svg-icon-nav {
            fill: $main-background;
        }
        {% if settings.logo_position == 'left' %}
            .desktop-nav-arrow svg {
                fill: $main-background;
            }
            .megamenu {
                background-color: $main-foreground;
                .megamenu-list .desktop-nav-item .desktop-nav-link {
                    color: $main-background;
                }
                &::-webkit-scrollbar-track {
                  background: rgba($main-background, .5);
                }
                &:-webkit-scrollbar-thumb {
                  background: rgba($main-background, .8%);
                }
                &::-webkit-scrollbar-thumb:hover {
                  background: $main-background;
                }
            }
        {% endif %}
    }
}

{% if settings.version_theme == 'full' and settings.head_background == 'transparent' and settings.logo_position == 'left' %}
    .theme-full {
        .head-logo-left.head-transparent {
            background: rgba($main-background, .4);
            background: -moz-linear-gradient(top, rgba($main-background,0.75) 0%, rgba($main-background,0) 100%);
            background: -webkit-gradient(left top, left bottom, color-stop(0%, rgba($main-background,0.75)), color-stop(100%, rgba($main-background,0)));
            background: -webkit-linear-gradient(top, rgba($main-background,0.75) 0%, rgba($main-background,0) 100%);
            background: -o-linear-gradient(top, rgba($main-background,0.75) 0%, rgba($main-background,0) 100%);
            background: -ms-linear-gradient(top, rgba($main-background,0.75) 0%, rgba($main-background,0) 100%);
            background: linear-gradient(to bottom, rgba($main-background,0.75) 0%, rgba($main-background,0) 100%);
            filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='$main-background', endColorstr='$main-background', GradientType=0 );
            position: absolute;
            width: 100%;
            box-shadow: 0 1px 3px rgba(0,0,0,0);
        }
        .head-logo-left.head-transparent.head-fix {
            position: fixed;
        }
        .head-logo-left.head-transparent.head-trans-out {
            background: rgba($main-background, 1);
            box-shadow: 0 1px 3px rgba(0,0,0,0.3);
        }
        .head-transparent .megamenu {
            background-color: rgba($main-background, .9);
        }
    }
{% endif %}


{# /* // Logo */ #}

.logo-text{
    color: $main-foreground;
    text-transform: capitalize;
    font-weight: bold;
}

{# /* // Nav desktop */ #}

.desktop-nav{
    background-color: $nav-background;
    border-top: 1px solid $nav-borders;
    border-bottom: 1px solid $nav-borders;
    &-link{
        color: $nav-foreground;
        font-family: $font-nav;
        &:hover,
        &:active,
        &:focus{
            color: $nav-hover-foreground;
        }
    }
    &-item{
        background-color: $nav-background;
    }
    &-item.selected > .desktop-nav-link{
        color: $nav-hover-foreground;
    }
    & > .selected{
        & > .desktop-nav-link{
            border-top: 1px solid $nav-hover-foreground;
            border-bottom: 1px solid $nav-hover-foreground;
        }
    }
    &-list{
        border: 1px solid $nav-borders;
        background-color:$nav-background;
    }
    .desktop-nav-arrow svg {
        fill: $nav-foreground;
    }

}

.desktop-nav-first-level > .desktop-nav-item.current > .desktop-nav-link {
    border-top: 1px solid $nav-hover-foreground;
    border-bottom: 1px solid $nav-hover-foreground;
}

.megamenu,
.head-transparent.head-fix .megamenu {
    background-color: $nav-background;
    border-top: 1px solid $nav-borders;
    border-bottom: 1px solid $nav-borders;
}

.megamenu::-webkit-scrollbar-track {
  background: rgba($main-foreground, .5);
}
.megamenu::-webkit-scrollbar-thumb {
  background: rgba($main-foreground, .8%);
}
.megamenu::-webkit-scrollbar-thumb:hover {
  background: $main-foreground;
}

.footer a {
    font-family: $font-nav;
}
.powered-by-logo svg { 
    fill:$main-foreground; 
}

{# /* // Nav mobile */ #}

.mobile-nav{
    background-color:$main-background;  
    border-bottom: 1px solid $nav-borders;

    &-title{
        font-family: $font-headings;
    }
    &-second-row{
        background-color: $nav-background;
    }
    &-tab.selected{
        border-bottom: 2px solid $nav-hover-foreground;
    }
    &-tab-text{
        color: $nav-foreground;
        fill: $nav-foreground;
    }
    &-tab.selected .mobile-nav-tab-text{
        color: $nav-hover-foreground;
        fill: $nav-hover-foreground;
    }
    &-cart-amount{
        background-color: $nav-hover-foreground;
        color: $nav-background;
    }
    input.mobile-search-input{
        background-color:$main-background;
    }
}
.mobile-nav-categories-container{
    background-color: $main-background;
    box-shadow: 2px 0px 1px 1px rgba(0, 0, 0, 0.14), 0 3px 1px -2px rgba(0, 0, 0, 0.2), 0 1px 5px 0 rgba(0, 0, 0, 0.12);
}

{# /* Hamburger nav */ #}

.hamburger-panel{
    background-color: $main-background;
    &-link{
        color: $main-foreground;
        border-top: 1px solid rgba($main-foreground, 0.1);
        &.selected{
            background:$btn-primary-background;
            color: $main-foreground;
        }
    }
    &-first-row,
    &-accordion{
        background:rgba($main-foreground, 0.1);
        color:white;
    }
    .mobile-accounts {
        background-color: $main-background;
        border-top: 1px solid rgba($main-foreground, .2);
        &-link {
            color: rgba($main-foreground, 0.8);
        }
    }
    .btn-hamburger-close {
        color: $main-foreground;
    }
    .hamburger-panel-arrow {
        color: $main-foreground;
        &-icon {
            fill: $main-foreground;
        }
    }
}

{# /* // Search suggestions */ #}

.search-suggest{
    background-color: $main-background;
    &-link,
    &-icon{
        color: rgba($main-foreground, 0.8);
        &:hover,
        &:focus{
            color: rgba($main-foreground, 0.6);
            background-color: darken($main-background, 3%);
        }
    }
    &-all-link{
        background-color: darken($main-background, 3%);
    }
}

{# /* // User Accounts */ #}

.user-items {
    background: $main-foreground;
    a {
        display: block;
        color: $main-background;
    }
}
.user-items:before {
    background: $main-foreground;    
}

.user-badge {
    background: $btn-primary-background;
    color: $main-background;
    fill: $main-background;
}

{# /* // Cart widget desktop */ #}

.cart-summary{
    background-color: $btn-secondary-background;
    color: $btn-foreground;
    font-family:$font-btn;
    &:hover{
        opacity: 0.8;
    }
    a {
        color: $btn-foreground;
    }
    &-icon {
        fill: $btn-foreground;
    }
}

{#/*============================================================================
  #Product grid
==============================================================================*/#}

{# /* // Filters */ #}

.filters-container {
  margin: 0 0 25px 0;
  border-bottom: 1px solid rgba($main-foreground, .2);
  padding-bottom: 20px;
}

.filters-overlay {
    background-color: rgba($main-background, .85);
}

{# /* // Grid item */ #}

.item{
    border-top:1px solid rgba($main-foreground, .2);
    &-name{
        font-family: $font-item-title;
    }
    &-price-compare{
        border-right: 1px solid $main-foreground;
    }
    &-quickshop-link{
        background-color: $footer-background;
        span,
        span:hover{
            color: $footer-foreground;
        }
    }
    &-colors-bullet {
        background-color: $main-background;
        &-text {
            background-color: $main-background;
        }
        border: 1px solid rgba($main-foreground, .5);
        &.selected {
            border: 1px solid $main-foreground;
        }
    }
}

{# /* // Labels */ #}

.label-light{
    background: rgba($main-background, .85);
    color: $main-foreground;
    border: 1px solid rgba($main-foreground, .3);
}
.label-primary,
.label-accent {
    background: $accent-background-color;
    color: $accent-foreground-color;
}
.label-secondary {
    background: $footer-background;;
    color: $footer-foreground;
}
.label-line {
    border-color: rgba($accent-background-color, .3);
    color: $accent-background-color;
}

{#/*============================================================================
  #Product detail
==============================================================================*/#}

.cloud-zoom-big {
    background-color: $main-background;
}

{# /* // Color variations */ #}

.btn-variant { 
    border: 2px solid rgba($main-foreground, 0.2); 
    &.selected{
        border: 2px solid $btn-secondary-background;
    }
} 

{# /* // Labels */ #}

.product-detail-label.label-light{
    border: 1px solid rgba($main-foreground, .3);
}

{# /* // CTA */ #}

.product-buy-fixed.affix .product-buy-container{
    background: $main-background;
    border: 1px solid rgba($main-foreground, .2);
}

{#/*============================================================================
  #Footer
==============================================================================*/#}

.rounded-icon {
  &.password-page-icon {
    color: $footer-foreground;
    background-color: $footer-background;
  }
}
.footer{
    background-color: $footer-background;
    color: $footer-foreground;
    h4,
    &-icon,
    a,
    li {
        color: $footer-foreground;
    }
    &-icon {
        fill: $footer-foreground;
    }
    .rounded-icon {
      color: $footer-background;
      background-color: $footer-foreground;
    }
}

input.footer-input {
    background-color: $footer-background;
    border: 1px solid $footer-foreground;
    color: $footer-foreground;
}

{#/*============================================================================
  #Cart page
==============================================================================*/#}

{# /* // Table */ #}

.cart-table-row{
    border-bottom: 1px solid;
    border-color: rgba($main-foreground, .2 );
}
.cart-table-header {
    border-bottom: 1px solid $main-foreground;
}
.cart-quantity-btn{
    color: $main-foreground; 
    border:1px solid $main-foreground; 
}
input.cart-quantity-input{
    border:0;
    border-top:1px solid rgba($main-foreground, .8); 
    border-bottom:1px solid rgba($main-foreground, .8);
}
.cart-total{
    color: $btn-primary-background;
}
.cart-totals-container {
    border-bottom: 1px solid rgba($main-foreground, .7 );
    background: rgba($main-foreground, .02 );
}

{# /* // Ajax cart */ #}

.cart-contents .name{
    color: $main-foreground;
    font-family: $font-body;
}
.ajax-cart-container{
    background: $main-background; 
    .ajax-cart-title{
        font-family: $font-headings;
    }
    .ajax-cart-table-header{ 
        font-family: $font-headings;
        border-top: 1px solid rgba($main-foreground, 0.1);
        border-bottom: 1px solid rgba($main-foreground, 0.1);
    }
    .ajax-cart-item { 
        border-bottom: 1px solid rgba($main-foreground, 0.1); 
    }
    .ajax-cart-shipping-calculator{
        background-color: rgba($main-foreground, 0.01); 
        border-top: 1px solid rgba($main-foreground, 0.1); 
        border-bottom: 1px solid rgba($main-foreground, 0.1); 
    }
}

{#/*============================================================================
  #Media queries
==============================================================================*/#}

{# /* // Max width 769px */ #}

@media(max-width: 769px){

    {# /* //// Texts */ #}

    {# /* Headings */ #}
    
    .h1-xs {
        font-size: 28px;
    }
    .h2-xs {
        font-size: 24px;
    }
    .h3-xs {
        font-size: 22px;
    }
    .h4-xs {
        font-size: 20px;
    }
    .h5-xs {
      font-size: 18px;
    }
    .h6-xs {
        font-size: 16px;
    }

    {# /* Body */ #}
    
    .font-body-xs {
        font-size: 14px;
    }
    .font-small-xs {
      font-size: 12px;
    }
    .font-small-extra-xs {
        font-size: 10px;
    } 

    {# /* Weight */ #}

    .weight-normal-xs {
        font-weight: 400;
    }
    .weight-strong-xs {
        font-weight: 700;
    }

    {# /* //// Components */ #}

    {# /* Buttons and links */ #}

    .btn{
        padding:12px;
    }
    .btn-floating{
        top: 5px;
        padding: 2px 7px;
        &-sticky {
            position: sticky;
            z-index: 9;
            top: 20px;
        }
    }

    .btn-module {
        border: 1px solid rgba($main-foreground, .2);
        border-radius: 0;
        background: $main-background;
        .btn-module-icon,
        .btn-module-icon-right{
            color: $btn-secondary-background; 
            fill: $btn-secondary-background; 
        }
    }
    .link-module-icon,
    .link-module-icon-right{
        color:$main-foreground;
        fill:$main-foreground;
    }
    .link-module{
        border-bottom: 1px solid rgba($main-foreground, .2); 
        border-top: 1px solid rgba($main-foreground, .2); 
    }
    
    {# /* Wrappers */ #}

    .container-xs{
        padding: 0 15px;
        @include border-box();
    }

    {# /* Forms */ #}

    input.form-control{
        height: 44px;
    }
    input.input-shipping{
        width: 46%;
        height: 47px; 
    }
    .newsletter-footer{
        input.newsletter-footer-input {
          width: 70%;
        }
        &-btn,
        input.newsletter-footer-btn{
          width: 30%;
        }
    }
    
    {# /* Modals */ #}

    .modal-xs{
        background-color:$main-background; 
        &.sheet-bottom {
           background-color: transparent;
        }
        .sheet-bottom-body {
            background-color:$main-background; 
        }
        &-header{
            background-color:rgba($main-foreground, .03);
            &.sheet-bottom-header{
                background-color:darken($main-background, 2%);
                &:active{
                    background-color:darken($main-background, 2%);
                    color:$main-foreground;
                }
            }
            &:active{
                background-color:$btn-secondary-background;
                color:$main-background;
                .modal-xs-header-icon{
                    color:$main-background;
                    fill:$main-background;
                }
            }
            &-icon{
                color:$btn-secondary-background;
                fill:$btn-secondary-background;
            }
        }
    }

    .modal-xs-list-item{
        color: $main-foreground;
        border-bottom: 1px solid rgba($main-foreground, .25);
        &.darker{
            background-color:rgba($main-foreground, 0.02);
        }
        .modal-xs-list-icon{
            fill:$btn-secondary-background;
        }
        &:active{
            background-color:$btn-secondary-background;
            color:$main-background;
            .modal-xs-list-icon{
                color:$main-background;
                fill:$main-background;
            }
        }
        &.selected{
            color: $main-background;
            border-right: 0;
            border-left: 0;
            border-bottom: 0;
            background: $btn-secondary-background;
            .modal-xs-radio-icon {
                background: $main-background;
                color: $btn-secondary-background;
                svg{
                    visibility: visible; 
                    fill: $btn-secondary-background;
                }
            }
        }
        .modal-xs-radio-icon {
            background: rgba($btn-secondary-background, .4);
        }
    }
    
    {# /* //// Header and nav */ #}

    {# /* Search Suggestons */ #}

    .mobile-search-backdrop{
        background-color: rgba($main-background, .9);
    }

    .mobile-nav-search-row form {
        max-width: 100%;
        .mobile-search-input-container {
            background: $main-background;
            .mobile-search-input-back {
                color: $main-foreground;
            }
            .mobile-search-input {
                border-bottom: 1px solid rgba($main-foreground, .3) !important; /* Override Bootstrap */
            }
            .mobile-search-input-submit {
                color: $main-foreground;
                background: transparent;
            }
        }
    }

    .theme-wide {
        .mobile-nav-second-row {
            border-top: 1px solid rgba($main-foreground, .1);
            border-bottom: 1px solid rgba($main-foreground, .1);
        }
        .search-fix-tab {
            form input.header-input {
                border: none;
                border-right: 1px solid rgba($main-foreground, .1);
                background: rgba($main-foreground, .05);
                border-radius: 0;
                @include webkit-appearance-none();
            }
        }

        .search-fix form input.header-input {
            border: none;
            border-top: 1px solid rgba($main-foreground, .1);
            border-bottom: 1px solid rgba($main-foreground, .1);
            border-radius: 0;
            @include webkit-appearance-none();
        }
        .head-dark {
            .mobile-search-btn,
            .mobile-nav-first-row-icon,
            .mobile-nav-tab-text,
            {
                color: $main-background;
                fill: $main-background;
            }
            .mobile-nav-categories-container a,
            .modal-xs-list-item {
                color: $main-foreground;
            }
            .search-fix form input.header-input {
                border-top: 1px solid rgba($main-background, .1);
                border-bottom: 1px solid rgba($main-background, .1);
            }
            .mobile-nav-second-row {
                background: $main-foreground;
                border-top: 1px solid rgba($main-background, .1);
            }
            .search-fix-tab {
                form input.header-input {
                    color: $main-background;
                    background: rgba($main-background, .05);
                    border: none;
                    border-right: 1px solid rgba($main-background, .1);
                    
                }
            }
        }
    }
    .theme-full {        
        .head-logo-left.head-transparent {
            background:$main-background;
            position: relative;
        }
        .head-logo-left.head-transparent.head-trans-out {
            background: $main-background;
        }
    }

    {# /* //// Footer */ #}

    .theme-wide { 
        .newsletter-footer{
            input.newsletter-footer-input {
              border-bottom: 1px solid $footer-foreground;
            }
        }
    }

    {# /* //// Product grid */ #}

    .category-controls {
        background-color: $main-background;
        &.is-sticky {
            border-bottom: 1px solid rgba($main-foreground, .1);
        }
    }

    {# /* //// Product detail */ #}

    .quantity-container{
        border-top:1px solid rgba($main-foreground, .2);
        border-bottom:1px solid rgba($main-foreground, .2);
    }
    
    .mobile-zoom-panel{
        background:$main-background;
    }

    {# /* //// Cart */ #}

    .cart-shipping-calculator{
        background-color: rgba($main-foreground, 0.01); 
        border-top: 1px solid rgba($main-foreground, 0.1); 
        border-bottom: 1px solid rgba($main-foreground, 0.1); 
    }
    .cart-totals-container{
        background-color:transparent;
        border-bottom:0;
    }

    {# /* Slider */ #}

    .theme-wide .placeholder-page{
        background: $main-foreground;
    }

}
