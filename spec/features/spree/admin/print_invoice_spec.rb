require 'spec_helper'

feature 'Admin Print Invoice', :js do
  stub_authorization!

  given(:user)    { create(:user, email: 'support@spreecommerce.com') }
  given(:address) { build(:address) }

  background do
    visit spree.admin_orders_path
  end

  context 'can not print' do

    given!(:order) do
      create(:order_with_line_items, user: user)
    end

    scenario 'when no shipped order exist' do
      navigate_thru_filters_with order
      within_table('listing_orders') { click_icon :edit }
      expect(page).not_to have_link 'Print Invoice'
    end
  end

  context 'can print' do

    given!(:order) do
      create(:shipped_order, user: user, bill_address: address)
    end

    scenario 'shipped order' do
      expect(order.user.email).to eq 'support@spreecommerce.com'
      expect(order.bill_address.company).not_to be_nil
      expect(order.ship_address.company).not_to be_nil
      expect(order.completed_at).not_to be_nil
      expect(order.payment_state).to eq 'paid'

      navigate_thru_filters_with order
      within_table('listing_orders') { click_icon :edit }

      expect(page).to have_link 'Print Invoice'
    end
  end

  private

  def navigate_thru_filters_with(order)
    uncheck 'Only show complete orders'
    click_button 'Filter Results'
    expect(page).to have_text order.user.email
  end

  def show_invoice_pdf_for(order)
    click_link 'Print Invoice'
    expect(current_path).to eq "/admin/orders/#{order.number}.pdf?template=invoice"
    expect(page.response_headers['Content-Type']).to eq 'application/pdf'
    expect(page.response_headers['Content-Disposition']).to eq "attachment; filename=#{order.number}.pdf"
  end
end