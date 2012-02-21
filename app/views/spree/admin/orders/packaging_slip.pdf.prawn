@hide_prices = params[:template] == "packaging_slip"

render :partial => "print"
