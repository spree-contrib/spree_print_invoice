module Spree
  module Admin
    module PrintInvoiceHelper
      def font_faces
        fonts = Prawn::Font::AFM::BUILT_INS.reject { |f| f =~ /zapf|symbol|bold|italic|oblique/i }.map { |f| [f.tr('-', ' '), f] }
        options_for_select(fonts, Spree::PrintInvoice::Config[:print_font_face])
      end

      def logo_scale
        Spree::PrintInvoice::Config[:print_invoice_logo_scale].to_f / 100
      end
    end
  end
end
