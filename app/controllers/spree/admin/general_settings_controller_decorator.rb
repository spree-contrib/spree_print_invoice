Spree::Admin::GeneralSettingsController.class_eval do
  before_filter :update_print_invoice_next_number_settings, only: :update

  private
    def update_print_invoice_next_number_settings
      params.each do |name, value|
        next unless Spree::PrintInvoice::Config.has_preference? name
        Spree::PrintInvoice::Config[name] = value
      end
    end
end