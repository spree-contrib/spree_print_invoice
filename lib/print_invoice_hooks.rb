class PrintInvoiceHooks < Spree::ThemeSupport::HookListener


  insert_after :admin_order_show_buttons , 'print_buttons'

  insert_after :admin_order_edit_buttons , 'print_buttons'

end
