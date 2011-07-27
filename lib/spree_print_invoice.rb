require 'print_invoice_hooks'
require 'prawn_handler'


module PrintInvoice
  class Engine < Rails::Engine
    
    def self.activate

      Admin::OrdersController.class_eval do
        def show
          load_order
          respond_with(@order) do |format|
            format.pdf do
              template = params[:template] || "invoice"
              render :layout => false , :template => "admin/orders/#{template}.pdf.prawn"
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
