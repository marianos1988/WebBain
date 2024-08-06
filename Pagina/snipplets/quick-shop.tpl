{% if settings.quick_view %}
    <div id="quickshop-modal" class="js-fullscreen-modal js-quickshop-container modal modal-xs modal-xs-right hide fade" tabindex="-1" role="dialog" q-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body modal-xs-body p-all-xs">
                    <div class="btn-floating-sticky">
                        <button type="button" class="js-fullscreen-modal-close btn-floating m-top-quarter m-right-quarter" data-dismiss="modal" aria-hidden="true">
                            {% include "snipplets/svg/times.tpl" with {fa_custom_class: "svg-inline--fa"} %}
                        </button>
                    </div>
                    <div class="js-item-product" data-product-id="">
                        <div class="js-product-container js-quickshop-container js-quickshop-modal" data-variants="" data-quickshop-id="">
                            <div class="js-item-variants">
                                <div class="row-fluid">
                                    <div class="span6 text-center">
                                        <div class="quickshop-img-container">
                                            <div class="js-quickshop-img-padding">
                                                <img srcset="" class="js-item-image js-quickshop-img quickshop-img"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="span6">
                                        <div class="product-form-container m-top">
                                            <div class="js-item-name h2 product-name"></div>
                                            <div class="product-price-container m-bottom">
                                                <span class="js-compare-price-display product-price-compare price-compare h5 m-bottom-quarter-xs m-right-half"></span>
                                                <span class="js-price-display product-price d-inline h2"></span>
                                                {{ component('payment-discount-price', {
                                                        visibility_condition: settings.payment_discount_price,
                                                        location: 'product',
                                                        container_classes: "h5 line-height-initial text-accent m-top-half m-bottom-quarter",
                                                        text_classes: {
                                                          price: 'h4 weight-strong',
                                                        }
                                                    }) 
                                                }}
                                            </div>
                                            <hr class="divider"></hr>
                                            <div id="quickshop-form"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
{% endif %}
