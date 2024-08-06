<script type="text/javascript">
    LS.ready.then(function() {
        DOMContentLoaded.addEventOrExecute(() => {
            {# 404 handling to show the example product #}
            if (window.location.pathname === "/product/example/") {
                document.title = "{{ "Producto de ejemplo" | translate | escape('js') }}";
                jQueryNuvem("#404").hide();
                jQueryNuvem("#product-example").show();
            } else {
                jQueryNuvem("#product-example").hide();
            }
        });
    });
</script>