{# Mobile Sharing #}
<div class="social-widgets-mobile visible-when-content-ready text-center p-top-half p-bottom-half m-top-xs{% if mobile %} visible-phone{% endif %}">
	{% if mobile %}
		<h4 class="social-widgets-mobile_title p-top-quarter p-bottom-half">{{ "Compartir" | translate }}:</h4>
		{# Whatsapp button #}
		<a class="js-mobile-social-share btn-social-mobile btn-social-mobile_whatsapp product-share-button btn-circle bg-whatsapp d-inline-block m-all-half" data-network="whatsapp" target="_blank"
		 href="whatsapp://send?text={{ product.social_url }}">
		 {% include "snipplets/svg/whatsapp-regular.tpl" with {fa_custom_class: "svg-inline--fa fa-2x fa-whatsapp"} %}
		</a>
	{% endif %}
	{# Facebook button #}
	<a class="js-mobile-social-share btn-social-mobile btn-social-mobile_facebook product-share-button btn-circle bg-facebook d-inline-block m-all-half" data-network="facebook" target="_blank"
	 href="https://www.facebook.com/sharer/sharer.php?u={{ product.social_url }}"
	 title="Share on Facebook">
	 	{% if mobile %}
	 		{% include "snipplets/svg/facebook-f.tpl" with {fa_custom_class: "svg-inline--fa fa-2x fa-facebook-f"} %}
	 	{% else %}
	 		{% include "snipplets/svg/facebook-f.tpl" with {fa_custom_class: "svg-inline--fa fa-lg svg-icon-text"} %}
	 	{% endif %}
	</a>
	{# Twitter button #}
	<a class="js-mobile-social-share btn-social-mobile btn-social-mobile_twitter product-share-button btn-circle bg-twitter d-inline-block m-all-half" data-network="twitter" target="_blank"
	 href="https://twitter.com/share?url={{ product.social_url }}"
	 title="Share on Twitter">
	 	{% if mobile %}
			{% include "snipplets/svg/twitter.tpl" with {fa_custom_class: "svg-inline--fa fa-2x fa-twitter"} %}
		{% else %}
			{% include "snipplets/svg/twitter.tpl" with {fa_custom_class: "svg-inline--fa fa-lg svg-icon-text"} %}
		{% endif %}
	</a>
	{# Pinterest button #}
 	<a class="js-mobile-social-share js-mobile-pinterest-share btn-social-mobile btn-social-mobile-branded product-share-button btn-social-mobile_pinterest btn-circle bg-pinterest d-inline-block m-all-half" target="_blank" href="#" data-network="pinterest">
		{% if mobile %}
			{% include "snipplets/svg/pinterest.tpl" with {fa_custom_class: "svg-inline--fa fa-2x fa-pinterest"} %}
		{% else %}
			{% include "snipplets/svg/pinterest.tpl" with {fa_custom_class: "svg-inline--fa fa-lg svg-icon-text"} %}
		{% endif %}
 	</a>
 	<div class="js-pinterest-share pull-left m-right-half pinterest hidden product-share-button" data-network="pinterest">
        {{product.social_url | pin_it('https:' ~ product.featured_image | product_image_url('large'))}}
    </div>
</div>