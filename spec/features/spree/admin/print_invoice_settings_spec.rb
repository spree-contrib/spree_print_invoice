RSpec.feature 'Configuration for Print Invoice' do
  stub_authorization!

  scenario 'can update configuration', :js do
    visit spree.edit_admin_print_invoice_configuration_path

    check 'use_footer'
    check 'use_page_numbers'

    fill_in 'logo_path', with: '/somewhere/logo.png'
    fill_in 'next_number', with: '200'
    select 'A4', from: 'Page Size'
    select 'portrait', from: 'Page Layout'
    select 'Courier', from: 'Font Face'
    select '11', from: 'Font Size'
    fill_in 'logo_scale', with: '99'
    fill_in 'footer_left', with: 'left text..'
    fill_in 'footer_right', with: 'right text..'
    fill_in 'return_message', with: 'Return message..'
    fill_in 'anomaly_message', with: 'Anomaly message..'

    check 'store_pdf'
    find('#storage_path').set('pdf/files') # wait for the input to be enabled

    click_button 'Update'

    configuration = Spree::PrintInvoiceConfiguration.new

    expect(configuration.preferred_use_footer).to be(true)
    expect(configuration.preferred_use_page_numbers).to be(true)

    expect(configuration.preferred_logo_path).to eq '/somewhere/logo.png'
    expect(configuration.preferred_next_number).to eq 200
    expect(configuration.preferred_page_size).to eq 'A4'
    expect(configuration.preferred_page_layout).to eq 'portrait'
    expect(configuration.preferred_font_face).to eq 'Courier'
    expect(configuration.preferred_font_size).to eq 11
    expect(configuration.preferred_logo_scale).to eq 99
    expect(configuration.preferred_footer_left).to eq 'left text..'
    expect(configuration.preferred_footer_right).to eq 'right text..'
    expect(configuration.preferred_return_message).to eq 'Return message..'
    expect(configuration.preferred_anomaly_message).to eq 'Anomaly message..'
    expect(configuration.preferred_store_pdf).to be(true)
    expect(configuration.preferred_storage_path).to eq 'pdf/files'
  end
end
