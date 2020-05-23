# frozen_string_literal: true

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

  describe 'deprecated methods' do
    let(:order) { Spree::Order.new }
    let(:invoice) { Spree::BookkeepingDocument.new }

    before do
      allow(order).to receive(:invoice).and_return(invoice)
    end

    describe '#pdf_file' do
      it 'calls invoice#pdf' do
        expect(invoice).to receive(:pdf)
        invoice.pdf
      end
    end

    describe '#pdf_filename' do
      it 'calls invoice#file_name' do
        expect(invoice).to receive(:file_name)
        invoice.file_name
      end
    end

    describe '#pdf_file_path' do
      it 'calls invoice#pdf_file_path' do
        expect(invoice).to receive(:pdf_file_path)
        invoice.pdf_file_path
      end
    end

    describe '#pdf_storage_path' do
      context 'with no document of the specified type present' do
        it 'raises ActiveRecord::RecordNotFound' do
          expect do
            order.pdf_storage_path('unknown_something')
          end.to raise_error(ActiveRecord::RecordNotFound)
        end
      end

      context 'with a document of the specified type present' do
        let(:bookkeeping_documents) { [invoice] }
        before do
          allow(order).to receive(:bookkeeping_documents).and_return(bookkeeping_documents)
          allow(bookkeeping_documents).to receive(:find_by!).and_return(invoice)
        end

        it 'calls #file_path on the invoice' do
          expect(invoice).to receive(:file_path)
          invoice.file_path('invoice')
        end
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
end
