totals = []

totals << [Prawn::Table::Cell.new( :text => Spree.t(:subtotal), :font_style => :bold), number_to_currency(@order.item_total)]

@order.adjustments.each do |charge|
  totals << [Prawn::Table::Cell.new( :text => charge.label + ":", :font_style => :bold), number_to_currency(charge.amount)]
end

totals << [Prawn::Table::Cell.new( :text => Spree.t(:order_total), :font_style => :bold), number_to_currency(@order.total)]

bounding_box [bounds.right - 500, bounds.bottom + (totals.length * 18)], :width => 500 do
  table totals,
    :position => :right,
    :border_width => 0,
    :vertical_padding   => 2,
    :horizontal_padding => 6,
    :font_size => 9,
    :column_widths => { 0 => 425, 1 => 75 } ,
    :align => { 0 => :right, 1 => :right }

end
