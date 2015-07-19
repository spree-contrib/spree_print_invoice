string  = "#{Spree.t(:page, scope: :print_invoice)} <page> #{Spree.t(:of, scope: :print_invoice)} <total>"

options = {
  at: [pdf.bounds.right - 155, 0],
  width: 150,
  align: :right,
  start_count_at: 1,
  color: '000000'
}

pdf.number_pages string, options
