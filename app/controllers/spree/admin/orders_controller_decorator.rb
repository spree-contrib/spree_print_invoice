module Spree
  module Admin
    OrdersController.class_eval do
      respond_to :pdf, only: :show

      def show
        load_order

        respond_with(@order) do |format|
          format.pdf do
            send_data @order.pdf_file(pdf_template_name),
              type: 'application/pdf', disposition: 'inline'
          end
        end
      end

      private

      def pdf_template_name
        pdf_template_name = params[:template] || 'invoice'
        if !Spree::PrintInvoice::Config.print_templates.include?(pdf_template_name)
          raise Spree::PrintInvoice::UnsupportedTemplateError.new(pdf_template_name)
        end
        pdf_template_name
      end
    end
  end
end
