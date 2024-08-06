<div class="page-content container-wide container-xs">
    {% snipplet "breadcrumbs.tpl" %}
    <div class="account-form-wrapper visible-when-content-ready row-fluid">
        <form action="" method="post" class="contact_form span6 offset3 m-bottom m-top">
            <div class="form-group">
                <label for="name" class="form-label">{{ 'Nombre (alias)' | translate }}</label>
                <input type="text" name="name" id="name" value="{{ result.name | default(address.name) }}"  class="form-control {% if result.errors.name %} input-error {% endif %}" placeholder="{{ 'ej.: Trabajo' | translate }}"/>
            </div>
            {% if result.errors.name %}
                <div class="alert alert-danger">{{ 'Necesitamos saber tu nombre para actualizar tu información.' | translate }}</div>
            {% endif %}

            {% if current_language.country == 'BR' %}
                {% set address_placeholder = 'ej.: Av. Pueyrredón' | translate %}
            {% else %}
                {% set address_placeholder = 'ej.: Av. Pueyrredón 1234, CABA' | translate %}
            {% endif %}

            <div class="form-group {% if result.errors.address %} m-none {% endif %}">
                <label for="address" class="form-label">{{ 'Dirección' | translate }}</label>
                <input type="text" name="address" id="address" value="{{ result.address | default(address.address) }}" class="form-control {% if result.errors.address %} input-error {% endif %}" placeholder="{{ address_placeholder | translate }}"/>
            </div>
            {% if result.errors.address %}
                <div class="alert alert-danger">{{ 'Necesitamos saber tu dirección para actualizar tu información.' | translate }}</div>
            {% endif %}
            {% if current_language.country == 'BR' %}
                <div class="form-group">
                    <label for="number" class="form-label">{{ 'Número' | translate }}</label>
                    <input type="text" name="number" id="number" value="{{ result.number | default(address.number) }}" class="form-control {% if result.errors.number %} input-error {% endif %}" placeholder="{{ 'ej.: 1234' | translate }}"/>
                </div>
                {% if result.errors.number %}
                    <div class="alert alert-danger">{{ 'Necesitamos saber tu número para actualizar tu información.' | translate }}</div>
                {% endif %}
                <div class="form-group {% if result.errors.floor %} m-none {% endif %}">
                    <label for="floor" class="form-label">{{ 'Piso' | translate }}</label>
                    <input type="text" name="floor" id="floor" value="{{ result.floor | default(address.floor) }}" class="form-control {% if result.errors.floor %} input-error {% endif %}"/>
                </div>
                {% if result.errors.floor %}
                    <div class="alert alert-danger">{{ 'Necesitamos saber tu piso para actualizar tu información.' | translate }}</div>
                {% endif %}
                <div class="form-group {% if result.errors.locality %} m-none {% endif %}">
                    <label for="locality" class="form-label">{{ 'Localidad' | translate }}</label>
                    <input type="text" name="locality" id="locality" value="{{ result.locality | default(address.locality) }}" class="form-control {% if result.errors.locality %} input-error {% endif %}" placeholder="{{ 'ej.: CABA' | translate }}"/>
                </div>
                {% if result.errors.locality %}
                    <div class="alert alert-danger">{{ 'Necesitamos saber tu localidad para actualizar tu información.' | translate }}</div>
                {% endif %}
            {% endif %}
            <div class="form-group {% if result.errors.zipcode %} m-none {% endif %}">
                <label for="zipcode" class="form-label">{{ 'Código Postal' | translate }}</label>
                <input type="text" name="zipcode" id="zipcode" value="{{ result.zipcode | default(address.zipcode) }}" class="form-control {% if result.errors.zipcode %} input-error {% endif %}" placeholder="{{ 'ej.: 1429' | translate }}"/>
            </div>
            {% if result.errors.zipcode %}
                <div class="alert alert-danger">{{ 'Necesitamos saber tu código postal para actualizar tu información.' | translate }}</div>
            {% endif %}
            <div class="form-group {% if result.errors.city %} m-none {% endif %}">
                <label for="city" class="form-label">{{ 'Ciudad' | translate }}</label>
                <input type="text" name="city" id="city" value="{{ result.city | default(address.city) }}" class="form-control {% if result.errors.city %} input-error {% endif %}" placeholder="{{ 'ej.: CABA' | translate }}"/>
            </div>
            {% if result.errors.city %}
                <div class="alert alert-danger">{{ 'Necesitamos saber tu ciudad para actualizar tu información.' | translate }}</div>
            {% endif %}
            <div class="form-group {% if result.errors.province %} m-none {% endif %}">
                <label for="province" class="form-label">{{ 'Provincia' | translate }}</label>
                <input type="text" name="province" id="province" value="{{ result.province | default(address.province) }}" class="form-control {% if result.errors.province %} input-error {% endif %}" placeholder="{{ 'ej.: CABA' | translate }}"/>
            </div>
            {% if result.errors.province %}
                <div class="alert alert-danger">{{ 'Necesitamos saber tu provincia para actualizar tu información.' | translate }}</div>
            {% endif %}
            <div class="form-group">
                <label for="country" class="form-label">{{ 'País' | translate }}</label>
                <select name="country" id="country">{{ country_options }}</select>
            </div>
            {% if result.errors.country %}
                <div class="alert alert-danger">{{ 'Necesitamos saber tu país para actualizar tu información.' | translate }}</div>
            {% endif %}
            <div class="form-group {% if result.errors.phone %} m-none {% endif %}">
                <label for="phone" class="form-label">{{ 'Teléfono' | translate }}</label>
                <input type="text" name="phone" id="phone" value="{{ result.phone | default(address.phone) }}" class="form-control {% if result.errors.phone %} input-error {% endif %}" placeholder="{{ 'ej.: 1123445567' | translate }}"/>
            </div>
            {% if result.errors.phone %}
                <div class="alert alert-danger">{{ 'Necesitamos saber tu teléfono para actualizar tu información.' | translate }}</div>
            {% endif %}
            <input class="btn btn-primary full-width" type="submit" value="{{ 'Guardar cambios' | translate }}" />
        </form>
    </div>
</div>
