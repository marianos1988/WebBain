{# Single snipplet that work as credit cards example #} 
<div class="row-fluid visible-when-content-ready"> 
    <div class="span{{ has_shipping_payment_logos ? 2 : 3 }} pull-left-xs">
        <div class="col-foot text-uppercase">
            <h4 class="footer-title font-body">{{ "Navegación" | translate }}</h4>
            {% snipplet "navigation/navigation-foot.tpl" %}
        </div>
    </div>
    <div class="span{{ has_shipping_payment_logos ? 2 : 3 }} pull-left-xs">
        <div class="col-foot text-uppercase">
            <h4 class="footer-title font-body">{{ settings.news_message }}</h4>
                {% snipplet "newsletter.tpl" %}
        </div>
    </div> 
    <div class="span3 pull-left-xs"> 
        <div class="col-foot text-uppercase">
            <h4 class="footer-title font-body">{{ "Ejemplos de medios de pago" | translate }}</h4>
            {% if store.country == 'BR' %}
                {% for payment_method in [ 'visa','mastercard', 'amex', 'diners', 'pagseguro', 'moip' ] %}
                  {{ payment_method | payment_new_logo | img_tag('', {class : 'footer-payship-img card-img', height : 30}) }}
                {% endfor %}
            {% else %}
                {% for payment_method in [ 'visa','mastercard', 'amex', 'diners', 'mercadopago' ] %}
                  {{ payment_method | payment_new_logo | img_tag('', {class : 'footer-payship-img card-img', height : 30}) }}
                {% endfor %}
                {% if store.country == 'AR' %}
                    {% for payment_method in [ 'ar/pagofacil','ar/rapipago', 'ar/tarjeta-naranja' ] %}
                      {{ payment_method | payment_new_logo | img_tag('', {class : 'footer-payship-img card-img', height : 30}) }}
                    {% endfor %}                                
                {% endif %}
            {% endif %}
        </div>  
        <div class="col-foot text-uppercase">
            <h4 class="footer-title font-body">{{ "Ejemplos de formas de envío" | translate }}</h4>
            {% if store.country == 'BR' %}
                {% for shipping_method in [ 'br/correios' ] %}
                  {{ shipping_method | shipping_logo | img_tag('', {class : 'footer-payship-img card-img', height : 30}) }}
                {% endfor %}
            {% else %}
                {% for shipping_method in [ 'fedex','ups' ] %}
                  {{ shipping_method | shipping_logo | img_tag('', {class : 'footer-payship-img card-img', height : 30}) }}
                {% endfor %}
                {% if store.country == 'AR' %}
                    {{ "ar/oca" | shipping_logo | img_tag('', {class : 'footer-payship-img card-img', height : 30}) }}
                {% endif %}
            {% endif %}
        </div> 
    </div>  
</div>