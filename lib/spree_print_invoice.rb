require 'spree_core'
require 'spree_print_invoice/engine'
require 'spree_print_invoice/version'
require 'prawn_handler'
require 'coffee_script'

module Spree
  module PrintInvoice
    module_function

    def config(*)
      yield(Spree::PrintInvoice::Config)
    end
  end
end
