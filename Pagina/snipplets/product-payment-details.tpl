{% set installments_info = product.installments_info_from_any_variant %}
{% if installments_info %}
    <div id="installments-modal" class="js-fullscreen-modal js-mobile-installments-panel modal modal-xs modal-xs-right hide fade {% if gateways <= '3' %} two-gates {% endif %}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-xs-dialog">
            <div class="modal-header with-tabs">
                <a class="js-mobile-toggle-installments js-fullscreen-modal-close modal-xs-header visible-phone" href="#" data-dismiss="modal">
                    {% include "snipplets/svg/angle-left.tpl" with {fa_custom_class: "svg-inline--fa fa-2x modal-xs-header-icon modal-xs-right-header-icon"} %}
                    <span class="modal-xs-header-text modal-xs-right-header-text">
                        {% if store_set_for_new_installments_view %}
                            {{ 'Medios de pago' | translate }}
                        {% else %}
                            {{ 'Detalles de las cuotas' | translate }}
                        {% endif %}
                    </span>
                </a>                
            </div>
            <div class="modal-content">
                <div class="modal-body modal-xs-body">

                    <button type="button" class="btn-floating m-right-half m-top-quarter hidden-phone" data-dismiss="modal" aria-hidden="true">{% include "snipplets/svg/times.tpl" with {fa_custom_class: "svg-inline--fa"} %}</button>

                    {{ component('payments/payments-details',
                        {
                            text_classes: {
                                text_accent: "label label-primary label-inline m-left-quarter m-bottom-none font-small",
                                subtitles: "h6 box-title",
                                text_big: "font-medium",
                                text_small: "font-small",
                                align_right: "text-right"
                            },
                            spacing_classes: {
                                top_1x: "m-top-quarter",
                                top_2x: "m-top-half",
                                top_3x: "m-top",
                                right_1x: "m-right-quarter",
                                right_2x: "m-right-half",
                                right_3x: "m-right",
                                bottom_1x: "m-bottom-quarter",
                                bottom_2x: "m-bottom-half",
                                bottom_3x: "m-bottom-half",
                                left_3x: "m-left",
                            },
                            container_classes : {
                                payment_method: "box-container"
                            }
                        })
                    }}
                </div>

                {# Modal footer and close button #}

                <div class="modal-footer hidden-phone">
                    <a href="#" class="btn-link pull-right p-none" data-dismiss="modal">{{ 'Volver al producto' | translate }}</a>
                </div>
            </div>
        </div>
    </div>
{% endif %}