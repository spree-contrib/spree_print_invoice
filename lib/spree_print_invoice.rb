require 'print_invoice_hooks'
require 'prawn_handler'


module PrintInvoice
  class Engine < Rails::Engine
    
    def self.activate

      Spree::Admin::OrdersController.class_eval do
        if Spree.version < '0.60'
          respond_to :html
          alias_method :load_order, :load_object
        end
        
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

    end

    config.autoload_paths += %W(#{config.root}/lib)
    config.to_prepare &method(:activate).to_proc

  end
end

Mime::Type.register 'application/pdf', :pdf
