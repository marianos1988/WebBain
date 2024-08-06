<div class="page-content container-wide register-cont container-xs">
    {% snipplet "breadcrumbs.tpl" %}
    {# Page preloader #}
    <div class="page-loading-icon-container full-width hidden-when-content-ready">
        <div class="page-loading-icon page-loading-icon opacity-80 rotate">
            {% include "snipplets/svg/spinner.tpl" %}
        </div>
    </div>

    <div class="account-form-wrapper visible-when-content-ready m-bottom m-top row-fluid">
        <form id="login-form" action="" method="post" class="span6 offset3 contact_form" data-store="account-register">

            <p class="text-center-xs m-top m-bottom p-bottom"> {{ 'Comprá más rápido y llevá el control de tus pedidos, ¡en un solo lugar!'| translate }} </p>

        {# Account validation #}
        {% if account_validation == 'pending' %}
            <div class="js-account-validation-pending alert alert-primary p-all-double">
                {% include "snipplets/svg/envelope-regular.tpl" with {fa_custom_class: "svg-inline--fa fa-2x svg-icon-primary m-top"} %}
                <h6 class="m-top m-bottom">{{ "¡Estás a un paso de crear tu cuenta!" | translate }}</h6>
                <p class="m-bottom font-small">{{ "Te enviamos un link a <strong>{1}</strong> para que valides tu email." | t(customer_email) }} </p>
            </div>
            <div class="text-center m-bottom">
                <p>{{ "¿Todavía no lo recibiste?" | translate }} <span class="js-resend-validation-link btn-link weight-strong">{{ "Enviar link de nuevo" | translate }}</span></p>
            </div>
            <div class="js-resend-validation-success alert alert-success" style="display:none">
                <p>{{ "¡El link fue enviado correctamente!" | translate }}</p>
            </div>
            <div class="js-resend-validation-error alert alert-danger" style="display:none">
                <p>{{ "No pudimos enviar el email, intentalo de nuevo en unos minutos." | translate }}</p>
            </div>

        {% else %}
            <div class="form-group {% if result.errors.name %} m-none {% endif %}">
                <label for="name" class="form-label">{{ 'Nombre' | translate }}</label>
                <input type="text" name="name" id="name" value="{{ result.name }}" class="form-control {% if result.errors.name %} input-error {% endif %}" placeholder="{{ 'ej.: María Perez' | translate }}" />
            </div>
            {% if result.errors.name %}
                <div class="alert alert-danger">
                    {% include "snipplets/svg/info-circle.tpl" with {fa_custom_class: "svg-inline--fa fa-md svg-icon-danger m-right-quarter"} %}
                    {{ 'Necesitamos tu nombre para registrarte.' | translate }}
                </div>
            {% endif %}
            <div class="form-group {% if result.errors.email == 'exists' or result.errors.email %} m-none {% endif %}">
                <label for="email" class="form-label">{{ 'Email' | translate }}</label>
                <input autocorrect="off" autocapitalize="off" type="email" name="email" id="email" value="{{ result.email }}" class="form-control {% if result.errors.email == 'exists' or result.errors.email %} input-error {% endif %}" placeholder="{{ 'ej.: tunombre@email.com' | translate }}"/>
            </div>
            {% if result.errors.email == 'exists' %}
                <div class="alert alert-danger">{{ 'Encontramos otra cuenta que ya usa este email. Intentá usando otro o iniciá sesión.' | translate }}</div>
            {% elseif result.errors.email %}
                <div class="alert alert-danger">
                    {% include "snipplets/svg/info-circle.tpl" with {fa_custom_class: "svg-inline--fa fa-md svg-icon-danger m-right-quarter"} %}
                    {{ 'Necesitamos un email válido para crear tu cuenta.' | translate }}
                </div>
            {% endif %}
             <div class="form-group">
                <label for="phone" class="form-label">{{ 'Teléfono' | translate }} {{ '(opcional)' | translate }}</label>
                <input type="text" name="phone" id="phone" value="{{ result.phone }}" class="form-control" placeholder="{{ 'ej.: 1123445567' | translate }}"/>
            </div>
            <div class="form-group {% if result.errors.password == 'required' %} m-none {% endif %}">
                <label for="password" class="form-label">{{ 'Contraseña' | translate }}</label>
                <input type="password" name="password" id="password" autocomplete="off" class="js-password-input form-control {% if result.errors.password == 'required' %} input-error {% endif %}"/>
                <a aria-label="{{ 'Ver contraseña' | translate }}" class="js-password-view btn form-toggle-eye">
                    <span class="js-eye-open" style="display: none;">
                        {% include "snipplets/svg/eye.tpl" with {fa_custom_class: "svg-inline--fa svg-icon-primary"} %}
                    </span>
                    <span class="js-eye-closed">
                        {% include "snipplets/svg/eye-closed.tpl" with {fa_custom_class: "svg-inline--fa svg-icon-primary"} %}
                    </span>
                </a>       
            </div>
             {% if result.errors.password == 'required' %}
                <div class="alert alert-danger">
                    {% include "snipplets/svg/info-circle.tpl" with {fa_custom_class: "svg-inline--fa fa-md svg-icon-danger m-right-quarter"} %}
                    {{ 'Necesitamos una contraseña para registrarte.' | translate }}
                </div>
            {% endif %}
            <div class="form-group {% if result.errors.password == 'confirmation' %} m-none {% endif %}">
                <label for="password_confirmation" class="form-label">{{ 'Confirmar Contraseña' | translate }}</label>
                <input type="password" name="password_confirmation" id="password_confirmation" autocomplete="off" class="js-password-input form-control {% if result.errors.password == 'confirmation' %} input-error {% endif %}"/>
                <a aria-label="{{ 'Ver contraseña' | translate }}" class="js-password-view btn form-toggle-eye">
                    <span class="js-eye-open" style="display: none;">
                        {% include "snipplets/svg/eye.tpl" with {fa_custom_class: "svg-inline--fa svg-icon-primary"} %}
                    </span>
                    <span class="js-eye-closed">
                        {% include "snipplets/svg/eye-closed.tpl" with {fa_custom_class: "svg-inline--fa svg-icon-primary"} %}
                    </span>
                </a>       
            </div>
            {% if result.errors.password == 'confirmation' %}
                <div class="alert alert-danger">
                    {% include "snipplets/svg/info-circle.tpl" with {fa_custom_class: "svg-inline--fa fa-md svg-icon-danger m-right-quarter"} %}
                    {{ 'Las contraseñas no coinciden.' | translate }} 
                </div>
            {% endif %}
            {# Google reCAPTCHA #}
            <div class="g-recaptcha" data-sitekey="{{recaptchaSiteKey}}" data-callback="recaptchaCallback"></div>
            <input class="js-recaptcha-button btn btn-primary full-width" type="submit" value="{{ 'Crear cuenta' | translate }}" disabled/>

            <p class="m-top text-center"> {{ '¿Ya tenés una cuenta?' | translate }} {{ "Iniciá sesión" | translate | a_tag(store.customer_login_url, '', 'weight-strong') }}
        {% endif %}
        </form>
    </div>
</div>