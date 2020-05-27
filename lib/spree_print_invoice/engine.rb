module SpreePrintInvoice
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_print_invoice'

    config.autoload_paths += %W(#{config.root}/lib)

    initializer 'spree.print_invoice.preferences', before: :load_config_initializers do
      Spree::PrintInvoice::Config = Spree::PrintInvoiceSetting.new
    end

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare(&method(:activate).to_proc)
  end
end
