@hide_prices = params[:template] == "packaging_slip"
@hide_prices = true

render :partial => "print"
