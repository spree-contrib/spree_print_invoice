module Spree
  module Admin
    OrdersController.class_eval do
      respond_to :pdf, only: :show

      def show
        load_order
        respond_with(@order) do |format|
          format.pdf do
            template = params[:template] || 'invoice'
            @order.update_invoice_number! if template == 'invoice'
            render layout: false, template: "spree/admin/orders/#{template}.pdf.prawn"
          end
        end
      end
    end
  end
end
