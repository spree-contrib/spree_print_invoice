module Spree
  module PrintInvoice
    class PrawnRailsConfiguration
      def page_layout
        @_page_layout ||= Spree::PrintInvoice::Config.page_layout.to_sym
      end

      def page_size
        @_page_size ||= Spree::PrintInvoice::Config.page_size
      end

      def skip_page_creation
        false
      end

      def to_h
        {
          page_layout: page_layout,
          page_size: page_size,
          skip_page_creation: false
        }
      end
    end
  end
end

# A bit of a hack, but we really do need to modify PrawnRails' config all the time.
module PrawnRails
  def config
    Spree::PrintInvoice::PrawnRailsConfiguration.new
  end
end
