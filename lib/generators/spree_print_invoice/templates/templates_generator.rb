module SpreePrintInvoice
  module Generators
    class TemplatesGenerator < Rails::Generators::Base
      source_root File.expand_path('../../../../../app/views/spree', __FILE__)

      def copy_templates
        directory 'printables', 'app/views/spree/printables'
      end
    end
  end
end
