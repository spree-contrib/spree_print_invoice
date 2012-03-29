Spree::Admin::OrdersController.class_eval do
  def show
    load_order
    respond_with(@order) do |format|
      format.pdf do
        template = params[:template] || "invoice"
        render :layout => false , :template => "spree/admin/orders/#{template}.pdf.prawn"
      end
    end
  end
end
