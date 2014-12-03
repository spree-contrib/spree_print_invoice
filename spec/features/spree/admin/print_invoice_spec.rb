RSpec.feature 'Admin Print Invoice', :js do
  stub_authorization!

  context 'can not print' do

    background do
      @order = create(:order_with_line_items)
      visit spree.admin_orders_path
    end

    scenario 'when no completed order exist' do
      uncheck 'Only show complete orders'
      click_button 'Filter Results'
      expect(page).to have_text @order.user.email
      within_table('listing_orders') { click_icon :edit }
      expect(page).not_to have_link 'Print Invoice'
    end
  end

  context 'can print' do

    background do
      @order = create(:completed_order_with_totals)
      visit spree.admin_orders_path
    end

    scenario 'completed order' do
      expect(@order.completed_at).not_to be_nil
      expect(@order.state).to eq 'complete'

      uncheck 'Only show complete orders'
      expect(page).to have_text @order.user.email
      within_table('listing_orders') { click_icon :edit }

      expect(page).to have_link 'Print Invoice'
    end
  end

  private

  def show_invoice_pdf_for(order)
    click_link 'Print Invoice'
    expect(current_path).to eq "/admin/orders/#{order.number}.pdf?template=invoice"
    expect(page.response_headers['Content-Type']).to eq 'application/pdf'
    expect(page.response_headers['Content-Disposition']).to eq "attachment; filename=#{order.number}.pdf"
  end
end
