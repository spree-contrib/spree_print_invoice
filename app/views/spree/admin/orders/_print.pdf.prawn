require 'prawn'

fill_color "000000"
font "Helvetica", :size => 9, :style => :bold
text_box Spree::Config.site_name, :at => [0,720], :size => 25

if @hide_prices
  text I18n.t(:packaging_slip), :align => :right, :style => :bold, :size => 18
else
  text I18n.t(:customer_invoice), :align => :right, :style => :bold, :size => 18
end

move_down 4

font "Helvetica",  :size => 9,  :style => :bold
text "#{I18n.t(:order_number)} #{@order.number}", :align => :right

move_down 2
font "Helvetica", :size => 9
text "#{I18n.l @order.completed_at.to_date}", :align => :right

render :partial => "address"

move_cursor_to 500

render :partial => "line_items_box"

move_cursor_to 80 

font "Helvetica", :size => 9

bounding_box [20,cursor  ], :width => 400 do
  render :partial => "bye" unless @hide_prices
end

render :partial => "totals" unless @hide_prices

move_down 2

# Footer
# render :partial => "footer"
