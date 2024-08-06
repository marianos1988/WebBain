<div class="js-product-variants {% if quickshop %}js-product-quickshop-variants{% endif %}">
  <div class="row-fluid">

  {# Color and size variants #}
  {% for variation in product.variations if variation.name in ['Color', 'Cor', 'Talle', 'Talla', 'Tamanho', 'Size'] %}
    <div data-variant="{{ variation.name }}" class="variation_{{loop.index}} {% if settings.product_color_variants and variation.name in ['Color', 'Cor'] %}js-color-variant-bullet{% endif %} row-fluid variant-container btn-variant-container">
      <label class="variant-label" for="variation_{{loop.index}}">
        <span>{{variation.name}}:</span>
        <strong class="js-insta-variation-label">{{ product.default_options[variation.id] }}</strong>
      </label>
      {% if show_size_guide and settings.size_guide_url and variation.name in ['Talle', 'Talla', 'Tamanho', 'Size'] %}
        {% set has_size_guide_page_finded = false %}
        {% set size_guide_url_handle = settings.size_guide_url | trim('/') | split('/') | last %}
        {% for page in pages if page.handle == size_guide_url_handle and not has_size_guide_page_finded %}
          {% set has_size_guide_page_finded = true %}
          {% if has_size_guide_page_finded %}
            <a href="#size-guide-modal" data-toggle="modal" data-modal-url="modal-fullscreen-size-guide" class="js-fullscreen-modal-open btn-link btn-link-floating btn-link-primary p-absolute">
              {% include "snipplets/svg/ruler-horizontal.tpl" with {fa_custom_class: "svg-inline--fa fa-lg svg-icon-primary m-right-quarter"} %}
              {{ 'Guía de talles' | translate }}
            </a>
            <div id="size-guide-modal" class="js-fullscreen-modal modal modal-xs modal-xs-right hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
              <div class="modal-xs-dialog">
                <div class="modal-header">
                  <a class="js-fullscreen-modal-close modal-xs-header visible-phone" href="#" data-dismiss="modal">
                      {% include "snipplets/svg/angle-left.tpl" with {fa_custom_class: "svg-inline--fa fa-2x modal-xs-header-icon modal-xs-right-header-icon"} %}
                      <span class="modal-xs-header-text modal-xs-right-header-text">
                        {{ 'Guía de talles' | translate }}
                      </span>
                  </a>
                  <div class="hidden-phone">
                    <h3>{{ 'Guía de talles' | translate }}</h3>
                    <button type="button" class="btn-floating m-right-half m-top-quarter" data-dismiss="modal" aria-hidden="true">{% include "snipplets/svg/times.tpl" with {fa_custom_class: "svg-inline--fa"} %}</button>
                  </div>
                </div>
                <div class="modal-content">
                  <div class="modal-body modal-xs-body">
                    <div class="user-content">
                      {{ page.content }}
                    </div>
                  </div>
                </div>
              </div>
            </div>
          {% endif %}
        {% endfor %}
      {% endif %}
      <div class="row-fluid">
        {% for option in variation.options if option.custom_data %}
            <a data-option="{{ option.id }}" class="js-insta-variant btn-variant{% if not(variation.name in ['Color', 'Cor']) %} btn-variant-custom{% endif %} insta-variations {{ variation.name }} {% if product.default_options[variation.id] == option.id %} selected {% endif %}">
              <span class="btn-variant-content"{% if variation.name in ['Color', 'Cor'] %} style="background: {{ option.custom_data }}"{% endif %} data-name="{{ option.name }}">
                {% if not(variation.name in ['Color', 'Cor']) %}
                  {{ option.name }}
                {% endif %}
              </span>
            </a>
        {% endfor %}
        {% for option in variation.options if not option.custom_data %}
            <a data-option="{{ option.id }}" class="js-insta-variant btn-variant btn-variant-custom insta-variations insta-variations_btn-custom {{ variation.name }} {% if product.default_options[variation.id] == option.id %} selected {% endif %}">
                <span class="btn-variant-content" data-name="{{ option.name }}">{{ option.name }}</span>
            </a>
        {% endfor %}
      </div>
    </div>
  {% endfor %}

  {# Custom variants #}
  {% for variation in product.variations %}
    <div class="js-mobile-variations-container variant-container {% if variation.name in ['Color', 'Cor', 'Talle', 'Talla', 'Tamanho', 'Size']%} m-none {% endif %}">
      <div class="{% if not quickshop %} span8 {% else %} span12 {% endif %} desktop-product-variation {% if not(variation.name in ['Color', 'Cor', 'Talle', 'Talla', 'Tamanho', 'Size']) and not quickshop %}hidden-phone{% endif %}" {% if variation.name in ['Color', 'Cor', 'Talle', 'Talla', 'Tamanho', 'Size']%}style="display: none"{% endif %}>
          <label class="variant-label" for="variation_{{loop.index}}">
            <span {% if quickshop %}class="m-right-half"{% endif %}>{{variation.name}}:</span>
          </label>
          <div class="js-product-variants-group {% if variation.name in ['Color', 'Cor'] %}js-color-variants-container{% endif %}">
            <select class="js-variation-option js-refresh-installment-data variant-select" data-variant-id="variation_{{loop.index}}" name="variation[{{ variation.id }}]">
            {% for option in variation.options %}
                <option value="{{ option.id }}" {% if product.default_options[variation.id] == option.id %}selected="selected"{% endif %}>{{ option.name }}</option>
            {% endfor %}
            </select>
          </div>
      </div>
      {% if not(variation.name in ['Color', 'Cor', 'Talle', 'Talla', 'Tamanho', 'Size']) and not quickshop %}
        <div class="js-mobile-vars mobile-vars visible-phone">
          <a href="javascript:void(0)" class="js-mobile-vars-btn btn-module {% if quickshop %} js-quickshop-vars {% endif %}" id="{{variation.name}}" style="{% if variation.name in ['Color', 'Cor', 'Talle', 'Talla', 'Tamanho', 'Size']%}display:none;{% endif %}">
              <h5 class="weight-normal text-wrap">{{variation.name}}:</h5>
              <span class="js-mobile-vars-selected-label text-primary text-wrap ">{{ product.default_options[variation.id] }}</span>
              <div class="btn-module-icon btn-module-icon-right">
                {% include "snipplets/svg/angle-right-regular.tpl" with {fa_custom_class: "svg-inline--fa fa-2x"} %}
              </div>  
          </a>
          <div class="js-mobile-vars-panel modal-xs modal-xs-right panel-mobile-variant modal-xs-right-out" data-custom="{{variation.name}}" style="{% if quickshop %}top: 60px;{% endif %}{% if variation.name in ['Color', 'Cor', 'Talle', 'Talla', 'Tamanho', 'Size']%}display:none;{% endif %}">
            <div class="modal-xs-dialog">
              <a href="javascript:void(0)" class="js-close-panel modal-xs-header">
                {% include "snipplets/svg/angle-left.tpl" with {fa_custom_class: "svg-inline--fa fa-2x modal-xs-header-icon modal-xs-right-header-icon"} %}
                <span class="modal-xs-header-text modal-xs-right-header-text">{{variation.name}}</span>
              </a>
              <div class="modal-content">
                <div class="modal-xs-body modal-xs-body-list">
                  {% for option in variation.options %}
                    <a href="javascript:void(0)" class="js-mobile-vars-property modal-xs-list-item {% if quickshop %} js-quickshop-mobile-vars-property {% endif %}" data-option="{{ option.id }}">
                      <div class="row-fluid">
                        <div class="modal-xs-radio-icon-container">
                        <span class="m-right-half modal-xs-radio-icon">
                          {% include "snipplets/svg/check.tpl" with {fa_custom_class: "svg-inline--fa"} %}
                        </span>
                        </div>
                        <div class="modal-xs-radio-text p-none-left text-wrap">
                        {{ option.name }}
                        </div>
                      </div>
                    </a>
                  {% endfor %}
                </div>
              </div>
            </div>
          </div>
        </div>
      {% endif %}
    </div>
  {% endfor %}
  </div>
</div>
