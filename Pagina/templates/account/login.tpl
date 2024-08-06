<div class="page-content container-wide login-cont container-xs">
    {% snipplet "breadcrumbs.tpl" %}
    {# Page preloader #}
    <div class="page-loading-icon-container full-width hidden-when-content-ready">
        <div class="page-loading-icon page-loading-icon opacity-80 rotate">
            {% include "snipplets/svg/spinner.tpl" %}
        </div>
    </div>

    {# Account validation #}
    
    <div class="container">
        <div class="row justify-content-center">
            <div class="span6 offset3">
                {% if account_validation == 'success' %}
                    <div class="js-account-validation-success alert alert-success m-top-double">
                        <p class="m-all-half">{{ "¡Tu cuenta fue creada con éxito!" | translate }}</p>
                    </div>
                {% elseif account_validation == 'expired' %}
                    <div class="js-account-validation-expired alert alert-danger m-bottom-half m-top-double">
                        <p class="m-bottom-half">{{ "Tu link de validación expiró." | translate }}</p>
                    </div>
                    <div class="text-center m-bottom-double">
                        <span class="js-resend-validation-link btn-link weight-strong">{{ "Enviar link de nuevo" | translate }}</span>
                    </div>
                {% elseif account_validation == 'pending' %}
                    <div class="js-account-validation-pending alert alert-danger m-bottom-half m-top-double">
                        <p class="m-all-half">{{ "Validá tu email usando el link que te enviamos a <strong>{1}</strong> cuando creaste tu cuenta." | t(customer_email) }}</p>
                    </div>
                    <div class="text-center m-bottom-double">
                        <p>{{ "¿No lo encontraste?" | translate }} <span class="js-resend-validation-link btn-link weight-strong">{{ "Enviar link de nuevo" | translate }}</span></p>
                    </div>
                {% endif %}
                <div class="js-resend-validation-success alert alert-success" style="display:none">
                    <p class="m-bottom-half">{{ "¡El link fue enviado correctamente!" | translate }}</p>
                </div>
                <div class="js-resend-validation-error alert alert-danger" style="display:none">
                    <p>{{ "No pudimos enviar el email, intentalo de nuevo en unos minutos." | translate }}</p>
                </div>
                <div class="js-too-many-attempts alert alert-danger m-bottom-none" style="display:none">
                    <p class="m-all-half">
                        {{ 'Superaste la cantidad de intentos permitidos. <br> Volvé a probar en' | translate }}
                        <span class="js-too-many-attempts-countdown"></span>
                    </p>
                </div>
            </div>
        </div>
    </div>

    <div class="account-form-wrapper visible-when-content-ready m-bottom m-top row-fluid">
        <form id="login-form" action="" method="post" class="span6 offset3 contact_form" data-store="account-login">
            <div class="form-group">
                <label class="form-label" for="email">{{ 'Email' | translate }}</label>
                <input autocorrect="off" autocapitalize="off" type="email" name="email" value="{{ result.email }}" class="form-control {% if result.invalid %} input-error {% endif %}" placeholder="{{ 'ej.: tunombre@email.com' | translate }}" required />
            </div>
            <div class="form-group m-bottom-none">
                <label class="form-label" for="password">{{ 'Contraseña' | translate }}</label>
                <input type="password" name="password" autocomplete="off" class="js-password-input form-control {% if result.invalid %} input-error{% endif %}" required />
                <a aria-label="{{ 'Ver contraseña' | translate }}" class="js-password-view btn form-toggle-eye">
                    <span class="js-eye-open" style="display: none;">
                        {% include "snipplets/svg/eye.tpl" with {fa_custom_class: "svg-inline--fa svg-icon-primary"} %}
                    </span>
                    <span class="js-eye-closed">
                        {% include "snipplets/svg/eye-closed.tpl" with {fa_custom_class: "svg-inline--fa svg-icon-primary"} %}
                    </span>
                </a>       
            </div>
            <div class="font-small weight-strong m-top-quarter m-bottom"><a href="{{ store.customer_reset_password_url }}">{{ '¿Olvidaste tu contraseña?' | translate }}</a></div>
            <div class="row-fluid">
                {% if result.invalid %}
                    <div class="alert alert-danger">{{ 'Estos datos no son correctos. ¿Chequeaste que estén bien escritos?' | translate }}</div>
                {% endif %}
                <input class="btn btn-primary full-width" type="submit" value="{{ 'Iniciar sesión' | translate }}" />
            </div>
            {% if 'mandatory' not in store.customer_accounts %}
                <p class="m-top text-center"> {{ "¿No tenés cuenta?" | translate }} {{ "Crear cuenta" | translate | a_tag(store.customer_register_url, '', 'weight-strong') }}</p>
            {% endif %}
        </form>
    </div>
</div>
