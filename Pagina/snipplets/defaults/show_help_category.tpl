{# Products that work as examples #}
<div class="banner">
    {% include "snipplets/svg/banner-category.tpl" %}
</div>
<div class="row-fluid">
    <div class="row-fluid">
        <div class="pull-left full-width m-bottom">
            <div class="subtitle-container">
                <h2>{{"Productos de ejemplo" | translate}}</h2>
            </div>
            <div class="grid-row visible-when-content-ready m-bottom">  
                <div class="span3 item-container">
                    <div class="item">
                        <div class="item-image-container">
                            <div class="item-label item-label-offer product-label label-primary">
                                33% OFF
                            </div>
                            <a href="/product/example" title="{{ product.name }}" class="product-image">
                                {% include "snipplets/svg/help-product-2.tpl" %}
                            </a>
                        </div>
                        <div class="item-info-container">
                            <div class="title">
                                <a href="/product/example" class="item-name" title="{{ product.name }}">{{ "Producto de ejemplo" | translate }}</a>
                            </div>
                            <div class="item-price-container price m-none-xs">
                                <span class="price-compare">
                                    <span id="compare_price_display" class="item-price-compare p-none-left-xs p-right-quarter-xs">{{"150000" | money }}</span>
                                </span>
                                <span class="price item-price h6" id="price_display">{{"100000" | money }}</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="span3 item-container">
                    <div class="item">
                        <div class="item-image-container">
                            <a href="/product/example" title="{{ product.name }}" class="product-image">
                                {% include "snipplets/svg/help-product-1.tpl" %}
                            </a>
                            <div class="item-label product-label label-bottom label-light">
                                <span class="m-right-quarter d-inline-block label-shipping-icon svg-icon-text">
                                    {% include "snipplets/svg/truck.tpl" %}
                                </span>
                                <span class="d-inline-block">
                                    {{ "Envío gratis" | translate }}
                                </span>
                            </div>
                        </div> 
                        <div class="item-info-container">
                            <div class="title">
                                <a href="/product/example" class="item-name" title="{{ product.name }}">{{ "Producto de ejemplo" | translate }}</a>
                            </div>
                            <div class="item-price-container price m-none-xs">
                                <span class="price-compare">
                                    <span id="compare_price_display" class="item-price-compare p-none-left-xs p-right-quarter-xs">{{"450000" | money }}</span>
                                </span>
                                <span class="price item-price h6" id="price_display">{{"100000" | money }}</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="span3 item-container">
                    <div class="item">
                        <div class="item-image-container"> 
                            <a href="/product/example" title="{{ product.name }}" class="product-image">
                                {% include "snipplets/svg/help-product-6.tpl" %}
                            </a>
                        </div> 
                        <div class="item-info-container">
                            <div class="title">
                                <a href="/product/example" class="item-name" title="{{ product.name }}">{{ "Producto de ejemplo" | translate }}</a>
                            </div>
                            <div class="item-price-container price m-none-xs">
                                <span class="price-compare">
                                    <span id="compare_price_display" class="item-price-compare p-none-left-xs p-right-quarter-xs">{{"132000" | money}}</span>
                                </span>
                                <span class="price item-price h6" id="price_display">{{"102000" | money }}</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="span3 item-container">
                    <div class="item">
                        <div class="item-image-container"> 
                            <a href="/product/example" title="{{ product.name }}" class="product-image">
                                {% include "snipplets/svg/help-product-3.tpl" %}
                            </a>
                        </div> 
                        <div class="item-info-container">
                            <div class="title">
                                <a href="/product/example" class="item-name" title="{{ product.name }}">{{ "Producto de ejemplo" | translate }}</a>
                            </div>
                            <div class="item-price-container price m-none-xs">
                                <span class="price-compare">
                                    <span id="compare_price_display" class="item-price-compare p-none-left-xs p-right-quarter-xs">{{"38000" | money}}</span>
                                </span>
                                <span class="price item-price h6" id="price_display">{{"32000" | money }}</span>
                            </div>
                        </div>
                        <div class="item-label product-label label-light font-small">{{ "Sin stock" | translate }}</div>
                    </div>
                </div>
            </div>
            <div class="grid-row">  
                <div class="span3 item-container">
                    <div class="item">
                        <div class="item-image-container"> 
                            <a href="/product/example" title="{{ product.name }}" class="product-image">
                                {% include "snipplets/svg/help-product-4.tpl" %}
                            </a>
                        </div> 
                        <div class="item-info-container">
                            <div class="title">
                                <a href="/product/example" class="item-name" title="{{ product.name }}">{{ "Producto de ejemplo" | translate }}</a>
                            </div>
                            <div class="item-price-container price m-none-xs">
                                <span class="price-compare">
                                    <span id="compare_price_display" class="item-price-compare p-none-left-xs p-right-quarter-xs">{{"142000" | money}}</span>
                                </span>
                                <span class="price item-price h6" id="price_display">{{"122000" | money }}</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="span3 item-container">
                    <div class="item">
                        <div class="item-image-container"> 
                            <a href="/product/example" title="{{ product.name }}" class="product-image">
                                {% include "snipplets/svg/help-product-9.tpl" %}
                            </a>
                        </div> 
                        <div class="item-info-container">
                            <div class="title">
                                <a href="/product/example" class="item-name" title="{{ product.name }}">{{ "Producto de ejemplo" | translate }}</a>
                            </div>
                            <div class="item-price-container price m-none-xs">
                                <span class="price-compare">
                                    <span id="compare_price_display" class="item-price-compare p-none-left-xs p-right-quarter-xs">{{"142000" | money}}</span>
                                </span>
                                <span class="price item-price h6" id="price_display">{{"122000" | money }}</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="span3 item-container">
                    <div class="item">
                        <div class="item-image-container"> 
                            <a href="/product/example" title="{{ product.name }}" class="product-image">
                                {% include "snipplets/svg/help-product-8.tpl" %}
                            </a>
                        </div> 
                        <div class="item-info-container">
                            <div class="title">
                                <a href="/product/example" class="item-name" title="{{ product.name }}">{{ "Producto de ejemplo" | translate }}</a>
                            </div>
                            <div class="item-price-container price m-none-xs">
                                <span class="price-compare">
                                    <span id="compare_price_display" class="item-price-compare p-none-left-xs p-right-quarter-xs">{{"142000" | money}}</span>
                                </span>
                                <span class="price item-price h6" id="price_display">{{"122000" | money }}</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="span3 item-container">
                    <div class="item">
                        <div class="item-image-container"> 
                            <a href="/product/example" title="{{ product.name }}" class="product-image">
                                {% include "snipplets/svg/help-product-5.tpl" %}
                            </a>
                            <div class="item-label product-label label-bottom label-light">
                                <span class="m-right-quarter d-inline-block label-shipping-icon svg-icon-text">
                                    {% include "snipplets/svg/truck.tpl" %}
                                </span>
                                <span class="d-inline-block">
                                    {{ "Envío gratis" | translate }}
                                </span>
                            </div>
                        </div> 
                        <div class="item-info-container">
                            <div class="title">
                                <a href="/product/example" class="item-name" title="{{ product.name }}">{{ "Producto de ejemplo" | translate }}</a>
                            </div>
                            <div class="item-price-container price m-none-xs">
                                <span class="price-compare">
                                    <span id="compare_price_display" class="item-price-compare p-none-left-xs p-right-quarter-xs">{{"142000" | money}}</span>
                                </span>
                                <span class="price item-price h6" id="price_display">{{"122000" | money }}</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
