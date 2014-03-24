module Spree
  class PrintInvoiceConfiguration < Preferences::Configuration

    preference :print_invoice_next_number, :integer, :default => nil
    preference :print_invoice_logo_path, :string, :default => Spree::Config[:admin_interface_logo]
    preference :print_invoice_logo_scale, :integer, :default => 50
    preference :print_buttons, :string, :default => 'invoice'
    preference :print_font_face, :string, :default => 'Helvetica'

    def use_sequential_number?
      print_invoice_next_number.present? && print_invoice_next_number > 0
    end

    def increase_invoice_number
      current_invoice_number = print_invoice_next_number
      set_preference(:print_invoice_next_number, current_invoice_number + 1)
      current_invoice_number
    end

  end
end
