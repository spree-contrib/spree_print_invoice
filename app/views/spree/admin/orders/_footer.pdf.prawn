# To get a simple text, use the line below with your own footer_message
#  text_box footer_message, :at => [margin_box.left -10, margin_box.bottom + 40], :size => 8 , :position => :left

repeat :all do
  table [[Prawn::Table::Cell.new( :text => Spree.t(:footer_left), :font_style => :bold ),
            Prawn::Table::Cell.new( :text => Spree.t(:footer_left2)),
            Prawn::Table::Cell.new( :text => Spree.t(:footer_right), :font_style => :bold ),
            Prawn::Table::Cell.new( :text => Spree.t(:footer_right2))]],
            :border_width => 0,
            :vertical_padding   => 2,
            :font_size => 9,
            :column_widths => { 0 => 80, 1 => 190, 2 => 75, 3 => 190 }
end
