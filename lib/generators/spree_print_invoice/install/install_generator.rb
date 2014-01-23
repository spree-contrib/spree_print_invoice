module SpreePrintInvoice
  module Generators
    class InstallGenerator < Rails::Generators::Base
      class_option :auto_run_migrations, :type => :boolean, :default => true

      def add_migrations
        run 'rake railties:install:migrations FROM=spree_print_invoice'
      end

      def run_migrations
         if options[:auto_run_migrations] || ['', 'y', 'Y'].include?(ask "Would you like to run the migrations now? [Y/n]")
           run 'rake db:migrate'
         else
           puts "Skiping rake db:migrate, don't forget to run it!"
         end
      end
    end
  end
end