module Spree
  module Admin
    OrdersController.class_eval do
      respond_to :pdf, only: :show

      def show
        load_order
        respond_with(@order) do |format|
          format.pdf do
            template = params[:template] || 'invoice'
            update_sequential_number_for(@order) if template == 'invoice'
            render layout: false, template: "spree/admin/orders/#{template}.pdf.prawn"
          end
        end
      end

      private

      def update_sequential_number_for(order)
        return unless Spree::PrintInvoice::Config.use_sequential_number?
        return unless order.invoice_number.present?
        order.invoice_number = Spree::PrintInvoice::Config.increase_invoice_number
        order.invoice_date   = Date.today
        order.save!
      end
    end
  end
end
