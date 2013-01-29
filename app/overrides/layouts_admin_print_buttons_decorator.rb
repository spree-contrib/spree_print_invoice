Deface::Override.new(:virtual_path => "spree/layouts/admin",
                     :name => "print_buttons",
                     :insert_top => "[data-hook='toolbar']>ul",
                     :partial => "spree/admin/orders/print_buttons",
                     :disabled => false)
