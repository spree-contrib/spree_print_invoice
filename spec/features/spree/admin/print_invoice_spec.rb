RSpec.feature 'Admin print invoice feature' do
  stub_authorization!

  let!(:order) { create(:invoiceable_order) }

  scenario 'shows documents button on order page.' do
    visit spree.edit_admin_order_path(id: order.number)

    within('#sidebar') do
      expect(page).to have_link Spree.t(:documents, scope: :print_invoice)
    end
  end

  context 'with Config.store_pdf set to true' do
    before do
      allow(Spree::PrintInvoice::Config).to receive(:store_pdf).and_return(true)
    end

    context 'with pdf file already present' do
      let(:pdf_file_path) { 'spec/fixtures/invoice.pdf' }

      before do
        allow_any_instance_of(Spree::BookkeepingDocument).to receive(:file_path).and_return(pdf_file_path)
      end

      scenario 'sends the stored file.' do
        visit spree.admin_bookkeeping_document_path(id: order.invoice.id, format: :pdf)
        expect(page.body).to eq(IO.binread(pdf_file_path))
      end
    end

    context 'with pdf file not yet present' do
      before do
        allow(Spree::PrintInvoice::Config).to receive(:storage_path).and_return('tmp/order_prints')
        allow(Spree::PrintInvoice::Config).to receive(:next_number).and_return(100)
      end

      scenario 'sends the stored file.' do
        visit spree.admin_bookkeeping_document_path(id: order.invoice.id, format: :pdf)
        expect(page.body).to eq(
          IO.binread(
            Rails.root.join('..', '..', 'spec', 'dummy', 'tmp', 'order_prints', 'invoices', "invoice-D#{order.invoice.id}-N#{order.invoice.number}.pdf")
          )
        )
      end
    end # spec/dummy/tmp/order_prints/invoices/invoice-R679215110.pdf
  end

  context 'with Config.store_pdf set to false' do
    before do
      allow(Spree::PrintInvoice::Config).to receive(:store_pdf).and_return(false)
    end

    scenario 'sends rendered pdf.' do
      visit spree.admin_bookkeeping_document_path(id: order.invoice.id, format: :pdf)
      expect(page.body).to match(/\A%PDF-1\.\d/)
    end
  end
end
