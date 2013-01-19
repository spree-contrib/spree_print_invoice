Deface::Override.new(:virtual_path => "spree/admin/orders/show",
                     :name => "print_buttons",
                     :insert_after => "[data-hook=admin_order_show_details]",
                     :partial => "spree/admin/orders/print_buttons",
                     :disabled => false)
