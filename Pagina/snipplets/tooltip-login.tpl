{% if store.country == 'AR' and template == 'home' %}
    <div class="js-tooltip js-login-tooltip {% if desktop %}js-login-tooltip-desktop fade-in-vertical{% endif %} tooltip {% if desktop or (mobile and (settings.logo_position == 'left' or settings.version_theme == 'box')) %}tooltip-left{% endif %} {% if desktop and settings.logo_position == 'left' and settings.version_theme != 'box' %}m-top-half{% endif %} {% if desktop and settings.version_theme == 'box' %}m-right{% endif %} {% if mobile %}tooltip-top{% else %}tooltip-bottom{% endif %}" style="display: none;">
        <span class="tooltip-arrow"></span>
        <a href="#quick-login" data-toggle="modal" class="js-trigger-modal-zindex-top text-background m-right">
            {{ '<strong>¡Comprá más rápido</strong> y seguí tus pedidos!' | translate }}
        </a>
        <a href="#" class="js-tooltip-close js-dismiss-quicklogin pull-right notification-close">
            {% include "snipplets/svg/times.tpl" with {fa_custom_class: "svg-inline--fa svg-icon-back h5"} %}
        </a>
    </div>
{% endif %}