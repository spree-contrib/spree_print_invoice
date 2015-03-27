Spree::Order.class_eval do

  def update_invoice_number!
    return unless Spree::PrintInvoice::Config.use_sequential_number?
    return if invoice_number.present?
    update_columns(
      invoice_number: Spree::PrintInvoice::Config.increase_invoice_number,
      invoice_date: Date.today
    )
  end
end
