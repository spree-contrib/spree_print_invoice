@font_style = {
  face: Spree::PrintInvoice::Config[:font_face],
  size: Spree::PrintInvoice::Config[:font_size]
}

prawn_document(force_download: true) do |pdf|
  pdf.define_grid(columns: 5, rows: 8, gutter: 10)
  pdf.font @font_style[:face], size: @font_style[:size]

  pdf.repeat(:all) do
    render 'spree/admin/invoices/header', pdf: pdf, invoice: @invoice, template: @template
  end

  # CONTENT
  pdf.grid([1,0], [6,4]).bounding_box do

    # address block on first page only
    if pdf.page_number == 1
      render 'spree/admin/invoices/address_block', pdf: pdf, invoice: @invoice
    end

    pdf.move_down 10

    render 'spree/admin/invoices/invoice_items', pdf: pdf, invoice: @invoice

    pdf.move_down 10

    render 'spree/admin/invoices/totals', pdf: pdf, invoice: @invoice

    pdf.move_down 30

    pdf.text Spree::PrintInvoice::Config[:return_message], align: :right, size: @font_style[:size]
  end

  # Footer
  if Spree::PrintInvoice::Config[:use_footer]
    render 'spree/admin/invoices/footer', pdf: pdf
  end

  # Page Number
  if Spree::PrintInvoice::Config[:use_page_numbers]
    render 'spree/admin/invoices/footer', pdf: pdf
  end
end
