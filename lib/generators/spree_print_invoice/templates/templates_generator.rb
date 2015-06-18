module SpreePrintInvoice
  module Generators
    class TemplatesGenerator < Rails::Generators::Base
      source_root File.expand_path('../../../../../app/views/spree/admin/orders', __FILE__)

      def copy_templates
        copy_file 'invoice.pdf.prawn', 'app/views/spree/admin/orders/invoice.pdf.prawn'
        copy_file 'packaging_slip.pdf.prawn', 'app/views/spree/admin/orders/packaging_slip.pdf.prawn'
      end
    end
  end
end
