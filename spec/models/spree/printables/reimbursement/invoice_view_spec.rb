RSpec.describe Spree::Printables::Reimbursement::InvoiceView do
  let(:invoiceable) { Spree::Reimbursement.new }
  let(:order) { Spree::Order.new }
  let(:presenter) { Spree::Printables::Reimbursement::InvoiceView.new(invoiceable) }

  before do
    allow(invoiceable).to receive(:order) { order }
  end

  describe '#bill_address' do
    it "calls the reimbursement's order's bill address" do
      expect(order).to receive(:bill_address)
      presenter.bill_address
    end
  end

  describe '#ship_address' do
    it "calls the reimbursement's order's ship address" do
      expect(order).to receive(:ship_address)
      presenter.ship_address
    end
  end

  describe '#tax_address' do
    it "calls the reimbursement's order's tax address" do
      expect(order).to receive(:tax_address)
      presenter.tax_address
    end
  end

  describe '#items' do
    it 'calls return items on the reimbursement' do
      expect(invoiceable).to receive(:return_items) { [create(:return_item)] }
      presenter.items
    end
  end

  describe '#item_total' do
    let(:return_item) { Spree::ReturnItem.new }

    before do
      allow(invoiceable).to receive(:total) { 12 }
      allow(invoiceable).to receive(:return_items) { [return_item] }
      allow(return_item).to receive(:additional_tax_total) { 2 }
      allow(return_item).to receive(:included_tax_total) { 3 }
    end

    xit 'equals the negative reimbursement total minus additional tax' do
      expect(presenter.item_total).to eq(-10)
    end
  end

  describe '#adjustments' do
    let(:return_items) { [] }

    it 'calls return_items on the order' do
      expect(invoiceable).to receive(:return_items) { return_items }

      presenter.adjustments
    end
  end

  describe '#shipments' do
    xit 'calls shipments on the order' do
      expect(invoiceable).to receive(:shipments)
      presenter.shipments
    end
  end

  describe '#total' do
    xit 'calls total on the reimbursement' do
      expect(invoiceable).to receive(:total) { 10 }
      presenter.total
    end
  end

  describe '#payments' do
    it 'calls refunds on the reimbursement' do
      expect(invoiceable).to receive(:refunds)
      presenter.payments
    end
  end
end
