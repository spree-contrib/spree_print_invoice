require 'spec_helper'

feature 'Settings for Print Invoice', :js do
  stub_authorization!

  scenario 'update' do
    visit spree.admin_path
    click_link 'Configuration'
    click_link 'Print Invoice Settings'

    # TODO: it does not save boolean values :(
    # check   'preferences_use_footer'
    # uncheck 'preferences_use_page_numbers'

    fill_in 'preferences_print_invoice_logo_path', with: '/somewhere/logo.png'
    fill_in 'preferences_print_buttons', with: 'invoice,packaging_slip'
    fill_in 'preferences_print_invoice_next_number', with: '200'
    fill_in 'preferences_footer_left', with: 'left text..'
    fill_in 'preferences_footer_right', with: 'right text..'
    fill_in 'preferences_return_message', with: 'Return message..'
    fill_in 'preferences_anomaly_message', with: 'Anomaly message..'

    # TODO: can't get select2 to find anything :(
    # select2 'A4', from: 'preferences_page_size'
    # select2 'portrait', from: 'preferences_page_layout'

    click_button 'Update'

    setting = Spree::PrintInvoiceSetting.new

    # expect(setting[:use_footer]).to be_true
    # expect(setting[:use_page_numbers]).to be_false

    expect(setting[:print_invoice_logo_path]).to eq '/somewhere/logo.png'
    expect(setting[:print_buttons]).to eq 'invoice,packaging_slip'
    expect(setting[:print_invoice_next_number]).to eq 200
    expect(setting[:footer_left]).to eq 'left text..'
    expect(setting[:footer_right]).to eq 'right text..'
    expect(setting[:return_message]).to eq 'Return message..'
    expect(setting[:anomaly_message]).to eq 'Anomaly message..'

    # expect(setting[:page_size]).to eq 'A4'
    # expect(setting[:page_layout]).to eq 'portrait'
  end
end