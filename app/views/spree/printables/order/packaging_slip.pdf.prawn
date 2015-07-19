@font_style = {
  face: Spree::PrintInvoice::Config[:font_face],
  size: Spree::PrintInvoice::Config[:font_size]
}

prawn_document(force_download: true) do |pdf|
  pdf.define_grid(columns: 5, rows: 8, gutter: 10)
  pdf.font @font_style[:face], size: @font_style[:size]

  pdf.repeat(:all) do
    render 'spree/printables/shared/header', pdf: pdf, printable: @doc
  end

  # CONTENT
  pdf.grid([1,0], [6,4]).bounding_box do

    # address block on first page only
    if pdf.page_number == 1
      render 'spree/printables/shared/address_block', pdf: pdf, printable: @doc
    end

    pdf.move_down 10

    render 'spree/printables/shared/packaging_slip/items', pdf: pdf, printable: @doc

    pdf.move_down 30
    pdf.text Spree::PrintInvoice::Config[:anomaly_message], align: :left, size: @font_size

    pdf.move_down 20
    pdf.bounding_box([0, pdf.cursor], width: pdf.bounds.width, height: 250) do
      pdf.transparent(0.5) { pdf.stroke_bounds }
    end
  end

  # Footer
  if Spree::PrintInvoice::Config[:use_footer]
    render 'spree/printables/shared/footer', pdf: pdf
  end

  # Page Number
  if Spree::PrintInvoice::Config[:use_page_numbers]
    render 'spree/printables/shared/page_number', pdf: pdf
  end
end
