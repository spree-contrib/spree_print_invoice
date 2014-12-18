RSpec.describe Spree::Admin::OrdersController, type: :controller do
  stub_authorization!

  let(:order) { create(:order_ready_to_ship) }

  context '#show as :pdf' do
    it 'returns http success' do
      spree_get :show, id: order.number, format: :pdf
      expect(response).to be_success
    end
  end
end
