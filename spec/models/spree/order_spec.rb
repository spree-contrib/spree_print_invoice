RSpec.describe Spree::Order do
  let(:order) { create(:order_ready_to_ship) }

  describe '#update_invoice_number!' do

    it 'updates invoice number' do
      expect {
        order.update_invoice_number!
      }.to change(order, :invoice_number)
    end

    it 'updates invoice date' do
      expect {
        order.update_invoice_number!
      }.to change(order, :invoice_date)
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

      it 'does not update invoice date' do
        expect {
          order.update_invoice_number!
        }.to_not change(order, :invoice_date)
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

      it 'does not update invoice date' do
        expect {
          order.update_invoice_number!
        }.to_not change(order, :invoice_date)
      end
    end
  end
end
