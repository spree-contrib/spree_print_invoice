require 'prawn/layout'

@font_face = Spree::PrintInvoice::Config[:print_font_face]

font @font_face

im = Rails.application.assets.find_asset(Spree::PrintInvoice::Config[:print_invoice_logo_path])
image im , :at => [0,720] #, :scale => 0.35

fill_color "E99323"
if @hide_prices
  text Spree.t(:packaging_slip), :align => :right, :style => :bold, :size => 18
else
  text Spree.t(:customer_invoice), :align => :right, :style => :bold, :size => 18
end
fill_color "000000"

move_down 4

if Spree::PrintInvoice::Config.use_sequential_number? && @order.invoice_number.present? && !@hide_prices

  font @font_face,  :size => 9,  :style => :bold
  text "#{Spree.t(:invoice_number)} #{@order.invoice_number}", :align => :right

  move_down 2
  font @font_face, :size => 9
  text "#{Spree.t(:invoice_date)} #{I18n.l @order.invoice_date}", :align => :right

else

  move_down 2
  font @font_face,  :size => 9
  text "#{Spree.t(:order_number, :number => @order.number)}", :align => :right

  move_down 2
  font @font_face, :size => 9
  text "#{I18n.l @order.completed_at.to_date}", :align => :right

end


render :partial => "address"

move_down 30

render :partial => "line_items_box"

move_down 8

# Footer
render :partial => "footer"

