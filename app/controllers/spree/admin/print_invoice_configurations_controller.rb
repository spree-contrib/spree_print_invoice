module Spree
  module Admin
    class PrintInvoiceConfigurationsController < ResourceController
      def update
        configuration = Spree::PrintInvoiceConfiguration.new
        preferences = params && params.key?(:preferences) ? params.delete(:preferences) : params
        preferences.each do |name, value|
          next unless configuration.has_preference? name.to_param
          configuration[name] = value
        end
        flash[:success] = Spree.t(:successfully_updated, resource: Spree.t(:configuration, scope: :print_invoice))
        redirect_to edit_admin_print_invoice_configuration_path
      end
    end
  end
end
