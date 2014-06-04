module Spree
  module Admin
    class PrintInvoiceSettingsController < Spree::Admin::BaseController

      def edit
      end

      def update
        Spree::PrintInvoice::Config.set(params[:preferences])
        respond_to do |format|
          format.html {
            redirect_to edit_admin_print_invoice_settings_path
          }
        end
      end

    end
  end
end
