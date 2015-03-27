module Spree
  module PrintInvoice
    class UnsupportedTemplateError < StandardError
      def initialize(template_name)
        @template_name = template_name
      end

      def message
        "#{@template_name} is an unsupported pdf template name! \
          Please use one of #{Spree::PrintInvoice::Config.print_templates}."
      end
    end
  end
end
