Deface::Override.new(
  virtual_path:  'spree/layouts/admin',
  insert_bottom: '#main-sidebar nav',
  partial:       'spree/admin/shared/menu/documents_tab',
  name:          'documents_tab'
)
