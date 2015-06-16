RSpec.describe Spree::Printables::Invoice::BaseView do
  let(:printable) { Object.new }
  let(:base_view) { Spree::Printables::Invoice::BaseView.new(printable) }

  describe '#bill_address' do
    it 'raises a NotImplementedError' do
      expect do
        base_view.bill_address
      end.to raise_error(NotImplementedError, 'Please implement bill_address')
    end
  end

  describe '#ship_address' do
    it 'raises a NotImplementedError' do
      expect do
        base_view.ship_address
      end.to raise_error(NotImplementedError, 'Please implement ship_address')
    end
  end

  describe '#tax_address' do
    it 'raises a NotImplementedError' do
      expect do
        base_view.tax_address
      end.to raise_error(NotImplementedError, 'Please implement tax_address')
    end
  end

  describe '#items' do
    it 'raises a NotImplementedError' do
      expect do
        base_view.items
      end.to raise_error(NotImplementedError, 'Please implement items')
    end
  end

  describe '#item_total' do
    it 'raises a NotImplementedError' do
      expect do
        base_view.item_total
      end.to raise_error(NotImplementedError, 'Please implement item_total')
    end
  end

  describe '#adjustments' do
    let(:order) { create :order }
    let!(:adjustments) { [create(:adjustment, order: order)] }
    it 'calls all_adjustments' do
      expect(base_view).to receive(:all_adjustments) { adjustments }
      base_view.adjustments
    end
  end

  describe '#shipments' do
    it 'raises a NotImplementedError' do
      expect do
        base_view.shipments
      end.to raise_error(NotImplementedError, 'Please implement shipments')
    end
  end

  describe '#payments' do
    it 'raises a NotImplementedError' do
      expect do
        base_view.payments
      end.to raise_error(NotImplementedError, 'Please implement payments')
    end
  end

  describe '#number' do
    context 'when using sequential numbers' do
      before do
        allow(Spree::PrintInvoice::Config).to receive(:use_sequential_number?) { true }
      end

      it 'calls next_number on Spree::PrintInvoice::Config' do
        expect(Spree::PrintInvoice::Config).to receive(:next_number)
        base_view.number
      end
    end

    context 'when not using sequential numbers' do
      before do
        allow(Spree::PrintInvoice::Config).to receive(:use_sequential_number?) { false }
      end

      it 'calls the printables number' do
        expect(printable).to receive(:number)
        base_view.number
      end
    end
  end
end
