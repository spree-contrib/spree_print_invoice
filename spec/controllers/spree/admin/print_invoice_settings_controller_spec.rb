RSpec.describe Spree::Admin::PrintInvoiceSettingsController, type: :controller do
  stub_authorization!

  before do
    reset_spree_preferences
    user = build(:admin_user)
    allow(controller).to receive(:try_spree_current_user).and_return(user)
  end

  context '#update' do
    it 'redirects to print invoice settings page' do
      put :update, params: { preferences: { logo_path: 4 } }
      expect(response).to redirect_to spree.edit_admin_print_invoice_settings_path
    end

    context 'For parameters:
            next_number: 1
            logo_path: my_path/logo.png,
            page_size: A4,
            page_layout: portrait,
            footer_left: abc
            footer_right: abc
            return_message: abc
            anomaly_message: abc
            use_footer: true
            use_page_numbers: true
            logo_scale: 80
            font_face: Arial
            font_size: 12' do
      subject { Spree::PrintInvoice::Config }

      it 'sets preferred_next_number to 1' do
        put :update, params: { preferences: { next_number: 1 } }
        expect(subject.preferred_next_number).to be(1)
      end

      it 'sets preferred_logo_path to "my_path/logo.png"' do
        put :update, params: { preferences: { logo_path: 'my_path/logo.png' } }
        expect(subject.preferred_logo_path).to eq('my_path/logo.png')
      end

      it 'sets preferred_page_size to "A4"' do
        put :update, params: { preferences: { page_size: 'A4' } }
        expect(subject.preferred_page_size).to eq('A4')
      end

      it 'sets preferred_page_layout to "portrait"' do
        put :update, params: { preferences: { page_layout: 'portrait' } }
        expect(subject.preferred_page_layout).to eq('portrait')
      end

      it 'sets preferred_footer_left to "abc"' do
        put :update, params: { preferences: { footer_left: 'abc' } }
        expect(subject.preferred_footer_left).to eq('abc')
      end

      it 'sets preferred_footer_right to "abc"' do
        put :update, params: { preferences: { footer_right: 'abc' } }
        expect(subject.preferred_footer_right).to eq('abc')
      end

      it 'sets preferred_return_message to "abc"' do
        put :update, params: { preferences: { return_message: 'abc' } }
        expect(subject.preferred_return_message).to eq('abc')
      end

      it 'sets preferred_footer_right to "abc"' do
        put :update, params: { preferences: { footer_right: 'abc' } }
        expect(subject.preferred_footer_right).to eq('abc')
      end

      it 'sets preferred_anomaly_message to "abc"' do
        put :update, params: { preferences: { anomaly_message: 'abc' } }
        expect(subject.preferred_anomaly_message).to eq('abc')
      end

      it 'sets preferred_use_footer to true' do
        put :update, params: { preferences: { use_footer: true } }
        expect(subject.preferred_use_footer).to be(true)
      end

      it 'sets preferred_use_page_numbers to true' do
        put :update, params: { preferences: { use_page_numbers: true } }
        expect(subject.preferred_use_page_numbers).to be(true)
      end

      it 'sets preferred_logo_scale to 80' do
        put :update, params: { preferences: { logo_scale: 80 } }
        expect(subject.preferred_logo_scale).to be(80)
      end

      it 'sets preferred_font_face to "Arial"' do
        put :update, params: { preferences: { font_face: 'Arial' } }
        expect(subject.preferred_font_face).to eq('Arial')
      end

      it 'sets preferred_font_size to 12' do
        put :update, params: { preferences: { font_size: 12 } }
        expect(subject.preferred_font_size).to be(12)
      end
    end
  end

  context '#edit' do
    it 'renders the edit template' do
      get :edit
      expect(response).to render_template(:edit)
    end
  end
end
