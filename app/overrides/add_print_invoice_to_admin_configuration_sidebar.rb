# frozen_string_literal: true

Deface::Override.new(
  virtual_path: 'spree/admin/shared/sub_menu/_configuration',
  name: 'print_invoice_admin_configurations_menu',
  insert_bottom: '[data-hook="admin_configurations_sidebar_menu"]',
  text: '<%= configurations_sidebar_menu_item Spree.t(:settings, scope: :print_invoice),
                      spree.edit_admin_print_invoice_settings_path %>'
)
