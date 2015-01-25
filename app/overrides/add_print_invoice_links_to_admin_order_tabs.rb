Deface::Override.new(
  virtual_path: 'spree/admin/shared/_order_tabs',
  name:         'print_invoice_order_tab_links',
  insert_bottom: '[data-hook="admin_order_tabs"]',
  partial:      'spree/admin/orders/print_invoice_order_tab_links'
)
