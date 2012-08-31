require 'open-uri'

@column_widths = [75, 205, 100, 50, 50, 60]
@align = { 0 => :left, 1 => :left, 2 => :left, 3 => :right, 4 => :right, 5 => :right}

# Line Items
span(540, :position => :center) do
  move_down 2
  header =  [
    make_cell( :content => t(:sku), :font_style => :bold),
    make_cell( :content => t(:item_description), :font_style => :bold ),
    make_cell( :content => 'Preview', :font_style => :bold ) ,
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
      link_to_product = make_cell(:content => "<color rgb='0000FF'><link href='#{product_url(item.variant.product)}'>#{item.variant.product.sku}</link></color>", :inline_format => true)
      row = [link_to_product, item.variant.product.name]
      row << ''
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
