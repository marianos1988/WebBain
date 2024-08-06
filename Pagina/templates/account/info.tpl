<div class="page-content container-wide container-xs">
    {% snipplet "breadcrumbs.tpl" %}
    <div class="account-form-wrapper visible-when-content-ready row-fluid">
        <form action="" method="post" class="contact_form span6 offset3 m-bottom m-top">
            <div class="form-group">
                <label for="name" class="form-label">{{ 'Nombre' | translate }}</label>
                <input type="text" name="name" id="name" value="{{ result.name | default(customer.name) }}" class="form-control {% if result.errors.name %} input-error {% endif %}"/>
            </div>
            {% if result.errors.name %}
                <div class="alert alert-danger">{{ 'Necesitamos saber tu nombre para actualizar tu información.' | translate }}</div>
            {% endif %}
            <div class="form-group">
                <label for="email" class="form-label">{{ 'Email' | translate }}</label>
                <input autocorrect="off" autocapitalize="off" type="email" name="email" value="{{ result.email | default(customer.email) }}" class="form-control {% if result.errors.email == 'exists' or result.errors.email %} input-error {% endif %}"/>
            </div>
            {% if result.errors.email == 'exists' %}
                <div class="alert alert-danger">{{ 'Encontramos otra cuenta que ya usa este email. Intentá usando otro.' | translate }}</div>
            {% elseif result.errors.email %}
                <div class="alert alert-danger">{{ 'Necesitamos saber tu email para actualizar tu información.' | translate }}</div>
            {% endif %}
            <div class="form-group">
                <label for="phone" class="form-label">{{ 'Teléfono' | translate }} {{ '(opcional)' | translate }}</label>
                <input type="text" name="phone" id="phone" value="{{ result.phone | default(customer.phone) }}" class="form-control"/>
            </div>
            <input class="btn btn-primary full-width" type="submit" value="{{ 'Guardar cambios' | translate }}" />
        </form>
    </div>
</div>