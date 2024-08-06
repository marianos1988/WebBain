<div id="news-popup" class="modal hide fade news-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">  <div class="modal-body">
    <button type="button" class="news btn-floating m-top-quarter m-right-quarter" data-dismiss="modal" aria-hidden="true">{% include "snipplets/svg/times.tpl" with {fa_custom_class: "svg-inline--fa"} %}</button>
        <div class="row-fluid">
            <div class='{% if "newsletter_image.jpg" | has_custom_image %} span7 {% else %} span8 offset2 {% endif %}'>
                <div class="logo-img-container {% if not has_logo %}hidden{% endif %}">
                    <img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ store.logo('large') }}" class="lazyload logo-img">
                </div>
                <div {% if has_logo %} class="hidden" {% endif %}>
                    <a class="logo-text h1" href="{{ store.url }}">{{ store.name }}</a>
                </div>
                {% if settings.news_popup_txt %}
                    <p class="newsletter text-center">{{ settings.news_popup_txt }}</p>
                {% else %}
                    <p class="newsletter text-center">{{ '¿Te gusta lo que ves? ¡Suscribite y recibí todas nuestras novedades!'  | translate }}</p>
                {% endif %}
                <div id="news-popup-form-container">
                    <form id="news-popup-form" method="post" action="/winnie-pooh" class="js-news-form" data-store="newsletter-form-popup">
                        <div class="input-append news full-width m-top">
                            <div class="form-group full-width pull-left">
                                <input type="text" name="name" class="js-mandatory-field form-control row-fluid pull-left" onfocus="if (this.value == '{{ "Nombre" | translate }}') {this.value = '';}" onblur="if (this.value == '') {this.value = '{{ "Nombre" | translate }}';}" value='{{ "Nombre" | translate }}' />
                            </div>
                            <div class="form-group full-width pull-left">
                                <input type="text" class="js-mandatory-field form-control row-fluid pull-left" onfocus="if (this.value == '{{ "Tu e-mail" | translate }}') {this.value = '';}" onblur="if (this.value == '') {this.value = '{{ "Tu e-mail" | translate }}';}" value='{{ "Tu e-mail" | translate }}' name="email" >
                            </div>
                            <div class="winnie-pooh hidden">
                                <label for="winnie-pooh-newsletter">{{ "No completar este campo" | translate }}</label>
                                <input id="winnie-pooh-newsletter" type="text" name="winnie-pooh"/>
                            </div>
                            <input type="hidden" name="message" value="{{ "Pedido de inscripción a newsletter" | translate }}" />
                            <input type="hidden" name="type" value="newsletter-popup" />
                            <input type="submit" name="contact" class="js-news-popup-submit btn btn-primary full-width pull-left" value='{{ "Enviar" | translate }}'>
                        </div>
                    </form>
                    <div style='display: none;' class="js-news-spinner h6 text-center m-top">{% include "snipplets/svg/sync-alt-regular.tpl" with {fa_custom_class: "svg-inline--fa fa-spin svg-icon-text"} %} {{ "Enviando..." | translate }}</div>
                    <div style='display: none;' class="js-news-popup-success contact-ok alert alert-success">{{ "¡Gracias por suscribirte! A partir de ahora vas a recibir nuestras novedades en tu email" | translate }}</div>
                    <div style='display: none;'class="js-news-popup-failed contact-error alert alert-danger">{{ "Necesitamos tu email para enviarte nuestras novedades." | translate }}</div>
                </div>
            </div>
            {% if "newsletter_image.jpg" | has_custom_image %}
                <div class="span5">
                    <img class="lazyautosizes lazyload full-width img-responsive p-right border-box" src="{{ 'images/empty-placeholder.png' | static_url }}" data-srcset='{{ "newsletter_image.jpg" | static_url | settings_image_url('large') }} 480w, {{ "newsletter_image.jpg" | static_url | settings_image_url('huge') }} 640w' data-sizes="auto" />
                </div>
            {% endif %}
        </div>  
    </div>
</div>
