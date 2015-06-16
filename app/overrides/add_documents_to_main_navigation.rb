Deface::Override.new(
  virtual_path:  'spree/layouts/admin',
  insert_bottom: '#main-sidebar',
  partial:       'spree/admin/shared/menu/documents_tab',
  name:          'documents_tab'
)
