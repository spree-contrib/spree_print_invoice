Deface::Override.new(:virtual_path => "spree/admin/shared/_configuration_menu",
                     :name => "add_configuration_line",
                     :insert_bottom => "[data-hook='admin_configurations_sidebar_menu'], #admin_configurations_sidebar_menu[data-hook]",
                     :text => "<%= configurations_sidebar_menu_item(Spree.t('Invoices settings'), edit_admin_print_invoice_settings_path) %>",
                     :disabled => false)
