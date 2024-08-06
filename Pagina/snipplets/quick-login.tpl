{% if template == 'home' or template == 'product' %}

    {# Quick login form #}

    <div id="quick-login" class="js-modal-xs-centered modal modal-small modal-centered-small modal-xs modal-xs-centered hide fade modal-zindex-top" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="js-close-modal-zindex-top modal-header p-right" data-dismiss="modal" aria-hidden="true">
            <div class="text-center">
                <h5 class="h6-xs m-top m-right m-bottom-half m-left p-right-quarter">{{ '¡Que bueno verte de nuevo!' | translate }}</h5>
                <p>{{ 'Iniciá sesión para comprar más rápido y ver todos tus pedidos.' | translate }}</p>
            </div>
            <button type="button" class="btn-floating m-right-half m-top-quarter">
                {% include "snipplets/svg/times.tpl" with {fa_custom_class: "svg-inline--fa"} %}
            </button>
        </div>
        <div class="modal-body">
            <form id="login-form" action="/account/login/" method="post" data-store="account-login">
                <input type="hidden" class="hidden" name="from" value="quick-login">
                <input type="hidden" class="hidden" autocorrect="off" autocapitalize="off" name="redirect_to" value="{{ current_url }}">
                <div class="form-group">
                    <label class="form-label" for="email">{{ 'Email' | translate }}</label>
                    <input autocorrect="off" autocapitalize="off" type="email" name="email" value="{{ result.email }}" class="form-control form-control-xs" placeholder="{{ 'ej.: tunombre@email.com' | translate }}"/>
                </div>
                <div class="form-group m-bottom-none">
                    <label class="form-label" for="password">{{ 'Contraseña' | translate }}</label>
                    <input type="password" name="password" autocomplete="off" class="js-password-input form-control form-control-xs"/>
                    <a aria-label="{{ 'Ver contraseña' | translate }}" class="js-password-view btn form-toggle-eye p-all-half">
                        <span class="js-eye-open" style="display: none;">
                            {% include "snipplets/svg/eye.tpl" with {fa_custom_class: "svg-inline--fa svg-icon-primary"} %}
                        </span>
                        <span class="js-eye-closed">
                            {% include "snipplets/svg/eye-closed.tpl" with {fa_custom_class: "svg-inline--fa svg-icon-primary"} %}
                        </span>
                    </a>       
                </div>
                <div class="row-fluid text-center m-top">
                    <input class="btn btn-primary btn-small" type="submit" value="{{ 'Iniciar sesión' | translate }}" />
                </div>
            </form>
        </div>
    </div>
{% endif %}
