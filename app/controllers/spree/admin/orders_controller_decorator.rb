Spree::Admin::OrdersController.class_eval do
  respond_to :pdf

  def show
    load_order
    respond_with(@order) do |format|
      format.pdf do
        template = params[:template] || "invoice"
        @shipment = Spree::Shipment.find(params[:ship][:id]) 
        @hide_prices = params[:commit] == "Print Slip" ? true : false     
        if (template == "invoice") && Spree::PrintInvoice::Config.use_sequential_number? && !@order.invoice_number.present?
          @order.invoice_number = Spree::PrintInvoice::Config.increase_invoice_number
          @order.invoice_date = Date.today
          @order.save!
        end
        render :layout => false , :template => "spree/admin/orders/#{template}.pdf.prawn"
      end
    end
  end

end
