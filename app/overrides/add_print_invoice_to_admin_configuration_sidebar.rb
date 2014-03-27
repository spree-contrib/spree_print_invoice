Deface::Override.new(virtual_path:  "spree/admin/shared/_configuration_menu",
                     name:          "print_invoice_admin_configurations_menu",
                     insert_bottom: "[data-hook='admin_configurations_sidebar_menu'], #admin_configurations_sidebar_menu[data-hook]",
                     text:          "<%= configurations_sidebar_menu_item Spree.t(:settings, scope: :print_invoice), edit_admin_print_invoice_settings_path %>",
                     original:      "737741636d3b0e7dcffd17c5b463c2983647e168 ",
                     disabled:      false)