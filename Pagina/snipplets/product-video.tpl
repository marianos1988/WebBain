{% if product.video_url %}

	{% if product_video_modal %}

		{# Product video modal wrapper for mobile #}

		<div id="modal-product-video" class="js-fullscreen-modal modal modal-xs modal-xs-right hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-xs-dialog">
				 <div class="modal-header">
					<a class="js-fullscreen-modal-close modal-xs-header visible-phone" href="#" data-dismiss="modal">
						{% include "snipplets/svg/angle-left.tpl" with {fa_custom_class: "svg-inline--fa fa-2x modal-xs-header-icon modal-xs-right-header-icon"} %}
						<span class="modal-xs-header-text modal-xs-right-header-text text-trim">{{ "Video de" | translate }} {{ product.name }}
						</span>
					</a>
				 </div>
				 <div class="modal-content">
					<div class="modal-body modal-xs-body p-none">
						{# Empty iframe component: will be filled with JS on play button click #}
						<div class="js-product-video-modal video-modal">
							<div class="js-video-iframe embed-responsive embed-responsive-16by9" style="display: none;" data-video-color="{{ settings.brand_color | trim('#') }}"></div>
						</div>
					</div>
				 </div>
			</div>
		</div>
	{% else %}
		{% if product.images_count > 1 %}
			{% set video_index = product.images_count %}
		{% else %}
			{% set video_index = 1 %}
		{% endif %}

		<div class="{% if not thumb %}js-product-slide js-product-video-slide slider-slide product-slide{% endif %} swiper-slide" {% if not thumb %}data-image-position="{{ video_index }}"{% endif %}>
			{% if thumb %}
				<a href="#" class="js-product-thumb js-video-thumb product-thumb full-width" data-slide-index="{{ video_index }}">
					{% include 'snipplets/video-item.tpl' with {thumb: true} %}
				</a>
			{% else %}

				{# Visible video inside slider #}

				<div class="product-video-container">
					<div class="product-video">
						{% include 'snipplets/video-item.tpl' with {product_video: true} %}
					</div>
				</div>
			{% endif %}
		</div>
	{% endif %}
{% endif %}