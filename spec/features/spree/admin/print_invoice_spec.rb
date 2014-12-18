RSpec.feature 'Admin Print Invoice', :js do
  stub_authorization!

  context 'can print' do

    background do
      @order = create(:completed_order_with_totals)
      visit spree.admin_orders_path
    end

    scenario 'completed order' do
      expect(@order.completed_at).not_to be_nil

      within_table('listing_orders') do
        expect(page).to have_text @order.user.email
        click_icon :edit
      end
      within('#sidebar') do
        expect(page).to have_link 'Print Invoice'
        expect(page).to have_link 'Print Packaging Slip'
      end
    end
  end
end
