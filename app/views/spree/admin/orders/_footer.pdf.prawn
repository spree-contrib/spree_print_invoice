config = Spree::PrintInvoice::Config
data = [
  [config[:print_invoice_footer_left1],config[:print_invoice_footer_left2],config[:print_invoice_footer_right1],config[:print_invoice_footer_right2]]
]
table(data) if data[0].any? { |string| string.present? }
