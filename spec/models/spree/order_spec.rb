RSpec.describe Spree::Order do
  let(:order) { create(:order_ready_to_ship) }

  describe '#update_invoice_number!' do

    it 'updates invoice number' do
      expect {
        order.update_invoice_number!
      }.to change(order, :invoice_number)
    end

    context 'with invoice number present' do
      before do
        order.invoice_number = "1000"
      end

      it 'does not update invoice number' do
        expect {
          order.update_invoice_number!
        }.to_not change(order, :invoice_number)
      end
    end

    context 'with use_sequential_number? disabled' do
      before do
        allow(Spree::PrintInvoice::Config).
          to receive(:use_sequential_number?).
          and_return(false)
      end

      it 'does not update invoice number' do
        expect {
          order.update_invoice_number!
        }.to_not change(order, :invoice_number)
      end
    end
  end

  describe 'checkout flow' do
    let(:order) { create :order_with_line_items, state: "confirm" }

    before do
      allow(order).to receive(:ensure_line_item_variants_are_not_deleted) { true }
      allow(order).to receive(:ensure_line_items_are_in_stock) { true }
      order.payments = [create(:payment)]
    end

    it "updates the invoice number when completing the order" do
      expect do
        order.next
      end.to change(order, :invoice_number)
    end
  end

  describe 'invoice_date' do
    let(:order) { Spree::Order.new }

    it 'calls completed at' do
      expect(order).to receive(:completed_at)
      order.invoice_date
    end
  end
end
