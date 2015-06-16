RSpec.describe Spree::Admin::BookkeepingDocumentsController, type: :controller do
  stub_authorization!

  describe '#show as :pdf' do
    context 'an order invoice' do
      let!(:order) { create(:invoiceable_order) }
      let(:pdf) { order.invoice }

      it 'renders pdf' do
        spree_get :show, id: pdf.id, format: :pdf
        expect(response).to be_success
      end
    end

    context 'an order packaging slip' do
      let!(:order) { create(:invoiceable_order) }
      let(:pdf) { order.packaging_slip }

      it 'renders pdf' do
        spree_get :show, id: pdf.id, format: :pdf
        expect(response).to be_success
      end
    end

    context 'a reimbursement invoice' do
      # In real life, the reimbursement total is only set when the reimbursement is performed.
      # That performance needs a refund reason and more bureaucracy, I'll just stub things here.
      let!(:reimbursement) { create(:reimbursement, total: 100) }
      let(:pdf) { reimbursement.invoice }

      it 'renders pdf' do
        spree_get :show, id: pdf.id, format: :pdf
        expect(response).to be_success
      end
    end
  end

  describe "#index as :html" do
    let(:bills_address) do
      create :address,
        firstname: "Bill",
        lastname: "Murray"
    end

    let(:joes_address) do
      create :address,
        firstname: "Joe",
        lastname: "Dalton"
    end

    let!(:bills_order) do
      create :invoiceable_order,
        ship_address: bills_address,
        email: "bill@murray.net"
    end

    let!(:joes_order) do
      create :invoiceable_order,
        ship_address: joes_address,
        email: "joe@dalton.com"
    end

    context "from the Spree::Orders#edit view" do
      before { spree_get(:index, order_id: bills_order.number) }

      it "returns 200 success" do
        expect(response).to be_success
      end

      it "assigns @bookkeeping_documents" do
        expect(assigns(:bookkeeping_documents)).to be_a(ActiveRecord::Relation)
      end

      it "includes bill's order, but not joe's order" do
        expect(assigns(:bookkeeping_documents)).not_to include(joes_order.invoice)
        expect(assigns(:bookkeeping_documents)).to include(bills_order.invoice)
      end
    end

    context "from the the side bar" do
      before {  spree_get(:index) }

      it "returns 200 success" do
        expect(response).to be_success
      end

      it "assigns @bookkeeping_documents" do
        expect(assigns(:bookkeeping_documents)).to be_a(ActiveRecord::Relation)
      end

      it "includes both bill and joes order" do
        expect(assigns(:bookkeeping_documents)).to include(joes_order.invoice)
        expect(assigns(:bookkeeping_documents)).to include(bills_order.invoice)
      end
    end

  end
end
