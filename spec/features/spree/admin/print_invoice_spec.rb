RSpec.feature 'Admin print invoice feature' do
  stub_authorization!

  let!(:order) { create(:order_ready_to_ship) }

  scenario 'shows print buttons on the order detail page.' do
    visit spree.edit_admin_order_path(id: order.number)

    within('#sidebar') do
      expect(page).to have_link 'Print Invoice'
      expect(page).to have_link 'Print Packaging Slip'
    end
  end

  context 'with Config.store_pdf set to true' do
    before do
      allow(Spree::PrintInvoice::Config).to receive(:store_pdf).and_return(true)
    end

    context 'with pdf file already present' do
      let(:pdf_file_path) { "spec/fixtures/invoice.pdf" }

      before do
        allow_any_instance_of(Spree::Order).
          to receive(:pdf_file_path).
          and_return(pdf_file_path)
      end

      scenario 'sends the stored file.' do
        visit spree.admin_order_path(id: order.number, format: :pdf)
        expect(page.body).to eq(IO.binread(pdf_file_path))
      end
    end

    context 'with pdf file not yet present' do
      scenario 'sends the stored file.' do
        visit spree.admin_order_path(id: order.number, format: :pdf)
        expect(page.body).to eq(IO.binread("spec/dummy/tmp/order_prints/invoices/#{order.number}.pdf"))
      end
    end
  end

  context 'with Config.store_pdf set to false' do
    before do
      allow(Spree::PrintInvoice::Config).to receive(:store_pdf).and_return(false)
    end

    scenario 'sends rendered pdf.' do
      visit spree.admin_order_path(id: order.number, format: :pdf)
      expect(page.body).to match(/\A%PDF-1\.3/)
    end
  end
end
