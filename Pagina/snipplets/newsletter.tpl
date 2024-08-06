{% set newsletter_contact_error = contact.type == 'newsletter' and not contact.success %}
<div class="newsletter-footer js-newsletter-footer p-relative">
    <form method="post" action="/winnie-pooh" onsubmit="this.setAttribute('action', '');" data-store="newsletter-form">
        <div class="input-append full-width p-relative m-none-xs">
          <input type="text" class="m-none newsletter-footer-input footer-input border-box form-control span8 {% if newsletter_contact_error %} input-error {% endif %}" onfocus="if (this.value == '{{ "Email" | translate }}') {this.value = '';}" onblur="if (this.value == '') {this.value = '{{ "Email" | translate }}';}" value='{{ "Email" | translate }}' name="email"  aria-label='{{ "Email" | translate }}' >
        <div class="winnie-pooh hidden">
            <label for="winnie-pooh-newsletter">{{ "No completar este campo" | translate }}</label>
            <input id="winnie-pooh-newsletter" type="text" name="winnie-pooh"/>
        </div>
        <input type="hidden" name="name" value="{{ "Sin nombre" | translate }}" />
        <input type="hidden" name="message" value="{{ "Pedido de inscripción a newsletter" | translate }}" />
        <input type="hidden" name="type" value="newsletter" />
        <span class="btn btn-footer p-all-half newsletter-footer-btn submit-icon">
            {% include "snipplets/svg/paper-plane.tpl" with {fa_custom_class: "svg-inline--fa svg-icon-foot"} %}
        </span>  
        <input type="submit" name="contact" class="btn submit-with-icon newsletter-footer-btn p-all-half p-absolute span4" value='{{ "Enviar" | translate }}' aria-label='{{ "Enviar" | translate }}' >    
        </div>
    </form>
    {% if contact and contact.type == 'newsletter' %}
        {% if contact.success %}
            <div class="contact-ok alert alert-success alert-success-contrast p-none">{{ "¡Gracias por suscribirte! A partir de ahora vas a recibir nuestras novedades en tu email" | translate }}</div>
        {% else %}
            <div class="contact-error alert alert-danger alert-danger-contrast p-none">{{ "Necesitamos tu email para enviarte nuestras novedades." | translate }}</div>
        {% endif %}
    {% endif %}
</div>
