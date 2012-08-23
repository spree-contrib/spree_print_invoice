# Address Stuff

bill_address = @order.bill_address
ship_address = @order.ship_address
anonymous = @order.email =~ /@example.net$/

bounding_box [0,600], :width => 540 do
  move_down 2
  address_cell_billing = make_cell(:content => t(:billing_address), :font_style => :bold)
  address_cell_shipping = make_cell(:content => t(:shipping_address), :font_style => :bold)
  billing = "#{bill_address.firstname} #{bill_address.lastname}
                  #{bill_address.address1}"
  billing << "\n#{bill_address.address2}" unless bill_address.address2.blank?
  billing << "\n#{@order.bill_address.city}, #{@order.bill_address.state_text} #{@order.bill_address.zipcode}"
  billing << "\n#{bill_address.country.name}"
  billing << "\n#{bill_address.phone}"

  shipping = "#{ship_address.firstname} #{ship_address.lastname}
                  #{ship_address.address1}"
  shipping << "\n#{ship_address.address2}" unless ship_address.address2.blank?
  shipping << "\n#{@order.ship_address.city}, #{@order.ship_address.state_text} #{@order.ship_address.zipcode}"
  shipping << "\n#{ship_address.country.name}"
  shipping << "\n#{ship_address.phone}"

  table [
      [address_cell_billing, address_cell_shipping],
      [billing, shipping]
    ],
    :column_widths => [270, 270],
    :position => :center,
    :cell_style => {
      :border_width => 0.5,
      :borders => [:top, :bottom, :right, :left],
      :padding => [2, 6, 2, 6]
    }
end