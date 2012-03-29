module SpreePrintInvoice
  class Engine < Rails::Engine
    engine_name 'spree_print_invoice'
    
    initializer "spree.print_invoice.environment", :before => :load_config_initializers do |app|
      Spree::PrintInvoice::Config = Spree::PrintInvoiceConfiguration.new
    end
    
    initializer "spree.print_invoice.mimetypes" do |app|
      Mime::Type.register 'application/pdf', :pdf
    end
    
    def self.activate

      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end

    end

    config.autoload_paths += %W(#{config.root}/lib)
    config.to_prepare &method(:activate).to_proc

  end
end
