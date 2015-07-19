RSpec.describe Spree::Order do
  describe "delegates" do
    let(:order) { Spree::Order.new }
    let(:invoice) { Spree::BookkeepingDocument.new(printable: order, template: "invoice") }

    before do
      allow(order).to receive(:invoice) { invoice }
    end

    describe "#invoice_number" do
      it "calls invoice" do
        expect(invoice).to receive(:number)
        order.invoice_number
      end
    end

    describe "#invoice_date" do
      it "calls invoice" do
        expect(invoice).to receive(:date)
        order.invoice_date
      end
    end
  end

  describe "checkout flow" do
    let(:order) { create :order_with_line_items, state: "confirm" }

    before do
      allow(order).to receive(:ensure_line_item_variants_are_not_deleted) { true }
      allow(order).to receive(:ensure_line_items_are_in_stock) { true }
      order.payments = [create(:payment)]
    end

    it "creates a new invoice when completing the order" do
      expect do
        order.next
      end.to change { Spree::BookkeepingDocument.count }
    end
  end

  describe "deprecated methods" do
    let(:order) { Spree::Order.new }
    let(:invoice) { Spree::BookkeepingDocument.new }

    before do
      allow(order).to receive(:invoice).and_return(invoice)
    end

    describe "#pdf_file" do
      it "calls invoice#pdf" do
        expect(invoice).to receive(:pdf)
        order.pdf_file
      end
    end

    describe "#pdf_filename" do
      it "calls invoice#file_name" do
        expect(invoice).to receive(:file_name)
        order.pdf_filename
      end
    end

    describe "#pdf_file_path" do
      it "calls invoice#pdf_file_path" do
        expect(invoice).to receive(:pdf_file_path)
        order.pdf_file_path
      end
    end

    describe "#pdf_storage_path" do
      context "with no document of the specified type present" do
        it "raises ActiveRecord::RecordNotFound" do
          expect do
            order.pdf_storage_path("unknown_something")
          end.to raise_error(ActiveRecord::RecordNotFound)
        end
      end

      context "with a document of the specified type present" do
        let(:bookkeeping_documents) {[invoice]}
        before do
          allow(order).to receive(:bookkeeping_documents).and_return(bookkeeping_documents)
          allow(bookkeeping_documents).to receive(:find_by!).and_return(invoice)
        end

        it "calls #file_path on the invoice" do
          expect(invoice).to receive(:file_path)
          order.pdf_storage_path("invoice")
        end
      end
    end
  end
end
