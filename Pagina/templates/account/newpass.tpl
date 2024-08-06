{% set is_account_activation = action == 'account_activation' %}
<div class="page-content container-wide container-xs">
    <div class="title-container" data-store="page-title">
        <h1>{{ (is_account_activation ? 'Activar cuenta' : 'Cambiar Contraseña') | translate }}</h1>
    </div>
    <div class="account-form-wrapper visible-when-content-ready row-fluid">
        {% if link_expired %}

            {% set contact_links = store.whatsapp or store.phone or store.email %}
            
            <div class="m-top m-bottom text-center">
                {% if is_account_activation %}
                    <div class="m-bottom-quarter weight-strong">{{ 'El link para activar tu cuenta expiró' | translate }}</div>
                    <div>{{ 'Contactanos para que te enviemos uno nuevo.' | translate }}</div>
                {% else %}
                    <div class="m-bottom-quarter weight-strong">{{ 'El link para cambiar tu contraseña expiró' | translate }}</div>
                    <div class="m-bottom">{{ 'Ingresá tu email para recibir uno nuevo.' | translate }}</div>
                    <a href="{{ store.customer_reset_password_url }}">{{ 'Ingresar email' | translate }}</a>
                {% endif %}
            </div>

            {% if contact_links and is_account_activation %}
                <ul class="text-center list-style-none">
                    {% if store.whatsapp %}
                        <li class="svg-icon-text m-bottom-half">{% include "snipplets/svg/whatsapp-regular.tpl" with {fa_custom_class: 'svg-inline--fa fa-w-16 fa-lg m-right-half'} %}<a href="{{ store.whatsapp }}">{{ store.whatsapp |trim('https://wa.me/') }}</a></li>
                    {% endif %}
                    {% if store.phone %}
                        <li class="svg-icon-text m-bottom-half">{% include "snipplets/svg/phone-solid.tpl" %}<a href="tel:{{ store.phone }}">{{ store.phone }}</a></li>
                    {% endif %}
                    {% if store.email %}
                        <li class="svg-icon-text m-bottom-half">{% include "snipplets/svg/envelope-solid.tpl" %}{{ store.email | mailto }}</li>
                    {% endif %}
                </ul>
            {% endif %}
        {% else %}
            <form action="" method="post" class="contact_form span6 offset3 m-top m-bottom">
                {% if failure %}
                    <div class="alert alert-danger">{{ 'Las contraseñas que escribiste no coinciden. Chequeá que sean iguales entre sí.' | translate }}</div>
                {% endif %}
                <div class="form-group">
                    <label for="password" class="form-label">{{ 'Contraseña' | translate }}</label>
                    <input type="password" name="password" id="password" autocomplete="off" class="form-control {% if failure %} input-error {% endif %}"/>
                </div>
                <div class="form-group">
                    <label for="password_confirm" class="form-label"> {{ 'Confirmar Contraseña' | translate }}</label>
                    <input type="password" name="password_confirm" id="password_confirm" autocomplete="off" class="form-control {% if failure %} input-error {% endif %}"/>
                </div>
                <input class="btn btn-primary full-width" type="submit" value="{{ (is_account_activation ? 'Activar cuenta' : 'Cambiar Contraseña')  | translate }}" />
            </form>
        {% endif %}
    </div>
</div>
