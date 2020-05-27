# frozen_string_literal: true

if Spree.version.to_f < 4.0
  Deface::Override.new(
    virtual_path: 'spree/layouts/admin',
    insert_bottom: '#main-sidebar',
    partial: 'spree/admin/shared/menu/documents_tab',
    name: 'documents_tab'
  )
else
  Deface::Override.new(
    virtual_path: 'spree/admin/shared/_main_menu',
    insert_bottom: 'nav',
    partial: 'spree/admin/shared/menu/documents_tab',
    name: 'documents_tab'
  )
end
