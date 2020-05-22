RSpec.describe Spree::Order do
  describe 'delegates' do
    let(:order) { Spree::Order.new }
    let(:invoice) { Spree::BookkeepingDocument.new(printable: order, template: 'invoice') }

    before do
      allow(order).to receive(:invoice) { invoice }
    end

    describe '#invoice_number' do
      it 'calls invoice' do
        expect(invoice).to receive(:number)
        order.invoice_number
      end
    end

    describe '#invoice_date' do
      it 'calls invoice' do
        expect(invoice).to receive(:date)
        order.invoice_date
      end
    end
  end

  describe 'checkout flow' do
    let(:order) { create :order_with_line_items, state: 'confirm' }

    before do
      allow(order).to receive(:ensure_line_item_variants_are_not_deleted) { true }
      allow(order).to receive(:ensure_line_items_are_in_stock) { true }
      order.payments = [create(:payment)]
    end

    it 'creates a new invoice when completing the order' do
      expect do
        order.next
      end.to change { Spree::BookkeepingDocument.count }
    end
  end

  describe 'destruction' do
    let!(:order) { create :invoiceable_order }

    context "when destroyed" do
      it 'also destroys the invoice' do
        expect(Spree::BookkeepingDocument.count).not_to eq(0)
        order.destroy!
        expect(Spree::BookkeepingDocument.count).to eq(0)
      end
    end
  end

end
