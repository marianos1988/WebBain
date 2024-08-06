{#/*============================================================================
	#Specific store JS functions: product variants, cart, shipping, etc
==============================================================================*/#}

{#/*============================================================================
  
    Table of Contents

    #Lazy load
    #Accordions
    #Cards
    #Modals
    #Notifications
    #Header and nav
        // Mobile navigation tabs and search
        // Header fixed
        // Search suggestions
    #Home page
        // Newsletter popup
        // Home slider
        // Banner services slider
        // Products slider
        // Youtube or Vimeo video embed
    #Product grid
        // Secondary image on mouseover
        // Sort by
        // Filters
        // Fixed category controls
        // Infinite scroll
        // Mobile pagination
        // Categories sidebar
    #Product detail functions
        // Installments
        // Change Variant
        // Product labels on variant change
        // Color and size variations
        // Quickshop variant update
        // Product mobile variants
        // Pinterest sharing
        // Product slider
        // Product thumbs
        // Product desktop fixed CTA
        // Desktop zoom
        // Mobile zoom
        // Submit to contact
        // Product Related
    #Cart
        // Free shipping bar
        // Cart quantitiy changes
        // Empty cart alert
        // Add to cart
        // Cart toggle
        // Go to checkout
    #Shipping calculator
        // Select and save shipping function
        // Toggle branches link
        // Shipping and branch click
        // Select shipping first option on results
        // Calculate shipping by submit
        // Calculate shipping function
        // Toggle more shipping options
        // Calculate shipping on page load
        // Calculate product detail shipping on page load
        // Change CP
        // Shipping provinces
        // Change store country
    #Forms
    #Footer

==============================================================================*/#}

// Move to our_content
window.urls = {
    "shippingUrl": "{{ store.shipping_calculator_url | escape('js') }}"
}

{#/*============================================================================
  #Lazy load
==============================================================================*/ #}

{# Lazy load horizontal for sliders #}

window.lazySizesConfig = window.lazySizesConfig || {};
lazySizesConfig.hFac = 0.1;

DOMContentLoaded.addEventOrExecute(() => {

    {#/*============================================================================
        #Accordions
    ==============================================================================*/ #}

    jQueryNuvem(document).on("click", ".js-accordion-toggle", function(e) {
        e.preventDefault();
        if(jQueryNuvem(this).hasClass("js-accordion-show-only")){
            jQueryNuvem(this).hide();
        }else{
            jQueryNuvem(this).find(".js-accordion-toggle-inactive").toggle();
            jQueryNuvem(this).find(".js-accordion-toggle-active").toggle();
        }
        jQueryNuvem(this).prev(".js-accordion-container").slideToggle();
    });


    {#/*============================================================================
        #Cards
    ==============================================================================*/ #}

    jQueryNuvem(document).on("click", ".js-card-collapse-toggle", function(e) {
        e.preventDefault();
        jQueryNuvem(this).toggleClass('active');
        jQueryNuvem(this).closest(".js-card-collapse").toggleClass('active').find(".js-card-body").slideToggle("fast");
        jQueryNuvem(this).closest(".js-card-collapse").find(".js-card-collapse-plus, .js-card-collapse-minus").toggle();
    });


    {#/*============================================================================
        #Modals
    ==============================================================================*/ #}

    {# /* Modals v2 - applied for now only on hamburguer panel */ #}

    var $modal_close = jQueryNuvem('.js-modal-close');
    var $modal_open = jQueryNuvem('.js-modal-open');
    var $modal_overlay = jQueryNuvem('.js-modal-overlay');

    $modal_open.on("click", function (e) {
        e.preventDefault(); 
        var $modal_id = jQueryNuvem(e.currentTarget).data('toggle');
        jQueryNuvem("body").toggleClass("overflow-none modal-active");
        if (jQueryNuvem($modal_id).hasClass("modal-show")) {
            let modal = jQueryNuvem($modal_id).removeClass("modal-show");
            setTimeout(() => modal.hide(), 200);
        } else {
            jQueryNuvem($modal_id).show().addClass("modal-show");
        }             
    });

    $modal_close.on("click", function (e) {
        e.preventDefault();
        jQueryNuvem("body").toggleClass("overflow-none modal-active");
        let modal = jQueryNuvem(e.currentTarget).closest(".js-modal").removeClass("modal-show");
        setTimeout(() => modal.hide(), 200);
    });

    $modal_overlay.on("click", function (e) {
        e.preventDefault();
        jQueryNuvem("body").toggleClass("overflow-none modal-active");
        let modal = jQueryNuvem(".js-modal").removeClass("modal-show");
        setTimeout(() => modal.hide(), 200);
    });

    {# Modals above all elements #}

    jQueryNuvem(document).on("click", ".js-trigger-modal-zindex-top", function (e) {
        e.preventDefault();
        var modal_id = jQueryNuvem(this).attr("href");
        jQueryNuvem(modal_id).detach().insertAfter(".modal-backdrop");
        jQueryNuvem(".modal-backdrop").addClass("modal-backdrop-zindex-top");
    });

    if (window.innerWidth < 768) {

        {# Modals backdrop close on mobile for small popups #}

        jQueryNuvem(document).on("click", ".modal-backdrop", function (e) {
            jQueryNuvem(this).next(".js-modal-xs-centered").modal('toggle');
        });

        {# Full screen mobile modals back events #}

        {# Clean url hash function #}

        cleanURLHash = function(){
            const uri = window.location.toString();
            const clean_uri = uri.substring(0, uri.indexOf("#"));
            window.history.replaceState({}, document.title, clean_uri);
        };

        {# Go back 1 step on browser history #}

        goBackBrowser = function(){
            cleanURLHash();
            history.back();
        };

        {# Clean url hash on page load: All modals should be closed on load #}

        if(window.location.href.indexOf("modal-fullscreen") > -1) {
            cleanURLHash();
        }

        {# Open full screen modal and url hash #}

        jQueryNuvem(document).on("click", ".js-fullscreen-modal-open", function(e) {
            e.preventDefault();
            var modal_url_hash = jQueryNuvem(this).data("modalUrl");
            window.location.hash = modal_url_hash;
        });


        {# Close full screen modal: Remove url hash #}

        jQueryNuvem(document).on("click", ".js-fullscreen-modal-close", function(e) {
            e.preventDefault();
            goBackBrowser();
        });

        {# Hide panels or modals on browser backbutton #}

        window.onhashchange = function() {
            if(window.location.href.indexOf("modal-fullscreen") <= -1) {
                jQueryNuvem("body").removeClass("overflow-none");

                {# For custom modals #}

                if(jQueryNuvem(".js-fullscreen-modal").hasClass("modal-xs-right-in")){
                    jQueryNuvem(".js-fullscreen-modal.modal-xs-right-in").toggleClass("modal-xs-right-in modal-xs-right-out");
                    setTimeout(function() {
                        jQueryNuvem(".js-fullscreen-modal.modal-xs-right-in").hide();
                    }, 300);

                {# For bootstrap modals #}

                }else if(jQueryNuvem(".js-fullscreen-modal").hasClass("in")){
                    jQueryNuvem(".js-fullscreen-modal.in").modal('hide');
                }
            }
        }
    }

    {# Bottom sheet modal #}

    jQueryNuvem('.js-sheet-bottom').on('show.bs.modal', function (e) {
        setTimeout(function(){
            jQueryNuvem('.modal-backdrop').addClass('sheet-bottom-backdrop');
        });
    });

    {#/*============================================================================
        #Notifications
    ==============================================================================*/ #}

    {# Notifications variables #}

    var $notification_status_page = jQueryNuvem(".js-notification-status-page");
    var $fixed_bottom_button = jQueryNuvem(".js-btn-fixed-bottom");

    {# Ajax cart product added notification position #}

    {% if theme_version != 'box' %}
        var header_height = jQueryNuvem(".js-desktop-head-container").outerHeight();
    {% else %}
        var header_height = jQueryNuvem(".js-mobile-nav").outerHeight();
    {% endif %}
    var header_second_row_height = jQueryNuvem(".js-mobile-head-second-row").outerHeight();
    var addbar_height = jQueryNuvem(".js-addbar").outerHeight();
    {% if theme_version != 'box' %}
        var notification_offset = header_height - header_second_row_height;
    {% else %}
        var notification_offset = header_height - 5;
    {% endif %}

    jQueryNuvem(".js-alert-added-to-cart").css("top" , (notification_offset - 12).toString() + 'px');

    {% if not settings.head_fix and theme_version != 'box' %}
        window.addEventListener("scroll", function(e) {
            if (window.pageYOffset > header_height) {
                jQueryNuvem(".js-alert-added-to-cart").css("position", "fixed").css("top", "0px");
                jQueryNuvem(".js-cart-notification-arrow-up").fadeOut();
            }else{
                jQueryNuvem(".js-alert-added-to-cart").css("top" , (notification_offset + 13).toString() + 'px');
                jQueryNuvem(".js-cart-notification-arrow-up").fadeIn();
            }
        });
    {% endif %}

    {# /* // Close notification and tooltip */ #}

    jQueryNuvem(".js-notification-close, .js-tooltip-close").on( "click", function(e) {
        e.preventDefault();
        jQueryNuvem(e.currentTarget).closest(".js-notification, .js-tooltip").hide();
    });

    {# /* // Follow order status notification */ #}

    if ($notification_status_page.length > 0){
        if (LS.shouldShowOrderStatusNotification($notification_status_page.data('url'))){
            $notification_status_page.show();
        };
        jQueryNuvem(".js-notification-status-page-close").on( "click", function(e) {
            e.preventDefault();
            LS.dontShowOrderStatusNotificationAgain($notification_status_page.data('url'));
        });
    }

    {# Cart notification: Dismiss notification #}

    jQueryNuvem(".js-cart-notification-close").on("click", function(){
        jQueryNuvem(".js-alert-added-to-cart").removeClass("notification-visible").addClass("notification-hidden");
        setTimeout(function(){
            jQueryNuvem('.js-cart-notification-item-img').attr('src', '');
            jQueryNuvem(".js-alert-added-to-cart").hide();
        },2000);
    });

    {# /* // Quick Login notification */ #}

    {% if not customer and template == 'home' %}

        {# Show quick login messages if it is returning customer #}

        setTimeout(function(){
            if (cookieService.get('returning_customer') && LS.shouldShowQuickLoginNotification()) {
                {% if store.country == 'AR' %}
                    jQueryNuvem(".js-quick-login-badge").fadeIn();
                    jQueryNuvem(".js-login-tooltip").show();
                    jQueryNuvem(".js-login-tooltip-desktop").show().addClass("visible");
                {% else %}
                    jQueryNuvem(".js-notification-quick-login").fadeIn();
                {% endif %}
                return;
            }
            
        },500);

    {% endif %}

    {# Dismiss quick login notifications #}

    jQueryNuvem(".js-dismiss-quicklogin").on( "click", function(e) {
        LS.dontShowQuickLoginNotification();
    });

    {% if customer and just_logged_in %}

        jQueryNuvem(".js-quick-login-success").addClass("visible");

        setTimeout(function(){
            let quickLoginAlert = jQueryNuvem(".js-quick-login-success").removeClass("visible");
            setTimeout(() => quickLoginAlert.fadeOut(), 800);
        },8000);

    {% endif %}

    {% if not params.preview %}

        {# /* // Legal footer visibility */ #}

        const footerLegal = jQueryNuvem(".js-footer-legal");

        {# /* // Cookie banner notification */ #}

        restoreNotifications = function(){

            // Whatsapp button position
            $fixed_bottom_button.css("marginBottom", "10px");

            footerLegal.removeAttr("style");
        };

        if (!window.cookieNotificationService.isAcknowledged()) {
            jQueryNuvem(".js-notification-cookie-banner").show();

            {# Offset to show legal footer #}
                
            const cookieBannerHeight = jQueryNuvem(".js-notification-cookie-banner").outerHeight();
            footerLegal.css("paddingBottom", cookieBannerHeight + 5 + "px");

            {# Whatsapp button position #}
            if (window.innerWidth < 768) {
                $fixed_bottom_button.css("marginBottom", "110px");
            }else{
                $fixed_bottom_button.css("marginBottom", "50px");
            }
        }

        jQueryNuvem(".js-acknowledge-cookies").on( "click", function(e) {
            window.cookieNotificationService.acknowledge();
            restoreNotifications();
        });

    {% endif %}

    {#/*============================================================================
      #Header and nav
    ==============================================================================*/ #}

    {# /* // Mobile navigation tabs and search */ #}

    var $top_nav = jQueryNuvem(".js-mobile-nav");
    var $page_main_content = jQueryNuvem(".js-main-content");
    var $mobile_categories_btn = jQueryNuvem(".js-toggle-mobile-categories");
    var $main_categories_mobile_container = jQueryNuvem(".js-categories-mobile-container");
    var $search_backdrop = jQueryNuvem(".js-search-backdrop");

    // Mobile search
    jQueryNuvem(".js-toggle-mobile-search").on("click", function (e) {
        e.preventDefault;
        var $mobile_tab_navigation = jQueryNuvem(".js-mobile-nav-second-row");
        jQueryNuvem(".js-mobile-first-row").toggle();
        jQueryNuvem(".js-mobile-search-row").toggle();
        $mobile_tab_navigation.toggle();
        jQueryNuvem(".js-search-input").val();
        $search_backdrop.toggle().toggleClass("search-open");
        if (!jQueryNuvem("body").hasClass("mobile-categories-visible")) {
            jQueryNuvem("body").toggleClass("overflow-none");
        } else {
            jQueryNuvem("body").removeClass("mobile-categories-visible");
        }
        $main_categories_mobile_container.hide();
        if ($page_main_content.hasClass("move-up")) {
            $page_main_content.removeClass("move-up").addClass("move-down");
            $search_backdrop.removeClass("move-up").addClass("move-down");
            setTimeout(function () {
                $page_main_content.removeClass("move-down");
            }, 200);
        } else {
            $page_main_content.removeClass("move-down").addClass("move-up");
            $search_backdrop.removeClass("move-down").addClass("move-up");
        }
        if ($mobile_categories_btn.hasClass("selected")) {
            $mobile_categories_btn.removeClass("selected");
            jQueryNuvem(".js-current-page").addClass("selected");
        }
    });

    var $mobile_search_input = jQueryNuvem(".js-mobile-search-input");
    jQueryNuvem(".js-toggle-mobile-search-open").on("click", function (e) {
        e.preventDefault;
        $mobile_search_input.each((el) => el.focus());
    });
    jQueryNuvem(".js-search-back-btn").on("click", function (e) {
        jQueryNuvem(".js-search-suggest").hide();
        $mobile_search_input.val('');
    });

    {# Mobile nav categories #}

    $top_nav.addClass("move-down").removeClass("move-up");
    $mobile_categories_btn.on("click", function (e) {
        e.preventDefault();
        jQueryNuvem("body").toggleClass("overflow-none mobile-categories-visible");
        if ($mobile_categories_btn.hasClass("selected")) {
            $mobile_categories_btn.removeClass("selected");
            jQueryNuvem(".js-current-page").addClass("selected");
        } else {
            $mobile_categories_btn.addClass("selected");
            jQueryNuvem(".js-current-page").removeClass("selected");
        }
        $main_categories_mobile_container.toggle();
        if ($top_nav.hasClass("move-up")) {
            $main_categories_mobile_container.toggleClass("move-list-up");
        }
    });

    {# Mobile nav subcategories #}

    jQueryNuvem(".js-open-mobile-subcategory").on("click", function (e) {
        e.preventDefault();
        var $this = jQueryNuvem(e.currentTarget);
        var this_link_id_val = $this.data("target");
        var $subcategories_panel_to_be_visible = $this.closest(".js-categories-mobile-container").find("#" + this_link_id_val);
        $subcategories_panel_to_be_visible.detach().insertAfter(".js-categories-mobile-container > .js-mobile-nav-subcategories-panel:last-child");
        $subcategories_panel_to_be_visible.addClass("modal-xs-right-out").show();
        setTimeout(function () {
            $subcategories_panel_to_be_visible.toggleClass("modal-xs-right-in modal-xs-right-out");
        }, 100);
    });

    jQueryNuvem(".js-go-back-mobile-categories").on("click", function (e) {
        e.preventDefault();
        var $this = jQueryNuvem(e.currentTarget);
        var $subcategories_panel_to_be_closed = $this.closest(".js-mobile-nav-subcategories-panel");
        jQueryNuvem(".js-mobile-nav-subcategories-panel").prop("scrollTop");
        $subcategories_panel_to_be_closed.toggleClass("modal-xs-right-in modal-xs-right-out");
        setTimeout(function () {
            $subcategories_panel_to_be_closed.removeClass("modal-xs-right-out").hide();
        }, 300);
    });

    {# Mobile nav hamburger subitems #}

    jQueryNuvem(".js-toggle-page-accordion").on("click", function (e) {
        e.preventDefault();
        jQueryNuvem(e.currentTarget).toggleClass("selected").closest(".js-hamburger-panel-toggle-accordion").next(".js-pages-accordion").slideToggle(300);
    });

    {# Show and hide mobile nav on scroll #}

    var didScroll;
    var lastScrollTop = 0;
    var delta = 20;
    var logoHeight = jQueryNuvem(".js-desktop-head-container").outerHeight();
    var navbarHeight = jQueryNuvem('.js-mobile-nav').outerHeight();
    {% if template == 'category' %}
        var categoryBannerHeight = jQueryNuvem('.js-category-banner').outerHeight();
        var categoryBreadcrumbsHeight = jQueryNuvem('.js-category-breadcrumbs').outerHeight();
        var moveNavOffset = logoHeight + navbarHeight + addbar_height + categoryBannerHeight + categoryBreadcrumbsHeight;
    {% else %}
        var moveNavOffset = logoHeight + navbarHeight + addbar_height;
    {% endif %}

    window.addEventListener("scroll", function (event) {
        didScroll = true;
    });

    setInterval(function () {
        if (didScroll) {
            hasScrolled();
            didScroll = false;
        }
    }, 250);

    {# /* // Header fixed */ #}

    {% if settings.head_fix %} 
        var top_head = jQueryNuvem(".js-head-fixed").position().top;
        {% if settings.head_background == 'transparent' and settings.logo_position == 'left' and template == 'home' %}
            window.addEventListener("scroll", function(){
                var position = window.pageYOffset;
                var height_head = jQueryNuvem(".js-head-fixed").height();
                var height_slider = jQueryNuvem(".js-home-slider-container").height();

                if(position > top_head){
                    jQueryNuvem(".js-head-fixed").addClass('head-fix');
                    if (window.innerWidth < 960) {  jQueryNuvem(".js-body-position").css("paddingTop", height_head.toString() + 'px'); }
                } else {
                    jQueryNuvem(".js-head-fixed").removeClass('head-fix');
                    if (window.innerWidth < 960) {  jQueryNuvem(".js-body-position").css("paddingTop", "0px"); }
                }

                if(position > height_slider - 100){
                    jQueryNuvem(".js-head-fixed").addClass('head-trans-out');
                } else {
                    jQueryNuvem(".js-head-fixed").removeClass('head-trans-out');
                }
            });
        {% else %}
            window.addEventListener("scroll", function(){
                var position = window.pageYOffset;
                var height_head = jQueryNuvem(".js-head-fixed").height();

                if(position > top_head){
                    jQueryNuvem(".js-head-fixed").addClass('head-fix');
                    jQueryNuvem(".js-body-position").css("paddingTop", height_head.toString() + 'px');
                } else {
                    jQueryNuvem(".js-head-fixed").removeClass('head-fix');
                    jQueryNuvem(".js-body-position").css("paddingTop", "0px");
                }
            });
        {% endif %}
    {% endif %}

    var $category_controls = jQueryNuvem(".js-category-controls");

    function hasScrolled() {
        var st = window.pageYOffset;

        // Make sure they scroll more than delta
        if (Math.abs(lastScrollTop - st) <= delta)
            return;

        // If they scrolled down and are past the navbar, add class .move-up.
        if (st > lastScrollTop && st > moveNavOffset) {
            // Scroll Down
            if (!jQueryNuvem("body").hasClass("mobile-categories-visible")) {
                $top_nav.addClass("move-up").removeClass("move-down");
                {% if theme_version == 'box' %}
                    $category_controls.addClass("move-up").removeClass("move-down");
                {% endif %}
            }
            jQueryNuvem(".backdrop").addClass("move-up").removeClass("move-down");
        } else {
            // Scroll Up
            let documentHeight = Math.max(
                document.body.scrollHeight,
                document.body.offsetHeight,
                document.documentElement.clientHeight,
                document.documentElement.scrollHeight,
                document.documentElement.offsetHeight
            );

            if (st + window.innerHeight < documentHeight) {
                if (!jQueryNuvem("body").hasClass("mobile-categories-visible")) {
                    $top_nav.removeClass("move-up").addClass("move-down");
                    {% if theme_version == 'box' %}
                        $category_controls.removeClass("move-up").addClass("move-down");
                    {% endif %}
                }
                jQueryNuvem(".backdrop").removeClass("move-up").addClass("move-down");
            }
        }

        lastScrollTop = st;
    }

    {# /* // Megamenu */ #}

    {% if settings.megamenu %}

        if (window.innerWidth > 768) {
        
            var winHeight = window.innerHeight;
            var headHeight = jQueryNuvem(".js-desktop-head-container").height();

            jQueryNuvem(".js-megamenu").css('max-height', winHeight - headHeight - 50);

            jQueryNuvem(".js-item-subitems-desktop").on("mouseenter", function (e) {
                jQueryNuvem(e.currentTarget).addClass("active");
            }).on("mouseleave", function(e) {
                jQueryNuvem(e.currentTarget).removeClass("active");
            });

            jQueryNuvem(".js-nav-main-item").on("mouseenter", function (e) {
                jQueryNuvem('.js-desktop-nav-first-level').children(".hover").removeClass("hover");
                jQueryNuvem(e.currentTarget).addClass("hover");
            }).on("mouseleave", function(e) {
                setTimeout(function () {
                    jQueryNuvem('.js-nav-main-item.hover').removeClass("hover");
                }, 500);
            });

            {# Nav desktop scroller #}

            {% set logo_desktop_left = settings.version_theme != 'box' and settings.logo_position == 'left' %}

            const menuContainer = jQueryNuvem('.js-desktop-nav-first-level').first(el => el.offsetWidth);
            const logoColWidth = jQueryNuvem('.js-logo-container').first(el => el.offsetWidth);
            const logoColHeight = jQueryNuvem('.js-logo-container').height();
            let utilityColWidth = jQueryNuvem(".js-utilities-col").first(el => el.offsetWidth);

            const totalColsWidth = logoColWidth + utilityColWidth;

            {% if logo_desktop_left %}
                const menuColWidth = menuContainer - totalColsWidth - 10;
            {% endif %}

            let menuItems = 0;

            jQueryNuvem('.js-desktop-nav-first-level > .js-desktop-nav-item').each(function(el) {
                menuItems +=  jQueryNuvem(el).first(el => el.offsetWidth);
            });

            jQueryNuvem(".js-desktop-nav-first-level").on("scroll", function() {
                const position = jQueryNuvem('.js-desktop-nav-first-level').prop("scrollLeft");
                if(position == 0) {
                    jQueryNuvem(".js-desktop-nav-arrow-left").addClass('disable');
                } else {
                    jQueryNuvem(".js-desktop-nav-arrow-left").removeClass('disable');
                }
                if(position == ( menuItems - menuContainer )) {
                    jQueryNuvem(".js-desktop-nav-arrow-right").addClass('disable');
                } else {
                    jQueryNuvem(".js-desktop-nav-arrow-right").removeClass('disable');
                }
            }); 
            
            if (menuContainer < menuItems) {
                jQueryNuvem('.js-desktop-nav-first-level').addClass('desktop-nav-with-scroll');
                jQueryNuvem('.js-desktop-nav-arrow').show();
                {% if logo_desktop_left %}
                    jQueryNuvem(".js-desktop-nav-col").css("width" , menuColWidth.toString() + 'px').removeClass("p-left-double");
                {% endif %}
            }

            jQueryNuvem(".js-desktop-nav-col, .js-desktop-nav, .js-utilities-col").css("visibility", "visible").css("height", "auto");
            {% if logo_desktop_left %}
                jQueryNuvem(".js-desktop-nav-col").height(logoColHeight);
            {% endif %}

            {# Show nav row once columns layout are ready #}

            jQueryNuvem('.js-desktop-nav-arrow-right').click(function() {
                var posL = jQueryNuvem('.js-desktop-nav-first-level').prop("scrollLeft") + 400;
                jQueryNuvem('.js-desktop-nav-first-level').each((el) => el.scroll({ left: posL, behavior: 'smooth' }));
            });
            jQueryNuvem('.js-desktop-nav-arrow-left').click(function() {
                var posR = jQueryNuvem('.js-desktop-nav-first-level').prop("scrollLeft") - 400;
                jQueryNuvem('.js-desktop-nav-first-level').each((el) => el.scroll({ left: posR, behavior: 'smooth' }));
            });

            {# Avoid megamenu dropdown flickering when mouse leave #}

            jQueryNuvem(".js-megamenu").on("mouseleave", function (e) {
                const self = jQueryNuvem(this);
                self.css("pointer-events" , "none");
                setTimeout(function(){
                    self.css("pointer-events" , "initial");
                },1000);
            });
        }

    {% endif %}

    {# /* // Search suggestions */ #}

    LS.search(jQueryNuvem(".js-search-input"), function (html, count) {
        $search_suggests = jQueryNuvem(this).closest(".js-search-container").next(".js-search-suggest");
        if (count > 0) {
            $search_suggests.html(html).show();
        } else {
            $search_suggests.hide();
        }
        if (jQueryNuvem(this).val().length == 0) {
            $search_suggests.hide();
        }
    }, {
        snipplet: 'search-results.tpl'
    });
    
    if (window.innerWidth > 768) {

        {# Hide search suggestions if user click outside results #}

        jQueryNuvem("body").on("click", function () {
            jQueryNuvem(".js-search-suggest").hide();
        });

        {# Maintain search suggestions visibility if user click on links inside #}

        jQueryNuvem(document).on("click", ".js-search-suggest a", function () {
            jQueryNuvem(".js-search-suggest").show();
        });
    }

    jQueryNuvem(".js-search-suggest").on("click", ".js-search-suggest-all-link", function (e) {
        e.preventDefault();
        $this_closest_form = jQueryNuvem(this).closest(".js-search-suggest").prev(".js-search-form");
        $this_closest_form.submit();
    });

    {#/*============================================================================
      #Home page
    ==============================================================================*/ #}

    {# /* // Newsletter popup */ #}

    LS.newsletter_avoid_siteblindado_bot();
    var $newspopup_mandatory_field = jQueryNuvem('#news-popup-form').find(".js-mandatory-field");

    {% if settings.show_news_box %}
        jQueryNuvem('#news-popup-form').on("submit", function () {
            jQueryNuvem(".js-news-spinner").show();
            $newspopup_mandatory_field.removeClass("input-error");
            jQueryNuvem(".js-news-popup-submit").prop("disabled", true);
            ga_send_event('contact', 'newsletter', 'popup');
        });
        LS.newsletter('#news-popup-form-container', '#news-popup', '{{ store.contact_url | escape('js') }}', function (response) {
            jQueryNuvem(".js-news-spinner").hide();
            var selector_to_use = response.success ? '.js-news-popup-success' : '.js-news-popup-failed';
            let newsPopupAlert = jQueryNuvem(this).find(selector_to_use).fadeIn(100);
            setTimeout(() => newsPopupAlert.fadeOut(500), 4000);
            if (jQueryNuvem(".js-news-popup-success").css("display") == "block") {
                setTimeout(function () {
                    jQueryNuvem("#news-popup").modal('hide');
                }, 2500);
            } else {
                $newspopup_mandatory_field.addClass("input-error");
            }
            jQueryNuvem(".js-news-popup-submit").prop("disabled", false);
        });

        LS.newsletterPopup({
            selector: "#news-popup"
        });
    {% endif %}

    {% if template == 'home' %}

        {# /* // Home slider */ #}

        var width = window.innerWidth;
        
        {% if settings.slider_auto %}
            if (width > 767) { 
                var slider_autoplay = {delay: 6000,};
            } else {
                var slider_autoplay = false;
            }
        {% else %}
            var slider_autoplay = false;
        {% endif %}

        {% if params.preview %}
            window.homeSlider = {
                getAutoRotation: function() {
                    return slider_autoplay;
                },
                updateSlides: function(slides) {
                    homeSwiper.removeAllSlides();
                    slides.forEach(function(aSlide){
                        homeSwiper.appendSlide(
                            '<div class="swiper-slide slide-container">' +
                                (aSlide.link ? '<a href="' + aSlide.link + '">' : '' ) +
                                    '<img src="' + aSlide.src + '" class="slide-img"/>' + 
                                (aSlide.link ? '</a>' : '' ) +
                            '</div>'
                        );
                    });

                    {% set has_mobile_slider = settings.toggle_slider_mobile and settings.slider_mobile and settings.slider_mobile is not empty %}

                    if(!slides.length){
                        jQueryNuvem(".js-home-main-slider-container").addClass("hidden");
                        jQueryNuvem(".js-home-empty-slider-container").removeClass("hidden");
                        jQueryNuvem(".js-home-mobile-slider-visibility").removeClass("visible-phone");
                        {% if has_mobile_slider %}
                            jQueryNuvem(".js-home-main-slider-visibility").removeClass("hidden-phone");
                            homeMobileSwiper.update();
                        {% endif %}
                    }else{
                        jQueryNuvem(".js-home-main-slider-container").removeClass("hidden");
                        jQueryNuvem(".js-home-empty-slider-container").addClass("hidden");
                        jQueryNuvem(".js-home-mobile-slider-visibility").addClass("visible-phone");
                        {% if has_mobile_slider %}
                            jQueryNuvem(".js-home-main-slider-visibility").addClass("hidden-phone");
                        {% endif %}
                    }
                },
                changeAutoRotation: function(){

                },
            };
        {% endif %}

        var homeSwiper = null;
        createSwiper(
            '.js-home-slider',
            {
                preloadImages: false,
                lazy: true,
                {% if settings.slider | length > 1 %}
                    loop: true,
                {% endif %}
                {% if settings.slider_auto %}
                    autoplay: slider_autoplay,
                {% endif %}
                pagination: {
                    el: '.js-swiper-home-pagination',
                    clickable: true,
                },
                navigation: {
                    nextEl: '.js-swiper-home-next',
                    prevEl: '.js-swiper-home-prev',
                },
            },
            function(swiperInstance) {
                homeSwiper = swiperInstance;
            }
        );

        var homeMobileSwiper = null;
        createSwiper(
            '.js-home-slider-mobile',
            {
                preloadImages: false,
                lazy: true,
                {% if settings.slider | length > 1 %}
                    loop: true,
                {% endif %}
                autoplay: false,
                pagination: {
                    el: '.js-swiper-home-pagination-mobile',
                    clickable: true,
                },
                navigation: {
                    nextEl: '.js-swiper-home-next-mobile',
                    prevEl: '.js-swiper-home-prev-mobile',
                },
            },
            function(swiperInstance) {
                homeMobileSwiper = swiperInstance;
            }
        );

        {% if settings.slider | length == 1 %}
            jQueryNuvem('.js-swiper-home .swiper-wrapper').addClass( "disabled" );
            {% if params.preview %}
                jQueryNuvem('js-swiper-home-control').hide();
            {% else %}
                jQueryNuvem('js-swiper-home-control').remove();
            {% endif %}                          
        {% endif %} 

        {# /* // Banner services slider */ #}

        {% set has_banner_services = settings.banner_services or settings.banner_services_home or settings.banner_services_category %}

        {% if has_banner_services %}

            {# /* // Banner services slider */ #}

            var width = window.outerWidth;
            if (width < 767) {   
                createSwiper('.js-mobile-services', {
                    slidesPerView: 1,
                    watchOverflow: true,
                    centerInsufficientSlides: true,
                    pagination: {
                        el: '.js-mobile-service-pagination',
                        clickable: true,
                    },
                });
            }

        {% endif %} 


        {# /* // Products slider */ #}

        {% if sections.sale.products %}

            {% if settings.product_color_variants or settings.quick_view %}

                {# Duplicate cloned slide elements for quickshop or colors forms #}

                updateClonedItemsIDs = function(element){
                    jQueryNuvem(element).each(function(el) {
                        var $this = jQueryNuvem(el);
                        var slide_index = $this.attr("data-swiper-slide-index");
                        var clone_quick_id = $this.find(".js-quickshop-container").attr("data-quickshop-id");
                        var clone_product_id = $this.attr("data-product-id");
                        $this.attr("data-product-id" , clone_product_id + "-clone-" + slide_index);
                        $this.find(".js-quickshop-container").attr("data-quickshop-id" , clone_quick_id + "-clone-" + slide_index);
                    });
                };

            {% endif %}

            window.swiperLoader('.js-swiper-sale-products', {
                lazy: true,
                {% if sections.sale.products | length > 3 %}
                loop: true,
                {% endif %}
                spaceBetween: 30,
                watchSlidesVisibility: true,
                slideVisibleClass: 'js-swiper-slide-visible',
                slidesPerView: 1,
                slidesPerGroup: 1,
                threshold: 5,
                pagination: {
                    el: '.js-swiper-sale-products-pagination',
                    clickable: true,
                },
                navigation: {
                    nextEl: '.js-swiper-sale-products-next',
                    prevEl: '.js-swiper-sale-products-prev',
                },
                breakpoints: {
                    640: {
                        slidesPerView: 3,
                        slidesPerGroup: 3,
                    }
                },
                {% if settings.product_color_variants or settings.quick_view %}
                    on: {
                        init: function () {
                            updateClonedItemsIDs(".js-swiper-sale-products .js-item-slide.swiper-slide-duplicate");
                        },
                    }
                {% endif %}
            });

            {% if sections.sale.products | length == 1 %}
                jQueryNuvem('.js-swiper-sale-products .swiper-wrapper').addClass( "disabled" );
                jQueryNuvem('.js-swiper-sale-products-pagination, .js-swiper-sale-products-prev, .js-swiper-sale-products-next').remove();
            {% endif %} 

        {% endif %}   


        {# Twitter Feed #}

        {% if settings.twitter_widget and store.twitter %}

            {% set twuser = store.twitter|split('/')|last %}

            var configProfile = {
            "profile": {"screenName": '{{ twuser }}'},
            "domId": 'twitterfeed',
            "maxTweets": 3,
            "enableLinks": true,
            "showUser": true,
            "showTime": true,
            "showImages": false,
            "lang": 'en'
            };
            twitterFetcher.fetch(configProfile);

        {% endif %}

    {% endif %}

    {% if template == 'home' %}
        {% set video_url = settings.video_embed %}
    {% elseif template == 'product' and product.video_url %}
        {% set video_url = product.video_url %}
    {% endif %}

    {% if video_url %}

        {# /* // Youtube or Vimeo video for home or each product */ #}

        LS.loadVideo('{{ video_url }}');

        jQueryNuvem('#modal-product-video').on('hidden.bs.modal', function (e) {
            jQueryNuvem(".js-product-video-modal").find(".js-video-iframe").empty().hide();
        });
        
    {% endif %}

    {#/*============================================================================
      #Product grid
    ==============================================================================*/ #}

    {# /* // Secondary image on mouseover */ #}
    
    {% if settings.product_hover %}
        if (window.innerWidth > 767) {
            jQueryNuvem(document).on("mouseover", ".js-item-with-secondary-image:not(.item-with-two-images)", function(e) {
                var secondary_image_to_show = jQueryNuvem(this).find(".js-item-image-secondary");
                secondary_image_to_show.show();
                secondary_image_to_show.on('lazyloaded', function(e){
                    jQueryNuvem(e.currentTarget).closest(".js-item-with-secondary-image").addClass("item-with-two-images");
                });
            });
        }
    {% endif %}

    {% if template == 'category' %}

        {# /* // Filters */ #}

        jQueryNuvem(".js-toggle-mobile-filters").on("click", function (e) {
            e.preventDefault();
            jQueryNuvem(".js-mobile-filters-panel").toggleClass("modal-xs-right-in modal-xs-right-out");
            jQueryNuvem("body").toggleClass("overflow-none");
        });

        {# /* // Filter apply and remove */ #}

        jQueryNuvem(document).on("click", ".js-apply-filter, .js-remove-filter", function(e) {
            e.preventDefault();
            var filter_name = jQueryNuvem(this).data('filterName');
            var filter_value = jQueryNuvem(this).attr('data-filter-value');
            if(jQueryNuvem(this).hasClass("js-apply-filter")){
                jQueryNuvem(this).find("[type=checkbox]").prop("checked", true);
                LS.urlAddParam(
                    filter_name, 
                    filter_value, 
                    true
                );
            }else{
                jQueryNuvem(this).find("[type=checkbox]").prop("checked", false);
                LS.urlRemoveParam(
                    filter_name, 
                    filter_value
                );   
            }
            {# Toggle class to avoid adding double parameters in case of double click and show applying changes feedback #}

            if (jQueryNuvem(this).hasClass("js-filter-checkbox")){
                if (window.innerWidth < 768) {
                    jQueryNuvem(".js-filters-overlay").show();
                    if(jQueryNuvem(this).hasClass("js-apply-filter")){
                        jQueryNuvem(".js-applying-filter").show();
                    }else{
                        jQueryNuvem(".js-removing-filter").show();
                    }
                }
                jQueryNuvem(this).toggleClass("js-apply-filter js-remove-filter");
            }
        });

        jQueryNuvem(document).on("click", ".js-remove-all-filters", function(e) {
            e.preventDefault();
            LS.urlRemoveAllParams();
        });

        {# /* // Sort by */ #}

        jQueryNuvem('.js-sort-by').on("change", function (e) {
            var params = LS.urlParams;
            params['sort_by'] = jQueryNuvem(e.currentTarget).val();
            var sort_params_array = [];
            for (var key in params) {
                if (!['results_only', 'page'].includes(key)) {
                    sort_params_array.push(key + '=' + params[key]);
                }
            }
            var sort_params = sort_params_array.join('&');
            window.location = window.location.pathname + '?' + sort_params;
        });

        {# /* // Set sticky filters */ #}

        var $category_controls = jQueryNuvem(".js-category-controls");

        {% if theme_version == 'box' %}
            var mobile_nav_height = jQueryNuvem(".js-mobile-nav").outerHeight();
        {% elseif settings.head_fix %}
            var mobile_nav_height = jQueryNuvem(".js-head-fixed").outerHeight();
        {% else %}
            var mobile_nav_height = 0;
        {% endif %}

        if (window.innerWidth < 768) {
            jQueryNuvem(".js-category-controls").css("top" , mobile_nav_height.toString() + 'px');

            {# Detect if category controls are sticky and add css #}
            var observer = new IntersectionObserver(function(entries) {
                if(entries[0].intersectionRatio === 0)
                    document.querySelector(".js-category-controls").classList.add("is-sticky");
                else if(entries[0].intersectionRatio === 1)
                    document.querySelector(".js-category-controls").classList.remove("is-sticky");
                }, { threshold: [0,1] 
            });
            observer.observe(document.querySelector(".js-category-controls-prev"));
        }

    {% endif %}

    {% if settings.infinite_scrolling and (template == 'category' or template == 'search') %}

        {# /* // Infinite scroll */ #}

        !function() {

            {# Show more products function #}

            {% if pages.current == 1 and not pages.is_last %}
                LS.hybridScroll({
                    productGridSelector: '.js-product-table',
                    spinnerSelector: '#js-infinite-scroll-spinner',
                    loadMoreButtonSelector: '.js-load-more-btn',
                    hideWhileScrollingSelector: ".js-hide-footer-while-scrolling",
                    productsBeforeLoadMoreButton: 50,
                    productsPerPage: {{ settings.category_quantity_products }}
                });
            {% endif %}
        }();
    {% endif %}

    {% if template == 'category' or template == 'search' %}

        {# /* // Mobile pagination */ #}

        jQueryNuvem(".js-mobile-paginator-input").on("focusout", function (e) {
            e.preventDefault();
            LS.paginateMobile();
        });

    {% endif %}

    {% if template == 'home' or template == 'category' %}

        {# /* // Categories sidebar */ #}

        var categoriesList = jQueryNuvem(".js-category-sidebar-item");
        var categoriesAmount = 10;

        if (categoriesList.length > categoriesAmount) {
            jQueryNuvem("#show-more-categories").show();
            for (i = categoriesAmount; i < categoriesList.length; i++) {
                jQueryNuvem(categoriesList.get()[i]).hide();
            }
        }

        jQueryNuvem("#show-more-categories").on("click", function(e){
            e.preventDefault();
            for (i = categoriesAmount; i < categoriesList.length; i++) {
                jQueryNuvem(categoriesList.get()[i]).toggle();
            }
            jQueryNuvem(e.currentTarget).toggleClass("selected");
        });

    {% endif %}

    {#/*============================================================================
      #Product detail functions
    ==============================================================================*/ #}

    {# /* // Installments */ #}

    {# Installments without interest #}

    function get_max_installments_without_interests(number_of_installment, installment_data, max_installments_without_interests) {
        if (parseInt(number_of_installment) > parseInt(max_installments_without_interests[0])) {
            if (installment_data.without_interests) {
                return [number_of_installment, installment_data.installment_value.toFixed(2)];
            }
        }
        return max_installments_without_interests;
    }

    {# Installments with interest #}

    function get_max_installments_with_interests(number_of_installment, installment_data, max_installments_with_interests) {
        if (parseInt(number_of_installment) > parseInt(max_installments_with_interests[0])) {
            if (installment_data.without_interests == false) {
                return [number_of_installment, installment_data.installment_value.toFixed(2)];
            }
        }
        return max_installments_with_interests;
    }

    {# Updates installments on payment popup for native integrations #}

    function refreshInstallmentv2(price){
        jQueryNuvem(".js-modal-installment-price" ).each(function( el ) {
            const installment = Number(jQueryNuvem(el).data('installment'));
            jQueryNuvem(el).text(LS.currency.display_short + (price/installment).toLocaleString('de-DE', {maximumFractionDigits: 2, minimumFractionDigits: 2}));
        });
    }

    {# Refresh price on payments popup with payment discount applied #}

    function refreshPaymentDiscount(price){
        jQueryNuvem(".js-price-with-discount" ).each(function( el ) {
            const payment_discount = jQueryNuvem(el).data('paymentDiscount');
            jQueryNuvem(el).text(LS.formatToCurrency(price - ((price * payment_discount) / 100)))
        });
    }

    {# /* // Change variant */ #}

    function changeVariant(variant){
        jQueryNuvem(".js-product-detail .js-shipping-calculator-response").hide();
        jQueryNuvem("#shipping-variant-id").val(variant.id);
        var parent = jQueryNuvem("body");
        if (variant.element){
            parent = jQueryNuvem(variant.element);
        }

        var sku = parent.find('#sku');
        if(sku.length) {
            sku.text(variant.sku).show();
        }

        {% if settings.product_stock or settings.latest_products_available %}
            var stock = parent.find('.js-product-stock');
            stock.text(variant.stock).show();
        {% endif %}

        {# Updates installments on list item and inside payment popup for Payments Apps #}

        var installment_helper = function($element, amount, price){
            $element.find('.js-installment-amount').text(amount);
            $element.find('.js-installment-price').attr("data-value", price);
            $element.find('.js-installment-price').text(LS.currency.display_short + parseFloat(price).toLocaleString('de-DE', { minimumFractionDigits: 2 }));
            if(variant.price_short && Math.abs(variant.price_number - price * amount) < 1) {
                $element.find('.js-installment-total-price').text((variant.price_short).toLocaleString('de-DE', { minimumFractionDigits: 2 }));
            } else {
                $element.find('.js-installment-total-price').text(LS.currency.display_short + (price * amount).toLocaleString('de-DE', { minimumFractionDigits: 2 }));
            }
        };

        if (variant.installments_data) {
            var variant_installments = JSON.parse(variant.installments_data);
            var max_installments_without_interests = [0,0];
            var max_installments_with_interests = [0,0];

            {# Hide all installments rows on payments modal #}
            jQueryNuvem('.js-payment-provider-installments-row').hide();

            for (let payment_method in variant_installments) {

                {# Identifies the minimum installment value #}
                var paymentMethodId = '#installment_' + payment_method.replace(" ", "_") + '_1';
                var minimumInstallmentValue = jQueryNuvem(paymentMethodId).closest('.js-info-payment-method').attr("data-minimum-installment-value");

                let installments = variant_installments[payment_method];
                for (let number_of_installment in installments) {
                    let installment_data = installments[number_of_installment];
                    max_installments_without_interests = get_max_installments_without_interests(number_of_installment, installment_data, max_installments_without_interests);
                    max_installments_with_interests = get_max_installments_with_interests(number_of_installment, installment_data, max_installments_with_interests);
                    var installment_container_selector = '#installment_' + payment_method.replace(" ", "_") + '_' + number_of_installment;

                    {# Shows installments rows on payments modal according to the minimum value #}
                    if(minimumInstallmentValue <= installment_data.installment_value) {
                        jQueryNuvem(installment_container_selector).show();
                    }
                    
                    if(!parent.hasClass("js-quickshop-container")){
                        installment_helper(jQueryNuvem(installment_container_selector), number_of_installment, installment_data.installment_value.toFixed(2));
                    }
                }
            }
            var $installments_container = jQueryNuvem(variant.element + ' .js-max-installments-container .js-max-installments');
            var $installments_modal_link = jQueryNuvem(variant.element + ' #btn-installments');
            var $payments_module = jQueryNuvem(variant.element + ' .js-product-payments-container');
            var $installmens_card_icon = jQueryNuvem(variant.element + ' .js-installments-credit-card-icon');

            {% if product.has_direct_payment_only %}
            var installments_to_use = max_installments_without_interests[0] >= 1 ? max_installments_without_interests : max_installments_with_interests;

            if(installments_to_use[0] <= 0 ) {
            {%  else %}
            var installments_to_use = max_installments_without_interests[0] > 1 ? max_installments_without_interests : max_installments_with_interests;

            if(installments_to_use[0] <= 1 ) {
            {% endif %}
                $installments_container.hide();
                $installments_modal_link.hide();
                $payments_module.hide();
                $installmens_card_icon.hide();
            } else {
                $installments_container.show();
                $installments_modal_link.show();
                $payments_module.show();
                $installmens_card_icon.show();
                installment_helper($installments_container, installments_to_use[0], installments_to_use[1]);
            }

            {# Whit tag: juno-featured-installments  Update interest-free installments #}
            
            {% if store.has_juno_featured_installments %}
                var $installments_featured_amount = parent.find('.js-installment-featured-amount').attr("data-value");
                parent.find('.js-installment-featured-price').text('$' + (variant.price_number/$installments_featured_amount).toFixed(2).replace(".", ","));
            {% endif %}
        }

        if(!parent.hasClass("js-quickshop-container")){
            jQueryNuvem('#installments-modal .js-installments-one-payment').text(variant.price_short).attr("data-value", variant.price_number);
        }

        if (variant.price_short){
            parent.find('.js-price-display').text(variant.price_short).show();
            parent.find('.js-price-display').attr("content", variant.price_number).data('productPrice', variant.price_number_raw);
            
            parent.find('.js-payment-discount-price-product').text(variant.price_with_payment_discount_short);
            parent.find('.js-payment-discount-price-product-container').show();
        } else {
            parent.find('.js-price-display, .js-payment-discount-price-product-container').hide();
        }

        if ((variant.compare_at_price_short) && !(parent.find(".js-price-display").css("display") == "none")) {
            parent.find('.js-compare-price-display').text(variant.compare_at_price_short).show();
            
            if(variant.compare_at_price_number > variant.price_number){
                const saved_compare_price_money = variant.compare_at_price_number - variant.price_number;
                parent.find('.js-offer-saved-money').text(LS.formatToCurrency(saved_compare_price_money));
                parent.find(".js-saved-money-message").show();
            }else {
                parent.find(".js-saved-money-message").hide();
            }
        } else {
            parent.find('.js-compare-price-display, .js-saved-money-message').hide();
        }

        var button = parent.find('.js-addtocart');

        {% set has_colors_and_quickshop = settings.product_color_variants and settings.quick_view %}

        {% if has_colors_and_quickshop %}
            var $quickshop_link = parent.find('.js-quickshop-modal-open');
        {% endif %}

        button.removeClass('cart').removeClass('contact').removeClass('nostock');
        var $product_shipping_calculator = parent.find("#product-shipping-container");
        {% if not store.is_catalog %}
        if (!variant.available){
            button.val('{{ "Sin stock" | translate }}');
            button.addClass('nostock');
            button.attr('disabled', 'disabled');
            {% if has_colors_and_quickshop %}
                $quickshop_link.hide();
            {% endif %}
            $product_shipping_calculator.hide();
        } else if (variant.contact) {
            button.val('{{ "Consultar precio" | translate }}');
            button.addClass('contact');
            button.removeAttr('disabled');
            {% if has_colors_and_quickshop %}
                $quickshop_link.hide();
            {% endif %}
            $product_shipping_calculator.hide();
        } else {
            button.val('{{ "Agregar al carrito" | translate }}');
            button.addClass('cart');
            button.removeAttr('disabled');
            {% if has_colors_and_quickshop %}
                $quickshop_link.show();
            {% endif %}
            $product_shipping_calculator.show();
        }
        {% endif %}
        {% if template == 'product' %}
            const base_price = Number(jQueryNuvem("#price_display").attr("content"));
            refreshInstallmentv2(base_price);
            refreshPaymentDiscount(variant.price_number);

            {% if settings.last_product and product.variations %}
                if(variant.stock == 1) {
                    jQueryNuvem('.js-last-product').show();
                } else {
                    jQueryNuvem('.js-last-product').hide();
                }
                {% if settings.latest_products_available %}
                    const stock_limit = jQueryNuvem(".js-latest-products-available").attr("data-limit");
                    if(variant.stock < stock_limit && variant.stock != null && variant.stock != 1 && variant.stock != 0) {
                        jQueryNuvem('.js-latest-products-available').show();
                    } else {
                        jQueryNuvem('.js-latest-products-available').hide();
                    }
                {% endif %}
            {% endif %}
        {% endif %}
        
        {# Update shipping on variant change #}

        LS.updateShippingProduct();

        zipcode_on_changevariant = jQueryNuvem("#product-shipping-container .js-shipping-input").val();
        jQueryNuvem("#product-shipping-container .js-shipping-calculator-current-zip").text(zipcode_on_changevariant);

        {% if cart.free_shipping.min_price_free_shipping.min_price %}
            {# Updates free shipping bar #}

            LS.freeShippingProgress(true, parent);

        {% endif %}
    }

    {# /* // Product labels on variant change */ #}

    {# Show and hide labels on product variant change. Also recalculates discount percentage #}

    jQueryNuvem(document).on("change", ".js-variation-option", function(e) {

        var $parent = jQueryNuvem(this).closest(".js-product-variants");
        var $variants_group = jQueryNuvem(this).closest(".js-product-variants-group");
        var $quickshop_parent_wrapper = jQueryNuvem(this).closest(".js-quickshop-container");

        {# If quickshop is used from modal, use quickshop-id from the item that opened it #}

        if($quickshop_parent_wrapper.hasClass("js-quickshop-modal")){
            var quick_id = jQueryNuvem(".js-quickshop-opened .js-quickshop-container").data("quickshopId");
        }else{
            var quick_id = $quickshop_parent_wrapper.data("quickshopId");
        }            
        if($parent.hasClass("js-product-quickshop-variants")){
            
            var $quickshop_parent = jQueryNuvem(this).closest(".js-item-product");

            {# Target visible slider item if necessary #}
            
            if($quickshop_parent.hasClass("js-item-slide")){
                var $quickshop_variant_selector = '.js-swiper-slide-visible .js-quickshop-container[data-quickshop-id="'+quick_id+'"]';
            }else{
                var $quickshop_variant_selector = '.js-quickshop-container[data-quickshop-id="'+quick_id+'"]';
            }

            LS.changeVariant(changeVariant, $quickshop_variant_selector);

            {% if settings.product_color_variants %}
                {# Match selected color variant with selected quickshop variant #}

                if(($variants_group).hasClass("js-color-variants-container")){
                    var selected_option_id = jQueryNuvem(this).find("option").filter((el) => el.selected).val();
                    if($quickshop_parent.hasClass("js-item-slide")){
                        var $color_parent_to_update = jQueryNuvem('.js-swiper-slide-visible .js-quickshop-container[data-quickshop-id="'+quick_id+'"]');
                    }else{
                        var $color_parent_to_update = jQueryNuvem('.js-quickshop-container[data-quickshop-id="'+quick_id+'"]');
                    }
                    $color_parent_to_update.find('.js-color-variant').removeClass("selected");
                    $color_parent_to_update.find('.js-color-variant[data-option="'+selected_option_id+'"]').addClass("selected");
                }
            {% endif %}
        } else {
            LS.changeVariant(changeVariant, '#single-product .js-product-container');
        }
        
        {# Offer and discount labels update #}

        var $this_product_container = jQueryNuvem(this).closest(".js-product-container");

        if($this_product_container.hasClass("js-quickshop-container")){
            var this_quickshop_id = $this_product_container.attr("data-quickshop-id");
            var $this_product_container = jQueryNuvem('.js-product-container[data-quickshop-id="'+this_quickshop_id+'"]');
        }
        var $this_compare_price = $this_product_container.find(".js-compare-price-display");
        var $this_price = $this_product_container.find(".js-price-display");
        var $installment_container = $this_product_container.find(".js-product-payments-container");
        var $installment_text = $this_product_container.find(".js-max-installments-container");
        var $this_add_to_cart = $this_product_container.find(".js-prod-submit-form");

        // Get the current product discount percentage value
        var current_percentage_value = $this_product_container.find(".js-offer-percentage");

        // Get the current product price and promotional price
        var compare_price_value = $this_compare_price.html();
        var price_value = $this_price.html();

        // Calculate new discount percentage based on difference between filtered old and new prices
        const percentageDifference = window.moneyDifferenceCalculator.percentageDifferenceFromString(compare_price_value, price_value);
        if(percentageDifference){
            $this_product_container.find(".js-offer-percentage").text(percentageDifference);
            $this_product_container.find(".js-offer-label").css("display" , "table");
        }

        if ($this_compare_price.css("display") == "none" || !percentageDifference) {
            $this_product_container.find(".js-offer-label").hide();
        }

        if ($this_add_to_cart.hasClass("nostock")) {
            $this_product_container.find(".js-stock-label").show();
        }
        else {
            $this_product_container.find(".js-stock-label").hide();
        }
        if ($this_price.css('display') == 'none'){
            $installment_container.hide();
            $installment_text.hide();
        }else{
            $installment_text.show();
        }
    });

    {# /* // Color and size variations */ #}

    jQueryNuvem(document).on("click", ".js-insta-variant", function (e) {
        e.preventDefault();
        $this = jQueryNuvem(this);
        $this.siblings().removeClass("selected");
        $this.addClass("selected");

        var option_id = $this.attr('data-option');
        $selected_option = $this.closest('.js-product-variants').find('.js-variation-option option').filter(function (el) {
            return el.value == option_id;
        });
        $selected_option.prop('selected', true).trigger('change');

        $this.closest("[class^='variation']").find('.js-insta-variation-label').html(option_id);

        {% if settings.product_color_variants %}

            {# Sync quickshop color links with item color item color links #}
            
            var quickshop_id = $this.closest(".js-item-product").data("productId");

            jQueryNuvem('#quick-item' + quickshop_id).find('.js-color-variant').removeClass("selected");
            jQueryNuvem('#quick-item' + quickshop_id).find('.js-color-variant[data-option="'+option_id+'"]').addClass("selected");
        {% endif %}
    });

    {% if settings.product_color_variants %}

        {# /* // Product grid color variations */ #}

        jQueryNuvem(document).on("click", ".js-color-variant", function(e) {
            e.preventDefault();
            $this = jQueryNuvem(this);

            var option_id = $this.data('option');
            $selected_option = $this.closest('.js-item-product').find('.js-variation-option option').filter(function(el) {
                return el.value == option_id;
            });
            $selected_option.prop('selected', true).trigger('change');
            $this.closest('.js-item-product').find('.js-color-variant-bullet .js-insta-variation-label').html(option_id);
            $this.closest('.js-item-product').find('.js-color-variant-bullet .js-insta-variant').removeClass('selected');
            $this.closest('.js-item-product').find('.js-color-variant-bullet .js-insta-variant[data-option="'+option_id+'"]').addClass('selected');

            var available_variant = jQueryNuvem(this).closest(".js-quickshop-container").data('variants');

            var available_variant_color = jQueryNuvem(this).closest('.js-color-variant-active').data('option');

            for (var variant in available_variant) {
                if (option_id == available_variant[variant]['option'+ available_variant_color ]) {

                    if (available_variant[variant]['stock'] == null || available_variant[variant]['stock'] > 0 ) {

                        var otherOptions = getOtherOptionNumbers(available_variant_color);

                        var otherOption = available_variant[variant]['option' + otherOptions[0]];
                        var anotherOption = available_variant[variant]['option' + otherOptions[1]];

                        changeSelect(jQueryNuvem(this), otherOption, otherOptions[0]);
                        changeSelect(jQueryNuvem(this), anotherOption, otherOptions[1]);
                        break;

                    }
                }
            }

            $this.siblings().removeClass("selected");
            $this.addClass("selected");
        });

        function getOtherOptionNumbers(selectedOption) {
            switch (selectedOption) {
                case 0:
                    return [1, 2];
                case 1:
                    return [0, 2];
                case 2:
                    return [0, 1];
            }
        }

        function changeSelect(element, optionToSelect, optionIndex) {
            if (optionToSelect != null) {
                var selected_option_parent_id = element.closest('.js-item-product').data("productId");
                var selected_option_attribute = jQueryNuvem('.js-item-product[data-product-id="'+selected_option_parent_id+'"]').find('.js-color-variant-available-' + (optionIndex + 1)).data('value');
                var selected_option = jQueryNuvem('.js-item-product[data-product-id="'+selected_option_parent_id+'"]').find('.js-variation-option[data-variant-id="'+selected_option_attribute+'"] option').filter(function(el) {
                    return el.value == optionToSelect;
                });

                selected_option.prop('selected', true).trigger('change');

                $this.closest('.js-item-product').find('.js-product-variants .variation_' + (optionIndex + 1) +' .js-insta-variation-label').html(optionToSelect);
                $this.closest('.js-item-product').find('.js-product-variants .variation_' + (optionIndex + 1) +' .js-insta-variant').removeClass('selected');
                $this.closest('.js-item-product').find('.js-product-variants .variation_' + (optionIndex + 1) +' .js-insta-variant[data-option="'+optionToSelect+'"]').addClass('selected');
                
            }
        }

    {% endif %}

    {% if settings.quick_view or settings.product_color_variants %}
    
        {# Product quickshop for color variations #}

        LS.registerOnChangeVariant(function(variant){
            {# Show product image on color change #}
            
            var $item_to_update_image = jQueryNuvem('.js-item-product[data-product-id^="'+variant.product_id+'"].js-swiper-slide-visible');
            var $item_to_update_image_cloned = jQueryNuvem('.js-item-product[data-product-id^="'+variant.product_id+'"].js-swiper-slide-visible.swiper-slide-duplicate');

            {# If item is cloned from swiper change only cloned item #}

            if($item_to_update_image.hasClass("swiper-slide-duplicate")){
                var slide_item_index = $item_to_update_image_cloned.attr("data-swiper-slide-index");
                var current_image = jQueryNuvem('.js-item-product[data-product-id="'+variant.product_id+'-clone-'+slide_item_index+'" ] .js-item-image');
            }else{
                var slide_item_index = $item_to_update_image.attr("data-swiper-slide-index");
                var current_image = jQueryNuvem('.js-item-product[data-product-id="'+variant.product_id+'"] .js-item-image');
            }
            current_image.closest(".js-item-image-container").find(".js-item-image-source").attr('srcset', variant.image_url);
            current_image.attr('srcset', variant.image_url);

            {% if settings.product_hover %}
                {# Remove secondary feature on image updated from changeVariant #}
                current_image.closest(".js-item-with-secondary-image").removeClass("item-with-two-images");
            {% endif %}
        });

        jQueryNuvem(document).on("click", ".js-quickshop-modal-open", function (e) {
            e.preventDefault();
            var $this = jQueryNuvem(this);
            if($this.hasClass("js-quickshop-slide")){
                jQueryNuvem("#quickshop-modal .js-item-product").addClass("js-swiper-slide-visible js-item-slide");
            }
            LS.fillQuickshop($this);

            {# Image dimensions #}
            if (window.innerWidth < 768) {
                var product_image_dimension = jQueryNuvem(this).closest('.js-item-product').find('.js-item-image-padding').attr("style");
                jQueryNuvem("#quickshop-modal .js-quickshop-img-padding").attr("style", product_image_dimension);
            }

        });

    {% endif %}

    {% if settings.quick_view %}
        restoreQuickshopForm = function(){

            {# Clean quickshop modal #}

            jQueryNuvem("#quickshop-modal .js-item-product").removeClass("js-swiper-slide-visible js-item-slide");
            jQueryNuvem("#quickshop-modal .js-quickshop-container").attr('data-variants', '').attr('data-quickshop-id', '');
            jQueryNuvem("#quickshop-modal .js-item-product").attr('data-product-id', '');

            {# Wait for modal to become invisible before removing form #}

            setTimeout(function(){
                var $quickshop_form = jQueryNuvem("#quickshop-form").find('.js-product-form');
                var $item_form_container = jQueryNuvem(".js-quickshop-opened").find(".js-item-variants");
                
                $quickshop_form.detach().appendTo($item_form_container);
                jQueryNuvem(".js-quickshop-opened").removeClass("js-quickshop-opened");
            },350);

        };

        {# Restore form to item when quickshop closes #}

        jQueryNuvem('#quickshop-modal').on('hidden.bs.modal', function (event) {
            restoreQuickshopForm();
        });

        {# Get width of the placeholder button #}

        var productButttonWidth = jQueryNuvem(".js-addtocart-placeholder-inline").prev(".js-addtocart").innerWidth();

    {% endif %}

    {% if template == 'product' %}

        {# /* // Product mobile variants */ #}

        jQueryNuvem(document).on("click", ".js-mobile-vars-btn", function(e) {
            jQueryNuvem(this).next(".js-mobile-vars-panel").removeClass('js-var-panel modal-xs-right-out').addClass('js-var-panel modal-xs-right-in');
            jQueryNuvem(this).closest(".modal").prop("scrollTop"), "fast";
            jQueryNuvem("body").addClass("overflow-none");
        });

        function closeVarPanel() {
        setTimeout(function(){
            jQueryNuvem('.js-var-panel').removeClass('js-var-panel modal-xs-right-in').addClass('js-var-panel modal-xs-right-out')}, 300);
            jQueryNuvem("body").removeClass("overflow-none");
        };

        jQueryNuvem(document).on("click", ".js-close-panel", function(e) {
          closeVarPanel();
        });

        jQueryNuvem(".js-quickshop-mobile-vars-property").on( "click", function(e) {
            jQueryNuvem(e.currentTarget).closest(".modal").prop("scrollTop", jQueryNuvem(e.currentTarget).closest(".js-mobile-vars").find(".js-mobile-vars-btn").offset().top);
            closeVarPanel();
        });

        jQueryNuvem(document).on( "click", ".js-mobile-vars-property", function(e) {
            var selectedoption = jQueryNuvem(this).attr("data-option");
            var varname = jQueryNuvem(this).closest(".js-mobile-vars-panel").data("custom");
            jQueryNuvem(this).closest(".js-mobile-vars").find(".js-mobile-vars-selected-label").html(selectedoption);
            jQueryNuvem(this).closest(".js-product-detail").prop("scrollTop", jQueryNuvem(this).closest(".js-mobile-vars").find(".js-mobile-vars-btn").offset().top);
            closeVarPanel();
        });

        jQueryNuvem(".js-mobile-vars-property").on("click", function(e) {
            e.preventDefault();
            $this = jQueryNuvem(e.currentTarget);
            $this.siblings().removeClass("selected");
            $this.addClass("selected");
            var option_id = $this.attr('data-option');
            $selected_option = $this.closest('.js-mobile-variations-container').find('.js-variation-option option').filter(function(el) {
                return el.value == option_id;
            });
            $selected_option.prop('selected', true).trigger('change');
        });

        {# /* // Pinterest sharing */ #}

        jQueryNuvem('.js-mobile-pinterest-share').on("click", function(e){
            e.preventDefault();
            jQueryNuvem(".js-pinterest-share a").get()[0].click();
        });

        {# /* // Product slider */ #}

        {% set has_multiple_slides = product.images_count > 1 or video_url %}

        function productSliderNav(){
            var productSwiper = null;
            createSwiper(
                '.js-swiper-product',
                {
                    lazy: true,
                    loop: false,
                    slideActiveClass: 'js-product-active-image',
                    pagination: {
                        el: '.js-swiper-product-pagination',
                        clickable: true,
                    },
                    navigation: {
                        nextEl: '.js-swiper-product-next',
                        prevEl: '.js-swiper-product-prev',
                    },
                    on: {
                        init: function () {
                            jQueryNuvem(".js-product-slider-placeholder, .js-product-detail-loading-icon").hide();
                            jQueryNuvem(".js-swiper-product").css("visibility", "visible").css("height", "auto");
                            {% if product.video_url %}
                                if (window.innerWidth < 768) {
                                    productSwiperHeight = jQueryNuvem(".js-swiper-product").height();
                                    jQueryNuvem(".js-product-video-slide").height(productSwiperHeight);
                                }
                            {% endif %}
                        },
                        {% if product.video_url %}
                            slideChangeTransitionEnd: function () {
                                if(jQueryNuvem(".js-product-video-slide").hasClass("js-product-active-image")){
                                    jQueryNuvem(".js-labels-group, .js-open-mobile-zoom").fadeOut(100);
                                }else{
                                    jQueryNuvem(".js-labels-group, .js-open-mobile-zoom").fadeIn(100);
                                }
                                jQueryNuvem('.js-video').show();
                                jQueryNuvem('.js-video-iframe').hide().find("iframe").remove();
                            },
                        {% endif %}
                    },
                },
                function(swiperInstance) {
                    productSwiper = swiperInstance;
                }
            );

            {% if has_multiple_slides %}
                LS.registerOnChangeVariant(function(variant){
                    var liImage = jQueryNuvem('.js-swiper-product').find("[data-image='"+variant.image+"']");
                    var selectedPosition = liImage.data('imagePosition');
                    var slideToGo = parseInt(selectedPosition);
                    productSwiper.slideTo(slideToGo);
                    jQueryNuvem(".js-product-slide-img").removeClass("js-active-variant");
                    liImage.find(".js-product-slide-img").addClass("js-active-variant");
                });

                jQueryNuvem(".js-product-thumb").on("click", function(e){
                    e.preventDefault();
                    var current_thumb_index = jQueryNuvem(e.currentTarget).attr("data-slide-index");
                    var match_thumb_image = jQueryNuvem('.js-swiper-product').find("[data-image-position='"+current_thumb_index+"']");
                    var selectedPosition = match_thumb_image.attr("data-image-position");
                    var slideToGo = parseInt(selectedPosition);
                    productSwiper.slideTo(slideToGo);        
                });
            {% endif %}
        }
        productSliderNav ()

        {# /* // Product thumbs */ #}

        {% if has_multiple_slides %}

            createSwiper('.js-swiper-product-thumbnails', {
                spaceBetween: 10,
                direction: 'vertical',  
                slidesPerView: 'auto',
                threshold: 5, 
                navigation: {
                    nextEl: '.js-swiper-product-thumbnails-next',
                    prevEl: '.js-swiper-product-thumbnails-prev',
                },
            });

        {% endif %}


        {# /* // Product desktop fixed CTA */ #}

        window.addEventListener("load", function () {
            product_left_col_height = jQueryNuvem(".js-product-left-col").outerHeight();

            if ((window.innerWidth > 768) && (product_left_col_height > 900)) {

                // Calculate distance to fix CTA after scroll
                affix_top_offset = (jQueryNuvem(".js-desktop-head-container").height() + jQueryNuvem(".js-product-breadcrumbs-container").outerHeight() + jQueryNuvem(".js-product-name-price-container").outerHeight() + jQueryNuvem(".js-product-promo-container").outerHeight() + jQueryNuvem(".js-product-payments-container").outerHeight() + jQueryNuvem(".js-product-quantity-container").outerHeight() + jQueryNuvem(".js-product-buy-container").outerHeight() + jQueryNuvem(".js-product-shipping-container").outerHeight() + jQueryNuvem(".js-product-variants").outerHeight());

                // Fix CTA after scroll
                jQueryNuvem('.js-product-buy-container').affix({
                      offset: {
                        top: affix_top_offset
                      }
                });

                // Ghost button placeholder to maintain position of elements when CTA is fixed
                jQueryNuvem('.js-product-buy-container').on('affix.bs.affix', function(){
                    jQueryNuvem(".js-product-buy-placeholder").removeClass("hidden").css('marginTop' , '60px');
                });
                jQueryNuvem('.js-product-buy-container').on('affix-top.bs.affix', function(){
                    jQueryNuvem(".js-product-buy-placeholder").addClass("hidden");
                });
            }
        });

        {# /* // Desktop zoom */ #}

        {% if store.useNativeJsLibraries() %}
            function setZoomImage(e, element) {
                if (window.innerWidth < 767) { return; }

                var zoomContainer = element.querySelector('.js-desktop-zoom-big');
                zoomContainer.style.backgroundImage = `url('${zoomContainer.getAttribute('data-desktop-zoom')}')`;
            }

            function zoom(e, element){
                if (window.innerWidth < 767) { return; }

                var zoomer = element.querySelector('.js-desktop-zoom-big');
                var offsetX = e.offsetX ? e.offsetX : 0;
                var offsetY = e.offsetY ? e.offsetY : 0;
                var x = offsetX / zoomer.offsetWidth * 100;
                var y = offsetY / zoomer.offsetHeight * 100;

                zoomer.style.backgroundPosition = x + '% ' + y + '%';
            }

            var desktopZoom = document.querySelectorAll('.js-desktop-zoom');
            desktopZoom.forEach(function(element){
                element.addEventListener('mouseenter', (event) => setZoomImage(event, element));
                element.addEventListener('mousemove', (event) => zoom(event, element));
            });
        {% endif %}

        {# /* // Mobile zoom */ #}

        //Save scrolling position for fixed body on Mobile Zoom opened
        var scrollPos = document.documentElement.scrollTop;
        window.addEventListener("scroll", function(){
            scrollPos = document.documentElement.scrollTop;
        });
        var savedScrollPos = scrollPos;

        // Add tap class to product image
        if (window.innerWidth < 768) {
            jQueryNuvem(".js-image-open-mobile-zoom").addClass("js-open-mobile-zoom");
        }

        // Mobile zoom open event
        jQueryNuvem(".js-open-mobile-zoom").on("click", function(e){
            e.preventDefault();
            savedScrollPos = scrollPos;
            jQueryNuvem('body').css("position", 'fixed').css("top", (-scrollPos).toString() + 'px');
            LS.openMobileZoom();
        });

        // Mobile zoom close event
        jQueryNuvem(".js-close-mobile-zoom").on("click", function(e){
            e.preventDefault();
            LS.closeMobileZoom(150);
        });
        
        {# /* // Product Related */ #}

        {% set related_products_ids = product.metafields.related_products.related_products_ids %}
        {% if related_products_ids %}
            {% set related_products = related_products_ids | get_products %}
            {% set show = (related_products | length > 0) %}
        {% endif %}
        {% if not show %}
            {% set related_products = category.products | shuffle | take(8) %}
            {% set show = (related_products | length > 1) %}
        {% endif %}

        {% set columns_mobile = settings.grid_columns_mobile %}
        {% set columns_desktop = settings.grid_columns_desktop %}
        
        {% if settings.quick_view %}
            const itemRelatedSpacing = 0;
        {% else %}
            let itemRelatedSpacing = 15;
            if (window.innerWidth > 768) {
                itemRelatedSpacing = 30;
            }
        {% endif %}

        createSwiper('.js-swiper-related', {
            lazy: true,
            {% if related_products | length > 3 %}
                loop: true,
            {% endif %}
            spaceBetween: itemRelatedSpacing,
            watchOverflow: true,
            centerInsufficientSlides: true,
            threshold: 5,
            watchSlideProgress: true,
            watchSlidesVisibility: true,            
            slideVisibleClass: 'js-swiper-slide-visible',
            slidesPerView: 2,
            slidesPerGroup: 2,
            pagination: {
                el: '.js-swiper-related-pagination',
                clickable: true,
            },
            navigation: {
                nextEl: '.js-swiper-related-next',
                prevEl: '.js-swiper-related-prev',
            },
            breakpoints: {
                768: {
                    slidesPerView: {{ columns_desktop }},
                    slidesPerGroup: {{ columns_desktop }},
                }
            },
        });

    {% endif %}

    {# /* // Submit to contact */ #}

    jQueryNuvem(".js-product-form").on("submit", function (e) {
        var button = jQueryNuvem(e.currentTarget).find('[type="submit"]');
        button.attr('disabled', 'disabled');
        if ((button.hasClass('contact')) || (button.hasClass('catalog'))) {
            e.preventDefault();
            var product_id = jQueryNuvem(e.currentTarget).find("input[name='add_to_cart']").val();
            window.location = "{{ store.contact_url | escape('js') }}?product=" + product_id;
        } else if (button.hasClass('cart')) {
            button.val('{{ "Agregando..." | translate }}');
        }
    });

    {# /* // Empty screen */ #}

    if ( window.location.pathname === "/product/example/" ) {
        document.title = "{{ "Producto de ejemplo" | translate | escape('js') }}";
        jQueryNuvem("#404").hide();
        jQueryNuvem("#product-example").show();
    } else {
        jQueryNuvem("#product-example").hide();
    }

    {#/*============================================================================
        #Cart
    ==============================================================================*/ #}

    {# /* // Free shipping bar */ #}

    {% if cart.free_shipping.min_price_free_shipping.min_price %}

        {# Updates free progress on page load #}

        LS.freeShippingProgress(true);

    {% endif %}


    {# /* // Cart quantitiy changes */ #}

    jQueryNuvem(document).on("keypress", ".js-cart-quantity-input", function (e) {
        if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
            return false;
        }
    });

    jQueryNuvem(document).on("focusout", ".js-cart-quantity-input", function (e) {
        var itemID = jQueryNuvem(this).attr("data-item-id");
        var itemVAL = jQueryNuvem(this).val();
        if (itemVAL == 0) {
            var r = confirm("{{ '¿Seguro que quieres borrar este artículo?' | translate }}");
            if (r == true) {
                LS.removeItem(itemID, true);
            } else {
                jQueryNuvem(this).val(1);
            }
        } else {
            LS.changeQuantity(itemID, itemVAL, true);
        }
    });

    {# /* // Empty cart alert */ #}

    jQueryNuvem(".js-hide-alert").on("click", function(e){
        e.preventDefault();
        jQueryNuvem(e.currentTarget).closest(".alert").hide();
    })

    jQueryNuvem(".js-trigger-empty-cart-alert").on("click", function (e) {
        e.preventDefault();
        let emptyCartAlert = jQueryNuvem(".js-mobile-nav-empty-cart-alert").fadeIn(100);
        setTimeout(() => emptyCartAlert.fadeOut(500), 1500);
    });

    {# /* // Add to cart */ #}

    function getQuickShopImgSrc(element){
        const image = jQueryNuvem(element).closest('.js-quickshop-container').find('img');
        return String(image.attr('srcset')); 
    }

    jQueryNuvem(document).on("click", ".js-addtocart:not(.js-addtocart-placeholder)", function (e) {

        {# Button variables for transitions on add to cart #}

        var $productContainer = jQueryNuvem(this).closest('.js-product-container');
        var $productVariants = $productContainer.find(".js-variation-option");
        var $productButton = $productContainer.find("input[type='submit'].js-addtocart");
        var $productButtonPlaceholder = $productContainer.find(".js-addtocart-placeholder");
        var $productButtonText = $productButtonPlaceholder.find(".js-addtocart-text");
        var $productButtonAdding = $productButtonPlaceholder.find(".js-addtocart-adding");
        var $productButtonSuccess = $productButtonPlaceholder.find(".js-addtocart-success");

        {# Define if event comes from quickshop or product page #}

        var isQuickShop = $productContainer.hasClass('js-quickshop-container');

        var quantity = $productContainer.find('.js-quantity-input').val();

        if (!isQuickShop) {
            if(jQueryNuvem(".js-product-slide-img.js-active-variant").length) {
                var imageSrc = $productContainer.find('.js-product-slide-img.js-active-variant').data('srcset').split(' ')[0];
            } else {
                var imageSrc = $productContainer.find('.js-product-featured-image .js-product-slide-img').data('srcset').split(' ')[0];
            }
            var name = jQueryNuvem('#product-name').text();
            var price = $productContainer.find('.js-price-display').text();
            var price = $productContainer.find('.js-product-name-price-container .js-price-display').text().trim();
        } else {
            var imageSrc = getQuickShopImgSrc(this);
            var name = $productContainer.find('.js-item-name').text();
            var price = $productContainer.find('.js-price-display').text();
        }

        if (!jQueryNuvem(this).hasClass('contact')) {

            {% if settings.ajax_cart %}
                e.preventDefault();
            {% endif %}

            {# Hide real button and show button placeholder during event #}

            $productButton.hide();
            $productButtonPlaceholder.show().addClass("active");
            if (isQuickShop) {
                $productButtonPlaceholder.width(productButttonWidth-37);
            }
            $productButtonText.removeClass("active");
            setTimeout(function(){
                $productButtonAdding.addClass("active");
            },300);

            {% if settings.ajax_cart %}

                var callback_add_to_cart = function(){

                    {# Fill notification info #}

                    jQueryNuvem('.js-cart-notification-item-img').attr('srcset', imageSrc);
                    jQueryNuvem('.js-cart-notification-item-name').text(name);
                    jQueryNuvem('.js-cart-notification-item-quantity').text(quantity);
                    jQueryNuvem('.js-cart-notification-item-price').text(price);

                    if($productVariants.length){
                        var output = [];

                        $productVariants.each( function(el){
                            var variants = jQueryNuvem(el);
                            output.push(variants.val());
                        });
                        jQueryNuvem(".js-cart-notification-item-variant-container").show();
                        jQueryNuvem(".js-cart-notification-item-variant").text(output.join(', '))
                    }else{
                        jQueryNuvem(".js-cart-notification-item-variant-container").hide();
                    }

                    $productContainer.find(".js-added-to-cart-product-message").fadeIn();

                    {# Set products amount wording visibility #}

                    jQueryNuvem(".js-cart-link").addClass("active");

                    var cartItemsAmount = jQueryNuvem(".js-cart-widget-amount").text();

                    if(cartItemsAmount > 1){
                        jQueryNuvem(".js-cart-counts-plural").show();
                        jQueryNuvem(".js-cart-counts-singular").hide();
                    }else{
                        jQueryNuvem(".js-cart-counts-singular").show();
                        jQueryNuvem(".js-cart-counts-plural").hide();
                    }

                    {# Show button placeholder with transitions #}

                    $productButtonAdding.removeClass("active");

                    setTimeout(function(){
                        $productButtonSuccess.addClass("active");
                    },300);
                    setTimeout(function(){
                        $productButtonSuccess.removeClass("active");
                        setTimeout(function(){
                            $productButtonText.addClass("active");
                        },300);
                        $productButtonPlaceholder.removeClass("active");
                    },2000);

                    setTimeout(function(){
                        $productButtonPlaceholder.hide();
                        $productButton.show();
                    },4000);

                    if (window.innerWidth > 768) {
                        {# Lock body scroll on cart visible #}
                        if(jQueryNuvem(".js-ajax-cart-panel").css('display') == 'none'){
                            jQueryNuvem("body").addClass("overflow-none");
                        }
                        jQueryNuvem(".js-ajax-cart-panel, .js-ajax-backdrop").toggle();
                    }else{

                        {# Show notification and hide it only after second added to cart #}

                        setTimeout(function(){
                            jQueryNuvem(".js-alert-added-to-cart").show().addClass("notification-visible").removeClass("notification-hidden");
                        },500);
                        if (!cookieService.get('first_product_added_successfully')) {
                            cookieService.set('first_product_added_successfully', 1, 7 );
                        } else{
                            setTimeout(function(){
                                jQueryNuvem(".js-alert-added-to-cart").removeClass("notification-visible").addClass("notification-hidden");
                                setTimeout(function(){
                                    jQueryNuvem('.js-cart-notification-item-img').attr('src', '');
                                    jQueryNuvem(".js-alert-added-to-cart").hide();
                                },2000);
                            },8000);
                        }

                        if (isQuickShop) {
                            cleanURLHash();
                        }
                    }

                    // set Add to Cart notification content

                    jQueryNuvem('.js-notification-item-img').attr('src', imageSrc);
                    jQueryNuvem('.js-notification-item-name').text(name);
                    jQueryNuvem('.js-notification-item-quantity').text(quantity);
                    jQueryNuvem('.js-notification-item-price').text(price);

                    {# Update shipping input zipcode on add to cart #}

                    {# Use zipcode from input if user is in product page, or use zipcode cookie if is not #}

                    if (jQueryNuvem("#product-shipping-container .js-shipping-input").val()) {
                        zipcode_on_addtocart = jQueryNuvem("#product-shipping-container .js-shipping-input").val();
                        jQueryNuvem("#cart-shipping-container .js-shipping-input").val(zipcode_on_addtocart);
                        jQueryNuvem(".js-shipping-calculator-current-zip").text(zipcode_on_addtocart);
                    } else if (cookieService.get('calculator_zipcode')){
                        var zipcode_from_cookie = cookieService.get('calculator_zipcode');
                        jQueryNuvem('.js-shipping-input').val(zipcode_from_cookie);
                        jQueryNuvem(".js-shipping-calculator-current-zip").text(zipcode_from_cookie);
                    }
                }
                var callback_error = function(){

                    {# Restore real button visibility in case o f error #}

                    $productButtonPlaceholder.removeClass("active");
                    $productButtonText.fadeIn("active");
                    $productButtonAdding.removeClass("active");
                    $productButtonPlaceholder.hide();
                    $productButton.show();

                }
                $prod_form = jQueryNuvem(this).closest("form");
                LS.addToCartEnhanced(
                    $prod_form,
                    '{{ "Agregar al carrito" | translate }}',
                    '{{ "Agregando..." | translate }}',
                    '{{ "¡Uy! No tenemos más stock de este producto para agregarlo al carrito." | translate }}',
                    {{ store.editable_ajax_cart_enabled ? 'true' : 'false' }},
                        callback_add_to_cart,
                        callback_error
                );

            {% endif %}
        }
    });

    {# /* // Cart toggle */ #}

    {% if settings.ajax_cart %}

        {# Ajax cart functions #}

        const ajax_cart_panel = jQueryNuvem(".js-ajax-cart-panel");

        mobileToggleAjaxCart = function(){

            if(!jQueryNuvem("body").hasClass("mobile-categories-visible")){
                jQueryNuvem("body").toggleClass("overflow-none");
            }

            if(ajax_cart_panel.hasClass("modal-xs-right-in")){
                ajax_cart_panel.toggleClass("modal-xs-right-in modal-xs-right-out");
                setTimeout(function() { 
                    ajax_cart_panel.hide();
                }, 300);
            }else{
                ajax_cart_panel.show();
                setTimeout(function() { 
                    ajax_cart_panel.toggleClass("modal-xs-right-in modal-xs-right-out");
                }, 300);
            }
        };

        {# Ajax cart show or hide #}

        jQueryNuvem(document).on("click", ".js-toggle-cart", function (e) {
            e.preventDefault();
            if (window.innerWidth < 768) {
                mobileToggleAjaxCart();
            }else{
                jQueryNuvem(".js-ajax-backdrop").toggle();
                ajax_cart_panel.toggle();
                jQueryNuvem("body").toggleClass("overflow-none");
            }            
        });

        {# Go to checkout #}

        {# Clear cart notification cookie after consumers continues to checkout #}

        jQueryNuvem('form[action="{{ store.cart_url | escape('js') }}"]').on("submit", function() {
            cookieService.remove('first_product_added_successfully');
        });

    {% endif %}

    {#/*============================================================================
      #Shipping calculator
    ==============================================================================*/ #}

    {# /* // Select and save shipping function */ #}

    selectShippingOption = function(elem, save_option) {
        jQueryNuvem(".js-shipping-method, .js-branch-method").removeClass('js-selected-shipping-method');
        jQueryNuvem(elem).addClass('js-selected-shipping-method');
        if (save_option) {
            LS.saveCalculatedShipping(true);
        }
        if(jQueryNuvem(elem).hasClass("js-shipping-method-hidden")){

            {# Toggle other options visibility depending if they are pickup or delivery for cart and product at the same time #}

            if(jQueryNuvem(elem).hasClass("js-pickup-option")){
                jQueryNuvem(".js-other-pickup-options, .js-show-other-pickup-options .js-shipping-see-less").show();
                jQueryNuvem(".js-show-other-pickup-options .js-shipping-see-more").hide();

            }else{
                jQueryNuvem(".js-other-shipping-options, .js-show-more-shipping-options .js-shipping-see-less").show();
                jQueryNuvem(".js-show-more-shipping-options .js-shipping-see-more").hide()
            }          
        }
    };

    {# Apply zipcode saved by cookie if there is no zipcode saved on cart from backend #}

    if (cookieService.get('calculator_zipcode')) {

        {# If there is a cookie saved based on previous calcualtion, add it to the shipping input to trigger automatic calculation #}

        var zipcode_from_cookie = cookieService.get('calculator_zipcode');

        {% if settings.ajax_cart %}

            {# If ajax cart is active, target only product input to avoid extra calulation on empty cart #}

            jQueryNuvem('#product-shipping-container .js-shipping-input').val(zipcode_from_cookie);

        {% else %}

            {# If ajax cart is inactive, target the only input present on screen #}

            jQueryNuvem('.js-shipping-input').val(zipcode_from_cookie);
            
        {% endif %}

        {# Fill zipcode message #}

        jQueryNuvem(".js-shipping-calculator-current-zip").text(zipcode_from_cookie);

        {# Hide the shipping calculator and show spinner  #}

        jQueryNuvem(".js-shipping-calculator-head").addClass("with-zip").removeClass("with-form");
        jQueryNuvem(".js-shipping-calculator-with-zipcode").addClass("transition-up-active");
        jQueryNuvem(".js-shipping-calculator-spinner").show();

    } else {

        {# If there is no cookie saved, show calcualtor #}

        jQueryNuvem(".js-shipping-calculator-form").addClass("transition-up-active");
    }

    {# Remove shipping suboptions from DOM to avoid duplicated modals #}

    removeShippingSuboptions = function(){
        var shipping_suboptions_id = jQueryNuvem(".js-modal-shipping-suboptions").attr("id");
        jQueryNuvem("#" + shipping_suboptions_id).remove();
        jQueryNuvem('.js-modal-overlay[data-modal-id="#' + shipping_suboptions_id + '"').remove();
    };

    {# /* // Toggle branches link */ #}

    jQueryNuvem(document).on("click", ".js-toggle-branches", function (e) {
        e.preventDefault();
        jQueryNuvem(".js-store-branches-container").slideToggle("fast");
        jQueryNuvem(".js-see-branches, .js-hide-branches").toggle();
    });

    {# /* // Shipping and branch click */ #}

    jQueryNuvem(document).on("change", ".js-shipping-method, .js-branch-method", function (e) {
        selectShippingOption(this, true);
        jQueryNuvem(".js-shipping-method-unavailable").hide();
    });

    {# /* // Select shipping first option on results */ #}

    jQueryNuvem(document).on('shipping.options.checked', '.js-shipping-method', function (e) {
        let shippingPrice = jQueryNuvem(this).attr("data-price");
        LS.addToTotal(shippingPrice);

        let total = (LS.data.cart.total / 100) + parseFloat(shippingPrice);
        jQueryNuvem(".js-cart-widget-total").html(LS.formatToCurrency(total));

        selectShippingOption(this, false);
    });

    {# /* // Calculate shipping by submit */ #}

    jQueryNuvem(".js-shipping-input").on("keydown", function (e) {
        var key = e.which ? e.which : e.keyCode;
        var enterKey = 13;
        if (key === enterKey) {
            e.preventDefault();
            jQueryNuvem(e.currentTarget).parent().find(".js-calculate-shipping").trigger('click');
            if (window.innerWidth < 768) {
                jQueryNuvem(e.currentTarget).trigger('blur');
            }
        }
    });

    {# /* // Calculate shipping function */ #}

    jQueryNuvem(".js-calculate-shipping").on("click", function (e) {
        e.preventDefault();

        {# Take the Zip code to all shipping calculators on screen #}
        let shipping_input_val = jQueryNuvem(e.currentTarget).closest(".js-shipping-calculator-form").find(".js-shipping-input").val();

        jQueryNuvem(".js-shipping-input").val(shipping_input_val);

        {# Calculate on page load for both calculators: Product and Cart #}

            {% if template == 'product' %}
            if (!vanillaJS) {
                LS.calculateShippingAjax(
                jQueryNuvem('#product-shipping-container').find(".js-shipping-input").val(),
                '{{store.shipping_calculator_url | escape('js')}}',
                jQueryNuvem("#product-shipping-container").closest(".js-shipping-calculator-container") );
            }
            {% endif %}

        if (jQueryNuvem(".js-cart-item").length) {
            LS.calculateShippingAjax(
                jQueryNuvem('#cart-shipping-container').find(".js-shipping-input").val(),
                '{{store.shipping_calculator_url | escape('js')}}',
                jQueryNuvem("#cart-shipping-container").closest(".js-shipping-calculator-container") );
        }

        jQueryNuvem(".js-shipping-calculator-current-zip").html(shipping_input_val);
        removeShippingSuboptions();

    });

    {# /* // Toggle more shipping options */ #}

    jQueryNuvem(document).on("click", ".js-toggle-more-shipping-options", function(e) {
        e.preventDefault();

        {# Toggle other options depending if they are pickup or delivery for cart and product at the same time #}

        if(jQueryNuvem(this).hasClass("js-show-other-pickup-options")){
            jQueryNuvem(".js-other-pickup-options").slideToggle(600);
            jQueryNuvem(".js-show-other-pickup-options .js-shipping-see-less, .js-show-other-pickup-options .js-shipping-see-more").toggle();
        }else{
            jQueryNuvem(".js-other-shipping-options").slideToggle(600);
            jQueryNuvem(".js-show-more-shipping-options .js-shipping-see-less, .js-show-more-shipping-options .js-shipping-see-more").toggle();
        }
    });

    {# /* // Calculate shipping on page load */ #}

    {# Only shipping input has value, cart has saved shipping and there is no branch selected #}

    calculateCartShippingOnLoad = function(){

        {# Triggers function when a previous selection is not necesary #}

        if(jQueryNuvem("#cart-shipping-container .js-shipping-input").val()){
       
            // If user already had calculated shipping: recalculate shipping

            setTimeout(function() { 
                LS.calculateShippingAjax(
                    jQueryNuvem('#cart-shipping-container').find(".js-shipping-input").val(),
                    '{{store.shipping_calculator_url | escape('js')}}',
                    jQueryNuvem("#cart-shipping-container").closest(".js-shipping-calculator-container") );
                    removeShippingSuboptions();
            }, 100);
        } 

        if(jQueryNuvem(".js-branch-method").hasClass('js-selected-shipping-method')){
            {% if store.branches|length > 1 %}
                jQueryNuvem(".js-store-branches-container").slideDown("fast");
                jQueryNuvem(".js-see-branches").hide();
                jQueryNuvem(".js-hide-branches").show();
            {% endif %}
        }
    };

    {% if cart.has_shippable_products %}
        calculateCartShippingOnLoad();
    {% endif %}

    {# /* // Calculate product detail shipping on page load */ #}

    {% if template == 'product' %}

        if(!vanillaJS) {
            if(jQueryNuvem('#product-shipping-container').find(".js-shipping-input").val()){
                setTimeout(function() {
                    LS.calculateShippingAjax(
                    jQueryNuvem('#product-shipping-container').find(".js-shipping-input").val(),
                    '{{store.shipping_calculator_url | escape('js')}}',
                    jQueryNuvem("#product-shipping-container").closest(".js-shipping-calculator-container") );

                    removeShippingSuboptions();
                }, 100);
            }
        }

        {# /* // Pitch login instead of zipcode helper if is returning customer */ #}

        {% if not customer %}
            if (cookieService.get('returning_customer') && LS.shouldShowQuickLoginNotification()) {
                jQueryNuvem('.js-product-quick-login').show();
            } else {
                jQueryNuvem('.js-shipping-zipcode-help').show();
            }
        {% endif %}

    {% endif %}

    {# /* // Change CP */ #}

    jQueryNuvem(document).on("click", ".js-shipping-calculator-change-zipcode", function(e) {
        e.preventDefault();
        jQueryNuvem(".js-shipping-calculator-response").fadeOut(100);
        jQueryNuvem(".js-shipping-calculator-head").addClass("with-form").removeClass("with-zip");
        jQueryNuvem(".js-shipping-calculator-with-zipcode").removeClass("transition-up-active");
        jQueryNuvem(".js-shipping-calculator-form").addClass("transition-up-active");
    }); 

    {# /* // Shipping provinces */ #}

    {% if provinces_json %}
    jQueryNuvem('select[name="country"]').on("change", function (e) {
        var provinces = {{ provinces_json | default('{}') | raw }};
        LS.swapProvinces(provinces[jQueryNuvem(e.currentTarget).val()]);
    }).trigger('change');
    {% endif %}

    {# /* // Change store country: From invalid zipcode message */ #}

    jQueryNuvem(document).on("click", ".js-save-shipping-country", function(e) {
        e.preventDefault();
        {# Change shipping country #}

        var selected_country_url = jQueryNuvem(this).closest(".js-modal-shipping-country").find(".js-shipping-country-select option").filter((el) => el.selected).attr("data-country-url");
        location.href = selected_country_url;

        jQueryNuvem(this).text('{{ "Aplicando..." | translate }}').addClass("disabled");
    });

    {#/*============================================================================
      #Forms
    ==============================================================================*/ #}

    {# Show the success or error message when resending the validation link #}
    
    {% if template == 'account.register' or template == 'account.login' %}
        jQueryNuvem(".js-resend-validation-link").on("click", function(e){
            window.accountVerificationService.resendVerificationEmail('{{ customer_email }}');
        });
    {% endif %}

    jQueryNuvem('.js-password-view').on("click", function (e) {
        jQueryNuvem(e.currentTarget).toggleClass('password-view');

        if(jQueryNuvem(e.currentTarget).hasClass('password-view')){
            jQueryNuvem(e.currentTarget).parent().find(".js-password-input").attr('type', '');
            jQueryNuvem(e.currentTarget).find(".js-eye-open, .js-eye-closed").toggle();
        } else {
            jQueryNuvem(e.currentTarget).parent().find(".js-password-input").attr('type', 'password');
            jQueryNuvem(e.currentTarget).find(".js-eye-open, .js-eye-closed").toggle();
        }
    });

    {% if store.country == 'AR' and template == 'home' %}
        if (cookieService.get('returning_customer') && LS.shouldShowQuickLoginNotification()) {
            {# Make login link toggle quick login modal #}

            jQueryNuvem(".js-login").removeAttr("href").attr("href", "#quick-login").attr("data-toggle", "modal").addClass("js-trigger-modal-zindex-top");
        }
    {% endif %}

    {#/*============================================================================
        #Footer
    ==============================================================================*/ #}

    {# Add alt attribute to external AFIP logo to improve SEO #}

    {% if store.afip %}
        jQueryNuvem('img[src*="www.afip.gob.ar"]').attr('alt', '{{ "Logo de AFIP" | translate }}');
    {% endif %}

});

{% if store.live_chat %}
    
    {# Begin olark code #}

    /*{literal}<![CDATA[*/
    window.olark||(function(c){var f=window,d=document,l=f.location.protocol=="https:"?"https:":"http:",z=c.name,r="load";var nt=function(){f[z]=function(){(a.s=a.s||[]).push(arguments)};var a=f[z]._={},q=c.methods.length;while(q--){(function(n){f[z][n]=function(){f[z]("call",n,arguments)}})(c.methods[q])}a.l=c.loader;a.i=nt;a.p={0:+new Date};a.P=function(u){a.p[u]=new Date-a.p[0]};function s(){a.P(r);f[z](r)}f.addEventListener?f.addEventListener(r,s,false):f.attachEvent("on"+r,s);var ld=function(){function p(hd){hd="head";return["<",hd,"></",hd,"><",i,' onl' + 'oad="var d=',g,";d.getElementsByTagName('head')[0].",j,"(d.",h,"('script')).",k,"='",l,"//",a.l,"'",'"',"></",i,">"].join("")}var i="body",m=d[i];if(!m){return setTimeout(ld,100)}a.P(1);var j="appendChild",h="createElement",k="src",n=d[h]("div"),v=n[j](d[h](z)),b=d[h]("iframe"),g="document",e="domain",o;n.style.display="none";m.insertBefore(n,m.firstChild).id=z;b.frameBorder="0";b.id=z+"-loader";if(/MSIE[ ]+6/.test(navigator.userAgent)){b.src="javascript:false"}b.allowTransparency="true";v[j](b);try{b.contentWindow[g].open()}catch(w){c[e]=d[e];o="javascript:var d="+g+".open();d.domain='"+d.domain+"';";b[k]=o+"void(0);"}try{var t=b.contentWindow[g];t.write(p());t.close()}catch(x){b[k]=o+'d.write("'+p().replace(/"/g,String.fromCharCode(92)+'"')+'");d.close();'}a.P(2)};ld()};nt()})({loader: "static.olark.com/jsclient/loader0.js",name:"olark",methods:["configure","extend","declare","identify"]});
    /* custom configuration goes here (www.olark.com/documentation) */
    olark.identify('{{store.live_chat | escape('js')}}');/*]]>{/literal}*/
{% endif %}
