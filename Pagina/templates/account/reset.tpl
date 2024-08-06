<div class="page-content container-wide container-xs">
    {% snipplet "breadcrumbs.tpl" %}
    <div class="account-form-wrapper visible-when-content-ready row-fluid">
        <p>{{ 'Vamos a enviarte un email para que puedas cambiar tu contraseña.' | translate }}</p>
        <form id="resetpass-form" action="" method="post" class="contact_form span6 offset3 m-top m-bottom">
            {% if failure %}
                <div class="alert alert-danger m-top">{{ 'No encontramos ninguna cuenta registrada con este email. Intentalo nuevamente chequeando que esté bien escrito.' | translate }}</div>
            {% elseif success %}
                <div class="alert alert-success m-top">{{ '¡Listo! Te enviamos un email a {1}' | translate(email) }}</div>
            {% endif %}
            <div class="form-group">
                <label for="email" class="form-label">{{ 'Email' | translate }}</label>
                <input autocorrect="off" autocapitalize="off" type="email" name="email" id="email" value="{{ email }}" class="form-control {% if failure %} input-error {% endif %}"/>
            </div>
            <input class="btn btn-primary full-width" type="submit" value="{{ 'Enviar email' | translate }}" />
        </form>
    </div>
</div>
