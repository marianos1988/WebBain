<div class="{% if store.branches|length > 1 %}js-toggle-branches{% endif %} link-module no-border {% if store.has_shipping %}p-top-half p-bottom-half{% endif %}" data-store="branches">
    {% include "snipplets/svg/store.tpl" with {fa_custom_class: "svg-inline--fa fa-lg link-module-icon svg-icon-text"} %}
    <span class="link-module-content">
        <div class="link-module-text">
            {% if store.branches|length > 1 %}
                {{ 'Nuestros locales' | translate }}
            {% else %}
                {{ 'Nuestro local' | translate }}
            {% endif %}
        </div>
        {% if store.branches|length > 1 %}
            <div class="btn-link">
                <span class="js-see-branches">
                    {{ 'Ver opciones' | translate }}
                    {% include "snipplets/svg/angle-down-regular.tpl" with {fa_custom_class: "svg-inline--fa fa-lg m-left-quarter"} %}
                </span>
                <span class="js-hide-branches" style="display: none;">
                    {{ 'Ocultar opciones' | translate }}
                    {% include "snipplets/svg/angle-up.tpl" with {fa_custom_class: "svg-inline--fa fa-lg m-left-quarter"} %}
                </span>
            </div>
        {% endif %}
    </span>
</div>

{# Store branches #}
    
<ul class="js-store-branches-container box-container p-none list-unstyled {% if product_detail %}list-readonly{% else %}radio-button-container{% endif %} m-top-half" {% if store.branches|length > 1 %}style="display: none;"{% endif %}>

    {% for branch in store.branches %}
        <li class="{% if product_detail %}list-item{% else %}radio-button-item{% endif %}" data-store="branch-item-{{ branch.code }}">

            {# If cart use radiobutton #}

            {% if not product_detail %}
                <label class="js-shipping-radio js-branch-radio radio-button" data-loop="branch-radio-{{loop.index}}">
                    <input 
                    class="js-branch-method {% if cart.shipping_data.code == branch.code %} js-selected-shipping-method {% endif %} shipping-method" 
                    data-price="0" 
                    {% if cart.shipping_data.code == branch.code %}checked{% endif %} type="radio" 
                    value="{{branch.code}}" 
                    data-name="{{ branch.name }} - {{ branch.extra }}"
                    data-code="{{branch.code}}" 
                    data-cost="{{ 'Gratis' | translate }}"
                    name="option" 
                    style="display:none" data-stats-frontend-shipping-event="branch_option">
                    <span class="row-fluid radio-button-content">
                       <div class="radio-button-icons-container">
                            <span class="radio-button-icons">
                                <span class="radio-button-icon unchecked"></span>
                                <span class="radio-button-icon checked"></span>
                            </span>
                        </div>
                        <span class="radio-button-label">
            {% endif %}
                            <div class="row-fluid {% if not product_detail %}radio-button-text{% endif %}">
                                <div class="span9 col-xs-9-custom pull-left pull-left-xs">
                                    <p class="shipping-method-name">
                                        {{ branch.name }} <span class="m-left-quarter">{{ branch.extra }}</span>
                                    </p>
                                </div>
                                <div class="span3 col-xs-3-custom pull-right-xs h6 text-right">
                                    <strong class="shipping-method-price text-primary">
                                        {{ 'Gratis' | translate }}
                                    </strong>
                                </div>
                            </div>
            {% if not product_detail %}
                        </span>
                    </span>
                </label>
            {% endif %}
        </li>
    {% endfor %}
</ul>