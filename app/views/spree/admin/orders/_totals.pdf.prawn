totals = []

totals << [make_cell( :content => t(:subtotal), :font_style => :bold), number_to_currency(@order.item_total)]

@order.adjustments.each do |charge|
  totals << [make_cell( :content => charge.label + ":", :font_style => :bold), number_to_currency(charge.amount)]
end

totals << [make_cell( :content => t(:order_total), :font_style => :bold), number_to_currency(@order.total)]

span(540, :position => :center) do
  table totals,
    :column_widths => [425, 115]
end
