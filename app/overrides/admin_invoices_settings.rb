Deface::Override.new(:virtual_path => "spree/admin/general_settings/edit",
                     :name => "admin_print_invoice_settings",
                     :insert_bottom => ".omega.six.columns",
                     :partial => "spree/admin/general_settings/invoice",
                     # :disabled => false)
                     :disabled => !Object.const_defined?('SpreePrintInvoice'))


