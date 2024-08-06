{# Single product that works as an example #}
<div class="container m-top m-top-none-xs container-xs">    
    <div id="single-product">
        <div id="single-product-container" class="row-fluid visible-when-content-ready m-top" >
            <div class="span6">
                <div class="product-img-col">
                    <ul class="js-product-slider visible-phone"> 
                        <li class="js-product-slide product-slide">
                            {% include "snipplets/svg/help-product-2.tpl" %}
                        </li> 
                    </ul> 
                    <div class="desktop-featured-product hidden-phone">
                        <div class="span3"> 
                            <div id="tS3" class="jThumbnailScroller">
                                <div class="jTscrollerContainer">
                                    <div class="jTscroller"> 
                                        {% include "snipplets/svg/help-product-2-green.tpl" %}
                                        {% include "snipplets/svg/help-product-2-red.tpl" %}
                                    </div>
                                </div>
                                <a href="#" class="jTscrollerPrevButton"></a>
                                <a href="#" class="jTscrollerNextButton"></a>
                            </div> 
                        </div>
                        <div class="span9 p-relative">
                            <div class="imagecolContent">
                                {% include "snipplets/svg/help-product-2.tpl" %}
                            </div>
                            <div class="product-label product-detail-label h6 label-primary">33% OFF</div>
                        </div>
                    </div>  
                </div>
                {# Share button #}
                <div class="pull-left m-top">
                    <div class="twitter pull-left m-right-half product-share-button" data-network="twitter">
                        {{product.social_url | tw_share('none', 'Tweet', store.twitter_user, current_language.lang) }}
                    </div>
                    <div class="google pull-left m-right-half product-share-button" data-network="gplus">
                        {{product.social_url | g_plus('large') }}
                    </div>
                    <div class="facebook pull-left m-right-half product-share-button" data-network="facebook">
                        {{product.social_url | fb_like('store-product', 'button_count')}}
                    </div>
                    <div class="js-desktop-pinterest-share pull-left m-right-half pinterest product-share-button" data-network="pinterest">
                        {{product.social_url | pin_it('http:' ~ product.featured_image | product_image_url('large'))}}
                    </div>
                </div>
            </div>

            <div class="span6">
                <div class="product-form-container">
                    <div class="row-fluid">
                        <div class="span12">
                            <div class="title">
                                <h1 class="product-name h2 h4-xs">{{ "Producto de ejemplo" | translate }}</h1>
                            </div> 
                            <div class="price-holder">
                                <div class="price product-price-container m-top-half text-left-xs m-bottom-half-xs m-bottom-half">
                                    <span class="price-compare price-compare h4 p-right-quarter">
                                      <span id="compare_price_display">{{"150000" | money }}</span>
                                    </span>
                                    <span class="price product-price" id="price_display">{{"100000" | money }}</span> 
                                </div>
                            </div>
                        </div>  
                        <div class="installments m-top">
                            <h5>{{ "En hasta 12 cuotas con tarjeta de crédito" | translate }}</h5>
                        </div>
                    </div>
                    <form id="product_form" method="post" action="">
                        <input type="hidden" name="add_to_cart" value="2243561">
                        <div class="row-fluid m-top"> 
                            <div class="span12">
                                <label class="variant-label font-body" for="variation_1">{{ "Talle" | translate }}</label>
                                <select class="variant-select full-width-xs" id="variation_1" name="variation[0]">
                                    <option value="s" selected="selected">{{ "S" | translate }}</option>
                                    <option value="m">{{ "M" | translate }}</option>
                                    <option value="l">{{ "L" | translate }}</option>
                                    <option value="xl">{{ "XL" | translate }}</option>
                                </select>
                            </div>
                            <div class="span12 m-none">
                                <label class="variant-label font-body" for="color_variant">{{ "Color" | translate }}</label>
                                <select class="variant-select full-width-xs" id="color_variant" name="color_variant">
                                    <option value="blue" selected="selected">{{ "Azul" | translate }}</option>
                                    <option value="green">{{ "Verde" | translate }}</option>
                                    <option value="red">{{ "Rojo" | translate }}</option>
                                </select>
                            </div>
                            <div class="span12 m-none">
                                <label class="variant-label font-body" for="variation_3">{{ "Material" | translate }}</label>
                                <select class="variant-select full-width-xs" id="variation_3" name="variation[2]">
                                    <option value="Resorte" selected="selected">{{ "Denim" | translate }}</option>
                                    <option value="Ganchito">{{ "Algodón" | translate }}</option>
                                </select>
                            </div>
                        </div> 
                       <div class="js-product-quantity-container row-fluid quantity-container {% if product.show_installments and not product.variations %} border-none-top {% endif %}">
                            <div class="quantity span3 pull-left">
                                <span class="quantity-label">{{ "Cantidad" | translate }} </span>
                                <input class="spinner quantity-input" value="1" type="number" name="quantity{{ item.id }}" value="{{ item.quantity }}" pattern="\d*"/>
                            </div>
                        </div>
                        
                        <div class="addToCartButton m-top-half m-top-xs">
                            <input type="submit" href="#" class="btn btn-primary js-addtocart cart full-width-xs" value="{{ "Agregar al carrito" | translate }}" disabled>
                        </div>
                        {% if store.country == 'BR' %}
                            <div id="shipping-calculator" class="shipping-calculator text-left">
                                <div class="row-fluid">
                                    <div id="shipping-calculator-form-example" class="shipping-calculator-form">
                                        <span class="shipping-calculator_label text-left-xs m-right-half">{{ "Calculá el costo de tu envío" | translate }}:</span>
                                        <input type="text" name="zipcode" value="{{ cart.shipping_zipcode }}" placeholder="{{ 'Código postal' | translate }}" class="shipping-zipcode">
                                        <button class="calculate-shipping-button btn btn-secondary">{{ "Calcular costo de envío" | translate }}</button>
                                        <span class="loading" style="display: none;">{% include "snipplets/svg/sync-alt-regular.tpl" with {fa_custom_class: "svg-inline--fa fa-spin svg-icon-text"} %}</span>
                                        <span class='alert alert-error invalid-zipcode' style="display: none;">{{ "El código postal es inválido." | translate }}</span>
                                    </div>
                                </div>
                                {# response #}
                                <div id="shipping-calculator-response-example" class="shipping-calculator-response" style="display: none;">
                                    <span>{{ "Este es un ejemplo de opciones de envío para un código postal" | translate }}</span>
                                    <ul class="shipping-list">
                                        <li>
                                            <label for="shipping-1">
                                                <span><img src="http://d26lpennugtm8s.cloudfront.net/assets/common/img/logos/shipping/br/correios/pac@2x.png">Correios - PAC - 6 dias úteis - R$19,10</span>
                                            </label>
                                        </li>
                                        <li>
                                            <label for="shipping-2">
                                                <span><img src="http://d26lpennugtm8s.cloudfront.net/assets/common/img/logos/shipping/br/correios/sedex@2x.png">Correios - SEDEX - 1 dia útil - R$43,00</span>
                                            </label>
                                        </li>
                                    </ul>
                                    <input type="hidden" name="after_calculation" value="1">
                                    <input type="hidden" name="zipcode" value="32682558">
                                </div> 
                            </div>
                        {% endif %}
                    </form>
                    <div class="description visible-when-content-ready user-content">
                        <p>{{ "¡Este es un producto de ejemplo! Para poder probar el proceso de compra, debes" | translate }}
                            <a href="/admin/products" target="_top">{{ "agregar tus propios productos." | translate }}</a>
                        </p>
                    </div>
                    <div class="fb-comments" data-href="/" data-num-posts="5" data-width="100%"></div>
                </div>
            </div>
        </div>
    </div>  
</div> 
</div>
{% if show_help %}
    <script type="text/javascript">
        LS.ready.then(function(){
            DOMContentLoaded.addEventOrExecute(() => {
                var $shipping_calculator = jQueryNuvem("#shipping-calculator");
                var $invalid_zipcode = jQueryNuvem("#invalid-zipcode");
                var $shipping_calculator_loading = $shipping_calculator.find(".loading")
                jQueryNuvem("#calculate-shipping-button-example").on("click", function() {
                    $invalid_zipcode.hide();
                    $shipping_calculator_loading.show();
                    setTimeout(() => $shipping_calculator_loading.hide(), 1800);
                    event.preventDefault(); // cancel default behavior
                    if( jQueryNuvem("#shipping-zipcode").val().length === 8 || jQueryNuvem("#shipping-zipcode").val().length === 9 ) {
                        jQueryNuvem("#shipping-calculator-form-example, #shipping-calculator-response-example").toggle();
                    } else {
                        setTimeout(() => $invalid_zipcode.show(), 1800);
                    }
                }); 

                jQueryNuvem('#color_variant').on("change", function(){
                    var $values_color = jQueryNuvem( "select#color_variant option:selected" ).val();
                    jQueryNuvem('#' + $values_color).click();
                    if ( $values_color == 'green'){
                        jQueryNuvem(".price02").show();
                        jQueryNuvem(".price01").hide();
                    } else {
                        jQueryNuvem(".price02").hide();
                        jQueryNuvem(".price01").show();
                    }
                }); 
            }); 
        }); 
    </script>
{% endif %}
