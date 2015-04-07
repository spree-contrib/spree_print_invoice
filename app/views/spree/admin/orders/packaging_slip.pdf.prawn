define_grid(columns: 5, rows: 8, gutter: 10)

@font_face = Spree::PrintInvoice::Config[:font_face]
@font_size = Spree::PrintInvoice::Config[:font_size]

# HEADER
repeat(:all) do
  im = Rails.application.assets.find_asset(Spree::PrintInvoice::Config[:logo_path])
  if im && File.exist?(im.pathname)
    image im, vposition: :top, height: 40, scale: Spree::PrintInvoice::Config[:logo_scale]
  end

  grid([0,3], [0,4]).bounding_box do
    font @font_face, size: @font_size
    text Spree.t(:packaging_slip, scope: :print_invoice), align: :right, style: :bold, size: 18
    move_down 4

    if Spree::PrintInvoice::Config.use_sequential_number? && @order.invoice_number.present?

      text Spree.t(:invoice_number, number: @order.invoice_number, scope: :print_invoice), align: :right
      move_down 2
      text "#{Spree.t(:invoice_date, scope: :print_invoice)} #{I18n.l @order.invoice_date}", align: :right

    else

      text Spree.t(:order_number, number: @order.number), align: :right
      move_down 2
      text I18n.l(@order.completed_at.to_date), align: :right

    end
  end
end

# CONTENT
grid([1,0], [6,4]).bounding_box do

  font @font_face, size: @font_size

  # address block on first page only
  repeat(lambda { |pg| pg == 1 }) do
    bill_address = @order.bill_address
    ship_address = @order.ship_address

    move_down 2
    address_cell_billing  = make_cell(content: Spree.t(:billing_address), font_style: :bold)
    address_cell_shipping = make_cell(content: Spree.t(:shipping_address), font_style: :bold)

    billing =  "#{bill_address.firstname} #{bill_address.lastname}"
    billing << "\n#{bill_address.address1}"
    billing << "\n#{bill_address.address2}" unless bill_address.address2.blank?
    billing << "\n#{bill_address.city}, #{bill_address.state_text} #{bill_address.zipcode}"
    billing << "\n#{bill_address.country.name}"
    billing << "\n#{bill_address.phone}"

    shipping =  "#{ship_address.firstname} #{ship_address.lastname}"
    shipping << "\n#{ship_address.address1}"
    shipping << "\n#{ship_address.address2}" unless ship_address.address2.blank?
    shipping << "\n#{ship_address.city}, #{ship_address.state_text} #{ship_address.zipcode}"
    shipping << "\n#{ship_address.country.name}"
    shipping << "\n#{ship_address.phone}"
    shipping << "\n\n#{Spree.t(:via, scope: :print_invoice)} #{@order.shipments.first.shipping_method.name}"

    data = [[address_cell_billing, address_cell_shipping], [billing, shipping]]
    table(data, position: :center, column_widths: [270, 270])
  end

  move_down 10

  header =  [
    make_cell(content: Spree.t(:sku)),
    make_cell(content: Spree.t(:item_description)),
    make_cell(content: Spree.t(:options)),
    make_cell(content: Spree.t(:qty))
  ]
  data = [header]

  @order.line_items.each do |item|
    row = [
      item.variant.sku,
      item.variant.name,
      item.variant.options_text,
      item.quantity
    ]
    data += [row]
  end

  table(data, header: true, position: :center, column_widths: [70, 300, 130, 40]) do
    row(0).style align: :center, font_style: :bold
    column(0..2).style align: :left
    column(3).style align: :center
  end

  move_down 30
  text Spree::PrintInvoice::Config[:anomaly_message], align: :left, size: @font_size

  move_down 20
  bounding_box([0, cursor], width: 540, height: 250) do
    transparent(0.5) { stroke_bounds }
  end
end

# FOOTER
if Spree::PrintInvoice::Config[:use_footer]
  repeat(:all) do
    grid([7,0], [7,4]).bounding_box do

      data  = []
      data << [make_cell(content: Spree.t(:vat, scope: :print_invoice) , colspan: 2, align: :center)]
      data << [make_cell(content: '', colspan: 2)]
      data << [make_cell(content: Spree::PrintInvoice::Config[:footer_left], align: :left),
      make_cell(content: Spree::PrintInvoice::Config[:footer_right], align: :right)]

      table(data, position: :center, column_widths: [270, 270]) do
        row(0..2).style borders: []
      end
    end
  end
end

# PAGE NUMBER
if Spree::PrintInvoice::Config[:use_page_numbers]
  string  = "#{Spree.t(:page, scope: :print_invoice)} <page> #{Spree.t(:of, scope: :print_invoice)} <total>"
  options = {
    at: [bounds.right - 150, 0],
    width: 150,
    align: :right,
    start_count_at: 1,
    color: '000000'
  }
  number_pages string, options
end
