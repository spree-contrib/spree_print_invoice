RSpec.describe Spree::Admin::OrdersController, type: :controller do
  stub_authorization!

  let!(:order) { create(:order_ready_to_ship) }

  before do
    allow(controller).to receive(:load_order)
    controller.instance_variable_set('@order', order)
  end

  describe '#show as :pdf' do
    it 'returns http success' do
      spree_get :show, id: order.number, format: :pdf
      expect(response).to be_success
    end

    context 'with next_number set' do
      before do
        allow(Spree::PrintInvoice::Config).to receive(:next_number).and_return(100)
      end

      it 'sets the invoice number' do
        expect {
          spree_get :show, id: order.number, format: :pdf
        }.to change(order, :invoice_number)
      end
    end

    context 'with wrong template name' do
      it 'raises error' do
        expect {
          spree_get :show, id: order.number, format: :pdf, template: 'foo'
        }.to raise_error(Spree::PrintInvoice::UnsupportedTemplateError)
      end
    end

    context 'with correct template name' do
      it 'renders pdf for given template.' do
        spree_get :show, id: order.number, format: :pdf, template: 'invoice'
        expect(response).to be_success
      end
    end
  end
end
