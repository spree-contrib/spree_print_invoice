Deface::Override.new(:virtual_path => "spree/admin/shared/_content_header",
                     :name => "print_buttons",
                     :insert_top => "[data-hook='toolbar']>ul",
                     :partial => "spree/admin/orders/print_buttons",
                     :disabled => false)
