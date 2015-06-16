RSpec.feature 'Settings for Print Invoice' do
  stub_authorization!

  scenario 'can update settings', :js do
    visit spree.edit_admin_print_invoice_settings_path

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

    setting = Spree::PrintInvoiceSetting.new

    expect(setting.preferred_use_footer).to be(true)
    expect(setting.preferred_use_page_numbers).to be(true)

    expect(setting.preferred_logo_path).to eq '/somewhere/logo.png'
    expect(setting.preferred_next_number).to eq 200
    expect(setting.preferred_page_size).to eq 'A4'
    expect(setting.preferred_page_layout).to eq 'portrait'
    expect(setting.preferred_font_face).to eq 'Courier'
    expect(setting.preferred_font_size).to eq 11
    expect(setting.preferred_logo_scale).to eq 99
    expect(setting.preferred_footer_left).to eq 'left text..'
    expect(setting.preferred_footer_right).to eq 'right text..'
    expect(setting.preferred_return_message).to eq 'Return message..'
    expect(setting.preferred_anomaly_message).to eq 'Anomaly message..'
    expect(setting.preferred_store_pdf).to be(true)
    expect(setting.preferred_storage_path).to eq 'pdf/files'
  end
end
