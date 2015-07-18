RSpec.describe Spree::BookkeepingDocument do
  let(:printable) { Spree::Order.new }
  let(:template) { 'invoice' }
  subject { Spree::BookkeepingDocument.new(printable: printable, template: 'invoice') }

  describe 'attributes' do
    it { is_expected.to respond_to(:printable) }
    it { is_expected.to respond_to(:template) }

    # These attributes are only stored for sorting and searching.
    # Consequently, I would hope that a view class implements methods for
    # all of them.

    it { is_expected.to respond_to(:date) }
    it { is_expected.to respond_to(:number) }
    it { is_expected.to respond_to(:firstname) }
    it { is_expected.to respond_to(:lastname) }
    it { is_expected.to respond_to(:email) }
    it { is_expected.to respond_to(:total) }
  end

  describe '#view' do
    it { is_expected.to respond_to(:view) }

    context 'with an order as printable' do
      it 'is an Spree::Printables::Order::InvoiceView'  do
        expect(subject.view).to be_a(Spree::Printables::Order::InvoiceView)
      end
    end
  end

  describe '#pdf' do
    subject { Spree::BookkeepingDocument.create(printable: printable, template: 'invoice') }

    before do
      allow(Spree::PrintInvoice::Config).to receive(:store_pdf) { false }
    end

    context 'with an order' do
      let(:printable) { create :invoiceable_order }

      it 'creates a PDF' do
        expect(subject.pdf).to match(/%PDF-1.\d/)
      end
    end
  end

  describe 'validations' do
    let(:pdf) { Spree::BookkeepingDocument.new }
    it 'is not valid without aa printable' do
      expect(pdf).not_to be_valid
    end
  end

  describe 'creation' do
    let(:printable) { create :order_ready_to_ship }
    let(:pdf) { Spree::BookkeepingDocument.new(printable: printable, template: 'invoice') }

    before do
      Spree::PrintInvoice::Config.set(next_number: 1)
      allow(pdf).to receive(:created_at) { Date.today }
    end

    it 'automatically has an invoice number after saving' do
      expect(pdf.number).to eq(nil)
      pdf.save
      expect(pdf.number).to eq('1')
    end

    it 'sets a new invoice number when saving' do
      expect(Spree::PrintInvoice::Config).to receive(:increase_invoice_number!)
      pdf.save
    end

    it 'does not assign a new number when the save fails' do
      expect(Spree::PrintInvoice::Config).not_to receive(:increase_invoice_number!)

      expect do
        pdf.printable = nil # make it invalid
        pdf.save!
      end.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe 'method_missing' do
    it 'sends stuff that the view knows to the view' do
      expect_any_instance_of(Spree::Printables::Order::InvoiceView).to receive(:after_save_actions)
      subject.after_save_actions
    end

    it 'accurately reports missing methods as missing' do
      expect do
        subject.something_that_is_not_known
      end.to raise_error NoMethodError
    end
  end
end
