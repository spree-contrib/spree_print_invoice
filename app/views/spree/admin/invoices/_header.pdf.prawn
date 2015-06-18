im = Rails.application.assets.find_asset(Spree::PrintInvoice::Config[:logo_path])

if im && File.exist?(im.pathname)
  pdf.image im, vposition: :top, height: 40, scale: Spree::PrintInvoice::Config[:logo_scale]
end

pdf.grid([0,3], [1,4]).bounding_box do
  pdf.text Spree.t(template.to_sym, scope: :print_invoice), align: :right, style: :bold, size: 18
  pdf.move_down 4

  pdf.text I18n.l(invoice.invoiceable.completed_at.to_date), align: :right if invoice.invoiceable.completed_at?

  if Spree::PrintInvoice::Config.use_sequential_number? && invoice.number.present?
    pdf.text Spree.t(:invoice_number, number: invoice.number), align: :right
    pdf.move_down 2
    pdf.text "#{Spree.t(:invoice_date, scope: :print_invoice)} #{I18n.l invoice.date}", align: :right
  else
    pdf.text Spree.t(:order_number, number: invoice.invoiceable.number), align: :right
    pdf.move_down 2
    pdf.text I18n.l(invoice.invoiceable.completed_at.to_date), align: :right
  end
end
