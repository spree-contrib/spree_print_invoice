Deface::Override.new(
  virtual_path:  'spree/admin/shared/_main_menu',
  insert_bottom: 'nav',
  partial:       'spree/admin/shared/menu/documents_tab',
  name:          'documents_tab'
)
