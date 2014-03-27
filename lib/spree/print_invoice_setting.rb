module Spree
  class PrintInvoiceSetting < Preferences::Configuration
    preference :print_invoice_next_number, :integer, default: nil
    preference :print_invoice_logo_path,   :string,  default: Spree::Config[:admin_interface_logo]
    preference :print_buttons,             :string,  default: 'invoice,packaging_slip'

    preference :page_size,       :string, default: 'LETTER'
    preference :page_layout,     :string, default: 'landscape'
    preference :footer_left,     :string, default: ''
    preference :footer_right,    :string, default: ''
    preference :return_message,  :text,   default: ''
    preference :anomaly_message, :text,   default: ''

    preference :use_footer,       :boolean, default: false
    preference :use_page_numbers, :boolean, default: false

    def page_sizes
      ::PDF::Core::PageGeometry::SIZES.keys
    end

    def page_layouts
      %w(landscape portrait)
    end

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
