if @hide_prices
  @column_widths = [100, 165, 75, 75]
else
  @column_widths = [75, 205, 75, 50, 75, 60]
end

# Line Items
span(540, :position => :center) do
  move_down 2
  header =  [
    make_cell( :content => t(:sku), :font_style => :bold),
    make_cell( :content => t(:item_description), :font_style => :bold ),
    make_cell( :content => t(:options), :font_style => :bold ) ,
    make_cell( :content => t(:price), :font_style => :bold ) ,
    make_cell( :content => t(:qty), :font_style => :bold ),
    make_cell( :content => t(:total), :font_style => :bold )
  ]
    
  table [header],
    :position      => :center,
    :column_widths => @column_widths

  move_down 8

  span(540, :position => :center) do
    content = []
    @order.line_items.each do |item|
      row = [item.variant.product.sku, item.variant.product.name]
      row << item.variant.option_values.map {|ov| "#{ov.option_type.presentation}: #{ov.presentation}"}.concat(item.respond_to?('ad_hoc_option_values') ? item.ad_hoc_option_values.map {|pov| "#{pov.option_value.option_type.presentation}: #{pov.option_value.presentation}"} : []).join(', ')
      row << number_to_currency(item.price) unless @hide_prices
      row << item.quantity
      row << number_to_currency(item.price * item.quantity) unless @hide_prices
      content << row
    end

    table content,
      :position      => :center,
      :column_widths => @column_widths
  end
end
