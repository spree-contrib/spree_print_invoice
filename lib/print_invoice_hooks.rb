class PrintInvoiceHooks < Spree::ThemeSupport::HookListener
  
  Deface::Override.new(:virtual_path => "spree/admin/orders/show",
  :name => "print_buttons",
  :insert_after => "[data-hook='admin_order_show_buttons'], #admin_order_show_buttons[data-hook]",
  :partial => "admin/orders/print_buttons",
  :disabled => false)

  Deface::Override.new(:virtual_path => "spree/admin/orders/edit",
  :name => "print_buttons",
  :insert_after => "[data-hook='admin_order_edit_buttons'], #admin_order_edit_buttons[data-hook]",
  :partial => "admin/orders/print_buttons",
  :disabled => false)


end
